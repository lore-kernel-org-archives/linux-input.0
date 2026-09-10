Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A86496D24
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071416; cv=none; b=THegvRWoW5FGH8fxWdNj+trF9xM2YN3FUnwVilyagDw8Zrn1bYLBfbjlp8N/Kd+uOTgNAKFphFfDFmp0DPKA6whEmxLBi62j1w/WyA8x+jxWDSPPuZqA2TAnnx0ONgl0O080gKNtbseX04xgkGCoV2sIb6P6HANENrCTmpEPaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071416; c=relaxed/simple;
	bh=IyP7LT/mGVrQ6WYR81tOSt1zWfPflkzZqpUahjdvtgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yq0DQPDQwAFLi3V1hIoqrWytXDCjxFM4vLNO4j7/rgiia9UVNuhtLjoM5bza3YXJ+vy0WJlGgBbii9nnl2w3czc0uphtKZ8wfe1f0QQzxAJ8t0E6zL4LpNLv6wbtFCVdFReZfyOy/TcShW95REfnV37u3GOxP9+B646Z+X3/9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgLYTFdl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgLYTFdl"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39682983a0fso165264a91.3
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789071414; x=1789676214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m8KQqxLyRIhER5q9An5jkJG2c5Mj68qpghEp6MeEZDA=;
        b=PgLYTFdltBhejYo5iIwFGzf4RDYGRfF/sz+A84glWVzJpZdM4FkNoiplW4TZz9Y2af
         TaTGNJRZfd8HS9fgUUeXKS8qz1rHoZbC+NQqMI0oDCKpXALCKaAX8eKDhu1ycgfdxvBI
         rA/mCxKynsrwrIciokSAoJmAFWW3jgSsA8jAfE7DWrYDpWb6AEP2yIfT6yA3VzSPf6GZ
         gguQR9d8s4pnD5sJe/uFoawLtC8By85l10r3q1c7BmSqcH9nLAwZBHIHfVjJIIOyRtWh
         0UD7r9pUNp5tiDnYnOeRyhWP1aBn5IveSyHtQc3efvYEfChdIGsAbvjmEe4f9EU7D+aG
         SiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071414; x=1789676214;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m8KQqxLyRIhER5q9An5jkJG2c5Mj68qpghEp6MeEZDA=;
        b=P/GZJFTYMTwLL+V8FPMsAZ+YNalUljGoW7Jyg3hbbWsRK+I6qatPluc+meNB/daqW3
         STTwLc9sEUo0e43fQ4ahI7Bt+RnGtFjptCE9cdWYJyQ5nDo609TKyA5OZpe6QsOMXX0f
         P26rc/RxUt8RQhtu2SwkyO057dbOvFtrQBxKox3wgVEsmljXkpXpj7PRVvDmc2BUwQMb
         hqhdgux/94z9NabLMlXgOr/7yIZS35XZfEfcJfy/NoBmCAaCrMgxat11SHxIPkihM9jC
         kcZbaWyDhroHzP8pgv7tEK9DmUME/icmkVC/O/NX7uVs2/Fps8bV2ST1sQqOwCzb5/BO
         lYIw==
X-Gm-Message-State: AFuF++n0n0v2/V8tAJe70cBtIAgZUSVR1yoH9FiR+VzyeJhYRIDWYbIN
	JD8wEd4v9TPBiJRianYDF1QiRbuQ1Ir7LbOj2ouEInLmXzW17DU7ZXfK
X-Gm-Gg: AYBFou0IBg5jlkQyHDB3hyj+S38TA/koqEXCNgOLCI07DY7FUyA0tG7n9Kwx6Igyp2/
	yXTqpukRylO/NhBNZAOqu3z1hNGL0eeTR7uCMU3sJtWI63qxdQk8xvO/e88CYvGwMsO3wi7OZZ5
	PtQ2JlDCtjpDJBVmXHpuw4q8vqv1WcNjVy4iHaTv3ORNgj/B4BQjz5rMixzcKFQnOQiB5NBu9ns
	+/a8Q1BqAwyG3roCFvvjwvjfVlLZo3Jr5/c9404MMUqY/+AO1XVwUPa6EFuvDnyjlkJI1YPtP1h
	UFYfslG6ZqbYSXVDdjJ2eGcwAPqiNg5+nRur7E7QrvvPO5ZgT5zMA2aAaIh1NbXnvwJbhbLMoAf
	IxMz+62dIWhLwD8Fo5FKoURFi49Rgb/wQny2UTZkri1/xi2yELwI+v4N8KYgS6tWFSlWmqG06f/
	OoDWwg3lQXH7VkdI6V2xkrx84aMpetTYyTLXwRwBYFoQSAlFdZFj45HjMf2153m6sA6gilR+3vu
	Ba+ZUc2wSDboa7jaH+EONHOxKwR9/6HVE26D69NYiBhR/2kKPAm3ZSuId/l+p6l9vZGl8sIPu6a
X-Received: by 2002:a17:90b:51c3:b0:398:9bd5:490c with SMTP id 98e67ed59e1d1-39d9c2276fdmr686220a91.19.1789071413551;
        Thu, 10 Sep 2026 13:16:53 -0700 (PDT)
Received: from [192.168.0.158] (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143659a9a06sm1091390c88.0.2026.09.10.13.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:16:53 -0700 (PDT)
Message-ID: <9b629895-d489-46de-a8fc-4ecfc08ae96b@gmail.com>
Date: Thu, 10 Sep 2026 13:16:52 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] HID: hid-oxp: support three-page button maps on X2
 controllers
To: Andrei Aldea <andrei1998@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-13-andrei1998@gmail.com>
Content-Language: en-US
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
In-Reply-To: <20260910032115.28669-13-andrei1998@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/26 20:21, Andrei Aldea wrote:
> The ONEXPLAYER 3 and X2 Mini Pro need mapping format 0x02 and a third
> page preserving the extra buttons' factory mappings. Use exact DMI
> matches and select configuration interface 2; the other HID interfaces
> remain available without duplicate configuration or LED registration.
>
> Initialize each page with the selected format. Page three is fixed because
> its factory encodings have no entries in the public mapping table.
> Legacy devices keep their two-page format 0x20 transaction.
>
> Fixes: e4c850a6e750 ("HID: hid-oxp: Add Button Mapping Interface")
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
> ---
>   drivers/hid/hid-oxp.c | 94 ++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 79 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 8c44f57..48fa916 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -19,6 +19,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/sysfs.h>
>   #include <linux/types.h>
> +#include <linux/usb.h>
>   #include <linux/workqueue.h>
>   
>   #include "hid-ids.h"
> @@ -35,6 +36,8 @@
>   
>   #define OXP_MAPPING_GAMEPAD	0x01
>   #define OXP_MAPPING_KEYBOARD	0x02
> +#define OXP_BMAP_FORMAT_DEFAULT	0x20
> +#define OXP_BMAP_FORMAT_X2	0x02
>   #define OXP_FILL_PAGE_SLOT(page, btn)            \
>   	{ .button_idx = (page)->btn.button_idx,  \
>   	  .mapping_idx = (page)->btn.mapping_idx }
> @@ -159,9 +162,9 @@ enum oxp_joybutton_index {
>   	BUTTON_DRIGHT,
>   	BUTTON_M1 =	0x22,
>   	BUTTON_M2,
> -	/* These are unused currently, reserved for future devices */
>   	BUTTON_M3,
>   	BUTTON_M4,
> +	/* These are unused currently, reserved for future devices */
>   	BUTTON_M5,
>   	BUTTON_M6,
>   };
> @@ -209,8 +212,10 @@ struct oxp_hid_cfg {
>   	struct oxp_bmap_page_1 *bmap_1;
>   	struct oxp_bmap_page_2 *bmap_2;
>   	bool gen2_work_initialized;
> +	bool bmap_page_3;
>   	u8 rumble_intensity;
>   	u8 gamepad_mode;
> +	u8 bmap_format;
>   
>   	/* RGB state */
>   	struct delayed_work oxp_rgb_queue;
> @@ -337,6 +342,9 @@ struct oxp_attr {
>   
>   struct quirk_entry {
>   	bool hybrid_mcu;
> +	bool bmap_page_3;
> +	u8 cfg_interface_num;
> +	u8 bmap_format;
>   };
>   
>   static u16 get_usage_page(struct hid_device *hdev)
> @@ -735,8 +743,17 @@ static void oxp_page_fill_data(char *buf, const struct oxp_button_idx *buttons,
>   
>   static int oxp_set_buttons(struct oxp_hid_cfg *cfg)
>   {
> -	u8 page_1[59] = { 0x02, 0x38, 0x20, 0x01, 0x01 };
> -	u8 page_2[59] = { 0x02, 0x38, 0x20, 0x02, 0x01 };
> +	u8 page_1[59] = { 0x02, 0x38, cfg->bmap_format, 0x01, 0x01 };
> +	u8 page_2[59] = { 0x02, 0x38, cfg->bmap_format, 0x02, 0x01 };
> +	u8 page_3[59] = {
> +		0x02, 0x38, cfg->bmap_format, 0x03, 0x01,
> +		/*
> +		 * M3/M4 have no mutable sysfs mapping slots. Keep their factory
> +		 * encodings, which are not entries in oxp_button_table.
> +		 */
> +		BUTTON_M3, OXP_MAPPING_KEYBOARD, 0x02, 0x05, 0x00, 0x00,
> +		BUTTON_M4, OXP_MAPPING_GAMEPAD, 0x21, 0x00, 0x00, 0x00,
> +	};
>   	u16 up = get_usage_page(cfg->hdev);
>   	int ret;
>   
> @@ -774,7 +791,11 @@ static int oxp_set_buttons(struct oxp_hid_cfg *cfg)
>   	if (ret)
>   		return ret;
>   
> -	return oxp_gen_2_property_out(cfg, OXP_FID_GEN2_KEY_STATE, page_2, ARRAY_SIZE(page_2));
> +	ret = oxp_gen_2_property_out(cfg, OXP_FID_GEN2_KEY_STATE, page_2, ARRAY_SIZE(page_2));
> +	if (ret || !cfg->bmap_page_3)
> +		return ret;
> +
> +	return oxp_gen_2_property_out(cfg, OXP_FID_GEN2_KEY_STATE, page_3, ARRAY_SIZE(page_3));
>   }
>   
>   static void oxp_reset_buttons(struct oxp_hid_cfg *cfg)
> @@ -1550,7 +1571,13 @@ static struct quirk_entry quirk_hybrid_mcu = {
>   	.hybrid_mcu = true,
>   };
>   
> -static const struct dmi_system_id oxp_hybrid_mcu_list[] = {
> +static struct quirk_entry quirk_x2_bmap = {
> +	.bmap_format = OXP_BMAP_FORMAT_X2,
> +	.bmap_page_3 = true,
> +	.cfg_interface_num = 2,
> +};
> +
> +static const struct dmi_system_id oxp_quirk_list[] = {
>   	{
>   		.ident = "OneXPlayer Apex",
>   		.matches = {
> @@ -1575,21 +1602,34 @@ static const struct dmi_system_id oxp_hybrid_mcu_list[] = {
>   		},
>   		.driver_data = &quirk_hybrid_mcu,
>   	},
> +	{
> +		.ident = "OneXPlayer 3",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER 3"),
> +		},
> +		.driver_data = &quirk_x2_bmap,
> +	},
> +	{
> +		.ident = "OneXPlayer X2 Mini Pro",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X2Mini PRO"),
> +		},
> +		.driver_data = &quirk_x2_bmap,
> +	},
>   	{},
>   };
>   
> -static bool oxp_hybrid_mcu_device(void)
> +static const struct quirk_entry *oxp_get_quirks(void)
>   {
>   	const struct dmi_system_id *dmi_id;
> -	struct quirk_entry *quirks;
>   
> -	dmi_id = dmi_first_match(oxp_hybrid_mcu_list);
> +	dmi_id = dmi_first_match(oxp_quirk_list);
>   	if (!dmi_id)
> -		return false;
> +		return NULL;
>   
> -	quirks = dmi_id->driver_data;
> -
> -	return quirks->hybrid_mcu;
> +	return dmi_id->driver_data;
>   }
>   
>   static void oxp_drain_output(struct oxp_hid_cfg *cfg)
> @@ -1613,6 +1653,21 @@ static void oxp_quiesce_work(struct oxp_hid_cfg *cfg)
>   	oxp_drain_output(cfg);
>   }
>   
> +static bool oxp_is_cfg_interface(struct hid_device *hdev,
> +				 const struct quirk_entry *quirks)
> +{
> +	struct usb_interface *intf;
> +
> +	if (!quirks || !quirks->cfg_interface_num)
> +		return true;
> +	if (hdev->bus != BUS_USB)
> +		return false;
> +
> +	intf = to_usb_interface(hdev->dev.parent);
> +	return intf->cur_altsetting->desc.bInterfaceNumber ==
> +	       quirks->cfg_interface_num;
> +}
> +
>   static void oxp_cfg_release(void *data)
>   {
>   	struct oxp_hid_cfg *cfg = data;
> @@ -1620,7 +1675,8 @@ static void oxp_cfg_release(void *data)
>   	hid_set_drvdata(cfg->hdev, NULL);
>   }
>   
> -static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
> +static int oxp_cfg_probe(struct hid_device *hdev, u16 up,
> +			 const struct quirk_entry *quirks)
>   {
>   	struct oxp_bmap_page_1 *bmap_1;
>   	struct oxp_bmap_page_2 *bmap_2;
> @@ -1642,7 +1698,7 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
>   	if (ret)
>   		return ret;
>   
> -	if (up == GEN2_USAGE_PAGE && oxp_hybrid_mcu_device())
> +	if (up == GEN2_USAGE_PAGE && quirks && quirks->hybrid_mcu)
>   		goto skip_rgb;
>   
>   	cfg->cdev = oxp_cdev_rgb;
> @@ -1693,6 +1749,9 @@ skip_rgb:
>   
>   	cfg->bmap_1 = bmap_1;
>   	cfg->bmap_2 = bmap_2;
> +	cfg->bmap_format = quirks && quirks->bmap_format ?
> +			   quirks->bmap_format : OXP_BMAP_FORMAT_DEFAULT;
> +	cfg->bmap_page_3 = quirks && quirks->bmap_page_3;
>   	oxp_reset_buttons(cfg);
>   	INIT_DELAYED_WORK(&cfg->oxp_btn_queue, oxp_btn_queue_fn);
>   
> @@ -1720,6 +1779,7 @@ err_quiesce:
>   static int oxp_hid_probe(struct hid_device *hdev,
>   			 const struct hid_device_id *id)
>   {
> +	const struct quirk_entry *quirks;
>   	int ret;
>   	u16 up;
>   
> @@ -1738,12 +1798,16 @@ static int oxp_hid_probe(struct hid_device *hdev,
>   	}
>   
>   	up = get_usage_page(hdev);
> +	quirks = oxp_get_quirks();
>   	dev_dbg(&hdev->dev, "Got usage page %04x\n", up);
>   
>   	switch (up) {
>   	case GEN1_USAGE_PAGE:
>   	case GEN2_USAGE_PAGE:
> -		ret = oxp_cfg_probe(hdev, up);
> +		if (!oxp_is_cfg_interface(hdev, quirks))
> +			return 0;
> +
> +		ret = oxp_cfg_probe(hdev, up, quirks);
>   		if (ret) {
>   			hid_hw_close(hdev);
>   			hid_hw_stop(hdev);

I'm unable to test as these features are not present on my OneXPlayer F1 
Pro.
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>


