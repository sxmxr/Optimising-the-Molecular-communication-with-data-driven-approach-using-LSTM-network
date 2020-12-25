# Molecular-Communications-Model-Based-and-Data-Driven-Receiver-Design-and-Optimization
## 1.1 System Model/Network Model
The channel considered in the article works on the Fick’s second law of diffusion i.e. the molecules will moves towards the less concentration from the higher concentration. It uses CSK (Concentration Shift Keying).
It shares (on-off shift keying) to transmit information particles towards the receiver. Also the the diffused particles follow Brownian motion and moves randomly and independently. This creates the interference between the molecules reaching at different time slots. This interference is known as Inter Symbol Interference(ISI) and we try to model different threshold based receivers to identify correct transmitted bit and lower BER.[2]
## 2.1 System model of ANN:
The Artificial Neural Network can also be known as weighted directed graph, where the nodes are the artificial neuron and the connections between the neuron outputs and neuron inputs is represented by edges with some weight. [1] The artificial neural networks receives the input signal from the external world in the form of a pattern and the image in the form of vector. It can be represented mathematically as x(n) for any number of input. Each of these inputs is then multiplied with the corresponding weights. These weights represents the strength of the interconnections in the artificial neural networks. If the weight of a particular edge is zero, then a bias is added in order to make the output non-zero. The Bias has a weight and the input for it is always 1. The range of the sum of the weighted inputs lies between 0 to infinity. The different types of layers present in the artificial neural networks are as follows:
1.	Input Layer : The input layer consists of those artificial neurons which receives input from theouter world.
2.	Output Layer : The output layers contain the artificial neurons which receives the output fromthe model and it is also used to check if has learned any task or not
3.	Hidden Layer : The Hidden layer are the intermediate layers between the input layers and theoutput layers. The hidden layer is used to change the input data into an desired output by using some particular techniques.
The ANN model is trained priorly or is fed with a large amount of data .Training consists of providing input and telling the network about the desired output.Each input is accompanied by the some matching information.By Providing the answers it becomes easy for the model to adjust its internal weightings in order to perform the jobs better. The type of ANN model that we have used is the Feed
Forward Neural network . The Feed Forward neural network is the simplest of the various different ANN models. In this type, the information is passed in one direction only, from the input layer towards the Output layer.
## 2.2	LSTM Network:
One of the most import recurrent neural networks in deep learning is the Long-Short Term Memory network (LSTM). A LSTM based system is used for the detection of the transmitted symbol at the collector in which the past assessed symbols are taken care of alongside the current number of particles so as to expand the presentation of the model expecting no channel information gave at the recipient. It is capable for storing memory and can practice long term dependencies that beats the issue of other neural networks.LSTM has been widely applied in many areas, especially in time series modeling, including speech recognition, natural language processing and sequence prediction. So basically we proposed 2 data-driven models: ANN model and LSTM model. The major difference between these two is that ANN doesn’t have any memory elements so that it is not able to store the information.
### 2.2.1	System Model of LSTM:
LSTM is an extremely efficient tool when the information is sequential. The basic condition of LSTM modeling is that all inputs and outputs are independent of each other.
y(k) = φ[y(k − 1),y(k − 2),../y(k − ny),u(k),...,u(k − ny)]
φ(·) is an unknown non-linear difference equation representing the plant dynamics, u(k) and y(k) are measurable scalar input and output, ny and nu are the last values of the output and input, respectively, to be considered for the system dynamics. LSTM uses gas cell to remember them. The key to LSTMs is the cell state. The gate in LSTM is a way to permit information to enter. LSTM has three gates to protect and control the cell state: [2]
a)	Forget gate
b)	Input gate
c)	Output gate
Each of these gates are binary gates. Input gate controls whether the memory cell is updated whereas forget gate controls if the memory cell is reset to 0 and finally the output gate controls whether the information of the current cell is made visible or not.
# Reference
1.	X. Qian, M. Di Renzo, and A. Eckford, ”Molecular communications: Model-basedand data-driven receiver design and optimization,”IEEE Access, vol. 7, pp. 53 555-53 565, 2019.
2.	Xuewen Qian, Marco Di Renzo. Receiver Design in Molecular Communications: An Approach Based on
Artificial Neural Networks. 2018 15th International Symposium on Wireless Communication Systems
(ISWCS), Aug 2018, Lisbon, Portugal. ff10.1109/ISWCS.2018.8491088ff. ffhal-01923667
3.	R. Mosayebi, H. Arjmandi, A. Gohari, M. Nasiri-Kenari, and U. Mitra, Receivers for diffusion-based molecular communication: Exploiting memory and sampling rate,” IEEE J. Sel. Areas Commun., vol.
32, no. 12, pp. 23682380, Dec. 2014.
