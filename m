Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1F41F5C7
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 04:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864017; cv=none; b=SpqW053QQHmGeISww+NCFQ6XhTN1TW1RTyAY4sBzcAYOLzv+ZoVIR4oGrZexZ9NPrZnlGxTnEd1EwtDRTS9BurK15FT4WiVE2LCPiPNixq7PigIoc2QwRgZsTt+9h8JUg/MN92GK6Eo/ssUSBeum2J6q2nbpi6KCa1L6APoHycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864017; c=relaxed/simple;
	bh=6BKnGNiwvfML3fksZBPC+9VGUmwf2rZFvJmcXBWvpmY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sHfzxcrprFJdLZmWCQJ0OD6jrxm8gmVkGJLc5NbWpKVZtsg7OOel+GmtkqtNFbO0Q5Rsfs2/Eh9jR7H+d8yApLDm0aEPFrgEVjI8X2ZVKiUAYyL1ZhxpP/wDMftLUok36V3yTY3PMPLw4Bm/PEJe72Ha0eITz97n6iju/076XVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9qKZvuo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9qKZvuo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8653D1F000FF;
	Tue, 13 Oct 2026 04:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791864015;
	bh=3giWnTqLsPXdUwDQVCPJjJWMhQrwpe8FMwcdqq0IbM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j9qKZvuoXSDQB/QfOaDfIOSeBgVGazbrR9AYsGjGERsEeRPozee7sn16pTa53RHUj
	 KSyOIac7D8URlr25IdZU488WlL1nZQdsja19n0Up22ihCYABLOuC0hbu28T+AZp671
	 J0vrDnzc7eTxZtOIIlHm51H9bk24p/n7szCmm64Jnh88rmMMFwDiE06awFsqPToAEd
	 2Jm+T1yCfa2ElP5Fn5pKhZ8E0aYuj1ZUgWDsRII29Yr7B3zH7cqxnSycNRCl0rejyh
	 7hGjYWNGZbm0L+Np4zWQlhWAXk550hVrSUBm5MLcxJlZz8qRq/Wfu+Dn9T7m4i6Mw/
	 pZYw+Er0sWCYA==
Message-ID: <sashiko-outbox-168950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] HID: core: Validate GET_REPORT report ID centrally
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20261012-hid-core-report-validation-v1-4-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
 <20261012-hid-core-report-validation-v1-4-e0dd5cb60b2e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 04:00:15 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] hid: bpf: HID-BPF cannot fix invalid report IDs due to centralized=
 validation
- [High] hid: __hid_hw_raw_request() breaks uhid unnumbered GET_REPORT
- [Medium] hid: core: un-ratelimited mismatched report ID warning allows lo=
g flooding DoS
- [Medium] hid: uninitialized memory read in __hid_hw_raw_request() on time=
out
--

commit d5fcafe8cdb215ca55eba80f821711e3f7748edf
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

HID: core: Validate GET_REPORT report ID centrally

This commit centralizes the check for whether a report retrieval response
returns the expected report ID into the core HID raw request path. It also
introduces a new quirk, HID_QUIRK_IGNORE_REPORT_ID_MISMATCH, to handle
hardware with buggy firmware.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 3a9bd56dbf85e..cd099a420b9b6 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2565,8 +2565,17 @@ int __hid_hw_raw_request(struct hid_device *hdev,
>  	if (ret)
>  		return ret;
> =20
> -	return hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
> +	ret =3D hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
>  					    rtype, reqtype);
> +	if (ret > 0 && reqtype =3D=3D HID_REQ_GET_REPORT &&
> +	    !(hdev->quirks & HID_QUIRK_IGNORE_REPORT_ID_MISMATCH) &&
> +	    buf[0] !=3D reportnum) {

[Severity: High]
Does this validation break uhid unnumbered GET_REPORT requests?

When __hid_hw_raw_request() in drivers/hid/hid-core.c is called for an
unnumbered report (reportnum =3D=3D 0) on a uhid device, this check expects=
 buf[0]
to contain the report ID (0).

However, the uhid driver copies the userspace response verbatim into the
buffer:

drivers/hid/uhid.c:uhid_hid_get_report() {
    ...
	req =3D &uhid->report_buf.u.get_report_reply;
	if (req->err) {
		ret =3D -EIO;
	} else {
		ret =3D min3(count, (size_t)req->size, (size_t)UHID_DATA_MAX);
		memcpy(buf, req->data, ret);
	}
    ...
}

Because uhid does not prepend a dummy 0x00 report ID like usbhid does, buf[=
0]
contains the first byte of the data payload. Unless the payload happens to
start with a 0, this check will fail and spuriously reject valid reports.

[Severity: Medium]
Could this read uninitialized memory?

If a userspace application issues a GET_REPORT request via hidraw, it passes
an uninitialized kmalloc buffer down to __hid_hw_raw_request():

drivers/hid/hidraw.c:hidraw_get_report() {
    ...
	buf =3D kmalloc(count, GFP_KERNEL);
    ...
}

If a transport driver like ishtp_raw_request() in
drivers/hid/intel-ish-hid/ishtp-hid.c times out waiting for the device, but
returns the length without populating the buffer:

drivers/hid/intel-ish-hid/ishtp-hid.c:ishtp_raw_request() {
    ...
	hid_hw_wait(hid);

	return len;
}

This validation check will evaluate the uninitialized memory and leak one
byte of kernel heap memory via the warning.

> +		hid_warn(hdev, "mismatched report ID %u (expected %u)\n",
> +			 buf[0], reportnum);

[Severity: Medium]
Could this warning cause a log flooding denial of service?

Any local user with read/write access to the hidraw node can synchronously
trigger this warning in a tight loop by issuing HIDIOCGFEATURE ioctls on a
device that returns a mismatched report ID.

Because hid_warn() expands to dev_warn() without rate limiting, this can be
exploited to flood the kernel log.

> +		return -EINVAL;

[Severity: High]
Does this prevent HID-BPF programs from fixing invalid report IDs?

When a BPF program calls hid_bpf_hw_request() to fetch a feature report from
the hardware, if the hardware returns an incorrect report ID in buf[0], this
check intercepts the response and immediately returns -EINVAL.

The BPF program receives -EINVAL instead of the raw data buffer, leaving it
unable to read the buggy buffer or apply a fixup, forcing the use of hardco=
ded
kernel quirks instead.

> +	}
> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-hid-core-r=
eport-validation-v1-0-e0dd5cb60b2e@gmail.com?part=3D4
