From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Microchip Touchscreen Driver Submissions
Date: Wed, 1 Dec 2010 16:14:39 -0800
Message-ID: <20101202001439.GA31397@core.coreip.homeip.net>
References: <E773D38DD616EA4A9B9DBDA8009918200B0298FA@CHN-CL-MAIL01.mchp-main.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46100 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab0LBAOs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Dec 2010 19:14:48 -0500
Received: by gxk1 with SMTP id 1so847404gxk.19
        for <linux-input@vger.kernel.org>; Wed, 01 Dec 2010 16:14:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <E773D38DD616EA4A9B9DBDA8009918200B0298FA@CHN-CL-MAIL01.mchp-main.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steve.Grahovac@microchip.com
Cc: Linux Input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

Hi Steve,

On Wed, Dec 01, 2010 at 03:01:58PM -0700, Steve.Grahovac@microchip.com wrote:
> Hi Dmitry,
> 
>  
> 
> We are looking to add Linux kernel support for three of our UART/RS-232
> touchscreen controller protocols.

Great! It is always nice when manufacturer is committed to support their
products on Linux.

> I was wondering if I might ask for
> your help on how I might best integrate them into the mainstream kernel.

Normally all code submission is done in patch form and sent (in case of
input drivers) to linux-input@vger.kernel.org (and please CC me as
well). Note that list does not accept HTML (only plain text) and if you
are using Outlook/Exchange you may get into issue with it replacing
tabs with spaces and otherwise mangling mails. I recommend using mutt or
similar MUA for patch submuission.

Please take a look and Documentation/SubmittingPatches in the kernel
source tree for the format and requirements on patches. One of the things I
need to apply your code ito my tree (and eventually mainline) is your
"Signed-off-by: ..." tag.

> 
>  
> 
> The attached bundle includes the following files:
> 
>  
> 
> mchpar1xxx.c - This file is for support of the Microchip AR1XXX
> touchscreen controllers .
> 
>  
> 
> mchptsharc.c - This file is for support of the Microchip TSHARC series
> of touchscreen controllers.  There is already a hampshire.c that
> correctly supports the protocol.  I would like to request that the
> "hampshire.c" filename is renamed to "tsharc.c" or "mchptsharc.c" since
> the "Hampshire" as a company no longer exists (Hampshire was acquired by
> Microchip).  If the renaming of the file is not possible, could we
> submit the "mchptsharc.c" file that basically supports the same protocol
> but has the Microchip or TSHARC labeling?

Adjusting Kconfig/Makefile to show the new name should be OK, and even
renaming the source file, but I'd prefer leaving the rest as is (i.e.
not changing names in the code, etc).

Please send a patch.

> 
>  
> 
> mchppcapmt.c - This file is for support of the Microchip Projected
> Capacitive Multi-Touch series of touchscreen controllers.  The
> ABS_MT_TRACKING_ID events were used, but I did not make use the MT slots
> protocol. I could spend additional time to convert to MT slots (if
> preferred) since our protocol reports an ID in the packet, but I'm not
> sure if it's necessary.

It is not necessary but it cuts down on the bandwidth that is needed to
transmit state to userspace so it is nice to have.

> I verified the multi-touch was being reported
> correctly by use of the pymt python multi-touch draw application.  For
> touchscreen emulation,  I did notice an issue where touch events seemed
> to be properly sent as evdev packets by the mchppcapmt kernel module,
> however Xorg 7.5 did not process these touch events correctly since the
> cursor moved but there were no click events (I'm guessing this is an
> Xorg issue, but not 100 percent sure).  Are you familiar with any
> multi-touch touchscreen emulation issues with Xorg?

Multitouch support is work in progress on all levels of our stack, I
think Henrik is in a better position to answer this question.

Thanks.

-- 
Dmitry
