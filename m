From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 01/06] input/rmi4: Public header and documentation
Date: Sat, 17 Nov 2012 23:41:18 +0100
Message-ID: <CACRpkdZXGA6tTZHfW0Ou758PD5X-8nqS2q3NgZs6RwQvjLu8yQ@mail.gmail.com>
References: <1353124734-16803-1-git-send-email-cheiny@synaptics.com>
	<1353124734-16803-2-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:55415 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab2KQWlU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Nov 2012 17:41:20 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so1525206eaa.19
        for <linux-input@vger.kernel.org>; Sat, 17 Nov 2012 14:41:18 -0800 (PST)
In-Reply-To: <1353124734-16803-2-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Alexandra Chin <alexandra.chin@tw.synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On Sat, Nov 17, 2012 at 4:58 AM, Christopher Heiny <cheiny@synaptics.com> wrote:

> rmi.h provides public definitions required by the RMI bus implementation and
> modules that interact with it.
>
> debugfs and sysfs attributes are documented in files in
> Documentation/ABI/testing.  There's two files, one for debugfs and one for
> sysfs.
>
>
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>

Cut this white line.

> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> Cc: Joeri de Gram <j.de.gram@gmail.com>

There is always room for improvement, but you've done a massive
job at fixing this driver to a state which is perfectly maintainable
in the kernel.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
