$event:=FORM Event:C1606

Case of 
	: ($event.code=On Mouse Leave:K2:34)
		
		OBJECT SET RGB COLORS:C628(*; "Sample"; 0xFFFFFFF0; 0xFFFFFFF0)
		Form:C1466.color:=""
		
	: ($event.code=On Mouse Enter:K2:33) | ($event.code=On Mouse Move:K2:35)
		
		OBJECT SET RGB COLORS:C628(*; "Sample"; 0xFFFFFFF0; 0xFFFFFFF0)
		Form:C1466.color:=""
		
		var MouseX; MouseY : Integer
		
		$image:=Form:C1466.image
		
		TRANSFORM PICTURE:C988($image; Crop:K61:7; MouseX; MouseY; 1; 1)
		
		CONVERT PICTURE:C1002($image; ".bmp")
		PICTURE TO BLOB:C692($image; $bmp; ".bmp")
		
		If (BLOB size:C605($bmp)>=18)
			
			var $BITMAPFILEHEADER : Blob
			COPY BLOB:C558($bmp; $BITMAPFILEHEADER; 0; 0; 14)
			
			$o:=0x0000
			
			$signature:=BLOB to integer:C549($BITMAPFILEHEADER; PC byte ordering:K22:3; $o)
			
			If ($signature=0x4D42)
				
				$size:=BLOB to longint:C551($BITMAPFILEHEADER; PC byte ordering:K22:3; $o)
				$reserved1:=BLOB to integer:C549($BITMAPFILEHEADER; PC byte ordering:K22:3; $o)
				$reserved2:=BLOB to integer:C549($BITMAPFILEHEADER; PC byte ordering:K22:3; $o)
				$offset:=BLOB to longint:C551($BITMAPFILEHEADER; PC byte ordering:K22:3; $o)
				
				var $data : Blob
				COPY BLOB:C558($bmp; $data; $offset; 0; $size-$offset)
				$rgb:=BLOB to longint:C551($data; PC byte ordering:K22:3)
				$rgb:=$rgb & 0x00FFFFFF
				
				OBJECT SET RGB COLORS:C628(*; "Sample"; $rgb; $rgb)
				$color:="00"+Substring:C12(String:C10($rgb; "&x"); 3)
				Form:C1466.color:="#"+Substring:C12($color; Length:C16($color)-5)
				
			End if 
			
		End if 
		
End case 