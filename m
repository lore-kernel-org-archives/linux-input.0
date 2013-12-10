From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] input synaptics-rmi4: Reorder declarations in
 rmi_bus.c
Date: Mon, 9 Dec 2013 22:39:14 -0800
Message-ID: <20131210063914.GD12524@core.coreip.homeip.net>
References: <1386289756-12429-1-git-send-email-cheiny@synaptics.com>
 <52A624A2.5000405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:50030 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3LJGjU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Dec 2013 01:39:20 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so6726513pde.28
        for <linux-input@vger.kernel.org>; Mon, 09 Dec 2013 22:39:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52A624A2.5000405@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Christopher Heiny <cheiny@synaptics.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

On Mon, Dec 09, 2013 at 03:14:26PM -0500, Benjamin Tissoires wrote:
> Hi Chris,
> 
> On 05/12/13 19:29, Christopher Heiny wrote:
> > This patch implements changes to the synaptics-rmi4 branch of
> > Dmitry's input tree.  The base for the patch is commit
> > 8ca01dc61a42b6f7bcba052a8c084000f7057a34.
> > 
> > This patch primarily reorders the various declarations in rmi_bus.c in order to
> > group related elements together, along with some typo fixes.  The code is still
> > horribly broken, but this change should make the following fixes easier to
> >  review.
> > 
> > Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Jean Delvare <khali@linux-fr.org>
> > Cc: Linus Walleij <linus.walleij@stericsson.com>
> > Cc: Joerie de Gram <j.de.gram@gmail.com>
> > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> > ---
> 
> FWIW, I made a review of the patch.
> The patches does not only reorder the functions, but also fix some few
> things I will detail later (plus fixes of whitespace/comments issues).
> It also changes the exported functions as GPL.
> 
> Dmitry, given the current state of the driver (which does not work at
> all if I understood correctly), maybe you can pick this one in its
> current state.

Applied, thank you.

-- 
Dmitry
