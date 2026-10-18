Received: from mta0.migadu.com (out-242.mta0.migadu.com [91.218.175.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD533ACEF3
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338620; cv=none; b=Zz5pKDY9BfwN+b2nNGn287+Nor9zLZA17bbybech1MCyQ7NMUptmtqfO/2035vHcxUtixKW+HbTSMyjERBiuQ/FFN4ma9gTPhHlXQWXhC76NfayVcwhC6EsRiGg0Or7iQmK+/fxinH6colORYrIwBCbqdlH5ax6OENi1pWzJlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338620; c=relaxed/simple;
	bh=eEWxZEiRQUSiOa6WosNyvYGzuvYa5ERYWUjbRMgTDwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMPc1fMS8YHEUD2BbunkCGqBLlMEQtGJprZWUqRdz86nPvu27YXuDgWHcrCEKk3MserF0+XEQ6u/bNxXdPd+ytZ7LzjW0gaEmXP/+CHTvzxwCDB0Gdl9D1gVHH5f6716ogyytfPdyit7+5bMnvIfSulsGysZ6ANPBBPPotZG0qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PN8iPp4t; arc=none smtp.client-ip=91.218.175.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PN8iPp4t"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eEWxZEiRQUSiOa6WosNyvYGzuvYa5ERYWUjbRMgTDwI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792338613; v=1; x=1792943413;
 b=PN8iPp4tT2ft8QnxEmXC3oCM5v6FMsvxoV6EKXOyUX8T3o4ylqsddBe37q2Vk4Nb4nDW/3Xs
 5oTmRFqtI3H2pt9U4siuYgjFx9hjdt4XGizoCa2fkGd5spWNwUvF8uS5uRKpfQ7zSWHRqBtmqLq
 iq3diogfz65bM/+TVDR9vgks=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 48859e15dde0fb73;
	Sun, 18 Oct 2026 15:50:11 +0000
X-Mizu-Trace-ID: 48859e15dde0fb73
X-Migadu-Flow: FLOW_OUT
Message-ID: <b22a521d-ec6e-4ac8-9aaa-d34e67ba898f@linux.dev>
Date: Sun, 18 Oct 2026 17:50:08 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] HID: asus: Fix up Zenbook Duo report descriptors
To: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luke Jones <luke@ljones.dev>, Ivan Levchenko <me@livan.pro>,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 Nathan Chancellor <nathan@kernel.org>
References: <20261013104033.36079-1-p.pisati@gmail.com>
 <20261013104033.36079-2-p.pisati@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261013104033.36079-2-p.pisati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/26 12:39, Paolo Pisati wrote:
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
>
> Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
> [pisati: fold the USB offsets and the padding removal into this patch,
>  bound the padding removal, move the whole tail of the descriptor, and
>  end the branch chain with a plain else so clang does not warn that
>  rsize_orig may be uninitialized]
> Assisted-by: LLM
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA

Hello Paolo,

I am back from vacation and I can therefore getting on with my review.

I don't know if I have enough time for all patches but I will try!

Thanks for looking into these devices!

> ---
>  drivers/hid/hid-asus.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index bd46aba6622a..34739198d90e 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -100,6 +100,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define QUIRK_ROG_ALLY_XPAD		BIT(13)
>  #define QUIRK_HID_FN_LOCK		BIT(14)
>  #define QUIRK_FILTER_CAMERA_COMPANION	BIT(15)
> +#define QUIRK_ZENBOOK_DUO_KEYBOARD	BIT(16)
>  
>  #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
>  						 QUIRK_NO_INIT_REPORTS | \
> @@ -1579,43 +1580,56 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  		hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
>  		rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
>  	}
> -	/* For the T100CHI/T90CHI keyboard dock */
> -	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
> +	/* For the T100CHI/T90CHI keyboard dock and Zenbook Duo keyboards */
> +	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI | QUIRK_ZENBOOK_DUO_KEYBOARD)) {
>  		int rsize_orig;
>  		int offs;
>  
>  		if (drvdata->quirks & QUIRK_T100CHI) {
>  			rsize_orig = 403;
>  			offs = 388;
> -		} else {
> +		} else if (drvdata->quirks & QUIRK_T90CHI) {
>  			rsize_orig = 306;
>  			offs = 291;
> +		} else if (hid_is_usb(hdev)) { /* QUIRK_ZENBOOK_DUO_KEYBOARD */
> +			rsize_orig = 90;
> +			offs = 66;
> +		} else { /* QUIRK_ZENBOOK_DUO_KEYBOARD over Bluetooth */
> +			rsize_orig = 257;
> +			offs = 176;
>  		}

Please either use a switch or otherwise make each if check one quirk, eventually use other nested if(s)
to check for bluetooth in order to not cause future problems if this code needs adding other models.

Also unless it's for counting try to use explicit types matching what you are trying to do like u8 or u16 etc...

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
> +			unsigned int new_rsize = rsize_orig;

In kernel declaration of variables goes on top of the function, in reverse xmas-tree.

The only exception is with _kfree() pattern for pointers.

>  			__u8 *new_rdesc;
>  
> -			new_rdesc = devm_kzalloc(&hdev->dev, rsize_orig + 1,
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

Does the zenbook duo really needs fixing the report descriptor? I think you can avoid this
altogether on this hardware.

Best regards,
Denis Benato

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
