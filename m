From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Apple Wireless Mighty Mouse HWheel quirk
Date: Wed, 10 Jun 2009 00:07:55 +0100
Message-ID: <1244588875.5973.1937.camel@cookie.hadess.net>
References: <3aaafc130904141224w3bb76cc1ic39c8c4fd738a458@mail.gmail.com>
	 <49E4E7E1.7040109@gmail.com>
	 <alpine.LNX.2.00.0904142307260.13028@wotan.suse.de>
	 <4A2ED39B.30100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:52764 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbZFIXIE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Jun 2009 19:08:04 -0400
In-Reply-To: <4A2ED39B.30100@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "J.R. Mauro" <jrm8005@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, linux-input@vger.kernel.org, locoxella@gmail.com

On Tue, 2009-06-09 at 23:26 +0200, Jiri Slaby wrote:
> On 04/14/2009 11:09 PM, Jiri Kosina wrote:
> > On Tue, 14 Apr 2009, Jiri Slaby wrote:
> > 
> >>> I have an Apple bluetooth mouse (info below) and have noticed that the 
> >>> horizontal scrolling is inverted. I've noticed some bug reports from 
> >>> others getting the same behavior. I looked at drivers/hid/hid-apple.c 
> >>> , and around line 444 I see that APPLE_INVERT_HWHEEL gets ORed in. I 
> >>> tried to trace the origins of the code, but I lost track of it before 
> >>> 8c19a515, where you moved Apple quirks to their own file. Is this 
> >>> quirk definitely correct?
> >>> Mouse's entry in /proc/bus/input/devices
> >>> I: Bus=0005 Vendor=05ac Product=030c Version=0200
> >>> I'm running Gentoo, vanilla 2.6.29 with no patches.
> >> I have no idea whether the inversion is correct or not. Or where the
> >> information comes from :).
> >> It was added in
> >> cb3fecc2f29056e89658e7eb371e7f9be66cda6d
> >> by Jiri Kosina, maybe he may shed some light on it?
> > 
> > I created this patch based solely on a bugreport, I didn't physically own 
> > the hardware at that time.
> > 
> > I think I have it somewhere. I will try to find it tomorrow or the day 
> > after tomorrow and verify whether the quirk is really needed. Maybe the 
> > original bug reporter messed up, or he had different hardware revision.
> 
> Any news here?
> 
> I think this is what you hit too, Andres?
> 
> 
> Interesting part from the Andres' email follows:
> 
> I have an Apple Mighty Mouse. This is how it looks with 'cat
> /proc/bus/input/devices'
> 
> I: Bus=0005 Vendor=05ac Product=030c Version=0200
> N: Name="Mighty Mouse"
> 
> And the trackball on it has it x axis inverted.

Same here, this is the info:
I: Bus=0005 Vendor=05ac Product=030c Version=0200
N: Name="Mighty Mouse"
P: Phys=00:13:EF:F1:42:B7
S:
Sysfs=/devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/bluetooth/hci0/hci0:46/input11
U: Uniq=00:14:51:D1:69:ED
H: Handlers=mouse2 event7 
B: EV=100017
B: KEY=f0000 0 0 0 0
B: REL=143
B: MSC=10


