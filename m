Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271799;
	b=UTYQowjvGGjCIi+fNiiUJ26LKUOIq5w/h36hftxTY6UtlURXdcqIM4kd1Z2mxem3pimp
	 Sv9cZBMlXnOOfX5Qa6AB4x/GNM7mQJdAb3E9H4XUTXr5DKm6OZ9OXurkF3yinDvTTa14r
	 DAMee+pLUh3ZC/mX1/uUjP2Oibz/LreLZzKk9OYe12pyyGs6J1dpL8xmsnPcQCWWyd5SY
	 AFx/Zc9Vx7xMyKtMc5gRgHO3dSK2VywFQJosrPwH9clSDWm9rSrFxSOTVWVV75P1ehIlh
	 yqIWN/WBrYUkcaLuomNndZMhStpO2oS/tGCEmHKFxKm3WuSWf8d7hISIlem2zCFFi/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271799;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=RQDry3reElj074ViZv7jzwuofj4XVYSFcwR4/9xfw6U=;
	b=iQVJqXnYFMPM/zankSCIA+0DTcaJZBkN4qUKZxa4hcE5LUYKo6SF0SPjsX7uM4UaIkgp
	 Fj9xWAurQfnFnX4cq1mr725cm5ke3C2W2WDTebrM3C8mGA7OS4cDHGA1NHoff0GB+Psnp
	 hHW+TiWBAceqrY5J8RpS6+ep9EohVZVcv/0S+RnIHb4fq5MOKH6WhxxJGt8EqWntThQDz
	 mFSBgq4nl9OF9GZ5Fy59QezDhOKwf03XYZgoyC8dm7zMhXsojJiNPyAduUqYOCTc0Y8W8
	 mey8g9gSLadVHmmXK7e+9qovEQKPsn4xc/E+QHEIEc4GnvuUdIZzRnsYZi4Km32xyOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squebb.ca;
	spf=pass smtp.mailfrom=squebb.ca;
	dkim=pass header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm1 header.b=dt5Uarrd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JHw89k4T;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFC606A31C
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 00:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBFFC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm1 header.b=dt5Uarrd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JHw89k4T
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C8FC7A019B
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 19:49:58 -0500 (EST)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Mon, 09 Nov 2026 19:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1794271798;
	 x=1794358198; bh=RQDry3reElj074ViZv7jzwuofj4XVYSFcwR4/9xfw6U=; b=
	dt5UarrdfI903AK11IDrFUoMUYs7eR0I53X+BsSj3f7lADJvmtENYqVHbfTR2nZW
	/AW79vQz2rOhSBwmiGAMA4RqM4uQWJElRQaH8n+RMzww4QOHtmZEF31CbiLRdLAo
	rupY99LhMHrhkX9vENkL3eM5RZyley5WJdMmW59hRXzfMz2X4RGJ5ICAwNUCa8zv
	VDvwRjKNcRPNMTPl4iEjx0yG8FSjdbCHjv9YSl13615IDT41sk1rh0vqAcij7AKX
	g28qV/hzo0ug7SAwYmEu7mTQuDEz3QUk1PxIZ0x4PeGe9O0ovrniukpkVhTx/ymT
	/6PalAT+QUEHAs+Pc6Z02w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794271798; x=
	1794358198; bh=RQDry3reElj074ViZv7jzwuofj4XVYSFcwR4/9xfw6U=; b=J
	Hw89k4TkB0BCB6Fn/KjI3NL71qSSVP3w0NKl7bggEEpD//C+Aq8YKkgebCb5aozw
	hK+GczFYDOeE4bmMPhyFKfkXhsHEz4+ij/QjH4b0OOnavMLqrHjz4qKQFoH2Fuxe
	Wq9uZGf+Ofnk8kbYvB3BJy5y0MPOP6CHotlOzNeNiu/8sm1AMzZhH7awUkBcFbfH
	PTQZ3cvwr5kwFKcsqWzgqz+F24QOluB5LkD+K3OKzVxHWikD4E1s3A8fWS3Ye2Eh
	o+O5QBYJg7EX3wx9dDrAyTPieGdtQBdQbwN+xFLr8n+t12XiKbAKAZiukxK9TPC+
	U6Cf1nWyfc2g9v92jCxCg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794271798; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:J8PhjIUhWDNN2ZBj7uOxNt5C5Z3OEeX1Z2XNSH9MCUdh5GY
	Na5PMZjEOhHXdx3zg2obXUXWPH2YiSkP5rzeJ+DN6NzWfWnigwcU/xX+wsmslu8N
	QlY2EIJRWj6YEfFwzSSm5DHDR7O0jPqsQSyBrnE3rEQiSDKi7/76plF7QeHeQsqr
	NkHOaBmT7KS1Q450cVlLz4+x8cZ7AohnNbB51AWe5yQf7WDamyCgkS1t7htVc7eE
	f0OAAjqQETvdjZKjOtbiAYeTKtWJQP3xv/Y2LOxr7gCuSBc+Sj4nFYrY8j3e03rG
	xzkSSni0+UFLppaUqgpnDgUhmJUNETlE9Kauumg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rLnn9tk5tg6+5Mxu7aiWzLTfl2kALkKoyjuFgThQJrE=:E9SRphe2A79zJGdGRNeQ4wVWJxCGGymXXskg0REOLM4=;
X-ME-Sender: <xms:NWryatBjPOxAZYYZZUbGq4AFxA1WTCLfpqXSX3coyTdOCN9RmAUWUg>
    <xme:NWryamUzshaG4va4vJ0j8trqdmjn8Ztpkb3gUxL7H8GiBJxL4QTLRwOfA4Ful0AQq
    qZv1BfBFjRg_DhT7JXwM9cB0YqV-AzF2f-VgKYcY7oR_gRlhofMrqyhig>
X-ME-Proxy-Cause: dmFkZTGh4s12zt89yw1eFiq/x5AkIZsxvC6NfjAswxuAO/i1HK1TmH7J7iAWYFVqsixfAY
    plB0iAb74gojV08ved3sIBdtMn8X7bglZTyYG8j8lonmH53mHLIM3pizYU9s4v28h1GgDN
    Kh2nELzcrqtwrVkhQeJLUgiK2sJ+xpSzSpvYdbmWnYQ8ZzxihfPoTug0aFk8U9i0pA85Uc
    5F5dIpJePthuD9jisREyF+CCBorbhvXRC1g9XyX34LUTVKN++C/l7m3Ax6DGboCz2i23x8
    dKTWXWuaSlXRf7gbOumOYL83m1Rhh+rr0Ph8gc6JxX27VXVP05Adl6/KO7kpR57Xv5kTQI
    KzViEjuCJEQg0xvY0IqZR5fHcJbvt/vI3OEb/yEzauvEyFK91VR3ka0FEtqYns73m73fsQ
    xBzYUYvgaUN9A10TpI9FFzYgSBjmK2dRQta0FbzeDIhjCJsjyt5Jwsg5L6y4wBKafbmYA4
    8AiVXUNygcr7HMgLJQaPHfhg0SX+mYw4NP35TBqvRBCfkepbmZ7NkRrcVrkdT+edK9LVmx
    DPiTqLqNca2oPFxpdCxneTa5+gvpOW4MUJiUfjYJjYmHmjWt8+YpvIaDT3N7uypvPOg26z
    5iik7Yea4goifzPXY8DrpZe11PjfJXAqTAn0DGOQmNO0IcCFpJ6ewbe2px7w
X-ME-Proxy: <xmx:NmryakPajf5kQr4nXvRdgToKvxijWOmssixnTl22kxjSMLPelNmtZA>
    <xmx:Nmryaj56Pih6vQahuujsAitMI3_aJmee11WkfqJxLC6Yt0IBnVqIWw>
    <xmx:Nmryam0Izw_kPvbNnkdEk4fCOnUeMWCBKtwLS9j40u2Acg_nnKlDsQ>
    <xmx:NmryaszFpf7QN-86x74VYKNaKymgEtA8EkIegwQptOjGRCb1KOg-nA>
    <xmx:NmryaqQcLerdAU-yEuy5a8L_vNHByAK8ond_P0ibhWp2XiIwtbFTf2-3>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id CFA982C00085; Mon,  9 Nov 2026 19:49:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A4C1pTx2ltvJ
Date: Mon, 09 Nov 2026 19:49:37 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Hans de Goede" <johannes.goede@oss.qualcomm.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Jiri Kosina" <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Message-Id: <d66407e5-a057-4149-9ad8-1f0dd0c2d6a8@app.fastmail.com>
In-Reply-To: <20261109214349.391853-1-johannes.goede@oss.qualcomm.com>
References: <20261109214349.391853-1-johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] HID: lenovo: suppress spurious F23 key events on ThinkPad T14s
 gen6/7 snapdragon
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Hans

On Mon, Nov 9, 2026, at 4:43 PM, Hans de Goede wrote:
> The Lenovo ThinkPad T14s gen6/7 snapdragon version I2C-HID keyboard sends
> spurirous F23 key-events when the Fn key is pressed/released. Leading to

Minor - typo (spurirous)

> e.g. garbage ESC-sequences in the terminal when doing FN key combos.
>
> A hwdb entry was added to map these to KEY_UNKNOWN [1], but this also maps
> the F23 part of the left-meta + left-shift + F23 combo send by the co-pilot
> key to KEY_UNKNOWN making that key unusable.
>
> Add a raw_event filter which removes any 0x72 codes from the 6 scancodes
> reported in the standard HID keyboard boot protocol report, but only when
> the report's modifier byte is not 0x0a to preserve the F23 press event
> when the co-pilot key is pressed.
>
Interesting - I'd missed that.

Should I be flagging this to the FW team? I think I'm unlikely to get anything fixed at this point realistically - so don't want to block the patch...but if there's something we can learn from this for maybe the next generation?

> Link: https://github.com/systemd/systemd/pull/44733 [1]
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  drivers/hid/hid-ids.h    |  1 +
>  drivers/hid/hid-lenovo.c | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 994e8bc69924..70d18d32fe3c 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -473,6 +473,7 @@
>  #define USB_DEVICE_ID_EDIFIER_QR30	0xa101	/* EDIFIER Hal0 2.0 SE */
> 
>  #define USB_VENDOR_ID_ELAN		0x04f3
> +#define I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD	0x000d
>  #define USB_DEVICE_ID_SB974D            0x0400
>  #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W	0x0401
>  #define USB_DEVICE_ID_HP_X2		0x074d
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 30bd3f794243..e997d0cf2672 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -812,6 +812,22 @@ static int lenovo_raw_event(struct hid_device *hdev,
>  		      size >= 4 && report->id == 0x03))
>  		return lenovo_raw_event_TP_X12_tab(hdev, get_unaligned_le32(data));
> 
> +	/*
> +	 * Lenovo ThinkPad T14s gen6/7 snapdragon version filter out spurious
> +	 * F23 events when Fn key is pressed. F23 cannot be unmapped because of
> +	 * the copilot key sending left-meta + left-shift + F23. Filter report 8
> +	 * (keyboard) scancode 0x72 (F23) when the modifier byte is not 0x0a.
> +	 */
> +	if (unlikely(hdev->product == I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD &&
> +		     size == 9 && data[0] == 8 && data[1] != 0x0a)) {
> +		for (int i = 3; i < 9; i++)
> +			if (data[i] == 0x72) {
> +				memmove(&data[i], &data[i + 1], 8 - i);
> +				data[8] = 0;
> +				break;
> +			}
> +	}
> +
>  	return 0;
>  }
> 
> @@ -1393,6 +1409,10 @@ static int lenovo_probe(struct hid_device *hdev,
>  {
>  	int ret;
> 
> +	/* Make the T14s  keyboard trackpoint a separate input-device */
> +	if (hdev->product == I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD)
> +		hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
> +

Shouldn't this be in a separate commit?

>  	ret = hid_parse(hdev);
>  	if (ret) {
>  		hid_err(hdev, "hid_parse failed\n");
> @@ -1558,6 +1578,7 @@ static const struct hid_device_id 
> lenovo_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_IBM, 
> USB_DEVICE_ID_IBM_SCROLLPOINT_800DPI_OPTICAL_PRO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, 
> USB_DEVICE_ID_LENOVO_SCROLLPOINT_OPTICAL) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, 
> USB_DEVICE_ID_LENOVO_TP10UBKBD) },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 
> I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD) },
>  	/*
>  	 * Note bind to the HID_GROUP_GENERIC group, so that we only bind to 
> the keyboard
>  	 * part, while letting hid-multitouch.c handle the touchpad and 
> trackpoint.
> -- 
> 2.56.0

Mark
