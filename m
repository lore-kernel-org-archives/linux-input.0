From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 1/1] input: bcm5974: retract efi-broken suspend_resume
Date: Sat, 13 Mar 2010 00:35:44 -0800
Message-ID: <20100313083544.GC22494@core.coreip.homeip.net>
References: <201003112204.o2BM4wYm013275@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:50286 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146Ab0CMIfu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Mar 2010 03:35:50 -0500
Received: by gxk27 with SMTP id 27so1389021gxk.1
        for <linux-input@vger.kernel.org>; Sat, 13 Mar 2010 00:35:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201003112204.o2BM4wYm013275@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, rydberg@euromail.se

Henrik,

On Thu, Mar 11, 2010 at 02:04:58PM -0800, akpm@linux-foundation.org wrote:
> From: "Henrik Rydberg" <rydberg@euromail.se>
> 
> With the recent system-wide improvements on suspend/resume and EFI booting
> the suspend_resume method of the bcm5974 has broken.  When waking up from
> the S3 state on the MacBookAir, the trackpad is found in a yet unknown
> state, unable to switch to the proper multitouch mode.  The result is a
> frozen touchpad, and a flood of errors of the kind
> 
> bcm5974: bad trackpad package, length: 8.
> 
> This patch retracts the reset_resume method altogether, falling back on
> the generic unbind/rebind functionality of the usb layer until further
> investigations can be made as how to reset the device when booting from
> efi.

Is the driver still broken on EFI without this patch? I was hoping if I
ignore the patch long enough EFI will get fixed ;)

Thanks.

-- 
Dmitry
