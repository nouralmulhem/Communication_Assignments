<div align= >

# <img align=center width=75px height=75px src="https://media2.giphy.com/media/jPYkx3b1R8X7lLappW/giphy.gif?cid=ecf05e47zkbwgfsujumrocqtcbmhye26zlysngf74qk8adib&ep=v1_stickers_search&rid=giphy.gif&ct=s"> Digital Communication Assignments


</div>
<div align="center">
   <img align="center" height=400px src="https://cdn.dribbble.com/users/1371241/screenshots/6829039/07-wave.gif" alt="logo">

</div>

<p align="center"> 
    <br> 
</p>

## <img align= center width=50px height=50px src="https://thumbs.gfycat.com/HeftyDescriptiveChimneyswift-size_restricted.gif"> Table of Contents

- <a href ="#about"> 📙 Overview</a>
- <a href ="#assignments"> 📝 Assignments</a>
  - <a href ="#assignment1"> ☝️ Assignment 1</a>
  - <a href ="#assignment2"> ✌️ Assignment 2</a>
  - <a href ="#assignment3"> 👌 Assignment 3</a>
- <a href ="#contributors"> ✨ Contributors</a>
- <a href ="#license"> 🔒 License</a>
<hr style="background-color: #4b4c60"></hr>

 <a id = "about"></a>

## <img align="center"  height =50px src="https://user-images.githubusercontent.com/71986226/154076110-1233d7a8-92c2-4d79-82c1-30e278aa518a.gif"> Overview
<br>
<ul> 
<li>
Solution of assignment in course Digital communications ELC325B</li>
<li>This project has solutions for 3 assignments</li>
<ul>
<li><a href="https://github.com/nouralmulhem/Communication_Assignments/tree/main/Assignment%201">Assignment 1</a></li>
<li><a href="https://github.com/nouralmulhem/Communication_Assignments/tree/main/Assignment%202">Assignment 2</a></li>
<li><a href="https://github.com/nouralmulhem/Communication_Assignments/tree/main/Assignment%203">Assignment 3</a></li>
</ul>

<li>Built using  <a href="https://www.mathworks.com/products/matlab.html">Matlab</a></li>

</ul>
<hr style="background-color: #4b4c60"></hr>

<a id ="assignments"></a>

## <img align= "center" width=50px src="https://media4.giphy.com/media/xN3IbsXsm1pOtGOkx2/giphy.gif?cid=ecf05e47lnbd6mvq1joc1wjqtdh7aonlxeiin9t26d7qgrh1&ep=v1_stickers_search&rid=giphy.gif&ct=s"> Assignments 

<a id = "assignment1"></a>

### <img align= "center" width=60px src="https://media0.giphy.com/media/ksNc3DpgrXoVbfm55o/giphy.gif?cid=ecf05e47xx37ikbgcba0srqvlw511mrn6z2g65a20hc3tn00&ep=v1_stickers_search&rid=giphy.gif&ct=s"> Assignment 1
<ul>
<li>This assignment is mainly talking about using uniform quantizer and see the  affect of this quantizer on both uniform signal and non-uniform ones with  small modification on the quantizer</li>
<li> calculating the signal to noise ratio for each to compare results when different number of bits are used to transmit the signal which means a more or less resolution on transmitting</li>
<li> for the non-uniform signal we used smaller quantization 
steps for smaller signal amplitudes this achieved through compressing 
the signal using the μ-Law Companding Technique then applying uniform 
quantizer which is equivalent to non-uniform quantization</li>
<li>View <a href="https://github.com/nouralmulhem/Communication_Assignments/tree/main/Assignment%201">Assignment 1</a></li>
</ul>
<table>
<thead>
<th>Title</th>
<th>Image</th>
<th>Description</th>
</thead>
<tr>
<td>Uniform Quantizer</td>
<td width="50%"><img  src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/5c01f681-9211-4a73-ac15-2b358c524b71"></td>
<td>Function is responsible to quantize and encode the transmitted 
signal to a specific number of levels specified by the number of bits 
it takes so the block outputs the zero-based index of the associated 
region</td>
</tr>
<tr>
<td>Uniform De Quantizer</td>
<td width="50%"><img  src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/92b4a97a-5e91-451c-8ab4-ad2446c52097">
</td>
<td>which was mainly responsible to decode the quantized signal and get the range back to the originally transmitted signal using previously calculated delta and x_min values</td>
</tr>
<tr>
<td>Quantize Dequantize Ramp Signal</td>
<td width="50%"><img  src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/4ecfbb9f-b59b-4255-a464-aaa616194494"><img  src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/90319681-d33e-4b90-8de7-0113ac33df0c"></td>
<td>

- Midrise Figure

  The figure shows a ramp function (dashed) which values ranges from -6 to 6 and the output of the quantizer and dequantizer for this signal where we used the mid-rise staircase for transmitting and using number of bits = 3 which leads to have 8 levels of values. the origin lies in the middle of a raising part of the stair-case like graph.

- Midtread Figure
  This figure shows the same ramp function (dashed) but when we used the mid-tread staircase for transmitting the signal, as shown the origin lies in the middle of a tread of the stair-case like graph. 
</td>
</tr>
<tr>
<td>Uniform Quantizer and De Quantizer on uniform random Signal</td>
<td width="50%"><img  src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/90319681-d33e-4b90-8de7-0113ac33df0c"></td>
<td>
<ul>
<li>The signal-to-noise ratio (SNR) is one of the performance measures used to describe communication systems.
</li>
<li>In this particular figure we did generate a uniform random function and tried to transmit it at different number of levels to see the affect of quantizer and dequantizer on it.
</li>
</ul>
</td>
</tr>
<tr>
<td>Uniform Quantizer and De Quantizer on non-uniform random Signa</td>
<td width="50%"><img  src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/488f63de-a58a-4c01-9099-f79ab5222ef4"></td>
<td>
<ul>
<li>
For this figure we generated a non-uniform random function and tried the uniform quantizer on it and we discovered that for small number of bits we transmit at.
</li>
<li>The SNR value was less than expected and theoretically proved in equations as it is a uniform quantizer applied on a non-uniform signal, in the other hand at higher number of bits we can hardly see a difference.
</li>
</ul>
</td>
</tr>
<tr>
<td>Using a non-uniform 𝝁 law quantizer</td>
<td width="50%"><img  src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/20d79f70-4e3d-4b4d-b250-72a878dae0e6"></td>
<td>
For this part we used non-uniform μ-Law quantizer for different μ-val using zero value for the μ means uniform quantizing the signal the blocks output exactly the same graph as last mentioned one and for different μ-values we could obviously see the difference between theoretically calculated SNR and experimentally calculated one
</td>
</tr>
</table>


<a id = "assignment2"></a>

### <img align= "center" width=60px src="https://media2.giphy.com/media/3o3IJrFTTV6Vf8Mfgy/giphy.gif?cid=ecf05e471k7i9700r3t25juhe42xfdkg4qzmfd6wdgoupt6v&ep=v1_stickers_search&rid=giphy.gif&ct=s"> Assignment 2
<div align="center">
<img height=500px src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/00828815-c7cd-4f92-841f-592f20bd8d4c">
</div>

View <a href="https://github.com/nouralmulhem/Communication_Assignments/tree/main/Assignment%202">Assignment 2</a>
<br>
<table>
<thead>
<th>Description</th>
<th>Image</th>
</thead>
<tr>
<td>Plot the output of the receive filter for the three mentioned cases 
For input: 0011000011
</td>
<td width="40%"><img  src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/793783cf-a554-46a6-9d55-ff7268937efe">
<img  src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/ecd78784-bc65-457d-9098-d8d2fded7cbd">
<img  src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/87c21840-d5d1-4b2d-a6da-b0c89cf8e711">
</td>
</tr>
<tr>
<td>On the same figure, plot the theoretical and simulated Bit Error Rate (BER) Vs E/𝑵𝒐 (where E is the average symbol energy) for the three mentioned cases. Take E/No to be in the range -10 dB: 20:dB. (Use a semilogy plot) 
</td>
<td width="40%"><img  src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/088ab469-5d15-4e77-ac62-1fb623b8bc21">
</td>

</tr>
</table>

<a id = "assignment3"></a>

### <img align= "center" width=60px src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExM3dxeHRrZGUzZW9kZzB2aDVjZjlqaG04OTFucm9oZDA5azBlODYxYyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/Lrge8fr6HFydZqahbw/giphy.gif"> Assignment 3

  Gram-Schmidt orthogonalization is a mathematical procedure that takes a set of linearly independent vectors and constructs an orthogonal or orthonormal set of vectors that span the same subspace. It is commonly used in linear algebra and signal processing.

  View <a href="https://github.com/nouralmulhem/Communication_Assignments/tree/main/Assignment%203">Assignment 3</a>

<table>
<tr>
<td  width="50%">
<img src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/70ebb47c-23de-4971-8bf6-1a80ccf94887" >
</td>
<td  width="50%">
<img src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/905d7979-e1a0-48c9-b34e-43469bb6cd98" >
</td>

</tr>

</table>


<table>
<thead>
<th>Description</th>
<th>Image</th>
</thead>
<tr>
<td>Φ1 VS time after using the GM_Bases function</td>
<td  width="40%">
<img src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/7718f5e6-4368-41ec-8178-f4ff8e2fb13d">
</td>
</tr>
<tr>
<td>Φ2 VS time after using the GM_Bases function</td>
<td  width="40%"><img src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/1181b03a-a42c-431d-a12c-c70f1b0a8605"></td>
</tr>
<tr>
<td>Signal Space representation of signals s1,s2</td>
<td  width="40%"><img src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/ad16f1a3-bfd1-420b-9bde-e8876c128bc2"></td>
</tr>
<tr>
<td>Signal Space representation of signals s1,s2 with E/σ¬2 =10dB</td>
<td  width="40%"><img src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/0ed2d44a-1417-4f60-8912-d118382588b1"></td>
</tr>
<tr>
<td>Signal Space representation of signals s1,s2 with E/σ¬2 =0dB</td>
<td  width="40%"><img src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/57272a81-3e8f-41d9-8669-6dcd0ab637d5"></td>
</tr>
<tr>
<td>Signal Space representation of signals s1,s2 with E/σ¬2 =-5dB</td>
<td  width="40%"><img src="https://github.com/EslamAsHhraf/Hand-Gesture-Recognition/assets/71986226/155d8d47-7482-415e-bad3-01f7aebcc642"></td>
</tr>
</table>

<hr style="background-color: #4b4c60"></hr>
<a id ="contributors"></a>

## <img  align="center" width= 70px height =55px src="https://media0.giphy.com/media/Xy702eMOiGGPzk4Zkd/giphy.gif?cid=ecf05e475vmf48k83bvzye3w2m2xl03iyem3tkuw2krpkb7k&rid=giphy.gif&ct=s"> Contributors 

<table  >
  <tr>
      <td align="center"><a href="https://github.com/nouralmulhem"><img src="https://avatars.githubusercontent.com/u/76218033?v=4" width="150px;" alt=""/><br /><sub><b>Nour Ziad Almulhem</b></sub></a><br /></td>
      <td align="center"><a href="https://github.com/EslamAsHhraf"><img src="https://avatars.githubusercontent.com/u/71986226?v=4" width="150;" alt=""/><br /><sub><b>Eslam Ashraf</b></sub></a><br /></td>
  </tr>
</table>

## 🔒 License <a id ="license"></a>

>This software is licensed under MIT License, See [License](https://github.com/BasmaElhoseny01/frog-frenzy/blob/main/LICENSE) for more information ©Frogger.
