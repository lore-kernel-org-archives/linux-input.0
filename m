From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] bcm5974-0.58: name changes, open/close and	suspend/resume
 serialized
Date: Sat, 26 Jul 2008 09:49:38 +0200
Message-ID: <488AD712.1020102@euromail.se>
References: <4888311E.9010005@euromail.se> <20080725154250.GA1861@anvil.corenet.prv> <488A1A99.2070609@euromail.se> <20080725143015.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:53596 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750796AbYGZHuA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jul 2008 03:50:00 -0400
In-Reply-To: <20080725143015.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, robfitz@273k.net, akpm@osdl.org, jikos@jikos.cz, vojtech@suse.cz, dmonakhov@openvz.org, johannes@sipsolutions.net

Hi Dmitry,

one thing about the drivers/input/mouse/Kconfig patch:

The original version contained "select USB", which was later changed
to "depends on USB" by Andrew Morton. I saw it reappear as "select USB"
in your latest patch, and simply considered it a change back, but
maybe it was an oversight?

Cheers,
Henrik

