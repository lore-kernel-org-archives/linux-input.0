From: Diego Zuccato <diego@otello.alma.unibo.it>
Subject: Re: REGRESSION: 2.6.24:  false double-clicks from USB mouse
Date: Thu, 06 Dec 2007 09:27:52 +0100
Message-ID: <4757B288.7060907@otello.alma.unibo.it>
References: <4752DB8C.50608@rtr.ca> <4752E432.10504@rtr.ca> <4752E5AD.40905@rtr.ca> <4752F226.1090003@garzik.org> <Pine.LNX.4.64.0712021907490.13260@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from otello.alma.unibo.it ([137.204.24.163]:58214 "EHLO
	otello.alma.unibo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbXLFLp5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Dec 2007 06:45:57 -0500
In-Reply-To: <Pine.LNX.4.64.0712021907490.13260@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <lkml@rtr.ca>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, rubini@ipvvis.unipv.it, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org

Jiri Kosina ha scritto:

>> My USB mouse recently started giving me phantom scrolls (movements of 
>> the mouse wheel, even I made sure the wheel was in a resting position) 
>> in recently kernels.  It happened too infrequently for me to care.
> Did this also start in 2.6.24, as in Mark's case?
It happens to me, too.
Wireless mouse, gives some "wheel up" signals when going into powersave
state. Kernel is 2.6.22-tmb-laptop-2mdv (Mandriva Cooker).

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=062a ProdID=0000 Rev= 0.00
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

Maybe a more-or-less undocumented sequence to tell the host it's going
to sleep?

BYtE,
 Diego.
