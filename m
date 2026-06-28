Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6525B081
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665974; cv=none; b=HbI7lnZVjMBMloZPNLtT/FxyR1uk2aQWqd2naYjK9Qn0EBIRVUgPtcxUp/VWTTL1MMu8bOMFoLwGhmBEOZ+CrvU+z7L7d11eZ0tAoWldUbdA9rLXBW22Lb6p+7r32KFR4Fx2Sg+FsTr/hEioXDanRjRnnAfsrlHJ0y1Xk48Vctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665974; c=relaxed/simple;
	bh=eCxoRmATq713ZlzzOwqrDSFD9/b6IOLGfqsVB8pD7ck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fBOzbzYJqCj75sdLlNwWq2XX+ZdsRZ9scfUUoz5JT87wZr5ES2ojibPN1+YDTID5/v9XTEW2dFUY5/is7UtJ5ojCkgz8QmOQoCYO3tl6CWjyxEBQLZXpF6Ng2r3wIXAeA94oa7slaDcIADCnChZyrOQUsMJQSgVBB3VD/YjUga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660281F000E9;
	Sun, 28 Jun 2026 16:59:33 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] HID: roccat-isku: reject short button reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628164611.17467-2-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
 <20260628164611.17467-2-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 16:59:32 +0000
Message-Id: <20260628165933.660281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `.raw_event` callback acquires mutexes while running in an ato=
mic context, leading to a "sleeping function called from invalid context" b=
ug. The HID core invokes the raw event handlers (`isku_raw_event`, etc.) fr=
om the USB URB completion handler, which executes in atomic context (softir=
q). The event handler delegates to `roccat_report_event()`, which erroneous=
ly acquires two mutexes.
- [High] Improper teardown ordering allows the URB completion handler to ac=
cess freed driver data (Use-After-Free). In `isku_remove()` and the error p=
ath of `isku_probe()`, `isku_remove_specials()` is called before `hid_hw_st=
op()`. This frees the `isku` structure but leaves the hardware URB polling =
active. If a USB interrupt completes in this window, `isku_raw_event()` fet=
ches the freed `isku` pointer via `hid_get_drvdata(hdev)` and dereferences =
it.
- [Medium] The patch fixes an out-of-bounds read in `isku_raw_event` caused=
 by missing size validation, and subsequent patches in the series fix simil=
ar flaws in `koneplus`, `konepure`, `kovaplus`, `pyra`, and `ryos`. However=
, the `savu` driver was left unpatched. In `savu_raw_event()`, if a malform=
ed USB device issues a truncated packet, the driver reads fields directly f=
rom the uninitialized portion of the HID core's URB buffer (out-of-bounds o=
f the actual packet) and forwards this data to the character device, leakin=
g kernel memory to user space.
--

commit c7e16c12dacea0adf121145e16f7eec60bf190b2
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: roccat-isku: reject short button reports

The Isku raw-event path casts button reports to a five-byte structure
and reads the event payload without validating the received size. A
malformed USB device can therefore trigger out-of-bounds reads from a
short report. Require the complete button report before updating or
forwarding it.

> diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
> index 93a49c93ae8c0..c65f414b13cdf 100644
> --- a/drivers/hid/hid-roccat-isku.c
> +++ b/drivers/hid/hid-roccat-isku.c
> @@ -411,6 +411,10 @@ static int isku_raw_event(struct hid_device *hdev,
>  	if (isku =3D=3D NULL)
>  		return 0;
> =20
> +	if (data[0] =3D=3D ISKU_REPORT_NUMBER_BUTTON &&
> +	    size < sizeof(struct isku_report_button))
> +		return 0;
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but since we are fixing
out-of-bounds reads here, should a similar size validation be applied to the
savu driver?

In drivers/hid/hid-roccat-savu.c:savu_raw_event(), if a malformed USB device
issues a truncated packet, the driver passes input data without size
validation:

    if (savu->roccat_claimed)
        savu_report_to_chrdev(savu, data);

Then savu_report_to_chrdev() reads fields directly from the uninitialized
portion of the HID core's URB buffer:

    special_report =3D (struct savu_mouse_report_special const *)data;
    roccat_report.type =3D special_report->type;

Could this leak kernel memory to user space?

>  	isku_keep_values_up_to_date(isku, data);

[Severity: High]
This is a pre-existing issue, but does the teardown order in isku_remove()
allow a use-after-free here if an interrupt fires during device disconnect?

In isku_remove() and the probe error path, the driver data is freed via
isku_remove_specials() before stopping the hardware URBs:

    isku_remove_specials(hdev);
    hid_hw_stop(hdev);

If a final URB completes in this window, isku_raw_event() fetches the freed
isku pointer and dereferences it in isku_keep_values_up_to_date().

> =20
>  	if (isku->roccat_claimed)

[Severity: High]
This is a pre-existing issue, but does this call chain sleep in atomic cont=
ext?

The HID core invokes isku_raw_event() from the USB URB completion handler
in softirq context. This delegates to isku_report_to_chrdev() and then to
roccat_report_event(), which acquires mutexes:

drivers/hid/hid-roccat.c:roccat_report_event() {
    ...
    mutex_lock(&device->readers_lock);
    mutex_lock(&device->cbuf_lock);
    ...
}

Can this cause a "sleeping function called from invalid context" bug?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628164611.1746=
7-1-alhouseenyousef@gmail.com?part=3D2
