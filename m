Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469889;
	b=vmkHgUPA8MEYVhQvE7dq6Ebq2QnfIfHTqw5/kFHiTqSmnrl49Eek8I7Pib7i/amC0BIc
	 Sun+k3DHEBon76wS+rJ9w5O0YN1nxSksRwsa+3zv0/lajWQuc5GO/Y+C08JeGl7Epa8IK
	 0ovEGkBjNEXXHpJzQyHs6c7enNrmefhZmRtERUCevBAlkJpBp72FdUsfuSvCVghu0rt7n
	 RZtxWnTpm5QUsu5NYjeUe/prwoM32OhJSmkOhNKE5LiuwmDiQBOoxcZd6fXWuUX8Qgcz0
	 uBqb1N2d+7CLX1gZAX4LTMVdRrO7sS9hsr82G17bRdVh36VgXLT7AbyZCo/5fyd5EHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469889;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yt7HpmiySSVXx+PJnecjQbdEdMDehnD/uSyV58XtdEs=;
	b=wMnR6a921rBYc7u29SwVYrClhr/q0u6CQaCUrKF0zbX1Jmz8TVhChHLZ6d+JwIXCmOsn
	 Ea5ZEV8yPdUhWx1B6G3q1Hd2pgoFS/bjjjRHnwWXJwwtlCOjp82N/uROVOb0qk0BnVi9y
	 uiAmrYtqYNBUa1NR/VXNbB/XTWTWdzwH4nGZnr8W7seoET6kZopBU889ehEWFf8erVFJX
	 vJW8B6dyJe5F/6hBqmO8KPKDKxOePYMVEpVrqSb+6j/oT8XOiE+pvH3Xc+wMHK7Ruau5x
	 X9HjvXt4OhlZ3c+7fBoxh08BuqNtbSxLx7r5fcQee7+qIzMxBQMh0FH+caHawo9w3ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjdwzCqq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7894606A31A
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjdwzCqq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D6E1F000C1;
	Sat, 31 Oct 2026 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793469888;
	bh=yt7HpmiySSVXx+PJnecjQbdEdMDehnD/uSyV58XtdEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kjdwzCqqGLaFirDgsLTzZsC+GpdCuyfh+mJ1Nen4zSBWII046BFwB8LpDXFeI1ne8
	 SjGhJmJXs3a49gCatoMZNQpu2UERqpuerffurmnjo3WmPKOqXdvnP1+reI1DjYzCn9
	 XgK0RKCN8Yw8VrqIpo7nRW9Plj+CJpIlXKj/KGfq1PnuyCVGl+EA/tknP4e60QBKmn
	 02xnutyHH9WipvHYZWNOkYGwO7IJ3mdSoGDrrrtm+NAhpo406JQlClycueIo828ZFH
	 r4fxQQZ3Nfbc+iuGnNTjqP6VUCfIWSNeoZFEWLATmyb3eRUarH9gowFQ8X2VROuqkI
	 UsLO5BPmv4zgQ==
Message-ID: <sashiko-outbox-192088@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/17] HID: asus: size feature reports from the HID
 report descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261031174130.208240-2-denis.benato@linux.dev>
References: <20261031174130.208240-1-denis.benato@linux.dev>
 <20261031174130.208240-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 18:04:47 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: asus: wrong report ID in mcu_request_version() breaks MCU che=
ck
--

commit 95aa403a07769e0a4dbd2dee41abe2766cd2fe36
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: size feature reports from the HID report descriptor

This commit derives feature report transfer lengths from the HID report
descriptor via asus_report_len() instead of using hardcoded sizes across
asus_kbd_set_report(), asus_kbd_get_report(), mcu_request_version(), and
asus_xgm_led_set().

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index f6aa1be09ad53..327bb4ab1a0d6 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -900,10 +992,15 @@ static int mcu_parse_version_string(const u8 *respo=
nse, size_t response_size)
> =20
>  static int mcu_request_version(struct hid_device *hdev)
>  {
> -	u8 *response __free(kfree) =3D kzalloc(ROG_ALLY_REPORT_SIZE, GFP_KERNEL=
);
> -	const u8 request[] =3D { 0x5a, 0x05, 0x03, 0x31, 0x00, 0x20 };
> +	size_t hw_len =3D asus_report_len(hdev, FEATURE_REPORT_ID);
> +	const u8 request[] =3D { FEATURE_KBD_REPORT_ID, 0x05, 0x03, 0x31, 0x00,=
 0x20 };
>  	int ret;
> =20
> +	if (!hw_len)
> +		return -EINVAL;
> +
> +	u8 *response __free(kfree) =3D kzalloc(hw_len, GFP_KERNEL);
> +
>  	if (!response)
>  		return -ENOMEM;
> =20
> @@ -911,17 +1008,16 @@ static int mcu_request_version(struct hid_device *=
hdev)
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D hid_hw_raw_request(hdev, FEATURE_REPORT_ID, response,
> -				ROG_ALLY_REPORT_SIZE, HID_FEATURE_REPORT,
> -				HID_REQ_GET_REPORT);
> +	ret =3D hid_hw_raw_request(hdev, FEATURE_REPORT_ID, response, hw_len,
> +				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>  	if (ret < 0)
>  		return ret;

[Severity: High]
Does asus_report_len(hdev, FEATURE_REPORT_ID) return 0 here on ROG Ally and
ROG Ally X devices?

In drivers/hid/hid-asus.c, FEATURE_REPORT_ID (0x0d) is the I2C touchpad
multitouch report ID used by asus_start_multitouch(), whereas the ROG Ally
N-Key vendor HID interface declares feature report 0x5a
(FEATURE_KBD_REPORT_ID) in its HID report descriptor (and as documented abo=
ve
mcu_parse_version_string(), the MCU response payload starts with "5a 05 03 =
31
00 1a 13").

Previously, mcu_request_version() passed a hardcoded ROG_ALLY_REPORT_SIZE (=
64)
to hid_hw_raw_request(), which succeeded because usbhid_get_raw_report() do=
es
not look up the report ID in hdev->report_enum[HID_FEATURE_REPORT].

With this change, when probing USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY or
USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X via:

  asus_probe()
    -> asus_kbd_register_leds()
      -> validate_mcu_fw_version()
        -> mcu_request_version()

looking up FEATURE_REPORT_ID (0x0d) in hdev->report_enum[HID_FEATURE_REPORT]
via asus_report_len() will not find a report and will return 0, causing
mcu_request_version() to return -EINVAL. validate_mcu_fw_version() then
silently aborts without checking the MCU version or configuring MCU powersa=
ve:

  version =3D mcu_request_version(hdev);
  if (version < 0)
          return;

Should mcu_request_version() look up FEATURE_KBD_REPORT_ID instead of
FEATURE_REPORT_ID when sizing the buffer with asus_report_len()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031174130.2082=
40-1-denis.benato@linux.dev?part=3D1
