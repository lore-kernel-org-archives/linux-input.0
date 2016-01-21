From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] usbhid: replace inappropriate ENOSYS with ENODEV
Date: Thu, 21 Jan 2016 15:18:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601211516510.21446@cbobk.fhfr.pm>
References: <56A0028C.9080308@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49397 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759175AbcAUOSY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 09:18:24 -0500
In-Reply-To: <56A0028C.9080308@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 20 Jan 2016, Heiner Kallweit wrote:

> Primary meaning of ENOSYS is "system call not available" but it's also used
> with meaning "function not implemented". Both are not applicable here.
> 
> Typically this error occurs when the device was unplugged.
> usbhid_raw_request returns -ENODEV in such a case what seems to be more
> reasonable. Therefore use -ENODEV also here.
> 
> Primary motivation for this change is a change in the LED subsystem to
> ignore -ENODEV if the device was most likely unplugged.

I believe POSIX defines ENOSYS as "Function not implemented". In this 
case, we are signalling there is no "URB OUT" function.

I don't have strong preference either way, but ENODEV doesn't seem to be 
particularly good fit for this purpose either.

-- 
Jiri Kosina
SUSE Labs

