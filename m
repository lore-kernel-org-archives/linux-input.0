From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add Atmel maXTouch touchscreen driver
Date: Tue, 16 Nov 2010 14:05:17 -0800
Message-ID: <20101116220516.GB5224@core.coreip.homeip.net>
References: <4CE2F692.8040403@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48305 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932592Ab0KPWF1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Nov 2010 17:05:27 -0500
Received: by gwj17 with SMTP id 17so753839gwj.19
        for <linux-input@vger.kernel.org>; Tue, 16 Nov 2010 14:05:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE2F692.8040403@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulf Samuelsson <ulf.samuelsson@atmel.com>
Cc: linux-input@vger.kernel.org, iiro.valkonen@atmel.com

Hi Ulf,

On Tue, Nov 16, 2010 at 10:24:34PM +0100, Ulf Samuelsson wrote:
> Hi Iiro,
> 
> On Fri, Nov 12, 2010 at 04:14:18PM +0200, Iiro Valkonen wrote:
> >/  /
> >/  Add Atmel maXTouch touchscreen driver (I2C interface)./
> >/  The MT slots protocol will be implemented later./
> >/  /
> 
> I believe there is already a driver for this hardware in the tree
> (qt602240.c). Could you tell me what additional features your driver
> implements and why can't they be added to the existing driver.
> 
> Thanks.
> 
> -- 
> Dmitry
> 
> 
> 
> =========
> When we reviewed the Samsung QT602240 driver internally,
> we found 20 significant problems including memory leaks
> and doing I2C transfers within interrupts.
> I have been told that since I2C transfers can sleep, this is not a
> good idea.

It does so in _threaded_ interrupt which is perfectly fine. The need to
access slower buses from the interrupt context was one of the reasons
this facility was added to the kernel.

> Configuration is done inside the driver, instead of using platform
> data. etc. etc.

The platform data is defined in include/linux/i2c/qt602240_ts.h and can
be extended if needed.

The driver passed both mutitouch protocol review process and the general
review and I believe most (all?) memory leaks and other issues presented
in the original version have been fixed.

> 
> This is why I started writing a new driver and Iiro has added significant
> improvements/rewrites and is the current maintainer of the maXTouch
> driver within Atmel - the manufacturer of the device in question.
> 
> Have not checked if the qt602240.c still does memory leaks,
> but it still seems to make I2C transfers in the interrupt.
> 
> My suggestion is that we deprecate the qt602240.c and remove
> it in some future version.
> Instead we should use the official driver from Atmel, that Iiro sent
> to the list.

No. I regret to say but I find the in-tree version of qt602240.c in much
better shape than what was submitted by Iiro. Please identify the
improvements that are needed for the driver and submit separate patches
implementing these improvements.

Thanks.

-- 
Dmitry
