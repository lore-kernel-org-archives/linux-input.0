From: Daniel Mack <daniel@caiaq.de>
Subject: Re: eeti_ts
Date: Wed, 10 Nov 2010 18:10:43 -0500
Message-ID: <4CDB2673.5020200@caiaq.de>
References: <000301cb80fc$91cf31a0$b56d94e0$@seedle@rigaku.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40554 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757218Ab0KJXKs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 18:10:48 -0500
Received: by qyk1 with SMTP id 1so117679qyk.19
        for <linux-input@vger.kernel.org>; Wed, 10 Nov 2010 15:10:47 -0800 (PST)
In-Reply-To: <000301cb80fc$91cf31a0$b56d94e0$@seedle@rigaku.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: charles.seedle@rigaku.com
Cc: linux-input@vger.kernel.org

Hi Charles,

please never write to me personally only, but always keep appropriate
mailing lists in the loop (the linux-input list in that case), and hit
"reply to all" when following up.

On 11/10/2010 12:27 PM, Charles Seedle wrote:
> Does your kernel module eeti_ts access the touchscreen hardware direc=
tly
> or is it accessing the data through input (HID) ?

The EETI touchscreen we have is controlled and queried via its I2C
interface. The driver implements the protocol and exposes an Linux inpu=
t
interface which is accessible from userspace.

The protocol reference we got is referenced in the comment block of the
first lines in this driver. You should first check whether your
controller is compatible.

> My current installation is using tkusb.ko to connect to the touchscre=
en.
> The calibration is quite bad and I am running on a

What module is that? I can't find it in the kernel mainline tree?

> Texas Instruments OMAP 3450 processor (ARM7) so the intel calibration
> tools can=92t be used.

And I don't know about any calibration tools, especially from Intel (an=
d
I'm surprised Intel has anything to do with EETI at all?).

All we needed was a very small input layer in user space to map the EET=
I
touchscreen coordinates to the actual display resolution, simply by
applying a factor to it, and I think there is also a static offset whic=
h
we need due to mechanical construction constraints of our hardware. The
driver can be told to invert any of the two axis (with a module
parameter), but you shouldn't need more than this.


Hope that helps,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
