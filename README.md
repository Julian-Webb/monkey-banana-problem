# monkey-banana-problem
I try to solve a harder version of the classic monkey banana problem. It involves a knife, a tap, and a monkey that refuses to feast in an untidy room. The code is written in PDDL. 

The problem description:
The monkey and banana problem1is a well-known toy problem from the field of AI. It consists of a monkey in a room with some bananas hanging from the ceiling 
outside its range. In addition, a crate is available that the monkey can use to reach the bananas by climbing on them. The monkey and the box have the height low, 
but when the monkey climbs on the box, it has the height high, same as the bananas. The monkey is then able to get the bananas.  
https://en.wikipedia.org/wiki/Monkey_and_banana_problem  
In contrast to the basic problem outlined in Figure 1, we make some additions:  
1.  The monkey is kept in discrete positions, i.e. instead of 3 positions, a total of 6 positions P1 to P6 are available. The monkey is initially at position P1, 
the bananas are hanging at position P3 and the box is at position P2.  
2.  The bananas are attached to the ceiling, which means that the monkey can’t just take them just like that.  He  therefore  needs  a  knife  to  cut  the  
bananas  from  the  ceiling.  This  knife  should  initially  beplaced at the position P4. The monkey can hold the knife and the bananas at the same time.
3.  The monkey would also like to have something to drink with his bananas. To do this, he can fill up a water glass at a water tap. The water tap is located 
at position P5 on the ceiling (high). The filled water glass is so heavy that the monkey cannot hold the knife or the bananas at the same time.
4.  The monkey loves order and therefore wants to eat in a tidy room. For this, the box and the knife must be at the edge of the room and the monkey must be in a
position where there is no box.The following functions are available to the monkey
•Go: To get from one place to another.
•Climbing: To climb a box that is in the same place as the monkey. After this action, the height of themonkey ishigh.
•Get down: To climb down again from a crate. After this action the height of the monkey islow.
•Take Bananas: To grab a banana to be able to transport it afterwards.
•Take Knife: Um ein Messer zu greifen und danach transportieren zu k ̈onnen.
•Greife Wasserglas: To be able to grab a knife and transport it afterwards.
•Release: To release a held object (knife, banana, water glass). Afterwards, the object should be in thesame place and at the same height as the monkey.
•Push: To move a box that is in the same place as the monkey to another position. However, the monkeycan only do this if it has both hands free, i.e. it is not 
transporting a banana at the moment.
•Fetch water: To fill a held water glass at the tap with water. Now model a suitable PDDL domain and a problem definition to describe the extended monkey and 
banana problem. Use the FF planner to test your modeling. 
You can test using the following command:
$ rosrun ff ff -o domain.pddl -f problem.pddl
