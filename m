From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Build breakage in samsung-keypad driver
Date: Tue, 15 Nov 2011 17:36:14 +0000
Message-ID: <20111115173614.GI3077@opensource.wolfsonmicro.com>
References: <20111115125319.GF3077@opensource.wolfsonmicro.com>
 <20111115172154.GA15114@core.coreip.homeip.net>
 <20111115172524.GH3077@opensource.wolfsonmicro.com>
 <20111115173509.GC15114@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57475 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756965Ab1KORgQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 12:36:16 -0500
Content-Disposition: inline
In-Reply-To: <20111115173509.GC15114@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>

On Tue, Nov 15, 2011 at 09:35:10AM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 15, 2011 at 05:25:24PM +0000, Mark Brown wrote:

> > arch/arm/plat-samsung/include/plat/keypad.h:16:11: error: unable to open 'linux/input/samsung_keypad.h'

> Ahh... that explains it. I'll fix it up, sorry for the trouble.

Thanks!  I'd not actually checked what the error came from, I'd just
reverted the patch.
