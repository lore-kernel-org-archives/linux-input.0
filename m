From: Goffredo Baroncelli <kreijack@gmail.com>
Subject: [RFC][PATCH] Add support for mouse logitech m560
Date: Sat, 23 Aug 2014 14:40:26 +0200
Message-ID: <1408797629-3474-1-git-send-email-kreijack@inwind.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:60226 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbaHWMeY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Aug 2014 08:34:24 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so11413835wev.26
        for <linux-input@vger.kernel.org>; Sat, 23 Aug 2014 05:34:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


Hi all,

I bought the mouse in subject. This is a mouse designed for windows 
8. Comparing to a standard one, some buttons (the middle one and the 
two ones placed on the side) are bounded to a key combination 
instead of a button.

Think this mouse as a pair of mouse and keyboard. When the middle
button is pressed the first time it sends a key (as keyboard) 
combination, the same for the other two side button.
Instead the left/right/wheel work correctly.
To complicate further the things, the middle button send a
key combination the odd press, and another one for the even press;
in the latter case it sends also a left click. No event is
generated when the middle button is released.

It is very frustrating to use this mouse in Linux.

Moreover this device is a wireless mouse which uses the unifying 
receiver.

I modified the driver hid-logitech-dj.c to support this, and now
it behaves like an ordinary mouse. I added some hooks to the
standard driver, which translate the "keyboard" event into the
appropriate mouse event.

These hooks call the "right" handler on the basis of the name of
the device (the USB id are the one of the receiver).

Below the patch. This is an RFC because I am not sure if this is 
the right thing to do. I would prefer implements these handler in
other kernel module (to simplify the developing), bu the logic of
the plug-and-play (call the right driver when the device is 
discovered and/or the driver is available), fights when exists
a "default driver" (i.e the one provided today by 
hid-logitech-dj.c.

BR
G.Baroncelli

P.S.
Please put me in CC in case of reply because I am not subscribed
to the mailing list. Thank

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D 17B2 0EDA 9B37 8B82 E0B5
