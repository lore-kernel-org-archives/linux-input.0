Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDB2D3ECF;
	Mon, 27 Jul 2026 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157647; cv=none; b=L+sGB0kprxntiXI12oqo9XjigR8vO677TXx/86Z0uW7rolu5j5n+VvbDgvl6I5HVZpRIX2dfTAaicBhNEd3i8g/vAVrdg7MddKId7Z16VR+RSdWZELqYUn2L3/pyWkBtkyAwgyK6itFFaAN2T7JPvR/CVJxNMvFpYyLGCocjb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157647; c=relaxed/simple;
	bh=aFHrSxljvcOOgNbmd7DM7VqqMgnT0aNl1eMF3UnZusU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KC0yifBlbzkzGRcpowaId15NqCLYqn5PD5JydPqyIVM6AXwFmlZk8sglZy4MfbiOFL8eFBs2tG2BPcCi77R5J56xxVKFXtkZOY4IefT93DS44n59p57D/A3rdgnJeCToBSxm7UnmVjBI0zAjxbgoirI0gJJkVfIUynW0cD7keXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A3A43EC83;
	Mon, 27 Jul 2026 13:07:22 +0000 (UTC)
Message-ID: <21e8047a869d9d15eaae927fc0282bf0689b69f3.camel@hadess.net>
Subject: Re: [PATCH] HID: logitech-hidpp: Remove duplicate ID for the G703
 Hero over USB
From: Bastien Nocera <hadess@hadess.net>
To: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Filipe =?ISO-8859-1?Q?La=EDns?=
	 <lains@riseup.net>
Date: Mon, 27 Jul 2026 15:07:22 +0200
In-Reply-To: <20260721173710.500368-2-stuart.a.hayhurst@gmail.com>
References: <20260721173710.500368-2-stuart.a.hayhurst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTG1vpk6O7RBU+wGGfaiN7Lm5Am2If7M9uNJZh75Q7LuKeWgqBm92Fzs+z4gdKzoaFbR1k/Wb77I0Z8UR8dzoPQDAfUX88CCgYqCvfz6mitgvtqKwcRl43VO4S+CdDNQ1V3SQBFd+EAdMfDi7Mm6zaKTippxdkeFGVHJUv2mNhp14A7oq1gQsYd/Oorou2ZaL3GR1mdCKJrGFqTscNX6NLksFTwLH5WeWUDKfhrd/bw2WkWS4tnQmCCmRc9tu2XP/dT0l3C7SnbMN5PvGZjEuE9xFUwmh7AXmOUf4+W1ee5OmzzJhqqtZTcdYXGT4D8ka3vILfIIvEU/0R8wAaEqRfjQPN0QEtFSr7zWxuwdVDbOiOYOM+3FuRyi83TN4B4dE26UlkmzHiSPvysm2CvAJuyfTDVEl1OYvWcARB3mtgjKRVo6xDaEUWAKBg4qNuZV2qZ6P3AxVZgdobW4xCbmrnztQVIrewKr9/Ei+ER0LH6ZjqvbcEn+UUnZskhl1MamcuFRbcSbndflC0moQztAkhVyMAuLFyhIZag35t8oJziGsZLTA5C5zDUKGrA3yxb5jt2LW1mgYUpcUYfmL9h+aJKT44Q94f2KFokTni7XoC8v6eXzEsQUciI77tETAdccfNmDTyTr8Vc6a9ltf07penQMuvFIIpp7kSlUk7DWVmB2gg

On Tue, 2026-07-21 at 18:37 +0100, Stuart Hayhurst wrote:
> The ID appears to be given twice, remove the duplicate
>=20
> Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

Indeed, at line 4652:
        { /* Logitech G703 Hero Gaming Mouse over USB */
          HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC090) },
        { /* Logitech G900 Gaming Mouse over USB */
          HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC081) },
        { /* Logitech G903 Gaming Mouse over USB */
          HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
        { /* Logitech G Pro Gaming Mouse over USB */
          HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
        { /* MX Vertical over USB */
          HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08A) },
        { /* Logitech G703 Hero Gaming Mouse over USB */
          HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC090) },

Benjamin, Jiri, is there not a way to detect duplicates like this?

In any case, looks good to me.

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
> =C2=A0drivers/hid/hid-logitech-hidpp.c | 2 --
> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 90b0184df777..b1b1c5cb657c 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4659,8 +4659,6 @@ static const struct hid_device_id
> hidpp_devices[] =3D {
> =C2=A0	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
> =C2=A0	{ /* MX Vertical over USB */
> =C2=A0	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08A) },
> -	{ /* Logitech G703 Hero Gaming Mouse over USB */
> -	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC090) },
> =C2=A0	{ /* Logitech G903 Hero Gaming Mouse over USB */
> =C2=A0	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC091) },
> =C2=A0	{ /* Logitech G915 TKL Keyboard over USB */
