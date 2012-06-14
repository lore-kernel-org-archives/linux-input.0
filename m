From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: [PATCH] input: edt-ft5x06 - Touchscreen driver for FT5x06 based
 EDT displays
Date: Thu, 14 Jun 2012 14:48:15 +0200
Message-ID: <20120614124814.GA25134@hposo>
References: <1339671707-24662-1-git-send-email-olivier@sobrie.be>
 <4FD9D37C.1070202@kernelconcepts.de>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43269 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab2FNMsX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jun 2012 08:48:23 -0400
Received: by eaak11 with SMTP id k11so555156eaa.19
        for <linux-input@vger.kernel.org>; Thu, 14 Jun 2012 05:48:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FD9D37C.1070202@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Jan Paesmans <jan.paesmans@gmail.com>

On Thu, Jun 14, 2012 at 02:05:16PM +0200, Simon Budig wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 06/14/2012 01:01 PM, Olivier Sobrie wrote:
> > This driver adds support for the EDT touchscreens based on the 
> > FocalTech chips.
> 
> Can you please elaborate a bit, why my driver was unsuitable for you?
In fact I never used your driver...

I developped this driver in December 2011/January 2012. At that time,
you were at the version 2 of the code. I looked at the code of v2 and
found it not very clear... There were some missing things like the check
of the CRC of frames, checkpatch was complaining everywhere, etc. This
is why I decided to write my own driver.

I didn't posted it until now because I had hope that yours would have
been improved, finalized and included in linux version 3.4 or 3.5
(that's what you said in one of your previous mail).
As it is not the case after almost one year after v1 of your patch, I
decided today to post my version of the driver so that maybe we don't
miss next kernel version.

Kind regards,

-- 
Olivier
