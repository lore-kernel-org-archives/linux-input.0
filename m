From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: edt-ft5x06 - Touchscreen driver for FT5x06 based
 EDT displays
Date: Thu, 21 Jun 2012 03:04:20 -0700
Message-ID: <20120621100420.GA15600@core.coreip.homeip.net>
References: <1339671707-24662-1-git-send-email-olivier@sobrie.be>
 <20120620184015.GA5390@polaris.bitmath.org>
 <4FE24024.9010807@kernelconcepts.de>
 <20120621083940.GA2193@core.coreip.homeip.net>
 <4FE2EBCC.2020108@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46994 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759237Ab2FUKEZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jun 2012 06:04:25 -0400
Received: by pbbrp8 with SMTP id rp8so1879346pbb.19
        for <linux-input@vger.kernel.org>; Thu, 21 Jun 2012 03:04:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FE2EBCC.2020108@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, Jan Paesmans <jan.paesmans@gmail.com>, Anatolij Gustshin <agust@denx.de>, Ilya Yanok <yanok@emcraft.com>

On Thu, Jun 21, 2012 at 11:39:24AM +0200, Simon Budig wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 06/21/2012 10:39 AM, Dmitry Torokhov wrote:
> >> Anyway. I have reviewed the changes Dmitry suggested and will
> >> test them on real hardware tomorrow.
> 
> Ok, the bad news is, that it doesn't work with your changes. There was
> one oops I was able to resolve (i2c_set_clientdata must happen before
> sysfs_create_group) but the touch also failed to deliver input events
> and mode switching doesn't work.

Hmm, OK, let me ponder this one a bit as well.

> 
> I'll try to incorporate your patch incrementally, but this might have
> to wait for the weekend.
> 
> > That would be great as I already reviewed your version. If there
> > is something missing from your version that is present in Olivier,
> > I woudl prefer getting an incremental patch.
> 
> One thing Olivier did which is not in my patch is, that he used the
> type B protocol while I am still on type A. This is something I could
> change.

That would be good.

-- 
Dmitry
