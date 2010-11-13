From: Daniel Mack <daniel@caiaq.de>
Subject: Re: eeti_ts
Date: Fri, 12 Nov 2010 20:56:15 -0500
Message-ID: <4CDDF03F.20201@caiaq.de>
References: <000301cb80fc$91cf31a0$b56d94e0$@seedle@rigaku.com> <4CDB2673.5020200@caiaq.de> <000001cb8274$af56ce30$0e046a90$@seedle@rigaku.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51384 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab0KMB4X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 20:56:23 -0500
Received: by ywc21 with SMTP id 21so954536ywc.19
        for <linux-input@vger.kernel.org>; Fri, 12 Nov 2010 17:56:22 -0800 (PST)
In-Reply-To: <000001cb8274$af56ce30$0e046a90$@seedle@rigaku.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: charles.seedle@rigaku.com
Cc: linux-input@vger.kernel.org

(please don't top-post)

On 11/12/2010 09:19 AM, Charles Seedle wrote:
> Daniel:
> After further study, I can't use the IC2 protocol. 
> The module tkusb.ko is for a usb based touchscreen. It is available 
> from the eeti website (ie. http://www.eeti.com/ or from www.hedus.com). 
> We used the tar file from Hedus. It seemed to be more complete. This is
> where
> I found intel processor based calibration tools). It has nothing to do with 
> the company Intel. 

Hmm, sorry, I'm afraid I can't help you. The touchscreen you have might
be totally incompatible to the one I wrote the driver for (ours has a
Cypress PSOC chip). I also don't know about the tools or tarballs you're
talking about, I haven't gotten any sources from EETI. The driver I
submitted is all written by myself, following the protocol specification
I pointed out in the comment block.

Let me know if you need any further information.

Daniel

> -----Original Message-----
> From: Daniel Mack [mailto:zonque@gmail.com] On Behalf Of Daniel Mack
> Sent: Wednesday, November 10, 2010 5:11 PM
> To: charles.seedle@rigaku.com
> Cc: linux-input@vger.kernel.org
> Subject: Re: eeti_ts
> 
> Hi Charles,
> 
> please never write to me personally only, but always keep appropriate
> mailing lists in the loop (the linux-input list in that case), and hit
> "reply to all" when following up.
> 
> On 11/10/2010 12:27 PM, Charles Seedle wrote:
>> Does your kernel module eeti_ts access the touchscreen hardware directly
>> or is it accessing the data through input (HID) ?
> 
> The EETI touchscreen we have is controlled and queried via its I2C
> interface. The driver implements the protocol and exposes an Linux input
> interface which is accessible from userspace.
> 
> The protocol reference we got is referenced in the comment block of the
> first lines in this driver. You should first check whether your
> controller is compatible.
> 
>> My current installation is using tkusb.ko to connect to the touchscreen.
>> The calibration is quite bad and I am running on a
> 
> What module is that? I can't find it in the kernel mainline tree?
> 
>> Texas Instruments OMAP 3450 processor (ARM7) so the intel calibration
>> tools can't be used.
> 
> And I don't know about any calibration tools, especially from Intel (and
> I'm surprised Intel has anything to do with EETI at all?).
> 
> All we needed was a very small input layer in user space to map the EETI
> touchscreen coordinates to the actual display resolution, simply by
> applying a factor to it, and I think there is also a static offset which
> we need due to mechanical construction constraints of our hardware. The
> driver can be told to invert any of the two axis (with a module
> parameter), but you shouldn't need more than this.
> 
> 
> Hope that helps,
> Daniel
> 

