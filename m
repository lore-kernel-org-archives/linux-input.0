From: Jonathan BISSON <bissonjonathan@gmail.com>
Subject: Linux Kernel: Microsoft Digital Media Keyboard 3000
Date: Wed, 11 Jul 2012 00:53:47 +0200
Message-ID: <4FFCB27B.9060809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55221 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab2GJWvS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jul 2012 18:51:18 -0400
Received: by wibhr14 with SMTP id hr14so486569wib.1
        for <linux-input@vger.kernel.org>; Tue, 10 Jul 2012 15:51:17 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, dtor@mail.ru, linux-input@vger.kernel.org

Hi,


I've a problem with my Microsoft Digital Media Keyboard 3000 (USB).

One part of the keyboard is seen as a joystick.


I managed to get most keys working by :

blacklisting joydev

adding:


in my udev config:
ENV{ID_VENDOR}=3D=3D"Microsoft", ENV{ID_MODEL_ID}=3D=3D"0730", RUN+=3D"=
keymap
$name 0xc022d zoomin 0xc022e zoomout 0xc01b6 camera 0xc01ab f20"

0xC022D and 0xC022E are zoom in and zoom out keys
0xC01B6 is the camera key
0xC01AB is the Fn-F10 (when disabling the function keys with the specia=
l
button switch)

The only one I'm lacking is the 0xC01A2 which corresponds to the =ABAer=
o=BB
key. I can see the scan code when looking in the scancodes given by the
/sys thing, but it's not taken into account. This scancode is not
described neither in the 3.4 kernel source hid-input part. So that can
explain why I can't map this key.


Do I just have to send a patch for adding the corresponding scancode ?

What to do for this part of the keyboard seen as a joydev ?


Thanks for your work on the kernel !
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
