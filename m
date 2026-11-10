Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277499;
	b=WNwqfDbE5Uf18RQtKKL5aqwPEHKP3lkefuYmRlIxnmJkWFIIAeg88ZcTwlnzDTqeIJIg
	 ZoWDQROXN9mgIytyfLa7U0Z2JZDx0AbKt+0dAfr6/LmmjGHE0dlGSncee7aSFXa04mQju
	 4r0QWHMeQVEkd2gk2nKfu2V22ZWWiesox8fKpW3RWBYbLfQwfIN/PLreBUbZbiJbHyYcI
	 FPbU7PtfOmfANYKqyvANGo41XTfrzgXqtd7x39AfZc9j/FR+ITLlD7oaimbs7cpzS0w+F
	 6mq/Q4ECRSXbbTl+Odc+vnaVjY4b9MqIm7rrSMIsVIJh6MRxq0lrcRT+7TT83ysphDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277499;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P9rsFkVvrQ9w45lKk2xSO3E8CvYzW07tLofVK2X0mBY=;
	b=wDSIEYrbUkeBurvjWOKwd+PgjIeKt7J7vKEwCzQdkpKVkZug4JVjtsKmkABEdDcqVBpH
	 Oa/sZpU6nVMrqQYascTPQpIsRwJNErFuWJkZK49hwMrNrhy7nIymoCOl30X57+ADbyyX/
	 HE4EWXtBIZYgPpLvx6iqBwty5QNi8UeDaPpypmBtreiYJfOEDvBZpHQwdeL5GoaNGhxnc
	 B2Y3h3KtfUi7dIUhiU3m9uowj8IOULW3jvQezfMuN62JUtssbE9FrYMUCUfr1T18WBi12
	 lAQXs0ZnzVG1h/zjRQJTTYuIVqmfoZKN5z+RrJ530hhypPR+w5ZVXZuHOL51iQwtWjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Caam6whC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CDD606A31C
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Caam6whC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1E21F0089F;
	Tue, 10 Nov 2026 02:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794277498;
	bh=P9rsFkVvrQ9w45lKk2xSO3E8CvYzW07tLofVK2X0mBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Caam6whC1zZyrVLvPmCixm5w+rwvTR+RZterLB5K0nSBP7bKd8HamqHeOAxLigB4Q
	 nQUj9/9N8FT2tLvDTElFb/S0PYSPLBQFLIRBoMJwyKVY2xZ+GjkV+hiiFpuwPX7q72
	 Sdm9Ua1fVjCZrn4IdZ0zeQkokyFV8GAa/KDJdzLYgxb2HPqVdkv0iWypH9l/KbBCpQ
	 q6p4mXkWgTrkp2vYCDKtAGURxsCRbqF5+361n36aPazuOwjPk2VZ3U6tkNLKBvXwS+
	 uu5Pb9LfYupB+7/xGg7dsFNmXtQ8hXM2oD8xXtuFWA0FX1NFCKmfI6PbBC3gHk/QKr
	 hDDaKRZ8HoYNw==
Message-ID: <sashiko-outbox-206043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 01/18] HID: asus: size feature reports from the HID
 report descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261110020036.112884-2-denis.benato@linux.dev>
References: <20261110020036.112884-1-denis.benato@linux.dev>
 <20261110020036.112884-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 02:24:58 +0000
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

commit 9e7f37337641ebe55d63a9fed78173afda17f344
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
Should asus_has_report_id() only check HID_FEATURE_REPORT?

Every caller of asus_has_report_id() gates feature-report operations that
now require asus_report_len() to find a HID_FEATURE_REPORT.  On devices
such as the ROG G752 keyboard (QUIRK_G752_KEYBOARD) that declare report
0x5a only as an input report, asus_initialize_reports() sees
asus_has_report_id(hdev, 0x5a) return true, calls asus_kbd_init(), and
hits the !hw_len check, failing with -EINVAL and logging a warning on
probe and reset_resume.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110020036.1128=
84-1-denis.benato@linux.dev?part=3D1
