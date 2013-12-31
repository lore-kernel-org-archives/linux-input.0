From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4 trivial: rmi_driver.c tidy-up
Date: Tue, 31 Dec 2013 10:44:11 -0800
Message-ID: <20131231184411.GB6897@core.coreip.homeip.net>
References: <1388458486-31102-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:52722 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341Ab3LaSoP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Dec 2013 13:44:15 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so12844349pbb.17
        for <linux-input@vger.kernel.org>; Tue, 31 Dec 2013 10:44:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1388458486-31102-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Mon, Dec 30, 2013 at 06:54:46PM -0800, Christopher Heiny wrote:
> This has three trivial changes:
> 
> 1) multi-line commenting is changed to kernel coding standard
> 
> 2) reset_and_reflash() function is renamed to rmi_initial_reset() and
> recommentedto reflect what it actually does.
> 
> 3) #endif comment was updated to actuall match the opening #if CONFIG_PM_SLEEP
> condition.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>

Applied, thank you.

-- 
Dmitry
