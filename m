Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6137CD40
	for <linux-input@vger.kernel.org>; Sat,  3 Oct 2026 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991222; cv=none; b=Vui8orURxb7KVdVyLuStXkSTIJzOhzLGoCQDLSm7MZ0mKQj07RmVUGyFKgGAGHTJqUtaVFSWgtWFib4gRsLBgCJlGSyWoSWpNsIHqFcP3DEWRmMLGrRwzHKLoj0jiyi9LpK1Q+qOAQ9mVnaCG+toZS3noAnMDeEdvEBxAd5NHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991222; c=relaxed/simple;
	bh=aAFtJbofNggnLhlUYhZURB5T14lUqlnECNY6G+HDHX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NjzxWZ+cA/cqNFv4WQXwrCwmsDSnFjbME0kW2kTptfH/1C/ZI9E9nLqGFhXc3RvIfpGDmdN/kfaa7b5wrmVYfGcJGaiA91850PWYyzXAk0Qakp9m+yg98rNDZfsKMd/Tr6n1Q9bptA5iyShb8zjkt0U61Opt6gT/3crwuyHf5ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erLHJsca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erLHJsca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDBE1F000FF;
	Sat,  3 Oct 2026 01:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991220;
	bh=U8JTMd6rbBBrtqYf2Y69dgGuXiljBgdMHPrADHSMzwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=erLHJsca9Tw6LHYtx3yxhpnU37MJp+L8xMzzFQTr044Qh2wsnCl67WZa5txFkd9pQ
	 OKKtLrWoup23jKcANouC/ZAgCbrnp3sMqYaaVmg8QAnFgTVNBsW7Ax2uIxMZB6V3gV
	 A1DajKDALvSvHnB736fNAV5j+AgQaxOn27zMedubTwjxcq8utf5V04ASMxixud30WY
	 73tftGOQSBn55kzfUEkej/EIzX21CLxogVXNtWpvKU7aFI+g8H/D526S2DWemaEwGM
	 x0a1KQNMx50r4Na7vNMwyL+mvPFjio7MK7KJkEouuHrNWUbbxBWuV8jcMGBCS89FZ3
	 4oaw4q8UkM+sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: i2c-hid: add quirk to send initial output reports
 for Acer SFA14-I31
Reply-To: sashiko-reviews@lists.linux.dev
To: DMS <dms3studio@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261002-swift-sfa14-kbd-v1-1-ad312bca1076@gmail.com>
References: <20261002-swift-sfa14-kbd-v1-1-ad312bca1076@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:40 +0000
Message-Id: <20261003013340.9FDBE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: i2c-hid: silent quirk failure due to dependency on synchronou=
s driver binding
- [High] hid: i2c-hid: unprotected report_list traversal causes data race a=
nd UAF
--

commit 8bcb0b187653aa75d332fb5ab3f4c9d75928faf8
Author: DMS <dms3studio@gmail.com>

HID: i2c-hid: add quirk to send initial output reports for Acer SFA14-I31

The internal keyboard of the Acer Swift Air 14 (SFA14-I31, ACPI
1025174B, HID 049f:5343) does not send any input reports after probe.
It stays silent, and its GPIO interrupt never fires, until the host has
written an output report to it at least once.

Add I2C_HID_QUIRK_INIT_OUTPUT_REPORTS, which sends every output report
once with its initial field values right after the HID device has been
added, and enable it for this keyboard.

> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index a8a9854854f52..f546710925e64 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c

[ ... ]

> @@ -1079,6 +1086,32 @@ static int __i2c_hid_core_probe(struct i2c_hid *ih=
id)
>  	return 0;
>  }
> =20
> +/*
> + * The input core only writes LED state when it changes (and on resume),=
 so
> + * a device that waits for an output report never gets one at boot. Send
> + * every output report once with its initial field values.
> + */
> +static void i2c_hid_send_initial_output_reports(struct hid_device *hid)
> +{
> +	struct hid_report_enum *report_enum =3D &hid->report_enum[HID_OUTPUT_RE=
PORT];
> +	struct hid_report *report;
> +	u8 *buf;
> +	int ret;
> +
> +	list_for_each_entry(report, &report_enum->report_list, list) {
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this unsynchronized iteration risk a data race or use-after-free?

Because hid_add_device() has already exposed the device to the driver core
and userspace, the high-level driver could be binding asynchronously and
mutating the list via hid_register_report(), or unbinding and freeing the
reports concurrently via hid_close_report().

[ ... ]

> @@ -1099,6 +1132,9 @@ static int i2c_hid_core_register_hid(struct i2c_hid=
 *ihid)
>  	if (ihid->quirks & I2C_HID_QUIRK_RE_POWER_ON)
>  		ret =3D i2c_hid_set_power(ihid, I2C_HID_PWR_ON);
> =20
> +	if (ihid->quirks & I2C_HID_QUIRK_INIT_OUTPUT_REPORTS)
> +		i2c_hid_send_initial_output_reports(hid);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Will this reliably send the initial reports?

Because this executes immediately after hid_add_device() registers the
device, reports are not parsed and added to report_list yet. The list is
only populated when the high-level driver (e.g. hid-generic) probes and
calls hid_parse().

If the high-level driver binds asynchronously or is loaded as a module
after i2c-hid, i2c_hid_send_initial_output_reports() will iterate over an
empty list and silently do nothing, leaving the keyboard unresponsive.

> +
>  	return ret;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-swift-sfa1=
4-kbd-v1-1-ad312bca1076@gmail.com?part=3D1
