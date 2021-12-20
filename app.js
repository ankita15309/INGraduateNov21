function book(bookid,bookname,authorname){
    this.bookid=bookid;
    this.bookname=bookname;
    this.authorname=authorname;
    this.displayDetails = function (){
        return this.bookid + " " + this.bookname +" "+this.authorname;
    };
}
const Book1=new book ("16262","wings_of_fire","A.P.J.abdul kalam");
const result=document.getElementById("result");
result.innerHTML=Book1.displayDetails();