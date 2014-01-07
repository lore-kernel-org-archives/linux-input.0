From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] Input: twl4030 - convert to using managed resources
Date: Tue, 07 Jan 2014 09:39:51 +0900
Message-ID: <001101cf0b40$fa0d1e90$ee275bb0$%han@samsung.com>
References: <20140104090147.GA16680@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:18458 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbaAGAj6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jan 2014 19:39:58 -0500
In-reply-to: <20140104090147.GA16680@core.coreip.homeip.net>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Sebastian Reichel' <sre@debian.org>
Cc: linux-input@vger.kernel.org, 'Fugang Duan' <B38611@freescale.com>, 'Peter Ujfalusi' <peter.ujfalusi@ti.com>, ".linux-kernel"@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Saturday, January 04, 2014 6:02 PM, Dmitry Torokhov wrote:
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

It looks good.

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
> 
> Compile-tested only.
> 
> 
>  drivers/input/keyboard/twl4030_keypad.c | 70 +++++++++++----------------------
>  1 file changed, 22 insertions(+), 48 deletions(-)

