From: Aristeu Rozanski <aris@ruivo.org>
Subject: Re: [PATCH] add context menu key
Date: Wed, 28 Nov 2007 13:35:58 -0500
Message-ID: <20071128183558.GI24494@cathedrallabs.org>
References: <20071113235836.GP407@cathedrallabs.org> <200711270056.09156.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([66.92.68.119]:59382 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbXK1SgL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Nov 2007 13:36:11 -0500
Received: from jake.ruivo.org (gw.qemu.cathedral [192.168.72.1])
	by lobo.ruivo.org (Postfix) with ESMTP id F08725278F
	for <linux-input@vger.kernel.org>; Wed, 28 Nov 2007 13:35:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200711270056.09156.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry,
> On Tuesday 13 November 2007, Aristeu Rozanski wrote:
> > This patch adds the context menu key (HUT GenDesc 0x84)
> > 
> > Signed-off-by: Aristeu Rozanski <aris@ruivo.org>
> 
> Applied, but moved to 0x1bx range. Thank you Aristeu.
moving it to 0x1bx range, the KEY_REMOTE_<num> won't fit anymore, as you
noticed already. Also, looking the available ranges, I couldn't find any
other that would be suitable:
	- 0x1cX is used for KEY_{DEL,INS}_{EOL,EOS,LINE}
	- 0x1eX is used for KEY_FN_*
other solution I can see other than using one of these ranges is
expanding KEY_MAX, but I'm not sure it's something you want.

Just to help others understand the problem: Dmitry told me about the
problem using KEY_<NUM> in remote controls and that using KEY_KP_<NUM>
isn't a solution. So I'm trying to define new keys for numbers in remote
controls.

-- 
Aristeu

