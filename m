From: Robert Gerlach <khnz@gmx.de>
Subject: Re: [PATCH] Fujitsu application panel driver
Date: Sun, 18 Nov 2007 23:36:58 +0100
Message-ID: <200711182336.59312.khnz@gmx.de>
References: <20070702111724.43ee5b43@freepuppy.localdomain.hemminger.net> <200709161623.00286.dtor@insightbb.com> <20071023125555.38d63567@shemminger-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755559AbXKRWh0@vger.kernel.org>
In-Reply-To: <20071023125555.38d63567@shemminger-laptop>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Dmitry Torokhov <dtor@insightbb.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am Dienstag 23 Oktober 2007 21:55:55 schrieb Stephen Hemminger:
> +MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifeBook*:pvr*:rvnFUJITSU:*");
> +MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifebook*:pvr*:rvnFUJITSU:*");

Please make sure that this module is not autoload on Lifebook tablets (T 
series and P1[56]10). It works fine, but only supports a subset of features 
(4 of 7 buttons and no display orientation for my T4010).

Thanks,
  Robert
