Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA61DF980
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561352; cv=none; b=YwiaR4C93MWXFTLQWl3nMhurj82Hm1F6/VbQDK6uP112wGg+iegs9FNA+vUnUhXgkfq9uIwmJzhfWu7ahtunKWHZoKLp7pPNTq9oVHYirTK7HCO2pEYTZXkeXlJpfbrdQpQhsB7RHlowcUJYqVjsE9i12+FynH4D/A+k8dm1U1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561352; c=relaxed/simple;
	bh=l/A0MrAnueFRpVKHAoze+aRjzn5Deisud2OPwmesoO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HMKqtV490DdmT12M8B+vGMxh+ZEnb3DiNBIV7eTLvg5zCO/4wS9cME4yRT3TEmdMLFRgEZ3alNCL8vfNAg46/PNGgej5XvGZdk84uwpVYNAXaeEQEaXhG3AvAy9MrvJCWIQkd7i8yLuA7brISYE26Zl+C4yd3FqagTgzYT09q64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk206cnF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk206cnF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B6DC2BCB0;
	Tue, 12 May 2026 04:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778561351;
	bh=l/A0MrAnueFRpVKHAoze+aRjzn5Deisud2OPwmesoO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Kk206cnFgPQjfb8zgWTVq1Mt0x912I12Wyr6GxZyGFhc5eDJ+626ZfCQvHEr1HyQg
	 JXhNvHa9zGHrJOZm2WXXiqXmnbOVPno6zAVTuQ2Fk0o+N60Gzr+/f666Q1X+yr9jlk
	 1oqgbMSm6Q6Ap10RUtxdgv9hLkOK0QspA+826c3tyX01AvUlhHUJgqbZqVQrbY2jRa
	 k0PHHzgnTbZwGqs/L1L0szB8BH3KKKSK0L/MZyuRLIjMvfjps4P1/48yLG6vg7uhZj
	 mqTY4jSXaTIZHL3OJEwXJR32gO/3ZM+fZYeh4ALAc+NWnmjRmhg0AQ0S0Yr9mFPp4p
	 bllWe9yPuvxSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: lenovo: Fix buffer over-read in X12 Tab raw_event
  handler
Reply-To: sashiko@lists.linux.dev
To: Kean <rh_king@163.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260511132854.1351379-1-rh_king@163.com>
References: <20260511132854.1351379-1-rh_king@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 04:49:11 +0000
Message-Id: <20260512044911.99B6DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unaligned memory access via direct pointer cast in raw event handl=
er.
- [High] Missing input capability registration causes hotkey events to be s=
ilently dropped.
--

commit a1525e53f7f5fe161ed804808d59755ff69c771f
Author: Kean <rh_king@163.com>

HID: lenovo: Fix buffer over-read in X12 Tab raw_event handler

In lenovo_raw_event(), the X12 Tab keyboard handler reads a 4-byte
little-endian value via *(__le32 *)data but only guards the access
with a size >=3D 3 check. If a 3-byte report with ID 0x03 is received,
the code reads one byte beyond the end of the buffer.
   =20
Change the size check to >=3D 4 to match the actual access width.

> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index a6b73e03c16b3..4686ecb6cfa8e 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -793,7 +793,7 @@ static int lenovo_raw_event(struct hid_device *hdev,
>  	 */
>  	if (unlikely((hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB
>  			|| hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB2)
> -			&& size >=3D 3 && report->id =3D=3D 0x03))
> +			&& size >=3D 4 && report->id =3D=3D 0x03))
>  		return lenovo_raw_event_TP_X12_tab(hdev, le32_to_cpu(*(__le32 *)data));

This isn't a regression from this patch, but could this direct pointer cast
lead to unaligned memory access exceptions?

The data pointer provided by the HID core can have arbitrary alignment
depending on the transport layer. For instance, if injected via uhid using
UHID_INPUT2, the payload data starts at an offset of 6 bytes from the start
of the uhid_event struct, which is 2-byte aligned but not 4-byte aligned.

On architectures that do not natively support unaligned memory access,
dereferencing an unaligned pointer triggers an unaligned access exception.

Would it be safer to use get_unaligned_le32(data) to safely extract the
value?

Also, another issue not introduced by this patch: do the hotkey events
processed by lenovo_raw_event_TP_X12_tab() get silently dropped by the input
core?

The lenovo_raw_event_TP_X12_tab() handler reports events for keys like
KEY_RFKILL, KEY_PERFORMANCE, and KEY_BOOKMARKS:

drivers/hid/hid-lenovo.c:lenovo_raw_event_TP_X12_tab() {
	...
	case TP_X12_RAW_HOTKEY_FN_F8:
		if (hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB) {
			report_key_event(input, KEY_RFKILL);
			return 1;
		}
		report_key_event(input, KEY_PERFORMANCE);
		return 1;
	...
}

However, if these key capabilities are not registered in the input_dev's
keybit array during device initialization, the kernel's input core checks
is_event_supported(code, dev->keybit, KEY_MAX) and drops the events when
report_key_event() is called.

Are these custom hotkey capabilities properly registered during device setup
to prevent them from being filtered out?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511132854.1351=
379-1-rh_king@163.com?part=3D1
