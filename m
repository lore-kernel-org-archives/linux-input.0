Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973448;
	b=VL+BlPEYtsR6bxrAPeARhb4b5Fao1dILftvj9IOAeUYqwFYKQECt/lWMvmm2xzzxBzfz
	 UcPyecMXa5H31h46zv9SphcimH6gLnxjtrPaeOfi+cJgKSab0xmq8IlJLMIoQTG/h26e1
	 aHzB+juzXA9106Bzcp1TR6hNnWxdV49syV+XyDMLAD6tYm0P/L7itRRvoejNojGE6fJ+N
	 PExeA3nW5B8+ZPBl4h4gXHUHRDwn93x1lF0q4u/oqfoeyyQ6NgOfyJ2cU9NWBblYJg/RZ
	 Z+wiIhYT/dC7hnfJxu84KtxlULZcdYwXrmv0U2yZyGqExFmo/917eyvX8irC1Yfyhtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IjGPvKb7XMKmOBdTY6+LLxdaluX8C6B2yi5VZti4Zm8=;
	b=D+IFhbBvxOGSDkBOBgDwaCzw7/5dcnu9gbu9EcjKVg9t4elVolgP8xBj+KrzUSLm1Q+u
	 haFgLjGyK8qxYXH7ePEQMONol75BJjF3ctwNvC+9dgUi2XZBL74zScQMnPjmIR5Wi+Ybg
	 ZG8LMYpdPoHKybJpp55ymKJR4RrMT0J3VGaXCGpkGjh0Y6XnsrDe/NsME64EbWw3cLtCa
	 07gBProf9kOgLny0HF9Pg/U1q6ghqTX9/YNhz0AxKHZH4qT+2wtiJl/1ZoiVYfcrbZbr6
	 nlreetixdNlHWTOVf34m4ewnOWr3lvpezldmZ0YyJRydbdMDm+hrvyCRQz3bdW2z6uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCjaRapr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A502606A31A
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCjaRapr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6BF1F01825;
	Mon, 26 Oct 2026 00:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792973448;
	bh=IjGPvKb7XMKmOBdTY6+LLxdaluX8C6B2yi5VZti4Zm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WCjaRapr6BHvGP3Gupa6Yyc+pyEJjFlAz8hyBK/2S2WbBcKYLWTSngIZQeVCQ3IVl
	 D4LEN1XAFz1JpO3f0TsZ5ziHT7QpMy084jTBkWoTU/ASzU0sOr4lTRoSkmgo7ZkREf
	 hqgxtA/DIN/PlV9sRy9jy0ikfBx8OTRugwqKoreOBJHoV9DyOqswT/41HyCElHI19h
	 BHqc/GIsRPBqAGF+W/hbcG1mEMBE2O8esEBCWUUjKp3mOZqjpHNyfp6fPl5ou/nN6d
	 S2JSsqiRQEuo1MuySDbi1zgPlZYTKb/Czxd9tLGhbhpkNn8y92XKmXmTWrpPekWG6r
	 M+tZvsoQRz9jw==
Message-ID: <sashiko-outbox-184556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 15/18] HID: asus: size ally gamepad commands from
 the HID report descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261025235232.129945-16-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-16-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 00:10:47 +0000
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
- [Medium] HID: asus: ally_dev_get_report() sizes 0x0D read from 0x5A repor=
t length
--

commit 10b46a2b16e439d019a0b1a24882abca2924c954
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: size ally gamepad commands from the HID report descriptor

This commit replaces the hardcoded ROG_ALLY_REPORT_SIZE constant with dynam=
ic
buffer sizing derived from the HID report descriptor via asus_report_len() =
for
ROG Ally gamepad commands and MCU version requests.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index f438cad13264a..e444cad85b32c 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -69,7 +69,6 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define ASUS_XGM_QUERY_VERSION 0x03
>  #define ASUS_XGM_INFO_LEN 32
> =20
> -#define ROG_ALLY_REPORT_SIZE 64
>  #define ROG_ALLY_X_MIN_MCU 313
>  #define ROG_ALLY_MIN_MCU 319
> =20
> @@ -943,28 +942,33 @@ static int ally_gamepad_send_receive_packet(struct =
ally_handheld *ally,
> =20
>  /**
>   * ally_alloc_cmd() - Construct a command buffer for the gamepad
> + * @hdev: HID device the command is built for
>   * @cmd: Command code to send
>   * @payload: Optional payload data to include in the command
>   * @payload_size: Size of the payload data
> + * @size: Where to store the length of the allocated buffer
>   *
> - * The constructed buffer is 64 bytes long, and it is the caller
> - * responsibility to free the buffer using kfree().
> + * The buffer is sized after the feature report the device declares for
> + * the gamepad commands, and it is the caller responsibility to free the
> + * buffer using kfree().
>   *
>   * Return: the newly allocated buffer containing the command, or NULL on
>   * allocation failure or if the payload would not fit in the report
>   */
> -static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload, u8 payload_size)
> +static u8 *ally_alloc_cmd(struct hid_device *hdev, u8 cmd, const u8 *pay=
load,
> +			  u8 payload_size, size_t *size)
>  {
> +	size_t hw_len =3D asus_report_len(hdev, HID_ALLY_SET_REPORT_ID);
>  	u8 *hidbuf;
> =20
>  	/*
>  	 * The payload is written after the 4-byte command header:
>  	 * reject one that would spill past the end of the report.
>  	 */
> -	if (payload_size > ROG_ALLY_REPORT_SIZE - 4)
> +	if (hw_len < 4 || payload_size > hw_len - 4)
>  		return NULL;
> =20
> -	hidbuf =3D kzalloc(ROG_ALLY_REPORT_SIZE, GFP_KERNEL);
> +	hidbuf =3D kzalloc(hw_len, GFP_KERNEL);
> =20
>  	if (!hidbuf)
>  		return NULL;
> @@ -977,6 +981,8 @@ static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload, =
u8 payload_size)
>  	if (payload_size > 0 && payload)
>  		memcpy(&hidbuf[4], payload, payload_size);
> =20
> +	*size =3D hw_len;
> +
>  	return hidbuf;
>  }
> =20
> @@ -992,15 +998,17 @@ static bool ally_check_capability(struct hid_device=
 *hdev, struct ally_handheld
>  				  enum ally_command_codes check_cmd)
>  {
>  	u8 payload[] =3D { 0x00 };
> +	size_t buf_len;
>  	int ret;
> =20
> -	u8 *buf __free(kfree) =3D ally_alloc_cmd(check_cmd, payload, sizeof(pay=
load));
> +	u8 *buf __free(kfree) =3D ally_alloc_cmd(hdev, check_cmd, payload,
> +					       sizeof(payload), &buf_len);
>  	if (!buf) {
>  		hid_err(hdev, "Failed to allocate buffer for capability check.\n");
>  		return false;
>  	}
> =20
> -	ret =3D ally_gamepad_send_receive_packet(ally, hdev, buf, ROG_ALLY_REPO=
RT_SIZE);
> +	ret =3D ally_gamepad_send_receive_packet(ally, hdev, buf, buf_len);

[Severity: Medium]
Does ally_gamepad_send_receive_packet() end up sizing the 0x0d feature repo=
rt
read using the length of the 0x5a feature report?

In ally_alloc_cmd(), buf_len is resolved from HID_ALLY_SET_REPORT_ID (0x5a).
However, when ally_check_capability() and ally_gamepad_check_ready() pass
buf_len into ally_gamepad_send_receive_packet(), the same length is passed =
to
both ally_dev_set_report() and ally_dev_get_report():

drivers/hid/hid-asus.c:ally_gamepad_send_receive_packet() {
	scoped_guard(mutex, &ally->intf_mutex) {
		ret =3D ally_dev_set_report(hdev, buf, len);
		if (ret >=3D 0) {
			memset(buf, 0, len);
			ret =3D ally_dev_get_report(hdev, buf, len);
		}
	}
}

While ally_dev_set_report() sends report 0x5a, ally_dev_get_report() reads
from HID_ALLY_GET_REPORT_ID (0x0d):

drivers/hid/hid-asus.c:ally_dev_get_report() {
	return hid_hw_raw_request(hdev, HID_ALLY_GET_REPORT_ID, out, len,
		HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
}

If a device declares different report lengths for feature reports 0x5a and
0x0d (or omits report 0x0d from its descriptor), ally_dev_get_report() will
request the wrong transfer size rather than consulting asus_report_len(hdev,
HID_ALLY_GET_REPORT_ID). Should the receive path in ally_dev_get_report() or
ally_gamepad_send_receive_packet() also check the length of
HID_ALLY_GET_REPORT_ID from the report descriptor?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025235232.1299=
45-1-denis.benato@linux.dev?part=3D15
