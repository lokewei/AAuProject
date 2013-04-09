import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;



public class Paowuxian {
    private double angle ;//�Ƕ�
    private float windVelocity; //����
    //private int windDirection; //����
    //private int time;// ʱ��
    private Point pStart;//��ʼ��
    private Point pEnd;//�յ�
   
    private float g;//�������ٶ�
    public static void main(String[] args) {  
        Point ps=new Point(5,15);
        Point pe=new Point(10,10);
        Paowuxian paowuxian=new Paowuxian();
        paowuxian.init( 180, 0f, 9.8f, ps, pe);
        paowuxian.drawLine();
        //System.out.println(Math.cos(170.0));
    }
   
    /**
     * 
     * @param angle �Ƕ�
     * @param windVelocity ����
     * @param g �������ٶ�
     * @param pStart ��ʼ��
     * @param pEnd �յ�
     */
    public  void  init(int angle,float windVelocity,float g,Point pStart,Point pEnd){
        
        this.angle=Math.toRadians(angle);
        this.windVelocity=windVelocity;
        this.g=g;
        this.pStart=pStart;
        this.pEnd=pEnd;
    }
    /**
     * ��ȡ�����߲�����
     */
    public  List<Point>  drawLine(){
        System.out.println(" begin point(x,y)=('" +pStart.getX()+"','"+pStart.getY()+"')");
        int horiz=pEnd.getY()-pStart.getY();
        int vert=pEnd.getX()-pStart.getX();
       
        System.out.println("Math.sin(angle)||Math.cos(angle)"+Math.sin(angle)+","+Math.cos(angle));
        System.out.println("�����ˮƽ����ֱ����("+vert+","+horiz+")");
        
        double a=roundBy4((vert*Math.sin(angle)- horiz*Math.cos(angle))*Math.cos(angle));
        double b=roundBy4(vert*Math.sin(angle)-2*horiz*Math.cos(angle))*windVelocity;
        double c=roundBy4(-(0.5*g*vert*vert-horiz*windVelocity*windVelocity));
        System.out.println("a="+a+" b='" +b+"',c='"+c+"'");

        float spreed=calculateSpeed( a, b, c);
        pStart.setSpeedx((float)(spreed*Math.cos(angle)+windVelocity));
        pStart.setSpeedy((float)(spreed*Math.sin(angle)));
        
        float time=Math.abs( vert/(pStart.getSpeedx()));
        List<Point> pointList=new ArrayList<Point>();
        for (int i = 1; i <=15; i++) {
            Point point=new Point();
            drawPoint( point, time*i/15);
            pointList.add(point);
        }
        System.out.println(" end point(x,y)=('" +pEnd.getX()+"','"+pEnd.getY()+"')");
        return pointList;
    }
    /**
     * 
     * @param t ʱ��
     */
    public  Point  drawPoint(Point pointT,float time){
        float vy=pStart.getSpeedy()-g*time;
        pointT.setSpeedy(vy);
        //System.out.println(" before running time "+time+"pointT(x,y)=('" +pointT.getX()+"','"+pointT.getY()+"')" );
        int sy=Math.round((float)(pStart.getSpeedy()*time-g*time*time/2)) ;
        int sx=Math.round((float)(pStart.getSpeedx()*time));
        pointT.setY(pStart.getY()+sy);
        pointT.setX(pStart.getX()+sx);
        
        System.out.println(" running time="+time+" pointT('" +pointT.getX()+"','"+pointT.getY()+"')" );
        
        return pointT;
        
    }
  
    public static float calculateSpeed(double a,double b,double c) {
        float speed=0.0f;
        if(Double.compare(a, 0.0d)== 0){
            System.out.println("��һԪһ�η���");
            speed=(float)(c/b);
            System.out.println("�����ٶ�Ϊ"+speed);
        }
        else if(b*b-4*a*c==0){
            speed= (float)((-b+Math.sqrt(b*b-4*a*c))/(2*a));
            System.out.println((-b+Math.sqrt(b*b-4*a*c))/(2*a));
            System.out.println("�����ٶ�Ϊ"+speed);
        }else if (b*b-4*a*c>0){
            /*speed= (float)((-b+Math.sqrt(b*b-4*a*c))/(2*a));
            speed= (float)((-b-Math.sqrt(b*b-4*a*c))/(2*a));*/
            if ((-b+Math.sqrt(b*b-4*a*c))/(2*a)>0) {
                speed= (float)((-b+Math.sqrt(b*b-4*a*c))/(2*a));
                System.out.println("�����ٶ�Ϊ"+speed);
            }else {
                speed= (float)((-b-Math.sqrt(b*b-4*a*c))/(2*a));
                System.out.println("�����ٶ�Ϊ"+speed);
            }
        }else{
            System.out.println("�Բ�����ϵĳ����ٶ�");
        } 
        return speed;
    }
    public double getAngle() {
            return angle;
        }
    public void setAngle(double angle) {
        this.angle = angle;
    }

    public float getWindVelocity() {
        return windVelocity;
    }

    public void setWindVelocity(float windVelocity) {
        this.windVelocity = windVelocity;
    }

    public Point getPStart() {
        return pStart;
    }

    public void setPStart(Point start) {
        pStart = start;
    }

    public Point getPEnd() {
        return pEnd;
    }

    public void setPEnd(Point end) {
        pEnd = end;
    }

    public float getG() {
        return g;
    }

    public void setG(float g) {
        this.g = g;
    }
    
    public static double roundBy4(double value){
        return round( value, 4, BigDecimal.ROUND_HALF_UP);
    }
    /** 
     * ��double���ݽ���ȡ����. 
     * @param value  double����. 
     * @param scale  ����λ��(������С��λ��). 
     * @param roundingMode  ����ȡֵ��ʽ. 
     * @return ���ȼ���������. 
     */ 
    public static double round(double value, int scale,
             int roundingMode) {  
        BigDecimal bd = new BigDecimal(value);  
        bd = bd.setScale(scale, roundingMode);  
        double d = bd.doubleValue();  
        bd = null;  
        return d;  
    }
}
