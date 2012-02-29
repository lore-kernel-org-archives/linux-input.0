From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: include patch to solve bug 916319
Date: Wed, 29 Feb 2012 12:54:43 +0100
Message-ID: <20120229115443.GA22868@polaris.bitmath.org>
References: <4F4E0451.5050106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:33890 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab2B2LyS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Feb 2012 06:54:18 -0500
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 62901C6D7
	for <linux-input@vger.kernel.org>; Wed, 29 Feb 2012 12:54:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F4E0451.5050106@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Diego Carrera Gallego <diegocarrera2000@gmail.com>
Cc: linux-input@vger.kernel.org, "Gustavo F. Padovan" <padovan@profusion.mobi>

Hi Diego,

> According instructions of Joseph Salisbury at
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/916319
> 
> I send this patch, in order to include into ubuntu kernel,
> 
> Credits to: eran, http://thread.gmane.org/gmane.linux.bluez.kernel/18801
> 
> 
> Changelog: Bluetooth: Adding USB device 13d3:3375 as an Atheros AR3012.
> Description:

You sent your request to the linux input subsystem, which (usually)
does not handle bluetooth patches. I have added the correct maintainer
to CC here.

It seems the patch you refer to is already on-route to the mainline
kernel, although it has yet to appear in linux-next. Thus, nothing
more should need to be done but wait.

Once the patch is available upstream, if you want the attention of the
ubuntu kernel developers, try sending a mail to their list
(kernel-team@lists.ubuntu.com), asking for a cherry-pick. Make sure to
motivate the pick properly. :-)

> 
> The bluetooth module in the Asus UX31/UX21 is based on Atheros AR3012
> and requires a firmware to be uploaded before it's usable.
> 
> output of usb-devices for this module:
> T:  Bus=01 Lev=02 Prnt=02 Port=07 Cnt=03 Dev#=  6 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3375 Rev=00.02
> S:  Manufacturer=Atheros Communications
> S:  Product=Bluetooth USB Host Controller
> S:  SerialNumber=Alaska Day 2006
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> 
> Signed-off-by: Diego Carrera diegocarrera2000@gmail.com
> 
> 
> ------------
> 
> Please, tell me if everything is ok
> 
> Thanks so much
> 
> Diego
> 

> diff -ur linux-3.2.5.orig/drivers/bluetooth/ath3k.c linux-3.2.5/drivers/bluetooth/ath3k.c
> --- linux-3.2.5.orig/drivers/bluetooth/ath3k.c	2012-02-06 18:47:00.000000000 +0100
> +++ linux-3.2.5/drivers/bluetooth/ath3k.c	2012-02-07 15:09:33.918295301 +0100
> @@ -70,6 +70,7 @@
>  
>  	/* Atheros AR3012 with sflash firmware*/
>  	{ USB_DEVICE(0x0CF3, 0x3004) },
> +	{ USB_DEVICE(0x13d3, 0x3375) },
>  
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xE02C) },
> @@ -86,6 +87,7 @@
>  
>  	/* Atheros AR3012 with sflash firmware*/
>  	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
>  
>  	{ }	/* Terminating entry */
>  };
> diff -ur linux-3.2.5.orig/drivers/bluetooth/btusb.c linux-3.2.5/drivers/bluetooth/btusb.c
> --- linux-3.2.5.orig/drivers/bluetooth/btusb.c	2012-02-06 18:47:00.000000000 +0100
> +++ linux-3.2.5/drivers/bluetooth/btusb.c	2012-02-07 15:09:33.918295301 +0100
> @@ -125,6 +125,7 @@
>  
>  	/* Atheros 3012 with sflash firmware */
>  	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
>  
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },

Thanks,
Henrik
