From: Michael Schmitt <tcwardrobe@gmail.com>
Subject: Logitech Wave Y-RCP140 on not-original receiver
Date: Thu, 11 Apr 2013 05:11:03 +0200
Message-ID: <516629C7.6080108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:34194 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936152Ab3DKDLI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Apr 2013 23:11:08 -0400
Received: by mail-ea0-f180.google.com with SMTP id d10so509005eaj.39
        for <linux-input@vger.kernel.org>; Wed, 10 Apr 2013 20:11:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi folks,

first, please bear with me if I ask some too basic questions here, as I 
did not find any comprehensive resources on the web to answer those 
"beginner questions" and / or my head started to smoke as some stuff I 
found was kind of too deep into the whole input layer stuff and got me 
rather confused on the way...

The situation:
I got a Logitech Wave keyboard (which was already discussed on this list 
back in 2008) connected to an usb receiver which does not belong to the 
keyboard originally. It has the USB-ID "046d:c505" and is shown as 
"Logitech, Inc. Cordless Mouse+Keyboard Receiver". I have several 
wireless Logitech keyboards and at least two receivers, but only one of 
them pairs successfully with the Wave-keyboard. All "normal" keys work, 
even some of the additional keys work, but some do not show a thing via 
showkey / xev / evtest. Only via usbmon I can see some action while 
pressing those dead keys.

The problem:
Mucho grande confusion and no idea where my head stands... as I've read 
the mentioned thread from back in 2008 I have the impression that the 
keyboard should at least recognize some of the additional keys, as some 
talk was going on there to include some quirks in some logitech-function 
in its hid-driver. The rest would not work because of the "higher than 
keycode 255"-issue, but even there I am not quite sure anymore.
Anyway, as only the most basic additional keys work (probably those that 
the keyboard had that shipped with the receiver originally) I *assume* 
that is because the kernel does not bother with the other keycodes the 
keyboard sends, as the original keyboard for that receiver did not have 
those keys?

The questions:
First, obvioulsy, is my assumption right? Do most additional keys not 
work because I use a not-originally-shipped-with receiver?
Second, I guess it would not make any sense adding the receiver I use 
for that keyboard to the mentioned "quirks"-section in the logitech 
hid-driver as I may be the only person on this planet using that 
combination. ;) But can I request the running kernel to see the receiver 
as the originally-shipped-with receiver? Or do I need to patch the 
source on my own? Does that even make any sense or is it a bogus idea 
and I just don't see it?
Third, if the kernel sees my receiver as the "original" one, setkeycode 
and the like will do the rest to make *all* keys work in X?
Forth, every 30 seconds without any keys pressed I see this with usbmon 
for that device (bus):

 > dd4a4680 1694370199 S Ci:4:011:0 s c0 09 0003 0000 0008 8 <
 > dd4a4680 1694373253 C Ci:4:011:0 0 8 = 043e800f 00008001

Normally not even worth asking, but as I am writing this mail, I may 
also include that question. :) Any idea what that is? Some 
ping-pong-thing to see if a device is still there?

regards and greetings
Michael
(I am subscribed, no cc needed, but I won't mind...)
