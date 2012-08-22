From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 00/11] input: Synaptics RMI4 Touchscreen Driver
Date: Wed, 22 Aug 2012 14:50:48 +0200
Message-ID: <CACRpkda6Aq_rmYjMx6fcYvPnEexZ47dhaiA3hsCozLyUT0Mikw@mail.gmail.com>
References: <1345241877-16200-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54150 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab2HVMut (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Aug 2012 08:50:49 -0400
Received: by weyx8 with SMTP id x8so561179wey.19
        for <linux-input@vger.kernel.org>; Wed, 22 Aug 2012 05:50:48 -0700 (PDT)
In-Reply-To: <1345241877-16200-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>, Peichen Chang <peichen.chang@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On Sat, Aug 18, 2012 at 12:17 AM, Christopher Heiny
<cheiny@synaptics.com> wrote:

> This patch implements a driver supporting Synaptics ClearPad and other
> touchscreen sensors that use the RMI4 protocol, as defined here:

Nice!

> This patch is against the v2.6.38 tag of Linus' kernel tree, commit
> 521cb40b0c44418a4fd36dc633f575813d59a43d.  This will be our last patch against
> such an old kernel version, future patches will be against 3.x kernels.

Please use the head of the subsystem tree to do this work.
In this case, use Dmitry's git.

Currently I just cannot test this because we have no such old codebase
around.

But I will attempt to review the patch set!

Yours,
Linus Walleij
