From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4: elliminate multiple sensor support
 from rmi_f11.c
Date: Sat, 7 Dec 2013 08:05:27 -0800
Message-ID: <20131207160527.GB11635@core.coreip.homeip.net>
References: <1386295167-866-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:48882 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab3LGQFd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Dec 2013 11:05:33 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so2785872pbc.15
        for <linux-input@vger.kernel.org>; Sat, 07 Dec 2013 08:05:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386295167-866-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Andrew,

On Thu, Dec 05, 2013 at 05:59:27PM -0800, Andrew Duggan wrote:
> This patch implements changes to the synaptics-rmi4 branch of
> Dmitry's input tree.  The base for the patch is commit
> 8ca01dc61a42b6f7bcba052a8c084000f7057a34.
> 
> This patch elliminates support for multiple sensors in rmi_f11. This feature
> has been removed from the RMI4 spec and no devices have every used multiple
> F11 sensors on a single device.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

I am a bit confused here - has this been coordinated with recent
submission by Chris? I'd prefer if there was a single person from
Synaptics posting patches at the same time, so that I know they are
properly sequenced.

Thanks!

-- 
Dmitry
