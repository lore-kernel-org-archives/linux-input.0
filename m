Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3936B902
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165498; cv=none; b=adkNVCuoBQexXbJyQMdwN7/NfYwrzh7NwY2tyi9pzPENHJ0X5Fa/pO/ns/J5HluRcKG6e18Cxq9fM4My6bkrkycd4x3gNOJDewlU1F3WgyWvzw2m2BECLMZx06wUzWdU7ugfrLvgBxzw34WjFFPje7eggYDHHwER6q8GyMXftGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165498; c=relaxed/simple;
	bh=Q4cXKA9KJvp9Cw0tw+VHZvBjtKLK8yFG6JdQehX77Xo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L0Vq3IhPANDaXa6rEaozNPMupcUESszpXHGoxUGE43pK/EzsNRqQUx+kfyYtO1luQdfuiQ5lhFvi911ppz5LTWDUx2F90XJypsS6sO9sgNamshjc3qn2fMtrdop81dQGiTE+4BkwPb+HG9cccbTSxhdo62SilHnDFtrAXcqtFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezQm5uSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezQm5uSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2C61F00A3A;
	Mon, 27 Jul 2026 15:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785165496;
	bh=+xbmbIV4+kY0QK5fmlZiZCKHUg+UxP65xt/jc8tBlT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ezQm5uStuvKSok6miWlhJS5xDcDP1gDQRitR0Bk8v7Z5+Jid/0kb3l9rDGuO97YjR
	 K187DVM6ByVewlcAhV4gwUk0SiBQYmdbsmnx2pn7hmVogbiIjwS/o4sWzpUivQqhk9
	 TgtmLIQFmqJlNgo5Ipdtm3mwXI21Nj+u1whfOui6TDxF8oXdxAP3gE8nLEJKNl6eIx
	 U1z3jPD7TA6C9myWn2DvrZtdxwk26SL8BnzUWbdApCLsZAVxKca9XlZCcATkulgQcy
	 ruRZJ167Y2fy8nGVVepC2+W65wG+9DwDCxnOPR/hA4tdC/V6TfhBw2zSntum3ywloA
	 5qjgzBoPqI3Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] HID: wacom: do not use 'driver_data'
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGF3ZWwgWmFsZXdza2kgKFRoZSBDYXBhYmxlIEh1Yik=?= <pzalewski@thegoodpenguin.co.uk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260727-mod-devicetable-hid_device_id-v3-8-980896ca283e@thegoodpenguin.co.uk>
References: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
 <20260727-mod-devicetable-hid_device_id-v3-8-980896ca283e@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:18:15 +0000
Message-Id: <20260727151816.2A2C61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Removal of driver_data breaks dynamic device binding via sysfs=
 'new_id', preventing testing of unknown/clone devices.

Pre-existing issues:
- [High] Missing cancellation of `wacom->init_work` on the error path for w=
ireless monitors leads to a UAF.
--

--- Patch [8]: [PATCH v3 8/8] HID: wacom: do not use 'driver_data' ---
commit 147dba29dc34be167b7150ce20799c7b7dd39442
Author: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

HID: wacom: do not use 'driver_data'

This patch removes the use of driver_data for looking up product features in
the wacom driver. It instead looks up wacom_features directly by product ID
to reduce macro complexity and simplify the code.

[ ... ]

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 834519751a5cf..4514b2762cc33 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2848,7 +2845,7 @@ static int wacom_probe(struct hid_device *hdev,
> =20
>  	wacom_wac =3D &wacom->wacom_wac;
> =20
> -	const struct wacom_features *id_features =3D get_wacom_features(id->dri=
ver_data);
> +	const struct wacom_features *id_features =3D get_wacom_features(id->pro=
duct);

[Severity: Critical]
Does removing driver_data introduce a regression for dynamic device binding
via sysfs 'new_id'?

By strictly using get_wacom_features(id->product), the mechanism for inject=
ing
unknown product IDs seems rendered unusable because the injected PID won't =
match
any entry in the static wacom_features_table. Previously, couldn't users pa=
ss a
feature table index via driver_data to test unknown or clone devices?

[Severity: High]
This is a pre-existing issue, but is there a missing cancellation of=20
wacom->init_work on the error path for wireless monitors?

drivers/hid/wacom_sys.c:wacom_parse_and_register() {
    ...
	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
		error =3D hid_hw_open(hdev);
		if (error) {
			hid_err(hdev, "hw open failed\n");
			goto fail_hw_stop;
		}
	}
    ...
}

In wacom_parse_and_register(), wacom_query_tablet_data() schedules
wacom->init_work. If hid_hw_open() subsequently fails for a wireless monitor
(WACOM_DEVICETYPE_WL_MONITOR), the error path jumps to fail_hw_stop and
returns without calling cancel_delayed_work_sync(&wacom->init_work).

Because the wacom structure is managed by devres and will be freed upon pro=
be
failure, could this result in a use-after-free when init_work executes late=
r?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-mod-device=
table-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk?part=3D8
