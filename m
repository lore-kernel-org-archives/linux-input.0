From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux-next: Tree for July 30
Date: Thu, 31 Jul 2008 16:39:44 -0400
Message-ID: <20080731163738.ZZRA012@mailhub.coreip.homeip.net>
References: <20080731104437.5e5669bc.akpm@linux-foundation.org> <20080731141302.ZZRA012@mailhub.coreip.homeip.net> <200807312048.57575.rjw@sisk.pl> <20080731145023.ZZRA012@mailhub.coreip.homeip.net> <alpine.LFD.1.10.0807311207000.3277@nehalem.linux-foundation.org> <20080731151625.ZZRA012@mailhub.coreip.homeip.net> <alpine.LFD.1.10.0807311235350.3277@nehalem.linux-foundation.org> <20080731155701.ZZRA012@mailhub.coreip.homeip.net> <alpine.LFD.1.10.0807311310090.3277@nehalem.linux-foundation.org> <alpine.LFD.1.10.0807311318580.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807311318580.3277@nehalem.linux-foundation.org>
Sender: linux-next-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jul 31, 2008 at 01:28:37PM -0700, Linus Torvalds wrote:
> 
> +				/* Some people get confused about size in bits vs bytes */
> +				if (size >= len/8)
> +					size = size/8;

People usually allocate single buffer (big enough) and the do a bunch
of tests so this condiion is likely to fire on EV_SW and similar event
types. I think it is safer to explicitely test for EV_KEY/0x1ff.

-- 
Dmitry
