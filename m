From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/4] HID: wacom - Add default permission defines for sysfs attributes
Date: Wed, 10 Sep 2014 14:59:43 -0400
Message-ID: <CAN+gG=FfZ3wb_-PO6OZc8_PSPuj_A=cEBi68+gbCZHik72LFgw@mail.gmail.com>
References: <1410374404-25832-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:51310 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbaIJS7o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 14:59:44 -0400
Received: by mail-qg0-f52.google.com with SMTP id i50so5054547qgf.25
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2014 11:59:43 -0700 (PDT)
In-Reply-To: <1410374404-25832-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>, Ping Cheng <pingc@wacom.com>, "Paul A. Tessier" <phernost@gmail.com>

On Wed, Sep 10, 2014 at 2:40 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> RW : ug=rw,o=r
> WO : ug=w
>
> Signed-off-by: Paul A. Tessier <phernost@gmail.com>
> Signed-Off-by: Ping Cheng <pingc@wacom.com>
> Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/wacom_sys.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index f0db7ec..2ce102b 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -23,6 +23,9 @@
>  #define WAC_CMD_ICON_BT_XFER   0x26
>  #define WAC_CMD_RETRIES                10
>
> +#define DEV_ATTR_RW_PERM (S_IRUGO | S_IWUSR | S_IWGRP)
> +#define DEV_ATTR_WO_PERM (S_IWUSR | S_IWGRP)
> +

I guess you missed the correct split with 2/4 :)
Please also add in this patch where these defines are used.

Cheers,
Benjamin

>  static int wacom_get_report(struct hid_device *hdev, u8 type, u8 id,
>                             void *buf, size_t size, unsigned int retries)
>  {
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
