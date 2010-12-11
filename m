From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add support for Wacom Bamboo Pen (CTL460, Product ID
 0xD4).
Date: Fri, 10 Dec 2010 23:03:40 -0800
Message-ID: <20101211070340.GA5306@core.coreip.homeip.net>
References: <alpine.DEB.1.10.1012101914290.2131@fakemat>
 <AANLkTikwK5UmQHYkcv86jEh69tuKriKcACitAgs=odQ4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:42541 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab0LKHDs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Dec 2010 02:03:48 -0500
Received: by gwb20 with SMTP id 20so3724060gwb.1
        for <linux-input@vger.kernel.org>; Fri, 10 Dec 2010 23:03:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikwK5UmQHYkcv86jEh69tuKriKcACitAgs=odQ4@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: "kevin.granade@gmail.com" <azmodean@gmail.com>, linux-input@vger.kernel.org, chris@cnpbagwell.com, pingc@wacom.com

On Fri, Dec 10, 2010 at 06:36:12PM -0800, Ping Cheng wrote:
> On Fri, Dec 10, 2010 at 6:10 PM, kevin.granade@gmail.com
> <azmodean@gmail.com> wrote:
> > Add the features struct and device table entry to enable the Wacom Bamboo
> > Pen.
> >
> > Generated against input/for-linus since that seems to be the most recent
> > input branch.
> >
> > Signed-off-by: Kevin Granade <kevin.granade@gmail.com>
> 
> Acked-by: Ping Cheng <pingc@wacom.com>
> 

Applied, thanks Kevin.

Ping, I wonder if you could gather the list of device IDs that Wacom
produced and we support and send it to me as one patch instead of having
users add them one by one?

Thanks.

-- 
Dmitry
