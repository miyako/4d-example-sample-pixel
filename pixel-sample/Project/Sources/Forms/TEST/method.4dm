$event:=FORM Event:C1606

Case of 
	: ($event.code=On Load:K2:1)
		
		$imageData:=Folder:C1567(fk resources folder:K87:11).file("Studio Color.png").getContent()
		BLOB TO PICTURE:C682($imageData; $image)
		Form:C1466.image:=$image
		
End case 