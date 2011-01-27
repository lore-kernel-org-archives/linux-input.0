From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Thu, 27 Jan 2011 13:26:25 +0100
Message-ID: <20110127122625.GD15626@polaris.bitmath.org>
References: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
 <20110127110255.GA15159@polaris.bitmath.org>
 <871v3ysibp.fsf@macbook.be.48ers.dk>
 <20110127114727.GA15626@polaris.bitmath.org>
 <87pqrir1r2.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:45251 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752873Ab1A0MZw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 07:25:52 -0500
Content-Disposition: inline
In-Reply-To: <87pqrir1r2.fsf@macbook.be.48ers.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, baruch@tkos.co.il

On Thu, Jan 27, 2011 at 01:04:49PM +0100, Peter Korsgaard wrote:
> >>>>> "Henrik" == Henrik Rydberg <rydberg@euromail.se> writes:
> 
> Hi,
> 
>  Henrik> I won't argue against this case (with < 0) being frequent, but one
>  Henrik> should really check "n < len" to be safe. Hopefully Dmitry has some
>  Henrik> more input.
> 
> No, the point is that write (and read) can consume less data than
> requested, without it being an error. Robust userspace code should
> adjust buffer address / size and redo the work until all data is
> transferred or an error occurs.

Shouldn't the error be on (!len || len % smallest_acceptable_chunk),
then? Which makes me wonder about regressions - perhaps accumulating
partial writes in evdev is more safe from that perspective.

Thanks,
Henrik
