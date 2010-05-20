From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Samsung touchscreen updates
Date: Thu, 20 May 2010 00:15:59 -0700
Message-ID: <20100520071559.GD8080@core.coreip.homeip.net>
References: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
 <888AB3A0-262F-4603-9B83-B8B6A4D25DC1@gmail.com>
 <20100519064138.GG4720@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50528 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab0ETHQJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 03:16:09 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so1949466pwi.19
        for <linux-input@vger.kernel.org>; Thu, 20 May 2010 00:16:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100519064138.GG4720@trinity.fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "ch.naveen@samsubng.com" <ch.naveen@samsubng.com>

On Wed, May 19, 2010 at 07:41:38AM +0100, Ben Dooks wrote:
> On Tue, May 18, 2010 at 11:34:51PM -0700, Dmitry Torokhov wrote:
> > On May 18, 2010, at 11:12 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> >
> >> Dimitry, this is a set of updates for the Samsung platform support for
> >> touchscreen devices and the drivers/input/touchscreen items for the
> >> s3c2410_ts driver.
> >>
> >> Since the changes have some interedependency, I would like permission
> >> to merge this via the Samsung platform tree with your acknowledgement
> >> for the drivers/input/touchscreen items.
> >>
> >> The arch/arm/* portions of this patchset have been included as FYI and
> >> to show other interested parties what is goign on.
> >>
> >> Please let me know what you think.
> >
> > Yeah, it all looks Ok, please merge through your tree.
> 
> Just rememberred I acked Maurus' original 64xx patch, did that get
> merged anywhere as I couldn't find it in the tree listed in MAINTAINERS?
> 

It looks like it got lost in my queue. The patch looks sane, would you
mind merging it with the rest of changes for s3c2140?

Thanks.

-- 
Dmitry
