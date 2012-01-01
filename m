From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 00/11] input: Synaptics RMI4 Touchscreen Driver
Date: Sun, 1 Jan 2012 14:51:39 +0100
Message-ID: <CACRpkdbcK9SGtQf9g55h_PGPenrvc9kxPYfZXNV1-4K8NvdAgg@mail.gmail.com>
References: <1324519802-23894-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33138 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab2AANvj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Jan 2012 08:51:39 -0500
In-Reply-To: <1324519802-23894-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On Thu, Dec 22, 2011 at 3:09 AM, Christopher Heiny <cheiny@synaptics.com> wrote:

> This patch implements a driver supporting Synaptics ClearPad and other
> touchscreen sensors that use the RMI4 protocol, as defined here:

This looks like a fundamental rewrite an huge improvement over the
previous RMI4 patches, good job!

I am not very deeply versed in the input subsystem but overall it looks
good to me, nice structure etc. I hope to be able to get back to a detailed
review and per-patch Acked-by:s ASAP.

Yours,
Linus Walleij
