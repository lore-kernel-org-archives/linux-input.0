From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: [bisected regression] Touchpad "paste" stops working after
	suspend to RAM
Date: Mon, 12 Oct 2009 12:09:29 +0200
Message-ID: <20091012100929.GA4402@Pilar.aei.mpg.de>
References: <20091011162155.GA4260@Pilar.aei.mpg.de> <20091011180134.GA5197@core.coreip.homeip.net> <20091011193100.GA4410@Pilar.aei.mpg.de> <20091012090224.GB7403@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ox1.aei.mpg.de ([194.94.224.6]:44975 "EHLO ox1.aei.mpg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754706AbZJLKLY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 06:11:24 -0400
Content-Disposition: inline
In-Reply-To: <20091012090224.GB7403@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-input@vger.kernel.org

On Mon 12.Oct'09 at  2:02:24 -0700, Dmitry Torokhov wrote:
> Still, I am curious to know why we can't simply reinitialize ALPS from
> the get go, could you please send me a dmesg of resume done with
> i8042.debug? Thanks!

The dmesg was too big, so I uploaded the ~5000 lines worth of syslog
from 2.6.32-rc4 with i8042.debug info with a suspend to RAM to

http://www.aei.mpg.de/~crmafra/syslog-i8042.debug.txt

I hope this helps!
