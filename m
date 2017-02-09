From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Half second spend in i8042 during suspend on TUXEDO BU1406
Date: Thu, 9 Feb 2017 12:24:04 +0100
Message-ID: <20170209112404.GB8852@suse.cz>
References: <234cc57f-6922-d866-e457-66eb2cafb85d@molgen.mpg.de>
 <20170208235826.GA28058@suse.com>
 <47598acc-5634-0426-43c9-7cb9bde13910@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbdBILYN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Feb 2017 06:24:13 -0500
Content-Disposition: inline
In-Reply-To: <47598acc-5634-0426-43c9-7cb9bde13910@molgen.mpg.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu, Feb 09, 2017 at 10:17:56AM +0100, Paul Menzel wrote:

> Starting Linux with that, the delay is gone.
> 
> Before:
> 
> > i8042 @ i8042 {i8042} sync_device (Total Suspend: 546.038 ms Total Resume: 3.850 ms)
> 
> After:
> 
> > i8042 @ i8042 {i8042} sync_device (Total Suspend: 0.973 ms Total Resume: 1.369 ms)
> 
> What downsides are there of using that `i8042.nomux=1`? Is any
> functionality lost?

If the notebook doesn't implement the Active AUX Multiplexing
specification, then there is no functionality lost. 

If it does, and apparently yours doesn't, then you lose the ability to
distinguish between the internal touchpad/touchpoint and an external
connected PS/2 mouse and lose the ability to use any advanced protocol
beyond standard PS/2 mouse.

Apparently the TUXEDO Book BU1406 doesn't have any external AUX port for
mouse, only USB and internally it only seems to have one touchpad, so
there is no need for Active AUX Multiplexing.

> >If that helps, it can be added to a blacklist based on DMI.
> Sounds good.
> 
> $ journalctl -k | grep 'DMI:'
> Feb 09 10:15:04 helmuth-N24-25BU kernel: DMI: Notebook
> N24_25BU/N24_25BU, BIOS 5.12 10/11/2016

A full output of 'dmidecode' would be more useful.

-- 
Vojtech Pavlik
Director SUSE Labs
