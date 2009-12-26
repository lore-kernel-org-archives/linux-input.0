From: Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [RFT] Input: speed up suspend/shutdown for PS/2 mice and keyboards
Date: Sat, 26 Dec 2009 13:40:06 +0000
Message-ID: <magh07-258.ln1@chipmunk.wormnet.eu>
References: <20091221070951.GA4170@core.coreip.homeip.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752315AbZLZOIi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> I am asking everyone to give this patch a try. It is reported to speed
> up suspend process, however there is a risk that there are boxes out
> there that do require full reset and I would prefer to know that sooner
> than later.
> 
Seems to work on my ICH8 lapdog (a Fujitsu T2010), can't say it actually 
speeds the suspend/resume cycle up though.

Cheers

-- 
Alexander Clouter
.sigmonster says: Bus error -- driver executed.
