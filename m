From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 04/06] input/rmi4: Config files and makefiles
Date: Tue, 9 Oct 2012 11:08:31 +0200
Message-ID: <CACRpkdagphG+z4d-6BREkgOy4Qza=-uKw49Mpn-wPDJKCpudTA@mail.gmail.com>
References: <1349496603-20775-1-git-send-email-cheiny@synaptics.com>
	<1349496603-20775-5-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48684 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab2JIJId (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Oct 2012 05:08:33 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so4546208wgb.1
        for <linux-input@vger.kernel.org>; Tue, 09 Oct 2012 02:08:32 -0700 (PDT)
In-Reply-To: <1349496603-20775-5-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Alexandra Chen <alexandra.chen@tw.synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On Sat, Oct 6, 2012 at 6:10 AM, Christopher Heiny <cheiny@synaptics.com> wrote:

(...)
> diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
(...)
> +config RMI4_DEBUG
> +       bool "RMI4 Debugging"
> +       depends on RMI4_BUS

select DEBUG_FS

This has been illustrated many times in the review. You definatley
have code depending on debugfs when this is selected.

Yours,
Linus Walleij
