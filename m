From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4: elliminate multiple sensor support
 from rmi_f11.c
Date: Mon, 9 Dec 2013 22:34:35 -0800
Message-ID: <20131210063435.GC12524@core.coreip.homeip.net>
References: <1386295167-866-1-git-send-email-aduggan@synaptics.com>
 <52A6301B.1090507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:45628 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab3LJGep (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Dec 2013 01:34:45 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so6687124pdj.15
        for <linux-input@vger.kernel.org>; Mon, 09 Dec 2013 22:34:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52A6301B.1090507@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

On Mon, Dec 09, 2013 at 04:03:23PM -0500, Benjamin Tissoires wrote:
> On 05/12/13 20:59, Andrew Duggan wrote:
> > This patch implements changes to the synaptics-rmi4 branch of
> > Dmitry's input tree.  The base for the patch is commit
> > 8ca01dc61a42b6f7bcba052a8c084000f7057a34.
> 
> FWIW, these three lines above could (should) go after the very first
> "---" before the stats. This way, you will tell the list which base is
> the patch based, but this will not go into Linus' tree (which would be
> irrelevant).
> 
> > 
> > This patch elliminates support for multiple sensors in rmi_f11. This feature
> > has been removed from the RMI4 spec and no devices have every used multiple
> > F11 sensors on a single device.
> > 
> > Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> > ---
> 
> I did not saw anything but what the commit message claims. So:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

-- 
Dmitry
