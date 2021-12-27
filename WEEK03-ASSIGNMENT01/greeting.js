var message;

function greeting(occasion){
switch(occasion) {
    case 'New_year':
        message = "Happy New Year";
      break;
    case 'Chrismas' :
        message = "Merry Christmas";
      break;
    case 'Birthday' :
        message = "Happy Birthday";
        break;
    case 'Anniversary' :
        message = "Happy Anniversary";
      break;  
    default:
        message = "No occasion";
  }
  console.log("On  "+occasion+" "+message);
}
greeting("New-Year");
greeting("Chrismas");
greeting("Birthday");
greeting("Anniversary");
greeting("Holiday");
