From: "Breton M. Saunders" <bms20@brettnet.eu>
Subject: HID input dealing with multiple collections?
Date: Mon, 09 Sep 2013 13:56:52 +0100
Message-ID: <522DC594.2000305@brettnet.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63788 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab3IIM4z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 08:56:55 -0400
Received: from [192.168.45.122] (unknown [194.223.214.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by brettnet.eu (Postfix) with ESMTPSA id 4B468200252
	for <linux-input@vger.kernel.org>; Mon,  9 Sep 2013 13:54:31 +0100 (BST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

   I've written a USB device which supports multiple input devices:
     * A touch surface digitizer (following Microsoft's specification)
     * A pen surface digitizer
     * A mouse emulator

   In windows each of these interfaces are exposed as a separate top 
level collection, e.g.:
   Usage_Page(Generic Desktop)
   Usage(Mouse)
   Collection(Application)
        ...
   End_Collection
   Usage_Page(Digitzer)
   Usage(Touch_Screen)
   Collection(Application)
      ...
   End_Collection
   Usage(Digitizer)
   Usage(Pen)
   Collection(Application)
      ...
   End_Collection

   Now this descriptor works well in Windows; all reporting channels are 
exposed correctly as hid devices and mouse/multitouch/pen input all 
works correctly as expected.  In linux, however, this is not the case.  
What I see is that if I drop out the touch/pen functionality then the 
mouse support works correctly.  Likewise, if I drop any pair of other 
top level collections such that I have exactly one top level collection 
the system works correctly.

   Am I missing something here - as in: Have I made an error in my usage 
of top level collections, or is linux-input's hid support incapable of 
dealing with multiple top level collections?

   Thanks in advance for any advice on this!

-bms20
