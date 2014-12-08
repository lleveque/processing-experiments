//bejoscha
//9 Jul 2010
//Hmm, could you explain a little further what is going on, and what one can "see" in this sketch? I am not sure I fully grapped it.
//
//Alasdair Turner
//9 Jul 2010
//I can try.
//Firstly in technical language, and then as a more intuitive description. 
//You're looking at a feed-forward multilayer perceptron, with one input layer (at the bottom), 
//one hidden layer (semi-transparent) and one output layer (at the top). 
//Each layer has a number of perceptrons (artificial 'neurons'): there are 196 in the input layer, 
//49 in the hidden layer and 10 in the output layer, so in the literature, it would be called '196-49-10' network.
//All the perceptrons in the input layer are connected to all the perceptrons in the hidden layer (a total of 196 x 49 = 9604 connections), 
//and all the perceptrons in the hidden layer are connected to the output layer (49 x 10 = 490 connections). 
//These connections are not shown because there are simply too many of them to make any sense. 
//All you see is the response of each perceptron in the hidden and output layers to the summation of its inputs.
//In metaphoric language: the 'input layer' might be thought of as a 'retina' which is presented with a number. 
//These 'neurons' either excite or inhibit the response of the brain through their connections to the 'hidden layer'. 
//The 'hidden layer' might be thought of as an indication of the brain activity in response to the retinal image. 
//Similarly the 'output layer' might be thought of the result of the brain activity leading to a signal to say 'one', 'two', 
//'three' and so on up to 'nine' and finally 'zero'.
//If there is just one black and nine white neurons displayed in the output layer, 
//that is a signal to say that number - e.g., if only the fourth neuron along is black, that means 'say four'. 
//If more than one is dark grey, that is a sign the network is unsure. 
//For example it might 'think' it is seeing either a 'four' or a 'nine', and mark both of those as almost black.
//The two printed numbers to the right reflect the actual known input at the bottom 
//(e.g., this image presented to the retina is intended to be a '4'), 
//and the network's best guess at the top (e.g., I'm not sure, it could be a '4' or a '9', but if I had to choose, I would say it's a '9').
//I hope this helps!
