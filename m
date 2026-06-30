Received: from sonic315-20.consmr.mail.ne1.yahoo.com (sonic315-20.consmr.mail.ne1.yahoo.com [66.163.190.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F63E022C
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843082; cv=none; b=JqTOVqUxIINN7m8KHOiRPdMfRO8qT7kTFKC/GnEspzko/ZMyQD9npg8wxakrfuVKmv3aCajWXxm03lgwCNGfJvq2Dyelwp1m/9jU08KTcy3f+gaVWkHW5iFIqy9VpQzDhPnJ7EAobvEua38XhBGUa5+pAp6dc2Iscb/bLZ9+7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843082; c=relaxed/simple;
	bh=9r2PFQJ6UrdGLmcCXU5Y+uNpZDQI9t/h4v3wH9pM56A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nd3qlwAcI8c4iOr1QLTre0VkPDoMFiRTz5IjWUxuKbZoHGRXdKEmjnzCUqjcpGdGrwvRjYbBQpm1tbt8ciE1tsbW9tnsrgmRTtjKYEWzGvoz9Kj1Dj0fEiYOYfVH8edRuYKjdmeTbo+5Eg/MIxqbjxo+yqnt04a6T59lBWnATes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jYC5J8LA; arc=none smtp.client-ip=66.163.190.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jYC5J8LA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1782843079; bh=CMc/pbXBHB+O3MF9vGtu+1r9O+IT31aOOgnEXI1yhIs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jYC5J8LAsb+x6Wr1XGckHZYjTbUida7CcbfOHVRYFfqYgz8HBXgU/5dUGcPM5Br79UAWRSDttKmj3c36P19dt1eJgtQdMqQfvZkZ+09foO2Ssqdn3lANArnNo0JD+STuook9d94vP5zvNjMM0Z+Bux60DaC8IEIP/jGw9TSiNuego1pkh4RHyfj9AEpuTw4QV7dmu3uUdW1stCAo0nKEfHMkmqXEh3Oyc+uAfUr7IBkAu1fuqnlVArJRjXrIAva3nqJvpi6GqgLfNDbv3Th0A/gd/6OgjQZMsVUvf6rnC8UGjFOC5jFgPUWSicdkk+/GzPF9fH38kMdPY313TYD+Gg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1782843079; bh=6YYcZuSasJ4XNWReLkLFhw5edj+8XMYq78ix9fPGXg1=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HmbXb+yWmypNRbwqkbW5B0OMbIgOAN3kD7q8ZYuO/+3ym3XXWPEh1lfad9594D2l3Upg4qhb7PTtgyhlDUaBq1jU3C0B5e7z6K5BtOrDfEEnebzvpp6OO6JaxMGorLjgG7LMqDsiIulTOOJtwWEa45C8MRzpSYwy5YPwSJmWIIgfbqCUrEt2/jK+xAC9sUpvIR/s4nz2OVysX5eUxtVVKU1CXIM9kIbJ2nHRsp4PLzTrBnnBvksrip7CJ2GkCd4CkeruGOrjAiuVwx0kpKriBv41OSxqR4cQlvIwXWdbQDNAQ7vXbzqWy0BThqcQygvJEcCl4NLBoY/GRewQ5W2aww==
X-YMail-OSG: Ih5WAUYVM1m9RD8kTSV3XeZpRWhZkZxranhS4NutQeRNoZMEPP97383.9nh_Dbd
 DGi62e.HgXzvDk4JrrmTdnF9yMibm1KBVN9bfoQr5amL9Sr3HCBqYUyo0F.T2j8_ZvD.LEphzcHh
 LDb1xghnP3qgTM2DZ.1f8WwFtsUSfHod_DwXmdsUMpymCW0NErOAfOJgYh6TZOy.1D81RUq36x64
 ivNRr7o28AaGaMR7tcstvBiTJt.6g0Sp.Ud325RszW7GdYCm1fmny7yti8oXGbmA._UDLnOh1jhJ
 GEhheck0DfH7hi1qfo5wURROBfEOAoHTeZj113m326Xdjru.fZ135W.KdQJIzmIfHitQF26LJOPe
 lPQvh.wzr3yhSRvZLetNKJOvJylZJro1l4GUtzjRiZYQkwvrzw_HUMvV9rYwf_g8BY5gPdmYGvLu
 ZpogekfGozgR6_8ajXyVNq6KPpz9s4SHF4_Fnaa7KB3o6sP_aDH8X8k7i0fINcy69sE70Jk4tufd
 5qco8Dc7n3MIqaJqIHhxEG9OZDofIBrtQnFDTlDxLaBkH2nZifNqPF3Mb2pcmrkrrze_WXY3ONLR
 4milFv35YeZD4IYUlgX8rjWOoMj.5_XheKt3E2hYkpx5xy_ttcY9CrAMSx_Zh5D1KMQtynulA6Et
 ugTmTzDVCnDD0klb2hHkZgT4NjaR69_0nBWftdi2tIpbDZyX_5Mey3bSpEkRmfvnjvVMUS8P8_XI
 TiE4w3AWVRzvf7VFCjmh3o5.gwX1mAmb9tHWOopU16FZsQnpECo2zrHp71zEaP6yQtXHn4Bj.CDg
 JCtMg6kJfd.pRMRl83hQopDXyooyHaig9APLC73YOH4QOr4jAiC6ZuYIk_Ubtt8_w74zhDbht6mu
 BRVBVPtTYJZkfy9e7.E.8C8D7wxBepzgVtoV3rXByBsVbiJmLmXKa0AVj4bhWgeLgUp5ec.b1ATJ
 OxWp2Lv3sUrzQYZmVqu6Cmhoyeb8oSpf03YAd70GS8l4kXgYOB2pWwIa1Oryt20ilOFmyPXT9qqV
 PBz1Psh92CnelG1wtHVSxTIC8Xl5lUcIZjP9ZAZFZstOX.b11rCYvE.BTMz3LBnwKvQWum.fvMzs
 ZUvxKPUP3VvAAF92V9ydns8O3M79_0vxtOO1eXzZkDfRvD2v_DpfLPeAEGL03ioX334vSA53maE4
 p9VpmMjh5Kk9hSS.8u2VaOvPir_CteCvTuAT7wux4NJXZ0GQ5SyeKeqf9EXmS9ji2yfCflTfv8tf
 NbwYvoTt_PzKBvF6JO.xI1QDe0ncmKcR9qpZCtxKljSOTGEsh4pz_fZqyFJLkcYVP2RIh6W8iQgo
 5z.eiEosv.BWG3Xmm3oD0cto92G9nTcfSE7bt.7sckmOvclEwu_0B6FV4YS5gUlrPpNOj2jidBHR
 tYdeoYqgjcrpDUvzMkBpIaOqn8WDDtTXYTdlqs76.ThiJIqE_tQEUhIcRio7MXQyo0a2EQh._xUU
 onUyDvbpKstsbGH18JalQFPAqbRRhqOVQVlRikLJfFVMDIDXOSNaJUBJt27rLXU7leGnKpDa7gmu
 nVfrH77mVCg1vnB0UcAIyQRVX03bzDKMiCkdxqJpOVHfaQgFmUQ78PrjFHNdX3C40kD6mwZ1lhBz
 rvS4_8le40o8kwoGkfSDHCDdW7lWgMrPzcIkpp5dprNbbt.X2H2kFcWYacMwR.EP4NegKZ9p5j00
 Zl2x1LIed.OFjABW5YFvdfVxVgnZeuWwy4h7VEk_edxwNiez0F2q7YkGUl9pZTTpAAfODXkowlho
 TGp7MRlU1DX6gvbjQDtz9FrJmlelEOWWcKrsB2bS2gLdox6XsbpREp0INdr_PD_4ji7a5IJYxjQp
 8_wgFl6mVLoPFY6eky3bStH2sINBahM0XSRPS1qu4FYPZzfwbMfXlAsNY.YDNKUh1ewXsiJ4Wdbo
 QQiz8FvaJc4_o.p16CitF_26jP_68.mOjC58yOXDcf1eMjIq.68Og3AyvKuoUsoabdCj8do.hIJS
 4VBI0JhwWzWEEppAArk4ewsqDFbaW3_myDjdb_0bOX1EVGRG4tgc0HhnielGPrT17VPtsibexK30
 fIbeWg5u7rbyBYv5ZgFOddF1egPBh3YyGGn_0T1lp5qxLU93bd6Pt59nZW2XUVn365jRX2Qak5tW
 bi.yyV78ATxOT5xcCCSYi.s.JxuzPqkUgI34rHPL86syTMO.wa1FKIyMwSXpuAjSb94wDoL7o9EB
 5BUGo8jQFtoXzEUuVTVSL_J2hSgclEZicn.ftm3Ova.2g1lBlcu9hGlVWH1QAv.3E4tYFoSw7DkB
 5
X-Sonic-MF: <serdeliuk@yahoo.com>
X-Sonic-ID: 7990f1ba-e42c-4164-89af-c2030526b81a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Jun 2026 18:11:19 +0000
Received: by hermes--production-ir2-7b48fcd765-h9mlk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d6fbd58cbf6cca63090647b376dcd879;
          Tue, 30 Jun 2026 16:43:32 +0000 (UTC)
Message-ID: <9fc25f84-b8b1-4ffa-a79e-ff95020ec45f@yahoo.com>
Date: Tue, 30 Jun 2026 18:43:29 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: asus: add new Asus EC hid device for keyboard
 backlight and FN HotKeys
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <20251221-add-support-for-the-asus-hid-ec-v1-1-35d7d70fbbfc@yahoo.com>
Content-Language: en-US
From: Alexandru Serdeliuc <serdeliuk@yahoo.com>
In-Reply-To: <20251221-add-support-for-the-asus-hid-ec-v1-1-35d7d70fbbfc@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26086 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi Jiri, Benjamin,

Enquiring if anyone has had a chance to look over this patch series from 
December?

To provide a bit of architectural context, this is a 100% pure HID 
client driver.

This laptop (Asus Zenbook A14 UX3407QA) runs on the Qualcomm ARM64 
Snapdragon platform.

Because it is an ARM device, it does not use traditional legacy x86 
ACPI/WMI code.

Instead, the Fn hotkeys and keyboard backlight controls are routed 
completely through standard vendor-specific HID reports (using Report ID 
0x5A) over the existing I2C-HID transport layer.

It requires absolutely zero Device Tree modifications or external 
platform subsystem hooks to bind or function.

The driver matches strictly on Vendor/Product ID (0x0B05 / 0x0220) 
passed directly through the core HID subsystem.

I would highly appreciate any architectural feedback or a quick review!

Best regards,
Alexandru Marc Serdeliuc


On 12/21/25 12:12, Alexandru Marc Serdeliuc via B4 Relay wrote:
> From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> 
> Add support for Asus Embedded Controlled accessed via HID
> 
> Currently working features:
> - Keyboard Backlight
> - FN HotKeys
> 
> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> ---
> Add support for Asus Embedded Controlled accessed via HID
> 
> Currently working features:
> - Keyboard Backlight
> - FN HotKeys
> ---
>   drivers/hid/Kconfig       |  10 ++
>   drivers/hid/Makefile      |   1 +
>   drivers/hid/hid-asus-ec.c | 386 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 397 insertions(+)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 920a64b66b25b39e8259105c7c9b975fb77b2725..f0fbc951735eeea39198137294a9429f5b9d34b8 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -202,6 +202,16 @@ config HID_ASUS
>   	- GL553V series
>   	- GL753V series
>   
> +config HID_ASUS_EC
> +	tristate "ASUS EC HID support (Zenbook A14 UX3407QA)"
> +	depends on HID && I2C_HID
> +	help
> +	  Say Y here if you have an ASUS Zenbook A14 (UX3407QA) and want
> +	  support for its EC-controlled keyboard backlight and Fn hotkeys
> +
> +	  This driver is currently only tested on the ASUS Zenbook A14
> +	  UX3407QA; behaviour on other models is unknown.
> +
>   config HID_AUREAL
>   	tristate "Aureal"
>   	help
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 361a7daedeb85454114def8afb5f58caeab58a00..bacccf00482c1b787ce59660e4366f8224aeefee 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_HID_APPLETB_BL)	+= hid-appletb-bl.o
>   obj-$(CONFIG_HID_APPLETB_KBD)	+= hid-appletb-kbd.o
>   obj-$(CONFIG_HID_CREATIVE_SB0540)	+= hid-creative-sb0540.o
>   obj-$(CONFIG_HID_ASUS)		+= hid-asus.o
> +obj-$(CONFIG_HID_ASUS_EC)	+= hid-asus-ec.o
>   obj-$(CONFIG_HID_AUREAL)	+= hid-aureal.o
>   obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
>   obj-$(CONFIG_HID_BETOP_FF)	+= hid-betopff.o
> diff --git a/drivers/hid/hid-asus-ec.c b/drivers/hid/hid-asus-ec.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1cf61fb2468d079827bfdb1db49daca905e53874
> --- /dev/null
> +++ b/drivers/hid/hid-asus-ec.c
> @@ -0,0 +1,386 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ASUS EC HID driver for Zenbook A14 (UX3407QA)
> + *
> + * EC I2C HID driver for keyboard backlight and Fn hotkeys.
> + *
> + * Copyright (c) 2025 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/hid.h>
> +#include <linux/input.h>
> +#include <linux/leds.h>
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/string.h>
> +#include <linux/delay.h>
> +#include <linux/pm.h>
> +
> +#define ASUS_VENDOR_ID		0x0B05
> +#define ASUS_PRODUCT_ID		0x0220
> +
> +#define A14_EC_REPORT_ID	0x5A
> +#define A14_EC_REPORT_SIZE	64
> +#define A14_EC_MAX_BACKLIGHT	3
> +
> +#define A14_EC_EVT_KEY_FN_ESC	0x4E
> +#define A14_EC_EVT_KEY_FN_F4	0xC7
> +#define A14_EC_EVT_KEY_FN_F5	0x10
> +#define A14_EC_EVT_KEY_FN_F6	0x20
> +#define A14_EC_EVT_KEY_FN_F8	0x7E
> +#define A14_EC_EVT_KEY_FN_F9	0x7C
> +#define A14_EC_EVT_KEY_FN_F10	0x85
> +#define A14_EC_EVT_KEY_FN_F11	0x6B
> +#define A14_EC_EVT_KEY_FN_F12	0x86
> +#define A14_EC_EVT_KEY_FN_F	0x9d
> +
> +
> +struct asus_hid_data {
> +	struct hid_device *hdev;
> +	struct led_classdev kbd_led_cdev;
> +	struct input_dev *hotkey_input_dev;
> +	enum led_brightness saved_brightness;
> +};
> +
> +static struct asus_hid_data *asus_data;
> +
> +static int asus_send_ec_command(struct hid_device *hdev, u8 *cmd_buf)
> +{
> +	int ret;
> +	u8 report_id = cmd_buf[0];
> +
> +	ret = hid_hw_raw_request(hdev, report_id, cmd_buf, A14_EC_REPORT_SIZE,
> +				     HID_FEATURE_REPORT,
> +				     HID_REQ_SET_REPORT);
> +
> +	if (ret < 0)
> +		dev_err(&hdev->dev, "hid_hw_raw_request failed with status: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int asus_kbd_led_init(struct hid_device *hdev)
> +{
> +	u8 ec_init_cmd[A14_EC_REPORT_SIZE] = { A14_EC_REPORT_ID, 0xD0, 0x8F, 0x01 };
> +	int ret;
> +
> +	ret = asus_send_ec_command(hdev, ec_init_cmd);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	u8 brightness_cmd[A14_EC_REPORT_SIZE] = { A14_EC_REPORT_ID, 0xBA, 0xC5,
> +				    0xC4, A14_EC_MAX_BACKLIGHT };
> +
> +	ret = asus_send_ec_command(hdev, brightness_cmd);
> +	if (ret < 0)
> +		dev_warn(&hdev->dev, "Brightness init failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void asus_kbd_set_brightness(struct led_classdev *led_cdev,
> +				    enum led_brightness brightness)
> +{
> +	struct asus_hid_data *data = container_of(led_cdev, struct asus_hid_data, kbd_led_cdev);
> +
> +	u8 level = (u8)brightness;
> +
> +	if (level > A14_EC_MAX_BACKLIGHT)
> +		level = A14_EC_MAX_BACKLIGHT;
> +
> +	u8 buf[A14_EC_REPORT_SIZE] = { A14_EC_REPORT_ID, 0xBA, 0xC5, 0xC4, level };
> +
> +	asus_send_ec_command(data->hdev, buf);
> +	msleep(20);
> +	data->saved_brightness = (enum led_brightness)level;
> +}
> +
> +static int asus_raw_event(struct hid_device *hdev, struct hid_report *report,
> +			  u8 *raw_data, int size)
> +{
> +	struct asus_hid_data *data = hid_get_drvdata(hdev);
> +	struct input_dev *input_dev = data->hotkey_input_dev;
> +
> +	if (report->id == A14_EC_REPORT_ID && size >= 2) {
> +		u8 usage_code = raw_data[1];
> +
> +		switch (usage_code) {
> +		case A14_EC_EVT_KEY_FN_ESC:
> +			input_event(input_dev, EV_KEY, KEY_FN_ESC, 1);
> +			input_sync(input_dev);
> +			input_event(input_dev, EV_KEY, KEY_FN_ESC, 0);
> +			input_sync(input_dev);
> +			return 1;
> +
> +		/* FN + F1, F2 and F3 are not managed by EC*/
> +
> +		case A14_EC_EVT_KEY_FN_F4:
> +			if (size >= 3) {
> +				u8 current_level = data->saved_brightness;
> +				u8 max_level = A14_EC_MAX_BACKLIGHT;
> +				u8 next_level = (current_level + 1) % (max_level + 1);
> +
> +				asus_kbd_set_brightness(&data->kbd_led_cdev,
> +							(enum led_brightness)next_level);
> +				if (next_level > current_level ||
> +				    (current_level == max_level && next_level == 0)) {
> +					if (next_level == 0) {
> +						input_event(input_dev, EV_KEY,
> +							    KEY_KBDILLUMDOWN, 1);
> +						input_sync(input_dev);
> +						input_event(input_dev, EV_KEY,
> +							    KEY_KBDILLUMDOWN, 0);
> +						input_sync(input_dev);
> +						input_event(input_dev, EV_KEY,
> +							    KEY_KBDILLUMDOWN, 1);
> +						input_sync(input_dev);
> +						input_event(input_dev, EV_KEY,
> +							    KEY_KBDILLUMDOWN, 0);
> +						input_sync(input_dev);
> +						input_event(input_dev, EV_KEY,
> +							    KEY_KBDILLUMDOWN, 1);
> +						input_sync(input_dev);
> +						input_event(input_dev, EV_KEY,
> +							    KEY_KBDILLUMDOWN, 0);
> +						input_sync(input_dev);
> +					} else {
> +						input_event(input_dev, EV_KEY,
> +							    KEY_KBDILLUMUP, 1);
> +						input_sync(input_dev);
> +						input_event(input_dev, EV_KEY,
> +							    KEY_KBDILLUMUP, 0);
> +						input_sync(input_dev);
> +					}
> +				} else if (next_level < current_level) {
> +					input_event(input_dev, EV_KEY,
> +						    KEY_KBDILLUMDOWN, 1);
> +					input_sync(input_dev);
> +					input_event(input_dev, EV_KEY,
> +						    KEY_KBDILLUMDOWN, 0);
> +					input_sync(input_dev);
> +					input_event(input_dev, EV_KEY,
> +						    KEY_KBDILLUMDOWN, 1);
> +					input_sync(input_dev);
> +					input_event(input_dev, EV_KEY,
> +						    KEY_KBDILLUMDOWN, 0);
> +					input_sync(input_dev);
> +					input_event(input_dev, EV_KEY,
> +						    KEY_KBDILLUMDOWN, 1);
> +					input_sync(input_dev);
> +					input_event(input_dev, EV_KEY,
> +						    KEY_KBDILLUMDOWN, 0);
> +					input_sync(input_dev);
> +				}
> +			}
> +			return 1;
> +		case A14_EC_EVT_KEY_FN_F5:
> +			input_event(input_dev, EV_KEY, KEY_BRIGHTNESSDOWN, 1);
> +			input_sync(input_dev);
> +			input_event(input_dev, EV_KEY, KEY_BRIGHTNESSDOWN, 0);
> +			input_sync(input_dev);
> +			return 1;
> +		case A14_EC_EVT_KEY_FN_F6:
> +			input_event(input_dev, EV_KEY, KEY_BRIGHTNESSUP, 1);
> +			input_sync(input_dev);
> +			input_event(input_dev, EV_KEY, KEY_BRIGHTNESSUP, 0);
> +			input_sync(input_dev);
> +			return 1;
> +
> +		/* FN + F7 is not managed by the EC*/
> +
> +		case A14_EC_EVT_KEY_FN_F8:
> +			input_event(input_dev, EV_KEY, KEY_EMOJI_PICKER, 1);
> +			input_sync(input_dev);
> +			input_event(input_dev, EV_KEY, KEY_EMOJI_PICKER, 0);
> +			input_sync(input_dev);
> +			return 1;
> +		case A14_EC_EVT_KEY_FN_F9:
> +			input_event(input_dev, EV_KEY, KEY_MICMUTE, 1);
> +			input_sync(input_dev);
> +			input_event(input_dev, EV_KEY, KEY_MICMUTE, 0);
> +			input_sync(input_dev);
> +			return 1;
> +		case A14_EC_EVT_KEY_FN_F10:
> +			input_event(input_dev, EV_KEY, KEY_CAMERA_ACCESS_TOGGLE, 1);
> +			input_sync(input_dev);
> +			input_event(input_dev, EV_KEY, KEY_CAMERA_ACCESS_TOGGLE, 0);
> +			input_sync(input_dev);
> +			return 1;
> +		case A14_EC_EVT_KEY_FN_F11:
> +			input_event(input_dev, EV_KEY, KEY_TOUCHPAD_TOGGLE, 1);
> +			input_sync(input_dev);
> +			input_event(input_dev, EV_KEY, KEY_TOUCHPAD_TOGGLE, 0);
> +			input_sync(input_dev);
> +			return 1;
> +		case A14_EC_EVT_KEY_FN_F12:
> +			input_event(input_dev, EV_KEY, KEY_PROG1, 1);
> +			input_sync(input_dev);
> +			input_event(input_dev, EV_KEY, KEY_PROG1, 0);
> +			input_sync(input_dev);
> +			return 1;
> +		case A14_EC_EVT_KEY_FN_F:
> +			input_event(input_dev, EV_KEY, KEY_PERFORMANCE, 1);
> +			input_sync(input_dev);
> +			input_event(input_dev, EV_KEY, KEY_PERFORMANCE, 0);
> +			input_sync(input_dev);
> +			return 1;
> +		default:
> +			return 0;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int asus_hid_suspend(struct hid_device *hdev, pm_message_t message)
> +{
> +	struct asus_hid_data *data = hid_get_drvdata(hdev);
> +
> +	if (message.event == PM_EVENT_SUSPEND || message.event == PM_EVENT_HIBERNATE) {
> +		asus_kbd_set_brightness(&data->kbd_led_cdev, LED_OFF);
> +		return 0;
> +	}
> +
> +	dev_dbg(&hdev->dev, "Runtime suspend: turning off keyboard backlight\n");
> +	asus_kbd_set_brightness(&data->kbd_led_cdev, LED_OFF);
> +	return 0;
> +}
> +
> +
> +static int asus_hid_resume(struct hid_device *hdev)
> +{
> +	struct asus_hid_data *data = hid_get_drvdata(hdev);
> +	int ret;
> +	int retry_count;
> +
> +	msleep(40);
> +
> +	dev_dbg(&hdev->dev, "Re-initialising EC backlight communication\n");
> +	retry_count = 0;
> +	do {
> +		ret = asus_kbd_led_init(hdev);
> +		if (ret >= 0) {
> +			dev_dbg(&hdev->dev,
> +				"EC init successful on attempt %d\n",
> +				retry_count + 1);
> +			break;
> +		}
> +		retry_count++;
> +		dev_warn(&hdev->dev,
> +			 "EC init attempt %d failed: %d, retrying...\n",
> +			 retry_count, ret);
> +		msleep(300 * retry_count);
> +	} while (retry_count < 5);
> +
> +	if (ret < 0) {
> +		dev_err(&hdev->dev,
> +			"EC init on resume failed after %d attempts: %d\n",
> +			retry_count, ret);
> +		dev_err(&hdev->dev,
> +			"Keyboard backlight may not work; try reloading the driver\n");
> +	} else {
> +		dev_dbg(&hdev->dev, "EC backlight communication restored\n");
> +	}
> +
> +	asus_kbd_set_brightness(&data->kbd_led_cdev, data->saved_brightness);
> +
> +	dev_info(&hdev->dev, "Resume complete\n");
> +	return 0;
> +}
> +
> +static const struct hid_device_id asus_hid_devices[] = {
> +	/* Tested on ASUS Zenbook A14 (UX3407QA) only. */
> +	{ HID_DEVICE(0x18, 0x00, ASUS_VENDOR_ID, ASUS_PRODUCT_ID) },
> +	{ } /* Terminating entry */
> +};
> +MODULE_DEVICE_TABLE(hid, asus_hid_devices);
> +
> +static int asus_hid_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	int ret;
> +	struct asus_hid_data *data;
> +
> +	data = devm_kzalloc(&hdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	data->hdev = hdev;
> +	hid_set_drvdata(hdev, data);
> +	asus_data = data;
> +	data->saved_brightness = A14_EC_MAX_BACKLIGHT;
> +	ret = hid_parse(hdev);
> +	if (ret)
> +		return ret;
> +	ret = hid_hw_start(hdev, HID_INPUT_REPORT | HID_OUTPUT_REPORT | HID_FEATURE_REPORT);
> +	if (ret)
> +		return ret;
> +	data->hotkey_input_dev = input_allocate_device();
> +	if (!data->hotkey_input_dev) {
> +		dev_err(&hdev->dev, "Failed to allocate hotkey input device\n");
> +		hid_hw_stop(hdev); return -ENOMEM;
> +	}
> +	data->hotkey_input_dev->name = "ASUS EC I2C HID hotkeys";
> +	data->hotkey_input_dev->phys = "i2c-hid/input1/hotkeys";
> +	data->hotkey_input_dev->id.bustype = hdev->bus;
> +	data->hotkey_input_dev->id.vendor = hdev->vendor;
> +	data->hotkey_input_dev->id.product = hdev->product;
> +	data->hotkey_input_dev->dev.parent = &hdev->dev;
> +	set_bit(EV_KEY, data->hotkey_input_dev->evbit);
> +	set_bit(KEY_FN_ESC, data->hotkey_input_dev->keybit);
> +	set_bit(KEY_KBDILLUMUP, data->hotkey_input_dev->keybit);
> +	set_bit(KEY_KBDILLUMDOWN, data->hotkey_input_dev->keybit);
> +	set_bit(KEY_BRIGHTNESSDOWN, data->hotkey_input_dev->keybit);
> +	set_bit(KEY_BRIGHTNESSUP, data->hotkey_input_dev->keybit);
> +	set_bit(KEY_SWITCHVIDEOMODE, data->hotkey_input_dev->keybit);
> +	set_bit(KEY_EMOJI_PICKER, data->hotkey_input_dev->keybit);
> +	set_bit(KEY_MICMUTE, data->hotkey_input_dev->keybit);
> +	set_bit(KEY_CAMERA_ACCESS_TOGGLE, data->hotkey_input_dev->keybit);
> +	set_bit(KEY_TOUCHPAD_TOGGLE, data->hotkey_input_dev->keybit);
> +	set_bit(KEY_PROG1, data->hotkey_input_dev->keybit);
> +	set_bit(KEY_PERFORMANCE, data->hotkey_input_dev->keybit);
> +
> +	ret = input_register_device(data->hotkey_input_dev);
> +	if (ret) {
> +		dev_err(&hdev->dev, "Failed to register hotkey input device\n");
> +		input_free_device(data->hotkey_input_dev); hid_hw_stop(hdev);
> +		return ret;
> +	}
> +	asus_kbd_led_init(hdev);
> +	data->kbd_led_cdev.name = "asus::kbd_backlight";
> +	data->kbd_led_cdev.brightness_set = asus_kbd_set_brightness;
> +	data->kbd_led_cdev.max_brightness = A14_EC_MAX_BACKLIGHT;
> +	ret = led_classdev_register(&hdev->dev, &data->kbd_led_cdev);
> +	if (ret) {
> +		input_unregister_device(data->hotkey_input_dev);
> +		hid_hw_stop(hdev);
> +		return ret;
> +	}
> +	dev_info(&hdev->dev,
> +		 "ASUS EC HID driver for Zenbook A14 loaded for 0x%04x:0x%04x\n",
> +		 ASUS_VENDOR_ID, ASUS_PRODUCT_ID);
> +	return 0;
> +}
> +static void asus_hid_remove(struct hid_device *hdev)
> +{
> +	struct asus_hid_data *data = hid_get_drvdata(hdev);
> +
> +	led_classdev_unregister(&data->kbd_led_cdev);
> +	input_unregister_device(data->hotkey_input_dev);
> +	hid_hw_stop(hdev);
> +	asus_data = NULL;
> +}
> +static struct hid_driver hid_asus_ec_driver = {
> +	.name       = "hid-asus-ec",
> +	.id_table   = asus_hid_devices,
> +	.probe      = asus_hid_probe,
> +	.remove     = asus_hid_remove,
> +	.raw_event  = asus_raw_event,
> +	.suspend    = asus_hid_suspend,
> +	.resume     = asus_hid_resume,
> +};
> +module_hid_driver(hid_asus_ec_driver);
> +MODULE_AUTHOR("Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>");
> +MODULE_DESCRIPTION("ASUS EC HID driver for Zenbook A14 (UX3407QA)");
> +MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251221-add-support-for-the-asus-hid-ec-a60b9a2d74b3
> 
> Best regards,

