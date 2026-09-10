Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076B33BBAF
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022627; cv=none; b=bY1LkaqHC48nEm47exah9rsM3iVn/2+xl/X4yJWiWSFkKCwgsp1kGxxSw+0903Qte8PKQFjXXejNLAvBkjsLMSrOP55f4TXOFOU0Yg67lInTj0X0UGV7HL95ypWYKuhXOQpojWEQGgsVdhIti2v/ietRjf1KbU/MvPs3bVt1ZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022627; c=relaxed/simple;
	bh=9MskohUVQC1zeQ1oKq6fSTuYE04vkbNG2zPffiH9beA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XXx5eFYx076wQs4pxBRJrBwu96oFXO2ISMh3qF3omderwIYGFGOGcg4DfQHQ47nSNMUo6Z2h3l3tybHSlL8HuvDLLi839xaZwHlO4Ck+37gYjNuJWiRx0KQEi1hUvMlf5RBgTObjiwFDUkBwKGZgChvS73T8O/sPDXgqA+OH/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWDIxwqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWDIxwqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF1E1F000FF;
	Thu, 10 Sep 2026 06:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789022625;
	bh=g6J2ZopFEA2loJjS+YUofaWIhvJ2gBQ/d3oGccq7UM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWDIxwqhocqKcKffCW0seQpotBm80vUL0cuqlv+fwZWq2lhzbYPbUGYtEroP/B3Iz
	 oiX9QovIYyA/HbVoUB9oepJMAu4PfHP0L5baYJsRR18YXVquqwsceDStemsLc+VbDj
	 8NgTMR/kPOeXSoq9BVjliUcDMACo7P7kfShjv0wTKiwddB9wZfVf4EqqYB+aggZv7d
	 lbGscQAhVt3RJma40x/nCNxAQUq6uOp0/fjD4QuGwtRKAfafHB5PeIlfiWW9X8SMmU
	 1/2QTju5tCcNuA2PHCcFvMFN21Ga1RDKAL2DUWmoWMvSQ3usKk2VGxA8XxxByW3UR4
	 01Pt1TX9BlXKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] HID: lenovo: suppress phantom radio control
 input on Yoga Slim 7x Gen 11
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oleg Keri" <okerixx@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260910063051.4556-3-okerixx@gmail.com>
References: <20260910063051.4556-1-okerixx@gmail.com>
 <20260910063051.4556-3-okerixx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 06:43:45 +0000
Message-Id: <20260910064345.9BF1E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting: `lenovo_remove()` incorrectly cancels asynchronous wo=
rk before stopping the hardware, which can cause a Use-After-Free.
- [High] Preexisting: In `lenovo_probe_tpkbd()`, sysfs attributes are regis=
tered and exposed to userspace before the required private driver data is a=
llocated.
--

commit 5bdafd669d3015385ef2a78a1df43a3a45427c70
Author: Oleg Keri <okerixx@gmail.com>

HID: lenovo: suppress phantom radio control input on Yoga Slim 7x Gen 11

This commit suppresses a phantom radio control input on the Yoga Slim 7x
Gen 11 by mapping the Wireless Radio Controls application collection to
nothing, avoiding an unnecessary KEY_RFKILL source.

> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 3976d7b53b14b..617bba6626592 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does lenovo_remove()
incorrectly cancel asynchronous work before stopping the hardware,
risking a use-after-free?

In lenovo_remove(), lenovo_remove_tp10ubkbd() is called before
hid_hw_stop():

drivers/hid/hid-lenovo.c:lenovo_remove() {
    ...
		lenovo_remove_tp10ubkbd(hdev);
		break;
	}

	hid_hw_stop(hdev);
    ...
}

This means hardware interrupts are still active when the work is cancelled:

drivers/hid/hid-lenovo.c:lenovo_remove_tp10ubkbd() {
    ...
	cancel_work_sync(&data->fn_lock_sync_work);
    ...
}

If an event like KEY_FN_ESC triggers lenovo_event_tp10ubkbd() in this windo=
w,
it will re-queue the work:

drivers/hid/hid-lenovo.c:lenovo_event_tp10ubkbd() {
    ...
		schedule_work(&data->fn_lock_sync_work);
    ...
}

Devres subsequently frees the data structure when remove() exits.
Will the re-queued work then run and access the freed data structure?


[Severity: High]
This is a pre-existing issue, but does lenovo_probe_tpkbd() expose sysfs
attributes before allocating required private driver data?

In lenovo_probe_tpkbd(), sysfs_create_group() exposes attributes like
sensitivity to userspace before driver data is allocated:

drivers/hid/hid-lenovo.c:lenovo_probe_tpkbd() {
    ...
	ret =3D sysfs_create_group(&hdev->dev.kobj, &lenovo_attr_group_tpkbd);
	if (ret)
		hid_warn(hdev, "Could not create sysfs group: %d\n", ret);

	data_pointer =3D devm_kzalloc(&hdev->dev,
				    sizeof(struct lenovo_drvdata),
				    GFP_KERNEL);
	if (data_pointer =3D=3D NULL) {
    ...
}

If userspace reads a sysfs file immediately after it appears, the read
callback will blindly dereference a NULL pointer:

drivers/hid/hid-lenovo.c:attr_sensitivity_show_tpkbd() {
    ...
	struct hid_device *hdev =3D to_hid_device(dev);
	struct lenovo_drvdata *data_pointer =3D hid_get_drvdata(hdev);

	return sysfs_emit(buf, "%u\n", data_pointer->sensitivity);
}

Can this lead to a NULL pointer dereference if the files are accessed
during device probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910063051.4556=
-1-okerixx@gmail.com?part=3D2
