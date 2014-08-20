From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] SOUND: kill gameport bits
Date: Wed, 20 Aug 2014 13:20:14 +0100
Message-ID: <20140820132014.5acc35f4@alan.etchedpixels.co.uk>
References: <20140820024638.GA25240@rhlx01.hs-esslingen.de>
	<20140820051815.GA1109@core.coreip.homeip.net>
	<20140820063951.GA6791@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:50970 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbaHTMUb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Aug 2014 08:20:31 -0400
In-Reply-To: <20140820063951.GA6791@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andreas Mohr <andi@lisas.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Takashi Iwai <tiwai@suse.de>

> It wouldn't be hard to fix: That code was developed when the timing
> infrastructure in the kernel was non-existent, making use of it today
> would make things a lot easier.

You can also use pm_qos on most machines to stop PM messing it up. Ugly
but works.

Alan
