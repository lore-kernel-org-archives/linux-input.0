Received: from mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1363A0B38
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338908; cv=none; b=AKBdogvhSiVLYUjbzuXKHBqlyZ3zOHdTDuEPl7QQt+LgVOBpxRC+1/erL+dolZh42/qYDMtOJOugIctYHEa14XGp/ChGevq7UnCC+C86WiRzCwl5PqZnWOlKauADvOB5UHvPxZT4BBD1rNAQ1Bh31K7izuGE0sSPn4tFP26vnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338908; c=relaxed/simple;
	bh=iKLvpKASGLc2eLR8dPTl1IxidRjrRKY4O3CBZcPtPeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crPFcqUeK+LWo6pOAXvLi2EaGJnf+KoHHPPxc1ZTA2CXM6k03VF4zFktDcvg3W+lD8OzQ5B0dzhQJeW0cyp7YtVG7PbSjNOMWLw9HwKL7+qEtAHcXhzVROTzcvz0Tt34UwnKAufr8I67XmteupHBVwIAW1uKY1D28P/fkbDjzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b/3Lx+bG; arc=none smtp.client-ip=91.218.175.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b/3Lx+bG"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iKLvpKASGLc2eLR8dPTl1IxidRjrRKY4O3CBZcPtPeE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792338904; v=1; x=1792943704;
 b=b/3Lx+bGIiDjzetkb+2DOQzocW2SO+A6OZJvjKfdqypXIz+Xkbgain+JJ07LY2tJNBt4mCtj
 o6WRbLY+b7qfeqxQ9nVVi399N9VHm4RvmICPa5Svp265cOohMwgBNMaVZamCKoouinFMrpa5SGS
 5he4NsKkTFVQcvZQVf8Ro9oY=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 25919a9a7c56687b;
	Sun, 18 Oct 2026 15:55:04 +0000
X-Mizu-Trace-ID: 25919a9a7c56687b
X-Migadu-Flow: FLOW_OUT
Message-ID: <7dfed94a-f7f9-417d-ba0d-09f199047b70@linux.dev>
Date: Sun, 18 Oct 2026 17:55:02 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] HID: asus: Add missing Zenbook Duo hotkeys
To: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luke Jones <luke@ljones.dev>, Ivan Levchenko <me@livan.pro>,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 Nathan Chancellor <nathan@kernel.org>
References: <20261013104033.36079-1-p.pisati@gmail.com>
 <20261013104033.36079-3-p.pisati@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261013104033.36079-3-p.pisati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/26 12:39, Paolo Pisati wrote:
> From: Joshua Leivenzon <hacker1024@users.sourceforge.net>
>
> Map the Zenbook Duo "screen swap" hotkey (vendor usage 0x9c) to
> KEY_F19, like the other ASUS vendor keys that have no dedicated
> keycode, so that userspace can bind it.
>
> The mappings from the ROG Ally onwards belong to devices with built-in
> keyboards and can share keycodes freely. The Zenbook Duo keyboard
> cannot: it is a standard USB/Bluetooth device and can be connected to
> another ASUS machine handled by this driver. Document that above the
> ROG Ally mappings.
>
> Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
> [pisati: drop the MyASUS key (0x86) mapping, 2061075360182 ("HID:
>  asus: support the Zenbook A16 (UX3607OA) keyboard") maps it to
>  KEY_PROG1 like asus-nb-wmi does]
> Assisted-by: LLM

Assisted-by tags have harness:model like this:

Assisted-by: opencode:deepseek-v4.1-flash

> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
> ---
>  drivers/hid/hid-asus.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 34739198d90e..242e273e4cb3 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1264,6 +1264,19 @@ static int asus_input_mapping(struct hid_device *hdev,
>  		case 0xb3: asus_map_key_clear(KEY_PROG3);	break; /* Fn+Left next aura */
>  		case 0x6a: asus_map_key_clear(KEY_F13);		break; /* Screenpad toggle */
>  		case 0x4b: asus_map_key_clear(KEY_F14);		break; /* Arrows/Pg-Up/Dn toggle */
> +		case 0x9c: asus_map_key_clear(KEY_F19);		break; /* Screen swap */
> +
> +		/*
> +		 * Mutually exclusive section: Special keys from different devices
> +		 * can bind to the same keycodes without concern, as they will never
> +		 * conflict.
> +		 *
> +		 * Note that devices with removable keyboards that connect over a
> +		 * standard interface (e.g. Zenbook Duo UX8406 with USB/Bluetooth) do
> +		 * not belong in this section, as such keyboards can be connected to
> +		 * another ASUS device that also uses this driver for its own keyboard.
> +		 */

Maybe shorten this and put it on top of the line it refers too.

Perhaps something like "Keep this unique as it may conflict since the keyboard is bluettoth"
above the F19.

> +		/* ROG Ally */
>  		case 0xa5: asus_map_key_clear(KEY_F15);		break; /* ROG Ally left back */
>  		case 0xa6: asus_map_key_clear(KEY_F16);		break; /* ROG Ally QAM button */
>  		case 0xa7: asus_map_key_clear(KEY_F17);		break; /* ROG Ally ROG long-press */
