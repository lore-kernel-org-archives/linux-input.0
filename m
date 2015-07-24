From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH 2/3] HID: apple: Add support for the 2015 Macbook Pro
Date: Fri, 24 Jul 2015 20:29:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507242029190.925@pobox.suse.cz>
References: <1437759260-7748-1-git-send-email-rydberg@bitmath.org> <1437759260-7748-2-git-send-email-rydberg@bitmath.org> <20150724175444.GC2872@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:34442 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754708AbbGXS3y (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Fri, 24 Jul 2015 14:29:54 -0400
In-Reply-To: <20150724175444.GC2872@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>

On Fri, 24 Jul 2015, Dmitry Torokhov wrote:

> On Fri, Jul 24, 2015 at 07:34:19PM +0200, Henrik Rydberg wrote:
> > This patch adds keyboard support for MacbookPro12,1 as WELLSPRING9
> > (0x0272, 0x0273, 0x0274). The touchpad is handled in a separate
> > bcm5974 patch, as usual.
> > 
> > Tested-by: John Horan <knasher@gmail.com>
> > Tested-by: Jochen Radmacher <jradmacher@gmx.de>
> > Tested-by: Yang Hongyang <burnef@gmail.com>
> > Tested-by: Yen-Chin, Lee <coldnew.tw@gmail.com>
> > Tested-by: George Hilios <ghilios@gmail.com>
> > Tested-by: Janez Urevc <janez@janezurevc.name>
> > Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>
> 
> Jiri, do you think I can take all three in through my tree? I think it
> might be worthwhile to get the changes in 4.2 still.

Absolutely.

	Acked-by: Jiri Kosina <jkosina@suse.com>

for this one.

Thanks,

-- 
Jiri Kosina
SUSE Labs
