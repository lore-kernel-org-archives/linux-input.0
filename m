From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] HID: Add support for Macbook Pro 8 keyboards.
Date: Sat, 22 Oct 2011 14:04:26 +0200
Message-ID: <20111022120426.GA2281@polaris.bitmath.org>
References: <1319220838-3297-1-git-send-email-gokcen@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:35700 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462Ab1JVL4V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Oct 2011 07:56:21 -0400
Received: from iph3.telenor.se (iph3.telenor.se [195.54.127.134])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 10294EAC64
	for <linux-input@vger.kernel.org>; Sat, 22 Oct 2011 13:56:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319220838-3297-1-git-send-email-gokcen@pardus.org.tr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?B?R/Zr52Vu?= Eraslan <gokcen@pardus.org.tr>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi G=F6k=E7en,

looks good, except

> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 7d27d2b..ffa7a85 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -112,6 +112,9 @@
>  #define USB_DEVICE_ID_APPLE_ALU_REVB_ANSI	0x024f
>  #define USB_DEVICE_ID_APPLE_ALU_REVB_ISO	0x0250
>  #define USB_DEVICE_ID_APPLE_ALU_REVB_JIS	0x0251
> +#define USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI	0x0252
> +#define USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO	0x0253
> +#define USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS	0x0254
>  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI  0x0239
>  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO   0x023a
>  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS   0x023b

which is not sorted.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
