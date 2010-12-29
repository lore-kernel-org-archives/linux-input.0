From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3 v2] input - wacom_w8001: Add one finger touch support
Date: Tue, 28 Dec 2010 23:42:20 -0800
Message-ID: <20101229074220.GB13061@core.coreip.homeip.net>
References: <1292607474-22674-1-git-send-email-pinglinux@gmail.com>
 <20101229074058.GA13061@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34170 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab0L2HmZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Dec 2010 02:42:25 -0500
Received: by iwn9 with SMTP id 9so9902108iwn.19
        for <linux-input@vger.kernel.org>; Tue, 28 Dec 2010 23:42:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101229074058.GA13061@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Tue, Dec 28, 2010 at 11:40:58PM -0800, Dmitry Torokhov wrote:
> Hi Ping,
> 
> On Fri, Dec 17, 2010 at 09:37:54AM -0800, Ping Cheng wrote:
> > Signed-off-by: Ping Cheng <pingc@wacom.com>
> > ---
> >  drivers/input/touchscreen/wacom_w8001.c |   89 ++++++++++++++++++++++++++++---
> >  1 files changed, 82 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> > index 59664a8..763eb8f 100644
> > --- a/drivers/input/touchscreen/wacom_w8001.c
> > +++ b/drivers/input/touchscreen/wacom_w8001.c
> > @@ -3,6 +3,7 @@
> >   *
> >   * Copyright (c) 2008 Jaya Kumar
> >   * Copyright (c) 2010 Red Hat, Inc.
> > + * Copyright (c) 2010 Ping Cheng, Wacom. <pingc@wacom.com>
> >   *
> >   * This file is subject to the terms and conditions of the GNU General Public
> >   * License. See the file COPYING in the main directory of this archive for
> > @@ -86,6 +87,12 @@ struct w8001 {
> >  	char phys[32];
> >  	int type;
> >  	unsigned int pktlen;
> > +	bool pen_in_prox;
> > +	bool has_touch;
> 
> We already have type, why do we need these 2 fields a well?
> 
> Actually, I tried massaging the patch a bit, could you please tell me if
> the patch below still works for you?
> 
> Thanks.
> 

And while we are at it could you please try this patch as well...

Thank you!

-- 
Dmitry

Input: wacom_w8001 - add single-touch pointer emulation

Let's emit single-touch compatible events for the 2-finger panels so that
they can be used with legacy clients.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/wacom_w8001.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index ce8c8e1..01489f7 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -145,6 +145,7 @@ static void parse_multi_touch(struct w8001 *w8001)
 		}
 	}
 
+	input_mt_report_pointer_emulation(dev, true);
 	input_sync(dev);
 }
 
@@ -420,6 +421,9 @@ static int w8001_setup(struct w8001 *w8001)
 						0, touch.y, 0, 0);
 			input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
 						0, MT_TOOL_MAX, 0, 0);
+
+			__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
+
 			break;
 		}
 	}
