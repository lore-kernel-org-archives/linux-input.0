From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ARM: S3C64XX: Add s3c64xx support to touchscreen driver
Date: Mon, 28 Jun 2010 11:30:41 -0700
Message-ID: <20100628183041.GC7427@core.coreip.homeip.net>
References: <4BE290E5.9050703@gmail.com>
 <20100507004030.GX2589@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44395 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0F1Sar (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 14:30:47 -0400
Content-Disposition: inline
In-Reply-To: <20100507004030.GX2589@trinity.fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, arnaud.patard@rtp-net.org

On Fri, May 07, 2010 at 01:40:30AM +0100, Ben Dooks wrote:
> On Thu, May 06, 2010 at 11:50:29AM +0200, Maurus Cuelenaere wrote:
> > Add support for the s3c64xx touchscreen to the s3c2410_ts driver,
> > ensuring it compiles and supports the extra features such as the
> > interrupt generation.
> > 
> > Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> Acked-by: Ben Dooks <ben-linux@fluff.org>

Hmm, it looks like I slept on th epatch for too long. Is it still
needed? Could you please rebase it against 2.6.35-rc*?

Thanks!

-- 
Dmitry
