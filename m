From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Build breakage in samsung-keypad driver
Date: Tue, 15 Nov 2011 09:21:54 -0800
Message-ID: <20111115172154.GA15114@core.coreip.homeip.net>
References: <20111115125319.GF3077@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49109 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836Ab1KORWF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 12:22:05 -0500
Received: by eye27 with SMTP id 27so5943920eye.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 09:22:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111115125319.GF3077@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>

Hi Mark,

On Tue, Nov 15, 2011 at 12:53:20PM +0000, Mark Brown wrote:
> Hi Dmitry,
> 
> Your commit 5862c02 (Input: samsung-keypad - enable compiling on other
> platforms) breaks the build on any platform using the driver as you've
> moved the header defining the platform data without updating any of the
> users.  Whenever doing updates to platform data you really need to grep
> the tree for users and make sure they're updated otherwise there will be
> build breakage.

Hmm, I haven't removed the original header though, I had plat/keypad.h
include the new linux/input/samsung-keypad.h so that it should be
transparent for all existing users.

Could you tell me exactly what breaks?

> 
> I also can't see the patch on the list...

Admittedly was buried in a separate thread, but:

http://www.spinics.net/lists/linux-samsung-soc/msg06578.html

Thanks.

-- 
Dmitry
