From: Eduard Hasenleithner <ehasenle@gmail.com>
Subject: Re: [PATCH v2] Wacom Intuos4 LED and OLED support
Date: Wed, 6 Apr 2011 21:08:56 +0200
Message-ID: <BANLkTi=RkB92OgBv75qPkMum-iCx78085w@mail.gmail.com>
References: <1301817429-12782-1-git-send-email-eduard@hasenleithner.at>
	<BANLkTimvgdahQyu94Ep=C8JU_Cfra_kdjg@mail.gmail.com>
	<20110405182808.GB13086@core.coreip.homeip.net>
	<BANLkTikmHMg=TVpQ_e7U2yED_2ciznsuCg@mail.gmail.com>
	<20110406184648.GA17470@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51949 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab1DFTI5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2011 15:08:57 -0400
Received: by iwn34 with SMTP id 34so1725894iwn.19
        for <linux-input@vger.kernel.org>; Wed, 06 Apr 2011 12:08:56 -0700 (PDT)
In-Reply-To: <20110406184648.GA17470@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

2011/4/6 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> OK, it could be that representing these leds as a generic framebuffer
> device is not the best idea (I am not ocnvinced either way yet). If this
> is the case have you thought about accessing the leds via binary sysfs
> attributes? At least you can simply "cat" icon data in those...

Hey, wow, this idea is brilliant! And no, I have not yet thought about
it. If this works, I would even prefer the solution over the IOCTL
stuff.

Now I will start the implementation of this approach, and come back
when I have a new patch. Since I have to get used to the sysfs API
this might take a few days.

Many thanks,
Eduard
