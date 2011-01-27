From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Thu, 27 Jan 2011 13:04:49 +0100
Message-ID: <87pqrir1r2.fsf@macbook.be.48ers.dk>
References: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
	<20110127110255.GA15159@polaris.bitmath.org>
	<871v3ysibp.fsf@macbook.be.48ers.dk>
	<20110127114727.GA15626@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44609 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368Ab1A0MFH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 07:05:07 -0500
Received: by wyb28 with SMTP id 28so1994692wyb.19
        for <linux-input@vger.kernel.org>; Thu, 27 Jan 2011 04:05:05 -0800 (PST)
In-Reply-To: <20110127114727.GA15626@polaris.bitmath.org> (Henrik Rydberg's
	message of "Thu, 27 Jan 2011 12:47:27 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, baruch@tkos.co.il

>>>>> "Henrik" == Henrik Rydberg <rydberg@euromail.se> writes:

Hi,

 Henrik> I won't argue against this case (with < 0) being frequent, but one
 Henrik> should really check "n < len" to be safe. Hopefully Dmitry has some
 Henrik> more input.

No, the point is that write (and read) can consume less data than
requested, without it being an error. Robust userspace code should
adjust buffer address / size and redo the work until all data is
transferred or an error occurs.

-- 
Bye, Peter Korsgaard
