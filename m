From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2]input - wacom_w8001: Add one finger touch support
Date: Thu, 9 Dec 2010 10:02:32 -0800
Message-ID: <201012091002.33372.dmitry.torokhov@gmail.com>
References: <1291857829-13804-1-git-send-email-pinglinux@gmail.com> <20101209064439.GB6233@core.coreip.homeip.net> <AANLkTinMKDjT9eTJkvvstYG_7LSs7mhcPCRrMsQAANhh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62409 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598Ab0LISCn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 13:02:43 -0500
Received: by qwa26 with SMTP id 26so2884547qwa.19
        for <linux-input@vger.kernel.org>; Thu, 09 Dec 2010 10:02:42 -0800 (PST)
In-Reply-To: <AANLkTinMKDjT9eTJkvvstYG_7LSs7mhcPCRrMsQAANhh@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org

On Thursday, December 09, 2010 09:39:09 am Ping Cheng wrote:
> On Wed, Dec 8, 2010 at 10:44 PM, Dmitry Torokhov
> 
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Dec 08, 2010 at 05:23:49PM -0800, Ping Cheng wrote:
> >> Signed-off-by: Ping Cheng <pingc@wacom.com>
> >> ---
> >>  drivers/input/touchscreen/wacom_w8001.c |   74
> >> +++++++++++++++++++++++++++++-- 1 files changed, 70 insertions(+), 4
> >> deletions(-)
> >> 
> >> diff --git a/drivers/input/touchscreen/wacom_w8001.c
> >> b/drivers/input/touchscreen/wacom_w8001.c index 90b92e8..68087d8 100644
> >> --- a/drivers/input/touchscreen/wacom_w8001.c
> >> +++ b/drivers/input/touchscreen/wacom_w8001.c
> >> @@ -3,6 +3,7 @@
> >>   *
> >>   * Copyright (c) 2008 Jaya Kumar
> >>   * Copyright (c) 2010 Red Hat, Inc.
> >> + * Copyright (c) 2010 Ping Cheng, Wacom. <pingc@wacom.com>
> >>   *
> >>   * This file is subject to the terms and conditions of the GNU General
> >> Public * License. See the file COPYING in the main directory of this
> >> archive for @@ -86,6 +87,12 @@ struct w8001 {
> >>       char phys[32];
> >>       int type;
> >>       unsigned int pktlen;
> >> +     bool pen_in_prox;
> >> +     bool has_touch;
> >> +     int max_touch_x;
> >> +     int max_touch_y;
> >> +     int max_pen_x;
> >> +     int max_pen_y;
> > 
> > This does not apply to my tree. What tree was it made against?
> 
> It was based on Henrik's mt-next branch since there are MT support in
> the driver. Should I use yours for v2?

Now that I have merged Henrik's it should not matter but generally it would
be helpful to specify which tree the patch was made against (if not mine)
so I can plan the merging accordingly.

Thanks.

-- 
Dmitry
