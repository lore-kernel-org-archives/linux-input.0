From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 01/05] input synaptics-rmi4: Split F01 definitions out
 into header file for use by reflash.
Date: Mon, 10 Mar 2014 07:46:58 -0700
Message-ID: <20140310144658.GB18578@sonymobile.com>
References: <1394245795-17347-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:13710 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753456AbaCJOpG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 10:45:06 -0400
Content-Disposition: inline
In-Reply-To: <1394245795-17347-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Sat, Mar 08, 2014 at 03:29:51AM +0100, Christopher Heiny wrote:
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Linux Walleij <linus.walleij@linaro.org>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> 
> ---
> 
>  drivers/input/rmi4/rmi_f01.c |  96 ++-----------------------------------
>  drivers/input/rmi4/rmi_f01.h | 110 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 114 insertions(+), 92 deletions(-)

$SUBJECT is 83 characters long.  Please be more brief and provide a
description.

[...]
> +#define RMI_SLEEP_MODE_NORMAL		0x00
> +#define RMI_SLEEP_MODE_SENSOR_SLEEP	0x01
> +#define RMI_SLEEP_MODE_RESERVED0	0x02
> +#define RMI_SLEEP_MODE_RESERVED1	0x03
> +
> +#define RMI_IS_VALID_SLEEPMODE(mode) \
> +	(mode >= RMI_SLEEP_MODE_NORMAL && mode <= RMI_SLEEP_MODE_RESERVED1)
> +

I might be missing something, but these seem like the only defines used
in the flash code.  Why not keep these in the f01 driver, and export
a couple more functions, like rmi_f01_reset() and rmi_f01_set_sleep_mode() ?

-Courtney
