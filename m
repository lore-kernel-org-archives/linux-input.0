From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Support for the eGalax dual-touch panel
Date: Sat, 10 Apr 2010 17:48:54 +0200
Message-ID: <1270914534.3869.9.camel@lovely>
References: <20100410144308.9ABEE951F6@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:61608 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab0DJPnt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Apr 2010 11:43:49 -0400
Received: by fxm23 with SMTP id 23so3379359fxm.21
        for <linux-input@vger.kernel.org>; Sat, 10 Apr 2010 08:43:48 -0700 (PDT)
In-Reply-To: <20100410144308.9ABEE951F6@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org, linux@philmerk.de, chatty@enac.fr

Am Samstag, den 10.04.2010, 16:43 +0200 schrieb Stephane Chatty:
> Added support for the eGalax dual-touch panel, found on the Asus EeePC T101MT

> diff -rupN a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c

> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>

add #include <linux/slab.h>

> +	if (!td->valid) {
> +		/*
> +		 * touchscreen emulation: if the first finger is invalid
> +		 * and there previously was finger activity, this is a release
> +		 */ 
whitespace

> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret)
> +		goto end;
> +
> +	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[5]; 
whitespace



