From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] Input: touchscreen: mc13783_ts.c: Convert to platform driver
Date: Mon, 7 Jan 2013 19:01:02 -0200
Message-ID: <CAOMZO5CeRRaXG5ZXf+nP1NT1SBk-ZCmBaPNKtK1TTe0qM2J4eg@mail.gmail.com>
References: <1357590777-7498-1-git-send-email-festevam@gmail.com>
	<20130107205010.GA24637@core.coreip.homeip.net>
	<CAOMZO5AeOg20V6Feh1psXYNbhPeTeTq9d8kNusNtD_Lb8CHLyw@mail.gmail.com>
	<20130107205928.GA22813@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:48712 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab3AGVBE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jan 2013 16:01:04 -0500
Received: by mail-vb0-f49.google.com with SMTP id r6so19722470vbi.22
        for <linux-input@vger.kernel.org>; Mon, 07 Jan 2013 13:01:02 -0800 (PST)
In-Reply-To: <20130107205928.GA22813@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: s.hauer@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Mon, Jan 7, 2013 at 6:59 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> module_platform_driver() internally uses platform_driver_register()
> whereas the original code used platform_driver_probe(). These 2 behave
> differently.

Ok, got it. Please discard it.
