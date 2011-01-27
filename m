From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Thu, 27 Jan 2011 13:43:17 +0100
Message-ID: <87lj26qzyy.fsf@macbook.be.48ers.dk>
References: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
	<20110127110255.GA15159@polaris.bitmath.org>
	<871v3ysibp.fsf@macbook.be.48ers.dk>
	<20110127114727.GA15626@polaris.bitmath.org>
	<87pqrir1r2.fsf@macbook.be.48ers.dk>
	<20110127122625.GD15626@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62461 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1A0Mna (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 07:43:30 -0500
Received: by wyb28 with SMTP id 28so2028270wyb.19
        for <linux-input@vger.kernel.org>; Thu, 27 Jan 2011 04:43:29 -0800 (PST)
In-Reply-To: <20110127122625.GD15626@polaris.bitmath.org> (Henrik Rydberg's
	message of "Thu, 27 Jan 2011 13:26:25 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, baruch@tkos.co.il

>>>>> "Henrik" == Henrik Rydberg <rydberg@euromail.se> writes:

 Henrik> I won't argue against this case (with < 0) being frequent, but one
 Henrik> should really check "n < len" to be safe. Hopefully Dmitry has some
 Henrik> more input.
 >> 
 >> No, the point is that write (and read) can consume less data than
 >> requested, without it being an error. Robust userspace code should
 >> adjust buffer address / size and redo the work until all data is
 >> transferred or an error occurs.

 Henrik> Shouldn't the error be on (!len || len % smallest_acceptable_chunk),
 Henrik> then? Which makes me wonder about regressions - perhaps accumulating
 Henrik> partial writes in evdev is more safe from that perspective.

No, writing more than 1 complete struct should just consume the full
structs and return the number of bytes consumed, similar to all other
cases in the kernel where we return a length < count.

No sane userspace will write anything else than a multiple of
sizeof(input_event) though.

I doubt this will introduce any regressions (but you never know). The
only situation I can see is if userspace would fill out a proper struct
input_dev but use a wrong (too small) length in the write call. We used
to accept these, but with the patch here it will -EINVAL.

-- 
Bye, Peter Korsgaard
