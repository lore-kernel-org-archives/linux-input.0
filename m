From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/4] input adxl34x: give a little love to the driver
Date: Mon, 24 Dec 2012 09:53:06 -0800
Message-ID: <20121224175306.GA16272@core.coreip.homeip.net>
References: <1356011471-18757-1-git-send-email-w.sang@pengutronix.de>
 <50D319F5.8040705@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:65124 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab2LXRxL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Dec 2012 12:53:11 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so3251453dak.16
        for <linux-input@vger.kernel.org>; Mon, 24 Dec 2012 09:53:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50D319F5.8040705@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

On Thu, Dec 20, 2012 at 03:00:21PM +0100, Michael Hennerich wrote:
> On 12/20/2012 02:51 PM, Wolfram Sang wrote:
> >Hi,
> >
> >I needed this driver in a project and there were some minor hurdles in getting
> >it to run smoothly. These four patches are fixing them.
> >
> >Kind regards,
> >
> >    Wolfram
> >
> >
> >Wolfram Sang (4):
> >   input: adxl34x: consistently use read/write encapsulation
> >   input: adxl34x: don't set THRESH_TAP twice
> >   input: adxl34x: make platform_data include self contained
> >   input: adxl34x: default platform_data should not use defines from
> >     driver
> >
> >  drivers/input/misc/adxl34x.c  |    7 +++----
> >  include/linux/input/adxl34x.h |    2 ++
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> >
> looks good to me -
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Applied all 4, thanks everyone.

-- 
Dmitry
