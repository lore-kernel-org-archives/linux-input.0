Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B093515FA
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678565; cv=none; b=GQIwCJlWPDF8qPoADoAvPbpLKv6y/TfIIf4rYH4ljxbQZE8ZrPu/wjCTHfO9hN0Aft5xgpMLceeMyZweHCH/jX0wDIo5BwE1E0oBcpGr03JH2Wh34q55hAZIXCs5IO3gAC+UZjd2hhCbg2CjZi2ekrmfQy+k6gO68aHFHOFyk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678565; c=relaxed/simple;
	bh=a+VYOgsuJZ4dBsf+IIU9Gn/ajB9NIrRW5qbqvTr1Zhg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V9bdMLZ7+kfxXvqx1/jmILo7fkumQ6vAbgTxsut4efPygepwj1mNhsyiad8brvJM0TIQxUZ/DzRJj8SAvHPVLpMpM6D6o9+z3UoWG7tDzeFGqW3WqBkQxTqAdpAiyMMhmnAzeGf8N5SZhEHjOe3Ux4vmOb2mNHDSenun4liqDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6z54IvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6z54IvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AD91F000E9;
	Tue, 25 Aug 2026 17:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787678564;
	bh=Osr4yd+jfUEXobCG6ToFIRMbWFCTsgb3LALyjdPyqwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O6z54IvCaNh/eil1WrSxGo0DVJYIxWlQIbIfwD2ceGM8LTcsuh3k3RZl872UVkmvY
	 WHSHcoO2qLzYtz9bBZqB5jw8aTSRxOCvrzpVlqvNs//yZKhl/R/OwXIvcWGv06LsP7
	 /GCewJ7PoHzg0Xt+qv4KG0Hfxf+vuik+nLXat82AV+ZT+rn0/EXAJl0MZy8KoWoUmw
	 gUINl47IU65vvGq/RXcq046IhIAyiQpc7PpPwqNx8TZGU/p3UiEeshWcOE8/IK+Z2f
	 O6YTPZXRcUMBx5IuUZVPWWNT8yz3wYcfq462jACYg7RYHSKpJoK/7VE8va7CKM9AVN
	 U5LPdrW4eDeng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260825151242.576456-4-lee@kernel.org>
References: <20260825151242.576456-1-lee@kernel.org>
 <20260825151242.576456-4-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 17:22:43 +0000
Message-Id: <20260825172244.39AD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `shared->pen` and `shared->touch` in `wacom_mod=
e_change_work` without RCU read lock leads to Use-After-Free.
- [High] Asynchronous resources started during probe are not cancelled if a=
 subsequent probe step fails.
--

commit cf6bbd224806057956b357da6af1b313f006731c
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
   =20
This patch resolves a use-after-free issue in wacom_bamboo_pad_pen_event
by introducing RCU protection for the pen and touch pointers.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index b88726cbbb4ec..79fd397e044af 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
[ ... ]
> @@ -2836,16 +2847,19 @@ static void wacom_mode_change_work(struct work_st=
ruct *work)
>  	bool is_direct =3D wacom->wacom_wac.is_direct_mode;
>  	int error =3D 0;
> =20
> -	if (shared->pen) {
> -		wacom1 =3D hid_get_drvdata(shared->pen);
> +	struct hid_device *pen =3D rcu_access_pointer(shared->pen);
> +	struct hid_device *touch =3D rcu_access_pointer(shared->touch);
> +
> +	if (pen) {
> +		wacom1 =3D hid_get_drvdata(pen);
>  		wacom_release_resources(wacom1);
>  		hid_hw_stop(wacom1->hdev);

[Severity: High]
This is a pre-existing issue, but does using rcu_access_pointer() here leave
the pointer unprotected?

The rcu_access_pointer() helper doesn't establish an RCU read-side critical
section. This means a concurrent removal of the sibling device could call
wacom_remove_shared_data() and nullify the shared pointer.

If the pointer is nullified, synchronize_rcu() won't wait for this work item
to finish.

Could this sequence allow the device and its driver data to be freed while
we're still executing hid_hw_stop() on it, resulting in a use-after-free?

>  		wacom1->wacom_wac.has_mode_change =3D true;
>  		wacom1->wacom_wac.is_direct_mode =3D is_direct;
>  	}
[ ... ]

Also, regarding a pre-existing issue in wacom_parse_and_register() not modi=
fied
by this patch:

[Severity: High]
This isn't a bug introduced by this patch, but does the error path here fai=
l to
cancel asynchronous works?

When an initialization step fails after hid_hw_start(hdev) is called,
the cleanup goes to fail_hw_stop:

fail_hw_stop:
	hid_hw_stop(hdev);
fail:
	wacom_release_resources(wacom);
	return error;

The call to hid_hw_start() enables interrupts, which could schedule work it=
ems
like wacom->battery_work, wacom->wireless_work, or wacom->mode_change_work.

Does failing to cancel these scheduled works before returning allow them to
execute after devres has freed the wacom structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825151242.5764=
56-1-lee@kernel.org?part=3D4
