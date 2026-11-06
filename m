Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976683;
	b=Hu+RcJG4WW9YDHOVnBC2o4+D4MacX4q1hOBaFIHxWyBXPMPLygADdMYkcWpn6t7ky70z
	 dibWrYELu9j5rkxLhB+cAhvUvQiAWYkEmgNfBL3MdtYlGUfCNKaRZezG4z933fVDwNwow
	 PsqwWNBFqj5LCfC+tnk/M5P1B1p3dVXjVDuVWHSsgCCqF/TMBngxci5AbafA1r7sf/fwD
	 m2SVkz0UrVZbEbqyOHsoLw/CPQKYl0PT3C1FBUHvuMRqXDud5pZ6bnioxvE1Lw+AH6XbZ
	 pSY1v0AOGubnGxJ6T/IEoSzMA4cf4nzx81wGEnEUHtcO20NFuRz56uTnoLDdhYe4uAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976683;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6Ol7Jy5h8yev4a5ZRKOAGeQBnJuHKDip9z6Pa5bOqlE=;
	b=mQXzeBeCqjpCt46jH0yyLVvEvXM0IGp4J6lytlo6iL8VgHUu0sAmuygtCvd5IqELGsYy
	 vOJoe2Ffs5P5EKulPvmivgKXK+p7/N8ewEAlvUv8IvoxYJdKGk7GMELyZEvkF5HV64N9Z
	 /qki1VY2FcxRZFZPHnQqg8RUj1CoAggqTLKzXREo2VPAGmxhY0h9haDpq4b6fqmlm0iH3
	 a3UZ5yof2yw8ioHQQhO4JnZGmiuIzPEm5v6z2kEAdiWmIY5pe9geF0khIonQyE3g+Y9C7
	 Jfb2m+8mAnkhyyHfSd+54V1tTymg288y80Hrs57AgQUvu5GRF9GIM5RIB+SnxQpqSgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dn4uwNeM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC8606A32C
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dn4uwNeM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640F11F0089F;
	Fri,  6 Nov 2026 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976682;
	bh=6Ol7Jy5h8yev4a5ZRKOAGeQBnJuHKDip9z6Pa5bOqlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dn4uwNeMHDVYlVnH+yyGkhdOnfUdzH4O69Q3bm2StthZq8y1cZ8kXzJXbVnPgkqdb
	 yRp1K7l2hRXigudLTgp1wJ52pnGtBJJw31V9sX9oaB/hkxLi03FnDoJKA4O9eZgQEn
	 yAljAvz3vWRcpGqSyKNPsLiL87UbW0F+6Vgy1qKAq7yYLjy1W9y/kURc8I3oj/44aZ
	 9ZfkU6mJ8tehUImhFHnqcO8LFOsJMUG2pZgiT2ZXzblE6vuFZFrjMd3Xum43gg0Tmd
	 /NFXGvQgpIWslitvHXbVd4k46ZpDn2T8BXHHfdp1ShNLjjkRiZZ0G7fOXcWdPIeVtd
	 op1156If5SgRA==
Message-ID: <sashiko-outbox-201618@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 01/18] HID: asus: size feature reports from the HID
 report descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261106142334.1881-2-denis.benato@linux.dev>
References: <20261106142334.1881-1-denis.benato@linux.dev>
 <20261106142334.1881-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:51:21 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: asus: report type mismatch in asus_has_report_id() and
  asus_report_len()
--

commit a49f4ba7e2479238fb06ec5527d0ef52ccd84b83
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: size feature reports from the HID report descriptor

This commit derives feature report transfer lengths from the device's HID
report descriptor via asus_report_len() instead of using hardcoded report
sizes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index f6aa1be09ad53..46643022b68d0 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> +static size_t asus_report_len(struct hid_device *hdev, u8 report_id)
> +{
> +	struct hid_report *report;
> +
> +	report =3D asus_find_report(hdev, HID_FEATURE_REPORT, report_id);
> +
> +	return report ? hid_report_len(report) : 0;
> +}
[ ... ]
> @@ -604,8 +687,13 @@ static int asus_kbd_init(struct hid_device *hdev, u8=
 report_id)
>  	 */
>  	const u8 buf[] =3D { report_id, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
>  		     0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
> +	size_t hw_len =3D asus_report_len(hdev, report_id);
> +	size_t cmp_len;
>  	int ret;
> =20
> +	if (!hw_len)
> +		return -EINVAL;
[ ... ]
> @@ -958,17 +1054,12 @@ static void validate_mcu_fw_version(struct hid_dev=
ice *hdev, int idProduct)
> =20
>  static bool asus_has_report_id(struct hid_device *hdev, u16 report_id)
>  {
> -	struct hid_report *report;
> -	int t;
> +	if (report_id >=3D HID_MAX_IDS)
> +		return false;
> =20
> -	for (t =3D HID_INPUT_REPORT; t <=3D HID_FEATURE_REPORT; t++) {
> -		list_for_each_entry(report, &hdev->report_enum[t].report_list, list) {
> -			if (report->id =3D=3D report_id)
> -				return true;
> -		}
> -	}
> -
> -	return false;
> +	return asus_find_report(hdev, HID_INPUT_REPORT, report_id) ||
> +	       asus_find_report(hdev, HID_OUTPUT_REPORT, report_id) ||
> +	       asus_find_report(hdev, HID_FEATURE_REPORT, report_id);
>  }

[Severity: Medium]
Should asus_has_report_id() and asus_report_len() check the same report
types?

asus_has_report_id() matches HID_INPUT_REPORT, HID_OUTPUT_REPORT, and
HID_FEATURE_REPORT, and its callers gate feature-report operations such as
asus_initialize_reports() -> asus_kbd_init():

drivers/hid/hid-asus.c:asus_initialize_reports() {
	for (int r =3D 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
			ret =3D asus_kbd_init(hdev, asus_report_id_init[r]);
			if (ret < 0)
				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
					 asus_report_id_init[r], ret);
		}
	}
}

However, asus_report_len() only checks HID_FEATURE_REPORT and returns 0
otherwise.  On devices whose descriptor declares report 0x5a only as an
input report (such as keyboards using QUIRK_G752_KEYBOARD, where the fixed
descriptor in asus_report_fixup() only defines an Input item for report
0x5a), asus_has_report_id() returns true while asus_kbd_init() now fails
with -EINVAL and logs a warning on probe and reset_resume.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106142334.1881=
-1-denis.benato@linux.dev?part=3D1
