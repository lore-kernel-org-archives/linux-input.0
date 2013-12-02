From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: [PATCH v2] Input:Add support for DualPoint device on Dell XT2 model
Date: Mon, 2 Dec 2013 15:50:24 +0800
Message-ID: <CA+F6ckP0bM37dp=r_oqzpx=t_6hE=KPEkH-P=rPWP8M5NrZYHg@mail.gmail.com>
References: <1384524702-3411-1-git-send-email-yunkang.tang@cn.alps.com>
	<20131127001822.GB15452@core.coreip.homeip.net>
	<CA+F6ckOPi2tmQxLtsWkcyvEb3ZnP2BK50Jj-9iZrXpBm11M56A@mail.gmail.com>
	<20131202063907.GC21404@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:45550 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab3LBHu0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Dec 2013 02:50:26 -0500
Received: by mail-wi0-f175.google.com with SMTP id hi5so4323418wib.8
        for <linux-input@vger.kernel.org>; Sun, 01 Dec 2013 23:50:24 -0800 (PST)
In-Reply-To: <20131202063907.GC21404@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, david turvene <dturvene@dahetral.com>, linux-input@vger.kernel.org, Niels de Vos <ndevos@redhat.com>, Justin Clift <jclift@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>

Hi Dmitry

2013/12/2 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Wed, Nov 27, 2013 at 04:19:05PM +0800, Tommy Will wrote:

>
> OK, fair enough. I will apply the patch, but I think the ALPS driver is
> becoming a bit too unwieldy. It looks like we should split it into
> alps-st (that woudl handle older single-touch models) and alps-mt (for
> the newer multi-touch ones) and maybe a support library for the common
> code.

Thanks for your suggestion. I would consider your idea and try to make
the patch later.

To be honest, not only splitting the file into alps-st and alps-mt, I
also want to rewrite some of ALPS driver's logic.
Some source code seems not exactly and some are hard to be reused later.
However it may cause huge changes and I'm not sure if such
modification would have side-effect or pass the
review and be applied.

# To be honest, I have no confidence to rewrite the logic without
causing any side-effect. Too many models exists
and I could not have chance to test all of them.

-- 
Best Regards,
Tommy
