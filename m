From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 00/11] input: Synaptics RMI4 Touchscreen Driver
Date: Wed, 4 Jan 2012 23:58:55 -0800
Message-ID: <20120105075855.GD31895@core.coreip.homeip.net>
References: <1324519802-23894-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33487 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab2AEH7B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jan 2012 02:59:01 -0500
Content-Disposition: inline
In-Reply-To: <1324519802-23894-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On Wed, Dec 21, 2011 at 06:09:51PM -0800, Christopher Heiny wrote:
> This patch implements a driver supporting Synaptics ClearPad and other
> touchscreen sensors that use the RMI4 protocol, as defined here:
> 
>     http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4%20Intrfacing%20Guide.pdf
> 
> as well as successor documents that haven't made their way through to
> publication yet.
> 
> This code represents a complete refactoring and rewrite of the previously
> submitted patches, and supersedes all those patches.  We believe that all
> outstanding issues arising from the previous submissions have been addressed.
> However, because of the quantity of new code, we are submitting this patch
> as an RFC and requesting feedback from the kernel community.
> 
> 
> This patch is against the v2.6.38 tag of Linus' kernel tree, commit
> 521cb40b0c44418a4fd36dc633f575813d59a43d.
> 
> 
> Included in this patch are:
>     - full support for an RMI virtual bus as a standard kernel bus
> 
>     - physical layer implementations for I2C and SPI
> 
>     - function implementations for the following RMI4 functions:
>         * F01 device control
>         * F09 self test (aka BIST)
>         * F11 multifinger pointing
>         * F19 capacitive buttons
>         * F34 device reflash
>         * F54 analog data reporting
> 
>     - character device access to the RMI4 register map via rmidev

Could you please tell me why this facility is needed?

-- 
Dmitry
