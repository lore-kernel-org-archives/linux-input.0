From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Subject: Re: [PATCH] input: Add support for eGalax TouchKit USB touchscreen used on HP tx1305us
Date: Sat, 28 Jun 2008 17:57:47 +0200
Message-ID: <200806281757.48201.daniel.ritz-ml@swissonline.ch>
References: <200806281719.16837.daniel.ritz-ml@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viefep28-int.chello.at ([62.179.121.48]:5362 "EHLO
	viefep28-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbYF1Pw4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Jun 2008 11:52:56 -0400
In-Reply-To: <200806281719.16837.daniel.ritz-ml@swissonline.ch>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alastair Bridgewater <nyef@lisphacker.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Saturday 28 June 2008 17:19:16 Daniel Ritz wrote:
> hi
> 
> > The eGalax touchscreen used in the HP tx1305us tablet PC (and presumably 
> > the rest of the tx1000 series) uses a different format for events from 
> > the device than the existing driver supports.
> > 
> is there more information available? datasheets? drivers?
> 
> > Add a new device description and interrupt packet handler for the 
> > touchscreen used in the tx1305us, claiming the USB device ID for the 
> > device that this patch was tested with from the older eGalax device code.
> >
> NAK. you cannot change device IDs currently used to some new code.
> this will break most eGalax setups as the device ID 0x0eef,0x0001 is used
> in most of them, including the one i have..
> 
> you'll need to find a way to distinguish the screens. as a starting point
> i attached an lsusb -vvv output from my screen...
> 

reading the latest driver guide and programming guide from eGalax (now EETI btw.
www.eeti.com.tw ) it turns out that the newer devices should support the HID
format and report with that by default. those newer screens are handled by the
'usbhid' driver. have you tried loading that one before usbtouchscreen?

can you give an lsusb -vvv output?

in case the usbhid driver does not work, it's possible to put the touchscreen
into the non-HID operating mode and have to current code work again..it's easy
to code...but please try usbhid first...

rgds
-daniel

