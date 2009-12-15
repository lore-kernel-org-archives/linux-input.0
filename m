From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Alps Dualpoint, Interleaved packets
Date: Tue, 15 Dec 2009 14:49:59 -0800
Message-ID: <20091215224959.GD21995@core.coreip.homeip.net>
References: <1259513695.32495.171.camel@sardelle.necksus.de> <20091204084902.GB22570@core.coreip.homeip.net> <1259963240.27307.213.camel@sardelle.necksus.de> <1260742145.9901.18.camel@sardelle.necksus.de> <20091215064224.GB12669@core.coreip.homeip.net> <1260910893.6294.26.camel@sardelle.necksus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:43079 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932AbZLOWuL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2009 17:50:11 -0500
Received: by pxi4 with SMTP id 4so253702pxi.33
        for <linux-input@vger.kernel.org>; Tue, 15 Dec 2009 14:50:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1260910893.6294.26.camel@sardelle.necksus.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Cc: Linux Input ML <linux-input@vger.kernel.org>

Hi Sebastian,

On Tue, Dec 15, 2009 at 10:01:33PM +0100, Sebastian Kapfer wrote:
> 
> Hi Dmitry,
> 
> I really hate to say, but I can still desync it.
> 
> [1240043.147596] alps.c: handle cf
> [1240043.148778] alps.c: handle 14
> [1240043.150043] alps.c: handle 1a
> [1240043.157696] alps.c: handle 5f
> [1240043.158851] alps.c: handle c
> [1240043.160044] alps.c: handle 29
> [1240043.163885] alps.c: handle 2f
> [1240043.165051] alps.c: handle 0
> [1240043.166213] alps.c: handle ff
> [1240043.166218] alps.c: refusing packet[5] = ff
> [1240043.166221] 
> [1240043.166227] psmouse.c: DualPoint TouchPad at isa0060/serio1/input0 lost sync at byte 6
> 
> In short, it's a 6-byte followed by a 3-byte; we mistakenly process it
> as a interleaved PS/2 (oh well), and, while the final bytes come in,
> happen upon high bits set in the PS/2 packet.  In a way, this is correct
> behaviour, because we _are_ processing the data incorrectly...  In my
> last patch, this went unnoticed because I didn't check for the high bit
> in bytes 7,8,9.
>

*sigh* Yes, unfortunately in both cases we report incorrect data to
userspace... Unfortunately I don't see any way to fix that; not unless
somebody (ALPS?) tells us a bit more about protocol... But it is likely
that this as good as it gets even for them.

The good thing is that it shoudl not trigger during nrmal usage (I doubt
many people work the device with both hands).

> For all practical purposes (i.e. not pressing three buttons and fumbling
> with both pointers at the same time), the patch works very well.
> 
> In particular, no double clicks.  :-)
> 

OK, then I will apply it and send it on. Thank you for all your efforts.

-- 
Dmitry
