From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH] Input: s3c2410_ts: Move to clk_prepare_enable/clk_disable_unprepare
Date: Wed, 09 Jul 2014 12:13:41 +0300
Message-ID: <2138540.gOK28iFQ6r@vasilykh-desktop-i5>
References: <1404155377-2862-1-git-send-email-anarsoul@gmail.com> <20140709010049.GC14935@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:47282 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbaGIJPd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jul 2014 05:15:33 -0400
In-Reply-To: <20140709010049.GC14935@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org

On 8 July 2014 18:00:49 Dmitry Torokhov wrote:

Hi Dmitry,

> > 
> > -	clk_disable(ts.clock);
> > +	clk_disable_unprepare(ts.clock);
> 
> Do we really need to unprepare on suspend? Why simply disabling is not
> enough here?

You're right, disabling should be enough here. I'll resend a patch after 
testing on a hardware.

Regards
Vasily
