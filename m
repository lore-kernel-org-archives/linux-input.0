From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 05/06] input/rmi4: F01 - device control
Date: Sat, 17 Nov 2012 23:56:15 +0100
Message-ID: <CACRpkdZOowrdgP4LTrvywVwsRhh7KZmEmO6t29dy9bcs-2tc3g@mail.gmail.com>
References: <1353124734-16803-1-git-send-email-cheiny@synaptics.com>
	<1353124734-16803-6-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46665 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab2KQW4Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Nov 2012 17:56:16 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so494284eek.19
        for <linux-input@vger.kernel.org>; Sat, 17 Nov 2012 14:56:15 -0800 (PST)
In-Reply-To: <1353124734-16803-6-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Alexandra Chin <alexandra.chin@tw.synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On Sat, Nov 17, 2012 at 4:58 AM, Christopher Heiny <cheiny@synaptics.com> wrote:

> RMI Function 01 implements basic device control and power management
> behaviors for the RMI4 sensor.
>
> rmi_f01.h exports definitions that we expect to be used by other functionality
> in the future (such as firmware reflash).
>
>
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>

Cut blank line.

> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> Cc: Joeri de Gram <j.de.gram@gmail.com>

All other comments I've had appear to be fixed.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
