From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 06/06] input/rmi4: F11 - 2D touch interface
Date: Sat, 17 Nov 2012 23:54:44 +0100
Message-ID: <CACRpkdbm2+gkXDSMWf56My3pVU6_hpM5FCK-FKq1zLJqqBp9ug@mail.gmail.com>
References: <1353124734-16803-1-git-send-email-cheiny@synaptics.com>
	<1353124734-16803-7-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53640 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab2KQWyp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Nov 2012 17:54:45 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so494063eek.19
        for <linux-input@vger.kernel.org>; Sat, 17 Nov 2012 14:54:44 -0800 (PST)
In-Reply-To: <1353124734-16803-7-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Alexandra Chin <alexandra.chin@tw.synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On Sat, Nov 17, 2012 at 4:58 AM, Christopher Heiny <cheiny@synaptics.com> wrote:

> rmi_f11.c is a driver for 2D touch sensors using the RMI4 protocol.  It supports
> both touchscreen and touchpad input, in both absolute and relative formats.
> Support for Type-B multitouch is the default, Type-A support is included for
> certain legacy sensors.
>
>
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>

Cut blank line.

> To: Henrik Rydberg <rydberg@euromail.se>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> Cc: Joeri de Gram <j.de.gram@gmail.com>

I'm happy. Now you only need to convince Dmitry and Henrik too ;-)

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
