From: Daniel FAIVRE <webmaster@geomaticien.com>
Subject: N-trig support
Date: Wed, 21 Oct 2009 06:39:07 +0200
Message-ID: <200910210639.08138.webmaster@geomaticien.com>
References: <4AD5DEF5.9020401@suse.com> <200910150547.30061.webmaster@geomaticien.com> <4AD6BEF8.6040308@seas.upenn.edu>
Reply-To: webmaster@geomaticien.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:47277 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbZJUEiX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2009 00:38:23 -0400
In-Reply-To: <4AD6BEF8.6040308@seas.upenn.edu>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org

Hi,

After our last mails about n-trig support, I have :

- reported a bug for  OBS HEAD kernel-desktop (some opensuse build service 
kernels do not include drivers as modules)
https://bugzilla.novell.com/show_bug.cgi?id=548445

- reported a bug for outdated n--trig.c , suggesting is replacement by the one 
from git as suggested by Rafi.
https://bugzilla.novell.com/show_bug.cgi?id=548463

- tested the last linuxwacom-dev from cvs, patched to support n-trig :
the touch support is far better with the dev version : a touch tap is a click 
far more easily than with the last release. Touch beacame very smooth, as 
much as comfortable as under windows !
Last commit on linuxwacom was "Support Tablet PCs 0xE2 and 0xE3 as well as 
touch only tablet 0x9F" : THE NTRIG PATCH IS STILL MISSING !!!

Multitouch support :
In wcmUSB.c, we can see that support for multitouch is now included, waiting 
an event BTN_TOOL_TRIPLETAP.
A new option for xorg.conf, "Gesture", is used. 
Actually, this could not work for n-trig because hid-ntrig.ko does NOT send 
any BTN_TOOL_TRIPLETAP event, but it may be something to investigate ?

Screen buttons support :
Among patches for linuxwacom on sourceforge, one is used to detect and convert 
events from these three buttons.

X crashes : I encounter some X crashes with wacom_drv.so :
The system log reports :
wacom: v1.49-pc-1:USB Wacom Graphire and Wacom Intuos tablet driver
[Xorg[2694]: segfault at 6a0000000f ip 00007fded576e5c5 sp 00007fff73602780 
error 4 in wacom_drv.so [7fded578000+18000]

Wacom X drivers compiled from last release or from cvs have the same issue. 
That happens always when quitting an X session, and freeze display and all 
input devices, including keyboard. That also sometimes happens at boottime 
when starting X.
When X crash after booting, logs always reports things like :
0 is not supported by linuxwacom or 
1F is not supported by linuxwacom ...
When closing the X session, it seems to be related to :
X(deleteInputDeviceRequest+0x3b) [0x47713b]

In both cases, this issue seems related to wrong device vendor/product used in 
linuxwacom. Any idea to fix that ?

Best regards,
-- 
Daniel FAIVRE
