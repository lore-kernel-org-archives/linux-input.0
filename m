From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: IS_INPUT_APPLICATION and tablets
Date: Wed, 20 May 2009 23:30:07 +0200
Message-ID: <33210D89-9534-4B12-B7C3-E7FAEA3C4A5D@enac.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:46232 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbZETVaM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2009 17:30:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, jirislaby@gmail.com
Cc: Greg KH <greg@kroah.com>, linux-input@vger.kernel.org

Dear Jiris, dear Greg,

I just saw a message in the linux-input ml about a USB tablet that is  
not registered in the input layer. Someone proposed that there might  
be no useful application in the HID report descriptors.

There is an other possibility: the IS_INPUT_APPLICATION in hid.h  
might fail to capture a legitimate application. I am currently  
working on a HID driver for a multitouch surface by Stantum that has  
application usage 0x000d0004 (Digitizer / Touchscreen), and I had to  
change IS_INPUT_APPLICATION to have it registered in the input layer.  
The N-Trig surface is registered only because it declares two  
application collections: a Pen and a Touchscreen.

The comment that accompanies the definition of the macro looks very  
old. Is there another reason why the definition of input applications  
is so restrictive? I had in mind to add the range  
0x000d0002-0x000d0006 at least. Is there any contraindication to this?

St.

