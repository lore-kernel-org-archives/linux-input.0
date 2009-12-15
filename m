From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Tue, 15 Dec 2009 14:07:55 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912151403440.3755@pobox.suse.cz>
References: <4B26B824.8010403@physik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59879 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759361AbZLONH4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2009 08:07:56 -0500
In-Reply-To: <4B26B824.8010403@physik.uni-muenchen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 14 Dec 2009, Johannes Ebke wrote:

> I own a Saitek Cyborg Evo Force which works fine with the HID driver on
> Linux. However, i could not find a force feedback driver for it, and
> just adding the USB id and spec to the IForce driver does not work (and
> crashes the kernel)

Hi Johannes,

thanks for your e-mail. I hope you don't mind adding a few relevant CCs.

First, kernel crashing means that we are probably lacking some error 
handling in the iforce driver, which we should add if possible. Could you 
please post the oops message preceeding the crash?

> After that, I have reverse-engineered the protocol using usb snoops from 
> a kvm virtual machine with XP on it. Using libusb, I have verified that 
> I understand the protocol, and it actually looks quite similar to the 
> iforce protocol (no wonder, it just implements the DirectInput interface 
> in hardware)

Good job, thanks a lot for doing this.

> My question: Would it make sense to adapt the iforce modules to include 
> this slightly modified protocol (other initialization strings, other 
> magic bytes) or would it be better to copy & modify?

It really depends how much different the protocols really are. iforce 
driver currently doesn't support any per-device flags which would allow 
for introducing slight differences between individual models.

Maybe it would help if you could just summarize the most important 
differences to iforce protocol, so that we could see what aproach would be 
the best.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
