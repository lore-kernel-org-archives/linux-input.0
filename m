From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Build breakage in samsung-keypad driver
Date: Tue, 15 Nov 2011 09:35:10 -0800
Message-ID: <20111115173509.GC15114@core.coreip.homeip.net>
References: <20111115125319.GF3077@opensource.wolfsonmicro.com>
 <20111115172154.GA15114@core.coreip.homeip.net>
 <20111115172524.GH3077@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:32775 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962Ab1KORfR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 12:35:17 -0500
Received: by eye27 with SMTP id 27so5958117eye.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 09:35:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111115172524.GH3077@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>

On Tue, Nov 15, 2011 at 05:25:24PM +0000, Mark Brown wrote:
> On Tue, Nov 15, 2011 at 09:21:54AM -0800, Dmitry Torokhov wrote:
> 
> > Hmm, I haven't removed the original header though, I had plat/keypad.h
> > include the new linux/input/samsung-keypad.h so that it should be
> > transparent for all existing users.
> 
> > Could you tell me exactly what breaks?
> 
> You've not got the name of your new header correct:
> 
> arch/arm/plat-samsung/include/plat/keypad.h:16:11: error: unable to open 'linux/input/samsung_keypad.h'

Ahh... that explains it. I'll fix it up, sorry for the trouble.

-- 
Dmitry
