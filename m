From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: goodix - preliminary support for GT801-2+1
Date: Sun, 5 Apr 2015 11:43:19 -0700
Message-ID: <20150405184319.GA31564@dtor-ws>
References: <1428181693-25362-1-git-send-email-plaes@plaes.org>
 <1428181693-25362-2-git-send-email-plaes@plaes.org>
 <1428249864.28443.4.camel@hadess.net>
 <1428253576.29867.7.camel@plaes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36557 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbbDESnY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Apr 2015 14:43:24 -0400
Received: by iebrs15 with SMTP id rs15so8895195ieb.3
        for <linux-input@vger.kernel.org>; Sun, 05 Apr 2015 11:43:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1428253576.29867.7.camel@plaes.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Priit Laes <plaes@plaes.org>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>

On Sun, Apr 05, 2015 at 08:06:16PM +0300, Priit Laes wrote:
> On Sun, 2015-04-05 at 18:04 +0200, Bastien Nocera wrote:
> > On Sun, 2015-04-05 at 00:08 +0300, Priit Laes wrote:
> > > This patch implements GT801x2 touchscreen support.
> > > Unfortunately, there is a big difference between GT801 and GT9xx 
> > > series
> > > chips, therefore some advice is needed on how to proceed.
> > > 
> > > Differences between GT801x2 and GT9xx series:
> > > 
> > > 1. I2C registers: 1 byte (GT801x2) vs 2 bytes (GT9xx)
> > > 2. Different configuration layout and version info
> > > 3. Different touch report protocol
> > 
> > That doesn't seem like an awful lot of differences. Approximately 80 
> > line changes for 500 lines of driver code. You could add an enum for 
> > the 8xx and 9xx types near the top, add that as driver data in the 
> > match arrays (both the ACPI and OF ones). Then have if statements 
> > choose the correct init, read and report functions.
> 
> How should I handle the version readout?
> 
> Currently the driver has following info in its registers (starting 
> from 0xf0):
> 
> f0: 47 54 38 30 31 4e 49 5f 33 52 31 35 5f 31 41 56    GT801NI_3R15_1AV
> 
> 
> And there's another issue with deactivating interrupts. When I remove 
> the goodix module, I get following traceback:
> 
> [snip]
> WARNING: CPU: 0 PID: 381 at fs/proc/generic.c:552 remove_proc_entry+0x138/0x16c()
> remove_proc_entry: removing non-empty directory 'irq/50', leaking at least 'gt801x2'
> Modules linked in: goodix(-) rtl8192cu rtl_usb rtl8192c_common rtlwifi

This is an issue with the i2c core and not the driver; the offending
patch has been reverted as far as I can remember.

Thanks.

-- 
Dmitry
