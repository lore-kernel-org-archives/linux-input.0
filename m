Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517875;
	b=Kp/cdzEDY3jyJPIZquZJqJAiwHcL970Jrt6Ln+XYDsdaON5f9uc0jEVFZKmPnVRNEsmw
	 kieLX8j/VI3qgrs5r/XqLNaxRirvzzIMWvQ6TbcIj91sewMmyZB0G2xp/J3qCRWUtvGUx
	 JRIhxnESQS0OIuyaw0ApvKb/S7IrMqDFQvs4oPUNTQiOzVCiuBPqG5tub6D7Tz/ScTEat
	 MSMEffP9Uoj/U5VTdF7V2vUQhAzWmuoq6Ka++7zEXhElv42jcHulHITWGAukO4dVhBt4s
	 pWJj1EZNfRyECAOm8Qd6adOOVluByyOKRwmmIK+G3+EzReTD4lA6jXTF9kxDlG7Ihww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517875;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=C4ODyxk4b1WWvMCw/VDISB8aylVl2NcwfKuwjiW99ok=;
	b=tWpXZhSJBVr83B1Paxa+YuoFqm7Pi3UQR/QMrm0PYRALZvamaQeHM7xKxtx3NOQmZyzo
	 +Z4yfqWp3RVKmtXVAD+Sbo5j+zaEe6STmq5hotZmTThPBf+ThphF9lGNd5osHUYb6OW9v
	 jS92+GzLlp7/LwHe9lryPuvs15KkkfZ0bFZz4mEWjWVFs0bj6zqnGnXlT/yX05inYiP65
	 pHRJ+dsH6aQoVkmAlLO/4QtJoS5hFUVcFDe+Xd5YqkeevvV8x68ERBM6zVgmmzn1FFWUr
	 vRjBQm/RL3+zsK0mM8T61YgkDu//33O231DHRkgMAui1z8yhoNuKc6wqTTIKY0iJZ1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PVZAeIg7;
	arc=none smtp.remote-ip=95.215.58.22
Received: from mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3792660A2600
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 17:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3792660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PVZAeIg7
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=llPR+65kBsxEo/GGcB0AIVjyy5+viBv+cJvYuf6Os6c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792517872; v=1; x=1793122672;
 b=PVZAeIg7d8+juM+2DeuH0GvmMKS/jp/jX7H+jxhFPlJSZRmd/CwugXQqgnV5RAmMJy3mScuA
 BNdQI0SSC7ViF5VZSMJv/ISCp6RzQu+JApYDr7CEGNhI1zkVR2lVhKhslsDGUqBz3xAsqYihFJC
 x7Lu2bmser43kQO7JsfGhD6Y=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fe535625422d4b45;
	Tue, 20 Oct 2026 17:37:52 +0000
X-Mizu-Trace-ID: fe535625422d4b45
X-Migadu-Flow: FLOW_OUT
Message-ID: <bbcd5640-9464-4c80-8443-96cf15fe6e74@linux.dev>
Date: Tue, 20 Oct 2026 19:37:47 +0200
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] HID: asus: Fix up Zenbook Duo report descriptors
To: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 Luke Jones <luke@ljones.dev>, Ivan Levchenko <me@livan.pro>,
 Nathan Chancellor <nathan@kernel.org>
References: <20261020092423.36380-1-p.pisati@gmail.com>
 <20261020092423.36380-2-p.pisati@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261020092423.36380-2-p.pisati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/20/26 11:24, Paolo Pisati wrote:
> From: Joshua Leivenzon <hacker1024@users.sourceforge.net>
>
> The Zenbook Duo keyboards (UX8406MA, UX8406CA, UX8407AA) ship the same
> broken vendor hotkey collection as the T100CHI/T90CHI keyboard docks:
> the Input item of report 0x5a is preceded by a single Usage (76h)
> instead of a Usage Minimum/Maximum range, so none of the hotkey codes
> get mapped and every key press logs
>
>   Unmapped Asus vendor usagepage code 0x76
>
> Extend the T100CHI/T90CHI fixup to the Zenbook Duo: the descriptor is
> 90 bytes long with the bogus usage at offset 66 on the USB hotkey
> interface, and 257 bytes long with the usage at offset 176 over
> Bluetooth.
>
> The dock fixup only moves the 12 bytes between the usage and the End
> Collection item, as nothing but a bogus trailing 0 byte follows them.
> That is not true of the Zenbook Duo: the collection goes on with a 15
> byte feature report (also ID 0x5a) after the Input item, and over
> Bluetooth a further collection follows it, which a 12 byte move
> corrupts, leaving stray 0 bytes at the end. Move everything after the
> usage instead, after dropping any trailing 0 bytes, and allocate the
> two bytes the usage range adds. The result for the T100CHI/T90CHI is
> unchanged.

Reviewed-by: Denis Benato <denis.benato@linux.dev>

> Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
> [pisati: fold the USB offsets and the padding removal into this patch,
>  bound the padding removal, move the whole tail of the descriptor, and
>  initialize rsize_orig and offs so clang does not warn that they may
>  be used uninitialized]
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> ---
>  drivers/hid/hid-asus.c | 44 ++++++++++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 27c1c3188513..c2ba2d825191 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -102,6 +102,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define QUIRK_ROG_ALLY_XPAD		BIT(13)
>  #define QUIRK_HID_FN_LOCK		BIT(14)
>  #define QUIRK_FILTER_CAMERA_COMPANION	BIT(15)
> +#define QUIRK_ZENBOOK_DUO_KEYBOARD	BIT(16)
>  
>  #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
>  						 QUIRK_NO_INIT_REPORTS | \
> @@ -1707,43 +1708,58 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  		hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
>  		rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
>  	}
> -	/* For the T100CHI/T90CHI keyboard dock */
> -	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
> -		int rsize_orig;
> -		int offs;
> +	/* For the T100CHI/T90CHI keyboard dock and Zenbook Duo keyboards */
> +	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI | QUIRK_ZENBOOK_DUO_KEYBOARD)) {
> +		u16 rsize_orig = 0, offs = 0;
> +		u16 new_rsize;
>  
>  		if (drvdata->quirks & QUIRK_T100CHI) {
>  			rsize_orig = 403;
>  			offs = 388;
> -		} else {
> +		} else if (drvdata->quirks & QUIRK_T90CHI) {
>  			rsize_orig = 306;
>  			offs = 291;
> +		} else if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) {
> +			if (hid_is_usb(hdev)) {
> +				rsize_orig = 90;
> +				offs = 66;
> +			} else { /* Bluetooth */
> +				rsize_orig = 257;
> +				offs = 176;
> +			}
>  		}
>  
>  		/*
>  		 * Change Usage (76h) to Usage Minimum (00h), Usage Maximum
> -		 * (FFh) and clear the flags in the Input() byte.
> -		 * Note the descriptor has a bogus 0 byte at the end so we
> -		 * only need 1 extra byte.
> +		 * (FFh) and clear the flags in the Input() byte, shifting
> +		 * the rest of the descriptor by the 2 bytes that adds. Drop
> +		 * the bogus 0 bytes some descriptors end with first, but
> +		 * never the Input() item that follows the usage.
>  		 */
>  		if (*rsize == rsize_orig &&
>  			rdesc[offs] == 0x09 && rdesc[offs + 1] == 0x76) {
>  			__u8 *new_rdesc;
>  
> -			new_rdesc = devm_kzalloc(&hdev->dev, rsize_orig + 1,
> +			new_rsize = rsize_orig;
> +			while (new_rsize > offs + 14 && rdesc[new_rsize - 1] == 0)
> +				--new_rsize;
> +
> +			new_rdesc = devm_kzalloc(&hdev->dev, new_rsize + 2,
>  						 GFP_KERNEL);
>  			if (!new_rdesc)
>  				return rdesc;
>  
>  			hid_info(hdev, "Fixing up %s keyb report descriptor\n",
> -				drvdata->quirks & QUIRK_T100CHI ?
> -				"T100CHI" : "T90CHI");
> +				drvdata->quirks & QUIRK_T100CHI ? "T100CHI" :
> +				drvdata->quirks & QUIRK_T90CHI ? "T90CHI" :
> +				"Zenbook Duo");
>  
> -			memcpy(new_rdesc, rdesc, rsize_orig);
> -			*rsize = rsize_orig + 1;
> +			memcpy(new_rdesc, rdesc, new_rsize);
> +			*rsize = new_rsize + 2;
>  			rdesc = new_rdesc;
>  
> -			memmove(rdesc + offs + 4, rdesc + offs + 2, 12);
> +			memmove(rdesc + offs + 4, rdesc + offs + 2,
> +				new_rsize - (offs + 2));
>  			rdesc[offs] = 0x19;
>  			rdesc[offs + 1] = 0x00;
>  			rdesc[offs + 2] = 0x29;
