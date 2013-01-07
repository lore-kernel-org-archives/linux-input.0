From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: touchscreen: mc13783_ts.c: Convert to platform
 driver
Date: Mon, 7 Jan 2013 12:59:28 -0800
Message-ID: <20130107205928.GA22813@core.coreip.homeip.net>
References: <1357590777-7498-1-git-send-email-festevam@gmail.com>
 <20130107205010.GA24637@core.coreip.homeip.net>
 <CAOMZO5AeOg20V6Feh1psXYNbhPeTeTq9d8kNusNtD_Lb8CHLyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33973 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab3AGU7b (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jan 2013 15:59:31 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so10991260pad.16
        for <linux-input@vger.kernel.org>; Mon, 07 Jan 2013 12:59:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AeOg20V6Feh1psXYNbhPeTeTq9d8kNusNtD_Lb8CHLyw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: s.hauer@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Mon, Jan 07, 2013 at 06:55:48PM -0200, Fabio Estevam wrote:
> Hi Dmitry,
> 
> On Mon, Jan 7, 2013 at 6:50 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > This is not equivalent transformation. Did you intend to change the
> > behavior? If you this should be mentioned (and reasoned) in the
> > patch description.
> 
> Sorry, do not understand why the behavior changes? Can you please explain?

module_platform_driver() internally uses platform_driver_register()
whereas the original code used platform_driver_probe(). These 2 behave
differently.

-- 
Dmitry
