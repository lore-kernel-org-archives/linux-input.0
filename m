Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327EE49CF23;
	Fri, 11 Sep 2026 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142695; cv=none; b=D6Rdst/qWlLir8Eeg+vdn4+NKZ+kLCiDBY/vZD78d0TkDeoTvlKtqJNulYbIkZS4NbJTC/wNUpoIBSMIASVDKy6AUUhXD/m3ECerzh2Yxj6UA7Q75eRNYh9Se+Y8SXbGqH7KpVnhnnW3Nd8c81Ce42cJDROi6dQsXjoZcoB970M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142695; c=relaxed/simple;
	bh=3Zc3nWyce5sMNuEKHI9DCuGmGl34YUEXrW0IwHMWgAI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aBr+ZeDuNEABsdW9THp9Q/uqCbGt5H6ri+DH1jW/DBC9SEXwXbVD0Mr/8QMV1P8TKU3wrRxo/dV3dG6LnajndWoN/TpKD80rMkHVEodG6o6WktOtAKlHsX/76CYmdY6HWXgyBc9BtrXSn8FqdXpJp0C/0qJdR+fyJnPbS8/9Csc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDSAUtmN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDSAUtmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623A21F00893;
	Fri, 11 Sep 2026 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789142693;
	bh=wtu38VMa0QReS4NmCuoeJ5ZXIzWAXunLBD6kLqxWGfg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=WDSAUtmN1B2x8Fz9i+CePYHuTPFejqvRN31lDnteazx7eZ8nNHhrC3nG3z6qsXUo5
	 wmG4tBdOYpZPjmZMJ03V7q8jjN9MmDy7fbyoLc+Xrn0k9all93MUJvhDxlcITVLX3c
	 U69p6YPTGdMSNlfc2lFlKXq3UXRTVpnbJYPlWK5WsHoiRaNICkjNu/gNOcSPXnCi1w
	 RymIgihdguF80aNdb+S5P79nojRdZ42FdONeALgE3+CrutaSBzOJHtA/WLAceWwqjO
	 DrT7Y9k9CG9o105UfF4VBaVaZ/s+mU/LV9AIbDdhyDwduSz2OibxywmFaWFKkJY/wG
	 29Xoy2eqlhxaQ==
Date: Fri, 11 Sep 2026 18:04:51 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Youth Cao <cocoh2os08@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, Xu Rao <raoxu@uniontech.com>, 
    Ai Chao <aichao@kylinos.cn>, Kwok Kin Ming <kenkinming2002@gmail.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: Add i2c-hid-quirk-bad-input-size quirk
 for 0911:5288 device
In-Reply-To: <20260903161444.786-1-cocoh2os08@gmail.com>
Message-ID: <r437p10n-qq2p-5p01-q059-520n2q31r17s@xreary.bet>
References: <20260903161444.786-1-cocoh2os08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Sep 2026, Youth Cao wrote:

> I have recently acquired a cheap Apollo Lake-based laptop that uses a
> Hynitron CST128-A touchpad controller. While booting from a Debian LiveCD,
> the kernel log is flooded with the following error (though the touchpad
> works well):
> 
>   i2c_hid_acpi i2c-ALPS0001:00: i2c_hid_get_input: incomplete report (27/42405)
> 
> The CST128-A was identified via ACPI as ALPS0001:00, and the I2C HID
> device ID (0911:5288) was shared with the Hantick 5288.
> 
> Add the I2C_HID_QUIRK_BAD_INPUT_SIZE quirk option to the existing Hantick
> 5288 quirk entry to suppress the kernel log flood.
> 
> Signed-off-by: Youth Cao <cocoh2os08@gmail.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 0e725a0f0abe..776dd14feba7 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -123,7 +123,7 @@ static const struct i2c_hid_quirks {
>  	__u32 quirks;
>  } i2c_hid_quirks[] = {
>  	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
> -		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
> +		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET | I2C_HID_QUIRK_BAD_INPUT_SIZE },
>  	{ I2C_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_VOYO_WINPAD_A15,
>  		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
>  	{ I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_3118,

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

