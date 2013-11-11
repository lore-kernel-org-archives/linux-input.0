From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] Input: usbtouchscreen: ignore eGalax/D-Wav/EETI
 HIDs
Date: Mon, 11 Nov 2013 11:21:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1311111121290.7751@pobox.suse.cz>
References: <20131021163818.GB30240@alittletooquiet.net> <alpine.LNX.2.00.1311051052530.2779@pobox.suse.cz> <20131108174937.GB17307@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53183 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283Ab3KKKVq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Nov 2013 05:21:46 -0500
In-Reply-To: <20131108174937.GB17307@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Forest Bond <forest@forestbond.com>, linux-input@vger.kernel.org, =?ISO-8859-15?Q?Sebastian_Dalfu=DF?= <sd@sedf.de>, Daniel Ritz <daniel.ritz@gmx.ch>, Max Weninger <max.weninger@gmail.com>, Christian Engelmayer <christian.engelmayer@frequentis.com>

On Fri, 8 Nov 2013, Dmitry Torokhov wrote:

> > > From: Forest Bond <forest.bond@rapidrollout.com>
> > > 
> > > The HID driver now handles these devices, regardless of what protocol
> > > the device claims it supports.
> > > 
> > > Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
> > 
> > Dmitry,
> > 
> > could you please Ack this, so that it can be applied together with 1/2? 
> > Thanks!
> 
> Jiri,
> 
> Sorry for the delay. Yes, please merge through your tree.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks, I have applied both patches now.

-- 
Jiri Kosina
SUSE Labs
