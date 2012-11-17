From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 02/06] input/rmi4: Core files
Date: Sat, 17 Nov 2012 23:45:27 +0100
Message-ID: <CACRpkdb6Vj2DuMM4Zb023MpHY4kJaW-xg4cjNYYqvaFQN5Tw+w@mail.gmail.com>
References: <1353124734-16803-1-git-send-email-cheiny@synaptics.com>
	<1353124734-16803-3-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:64903 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab2KQWp2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Nov 2012 17:45:28 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so1525847eaa.19
        for <linux-input@vger.kernel.org>; Sat, 17 Nov 2012 14:45:27 -0800 (PST)
In-Reply-To: <1353124734-16803-3-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Alexandra Chin <alexandra.chin@tw.synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On Sat, Nov 17, 2012 at 4:58 AM, Christopher Heiny <cheiny@synaptics.com> wrote:

> rmi_bus.c implements the basic functionality of the RMI bus.  This file is
> greatly simplified compared to the previous patch - we've switched from
> "do it yourself" device/driver binding to using device_type to distinguish
> between the two kinds of devices on the bus (sensor devices and function
> specific devices) and using the standard bus implementation to manage devices
> and drivers.

I have no further comments, I have reviewed up to my level of competence.
Next you need to fix comments from Greg & Dmitry, which will probably be
just as demanding :-)

But FWIW:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
