Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A03C09FF
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075556; cv=none; b=K2wL3ncDwHeF37jQsAGSf+x5MS8EoqLW2UX0XPUVpF71G68ZFYJB1apxzhHZlaChuxFlUrqV3ydSuO862z8YPfA5A2TsphI+m1CU3hVwMHp8Ed9MDu3lYm+sAy0z/S4RB4aGDlqVgpWD+ld8zIT02pvo8i0Bb3oMDfsDaSDvHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075556; c=relaxed/simple;
	bh=um7PxCksgLYby9xEiL1tyRMeKAn6xq7slNLh7sO53d0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YWuKDlaZ61FQXqvKm5fipeKYAr+yfzvQF3N1F/7+FhBqUeefGeIn2ZBNjRINBone45JjGZ9uCe+WjV3pIxlRKLsrW+QxLfpNjd1k7y+Nct8qSLLVUiq1YKVt0yVz0Y5ZGX2Rxxcq6kJQnP+NzCLy9Cr6icqyAJt03aT+eHyj5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+vUIiPt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+vUIiPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC361F000C4;
	Thu, 15 Oct 2026 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792075554;
	bh=QmZ2g7yS8hss6vp15w8f20pq34rlor4ESLEyOv0g1NE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c+vUIiPtJ/l7qg6j3dBAaShS5mj6zhKqQbHWEiPZOS33PtG/QnTHau7ZyskagJsn5
	 knC3lo7U0DkMnUAmza9jKyz8SN6OAlTyT4MU+8NuoEIOdirhwSHCwClTYtQGxfkPDo
	 5EGkyJuiDhtMs8eN8qR99h9Azl9cfAch6ExwpVe7rUJtgbqYAbZzXTFx+KZdaRM2JG
	 e//jh0qqdvH6neYqRGNDd9/3Iv6nr3KNNHx+QIyjyaXuLRpIkzX1yAwIKenXE0D3Kc
	 qQXG/pkFamiTj9KEw93xnn979QR1uW8GO2A71jDhAwHkL3BeN1PBkq3Hil6OovejPb
	 QwB58DjbdaKGA==
Message-ID: <sashiko-outbox-172986@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: saitek: don't dereference a NULL hidinput in
 saitek_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nguyen Ngoc Thang" <ngocthang2710.1999@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261015143433.129525-1-ngocthang2710.1999@gmail.com>
References: <20261015143433.129525-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:45:54 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: UAF in saitek_event() due to dangling field->hidinput on init=
 failure
--

commit c05cbb2256bb191c18315a19fe3d041ae082e349
Author: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

    HID: saitek: don't dereference a NULL hidinput in saitek_event()

    hid_process_event() calls the driver's ->event() for every usage of a
    report, including fields that hidinput did not map to any input device,
    e.g. a constant input item. For those fields field->hidinput is NULL,
    and saitek_event() loads field->hidinput->input unconditionally:

Closes: https://syzkaller.appspot.com/bug?extid=3Deba2b3201bd25a97cddf

> diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
> index 6fe7c087c594e..2a9e07a4fc77f 100644
> --- a/drivers/hid/hid-saitek.c
> +++ b/drivers/hid/hid-saitek.c
> @@ -151,7 +151,12 @@ static int saitek_event(struct hid_device *hdev, str=
uct hid_field *field,
>  		struct hid_usage *usage, __s32 value)
>  {
>  	struct saitek_sc *ssc =3D hid_get_drvdata(hdev);
> -	struct input_dev *input =3D field->hidinput->input;
> +	struct input_dev *input;
> +
> +	if (!field->hidinput)
> +		return 0;
> +
> +	input =3D field->hidinput->input;

[Severity: High]
Can this still cause a use-after-free if hidinput_connect() fails during
probe?

If hidinput_connect() fails (for example, if input_register_device() fails),
it calls hidinput_disconnect() which frees the hid_input structures:

drivers/hid/hid-input.c:hidinput_disconnect() {
    ...
	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
		list_del(&hidinput->list);
		...
		kfree(hidinput);
	}
    ...
}

However, it does not clear the field->hidinput pointers in the report field=
s.

Because the Saitek driver defines a ->raw_event callback, hid_connect()
tolerates the input connection failure and returns success. The probe seque=
nce
completes successfully and the device becomes active.

When a report arrives, __hid_input_report() processes it and calls the driv=
er's
->event() callback (saitek_event). The newly added check if (!field->hidinp=
ut)
will evaluate to false because the pointer is non-NULL but dangling, leading
to a use-after-free when field->hidinput->input is dereferenced.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015143433.1295=
25-1-ngocthang2710.1999@gmail.com?part=3D1
