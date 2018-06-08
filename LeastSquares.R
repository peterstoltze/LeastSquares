# Creating simple data set
x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
y <- c(2, 1, 4, 6, 2, 5, 8, 5, 7,  9)

# Fitting a line using OLS
line <- lm (y~x)

# Finding mean of x and y
xb <- mean(x)
yb <- mean(y)

# Define different slopes for which to calculate sum of squares
nstep <- 100 
delta <- 0.25
beta1 <- seq (from=line$coeff[2]-delta, to=line$coeff[2]+delta, length=nstep)

# Derive intercept corresponding to slopes as line must pass (xb,yb)
beta0 <- yb - beta1 * xb

################################
# Defining graphics for single slope as a function
# (1) Left pane illustrates line (defined by (xb,yb) and slope) and
# individual squared residuals
# (2) Right pane illustrates sum of squared residuals as function of slope
LinRegPlot <- function(i){
  
  def.par <- par(no.readonly = TRUE) # save default, for resetting...
  layout(matrix(c(1,1,2), 1, 3, byrow = TRUE))
  
  # (1) Squared Residuals shown as actual squares
  par (mar=c(4, 4, 1, 1) + 0.1 )
  
  # Data points, LS line, and center of mass
  plot (x,y, col="blue",pch=16,xlim=c(0,10),ylim=c(0,10),asp=1)
  abline (line, col=rgb(1,0,0,0.2))
  abline (h=yb, lty="dashed")
  abline (v=xb, lty="dashed")
  
  # Adding specific line and corresponding "squared residuals"
  abline (beta0[i],beta1[i],col=rgb(1,0,0))	
  yhat <- beta0[i] + beta1[i]*x
  
  for (j in 1:length(x)){
    d <- abs(y[j] - yhat[j])
    
    # y is above line
    if (y[j] > yhat[j]){
      xp <- c(x[j],x[j],x[j]-d,x[j]-d)
      yp <- c(y[j],y[j]-d,y[j]-d,y[j])
      polygon (xp,yp,border=NA,col=rgb(0,0,1,0.2))
    }
    
    # y is below line
    if (y[j] < yhat[j]){
      xp <- c(x[j],x[j],x[j]+d,x[j]+d)
      yp <- c(y[j],y[j]+d,y[j]+d,y[j])
      polygon (xp,yp,border=NA,col=rgb(0,0,1,0.2))
    }
    
    # if y is on line, by definition no error and hence no square...
  }
  
  # (2) Profile for sum of squares
  par (mar=c(4, 4, 1, 1) + 0.1 )
  
  # laver input af (beta0,beta1) til profil
  bbeta1 <- seq(from=min(beta1),to=max(beta1),length=nstep)
  bbeta0 <- yb - bbeta1 * xb
  
  # calulating sum of squares (sak in Danish)
  sak <- numeric(nstep)
  
  for (j in 1:nstep){
    yhat <- bbeta0[j] + bbeta1[j]*x
    sak[j] <- sum((yhat-y)^2)  
  }
  
  # plot ss-profile and both current and optimal slope
  plot (bbeta1, sak, type="l", col=rgb(0,0,1), xlab="Slope", ylab="Sum of Squares")
  
  abline (v=beta1[i],col=rgb(1,0,0))
  abline (v=line$coeff[2], col=rgb(1,0,0,0.2))
  
} # end-of-function


pdf ("LeastSquares.pdf", onefile=TRUE, version = "1.4", width=6,height=4)
for (i in 1:nstep){
  LinRegPlot(i)
}
for (i in (nstep-1):2){
  LinRegPlot(i)
}
dev.off()
