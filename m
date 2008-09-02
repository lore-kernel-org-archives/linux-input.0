From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Autocentering support for Logitech MOMO Racing Wheel
 (force feedback)
Date: Tue, 2 Sep 2008 17:11:16 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0809021710180.23448@jikos.suse.cz>
References: <bb829a0b0808180217t2bd3ed49q4cf5734dcc756311@mail.gmail.com>  <20080818110815.ZZRA012@mailhub.coreip.homeip.net>  <bb829a0b0808180916l1d2ca72fj689edcf5b8c156e5@mail.gmail.com>  <20080818131807.ZZRA012@mailhub.coreip.homeip.net>
 <bb829a0b0808181130r4c45403al45fffb356f321f9@mail.gmail.com> <alpine.LNX.1.10.0808191458050.18058@jikos.suse.cz> <48AB06F3.10808@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:50174 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753575AbYIBPLS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Sep 2008 11:11:18 -0400
In-Reply-To: <48AB06F3.10808@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sergey.Belyashov@gmail.com
Cc: linux-input <linux-input@vger.kernel.org>

On Tue, 19 Aug 2008, ?????? ??????? wrote:

>   Current kernel has no support for autocentering for Logitech wheels. 
> By default autocentering enabled in wheel and constant effect does not 
> work properly. Using USB sniffer I found command which change 
> autocentering settings: 0xFE, 0x0D, 0x0R, 0x0L, 0x80, 0x00, 0x00, where 
> R - clockwise force, L - counter-clockwise (0x0-0xF, 0xC = 100%). I 
> write patch for my current kernel (2.6.25), but I think git version also 
> supported, because I do not found any changes in it.

Applied, thanks Sergey.

-- 
Jiri Kosina
SUSE Labs
