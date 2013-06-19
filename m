From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH V3 5/5] input: pxa27x-keypad: add device tree support
Date: Wed, 19 Jun 2013 10:22:51 +0200
Message-ID: <201306191022.51630.marex@denx.de>
References: <1371527778-5236-1-git-send-email-chao.xie@marvell.com> <1371527778-5236-6-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:36789 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551Ab3FSIWz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Jun 2013 04:22:55 -0400
In-Reply-To: <1371527778-5236-6-git-send-email-chao.xie@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chao Xie <chao.xie@marvell.com>
Cc: dmitry.torokhov@gmail.com, arnd@arndb.de, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, drwyrm@gmail.com, stefan@openezx.org, laforge@openezx.org, robert.jarzmik@free.fr, sleep_walker@suse.cz, slapin@ossfans.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, xiechao.mail@gmail.com

Dear Chao Xie,

> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
>  .../devicetree/bindings/input/pxa27x-keypad.txt    |   60 +++++
>  drivers/input/keyboard/pxa27x_keypad.c             |  232
> +++++++++++++++++++- 2 files changed, 288 insertions(+), 4 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/input/pxa27x-keypad.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/pxa27x-keypad.txt
> b/Documentation/devicetree/bindings/input/pxa27x-keypad.txt new file mode
> 100644
> index 0000000..f8674f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/pxa27x-keypad.txt
> @@ -0,0 +1,60 @@
> +* Marvell PXA Keypad controller
> +
> +Required Properties
> +- compatible : should be "marvell,pxa27x-keypad"
> +- reg : Address and length of the register set for the device
> +- interrupts : The interrupt for the keypad controller
> +- marvell,debounce-interval : How long time the key will be

Is there no generic prop name for this debounce interval?

Best regards,
Marek Vasut
