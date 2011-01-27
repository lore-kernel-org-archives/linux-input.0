From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Thu, 27 Jan 2011 12:29:27 +0100
Message-ID: <87tygur3e0.fsf@macbook.be.48ers.dk>
References: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
	<20110127110255.GA15159@polaris.bitmath.org>
	<871v3ysibp.fsf@macbook.be.48ers.dk>
	<20110127112635.GF12588@jasper.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:51501 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368Ab1A0L3w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 06:29:52 -0500
Received: by wwi17 with SMTP id 17so6322084wwi.1
        for <linux-input@vger.kernel.org>; Thu, 27 Jan 2011 03:29:51 -0800 (PST)
In-Reply-To: <20110127112635.GF12588@jasper.tkos.co.il> (Baruch Siach's
	message of "Thu, 27 Jan 2011 13:26:35 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Henrik Rydberg <rydberg@euromail.se>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

>>>>> "Baruch" == Baruch Siach <baruch@tkos.co.il> writes:

 >> wlile (len) {
 >> n = write(fd, buf, len);
 >> if (n <= 0) break;
 >> len -= n;
 >> buf += n;
 >> }
 >> 
 >> Which will then loop forever.

 Baruch> Well this code won't loop forever, since n == 0. Only if you do:

 Baruch>     if (n < 0) break;

 Baruch> That is.

Naturally, -ENOCOFFE.

-- 
Bye, Peter Korsgaard
