# LeastSquares
Visualization of the Ordinary Least Squares estimation of slope for a simple linear model

(1) Left pane illustrates line (defined by center of mass and slope) and individual squared residuals
(2) Right pane illustrates sum of squared residuals as function of slope

![Resulting GIF](https://github.com/PeterStoltze/LeastSquares/blob/master/LeastSquares.gif

I originally created this back in 2010 using only base R and in less than 100 lines of code. The multipage pdf was added to LaTeX slides (beamer) and brought to live using the animate package.

Today and edited the code ever so slightly converting comments from Danish to English, and then I converted the resulting multipage pdf to an animated gif using a webservice, https://ezgif.com/.

IMHO a nice touch is the shading of overlapping squares :-)

Please feel free to improve upon this. A few things come to mind:
* Create the gif using code
* Move some of the calculation outside loop (although they are quite light)
* In this setup the range of slopes to explore is set by a single handpicked parameter (delta)
* Implement in ggplot2 ;-)
