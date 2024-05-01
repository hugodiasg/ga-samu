clear *
clc
close all
format long
data_base;

%% Initialize the population
  number_population =int32(input('Number of population:'));
  generations =int32(input('Max. of generations:'));
  %generations= 100;
  %number_population= 20;
  
  population=zeros(number_population, 4);
  %disp(population)
  
  for k=1:number_population % generate a random population X, Y
      population(k,1) = rand()*x_max;
      population(k,2) =rand()*y_max;
  end
  %disp(population);
  
for c=1:generations
    %% Fitness Function
     %disp(n_coords)
     %disp(n_freq)

     fitness= zeros(number_population,1);

     for k=1:number_population
         x = population(k,1);
         y = population(k,2);

         for i=1:n_freq
           fitness(k)=  fitness(k) + freq(i)*((coord(i,1)-x)^2+(coord(i,2)-y)^2)^0.5; 
         end
     end
    %disp(fitness)
    
    %% Elitism
    min_fitness = min(fitness);
    elite_index = find(fitness==min_fitness,1);
    elite = population(elite_index,:);
    
    %% Natural Selection (Proportional Selection - Roulette Wheel)
    fitness_sum =  sum(fitness);
    prob = fitness/fitness_sum;
    acumulative_prob = cumsum(prob);

    parents = zeros(number_population,2);
    %select parents
    for i=1:number_population
        random_number = rand();
        index = find((acumulative_prob >= random_number), 1);
        parents(i,1)=population(index,1);
        parents(i,2)=population(index,2);
    end
    %population
    %fitness
    %parents
    

    
    %% Cross over (Linear)
    test_son = zeros(3,2)
    son =zeros(number_population,2);
    fitness1 = 0;
    fitness2 = 0;
    fitness3 = 0;
    % Crossing parent(i) with parent(i+1)
    for i=1:number_population
        k = i+1;

        % avoid index overflow
        if (k>number_population)
            k = 1;
        end

        test_son(1,:)= 0.5*parents(i,:)+0.5*parents(k,:);
        test_son(2,:)= 1.5*parents(i,:)-0.5*parents(k,:);
        test_son(3,:)= -0.5*parents(i,:)+1.5*parents(k,:);
        
        
         for j=1:n_freq % fitness of each son
           fitness1=  fitness1 + freq(j)*((coord(j,1)- test_son(1,1))^2+(coord(j,2)-test_son(1,2))^2)^0.5; 
           fitness2=  fitness2 + freq(j)*((coord(j,1)- test_son(2,1))^2+(coord(j,2)-test_son(2,2))^2)^0.5; 
           fitness3=  fitness3 + freq(j)*((coord(j,1)- test_son(3,1))^2+(coord(j,2)-test_son(3,2))^2)^0.5; 
        end
    
        [best_son, index_best_son] = min([fitness1, fitness2, fitness3]);
        son(i,:)=test_son(index_best_son,:);
        % avoid index overflow
        if (son(i,1)<0)
            son(i,1)=0;
        end
        if (son(i,2)<0)
            son(i,2)=0;
        end
        
        if (son(i,1)>8)
            son(i,1)=8;
        end
        if (son(i,2)>7)
            son(i,2)=7;
        end
    end
    
    %% Mutation
    mutation_rate = 0.01;
    population = son;
    do_mutation = zeros(number_population,1);
    for i=1:number_population
       do_mutation(i) = rand()<=mutation_rate;

       % choose x or y to mutation
       if (do_mutation(i))
        coord_to_mutation = rand();
        if (coord_to_mutation<0.5) % coord x chosen
            population(i,1)= rand()*x_max;
        else                        % coord y chosen
             population(i,2)= rand()*y_max;
        end
       end
    end
    
      % Applying elitism
      population(1,1) = elite(1,1);
      population(1,2) = elite(1,2);
     
    %% Plot
    grid on
    clf % clear old frequency values
    
    
    % Plot the coord
    x_coord = coord(:,1);
    y_coord = coord(:,2);
    %scatter(x_coord, y_coord, 1000, 'white', 'filled');
    plot(x_coord, y_coord,'w');
    hold on;
    
    % Add. frequency values assotiated to each coord
    for i = 1:x_max*y_max
        text(coord(i,1),coord(i,2),num2str(freq(i)), 'Color', 'black', 'FontSize', 15, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    end
    hold on;

    % Add. the population x,y
    %for i=1:number_population
        %scatter(population(i,1), population(i,2), 50, 'red', 'filled');
        plot(population(:,1), population(:,2),'r*');
    %end
    title(['Generation: ' num2str(c)]);
    xlabel('km');
    ylabel('km');
    pause(0.001);
end

%% Best individual
  % Fitness Function
     fitness= zeros(number_population,1);
     for k=1:number_population
         x = population(k,1);
         y = population(k,2);
         for i=1:n_freq
           fitness(k)=  fitness(k) + freq(i)*((coord(i,1)-x)^2+(coord(i,2)-y)^2)^0.5; 
         end
     end
  
  % Individual with the best fitness
  min_fitness = min(fitness);
  best_index = find(fitness==min_fitness,1);
  best = population(best_index,:);
  
  % Add. the best individual on the plot
  %scatter(best(1,1), best(1,2), 50, 'blue', 'filled');
  plot(best(1,1), best(1,2),'b*');
  
  % Normalize the Best coordinate and add. annotation
  str = ['Best Point: (',num2str(round(best(1,1),1)),' ; ',num2str(round(best(1,2),1)),')']
  dim = [.2 .5 .3 .3];
  annotation('textbox',dim,'String',str,'FitBoxToText','on','BackgroundColor','white');