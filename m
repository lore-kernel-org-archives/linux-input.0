Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8AC4B0493
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786217529; cv=none; b=DIliJ/GVBgaRh7lesB9S0Sh+svHqxYkpyzv6Utltnwk/WF5fgxk5UEq3+K4HE5yBi00apPxy57eHyMAxceOMQAv7rDkKK/FO4q0xDuFcn/sXGwDVF65mlLhMdsD69uqJbIuR7qpGsIizs1D0/hz79c1D910nrKAPAyevwdxhObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786217529; c=relaxed/simple;
	bh=Rsq5oBI8VyslqetnsX8au16AuGmY5nC5NTdsNwYLGpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NdnvHf/3iTUFTuJGtnEbACASp7grEmmszi0UItQuReDtvOhMMKrHwHppDg5Zi7GfS0OpoTglqExxBhHnbMWheDaSkHywvfPVQHlLSLRwew9fukTFIBLLZdvsQhudxTWs21o6o2dh94O5+QBmCOD9agxYutPRtn8VgdZEFvrfgBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYWIyGQV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYWIyGQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615CD1F000E9;
	Sat,  8 Aug 2026 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786217527;
	bh=+tLkYiS7vGVdwC3qqIxj8cmCOffIJIPqhWtorcBM3kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MYWIyGQVgHPGPiOmOR/1x3bImAV5c/Br5mbK6XI7+xlQhJk4htndCdpVNlRgpPC+9
	 +OXZIvNCT9uhsNLU37c8K3jd3TWXfMkdOBw4+vDR5wG1ZaMWTYm9HsDKfJoM4fj8Pr
	 QjcXtn5cezz2lE2JnhEZ8UnQi5fkn8rIuEbtclQvjIkkoP/dF+v4qJwTU6L21QRlA5
	 FK4Cw2sj1mRb9EvwfLswqBu3007tSQfr0ZkOwJaG1PTKBVu0N2IJXZFNDBpoMYAFXf
	 O2KfDpLqu4/nT9DP+9qoVug6A3K0VXbxBn0sNMtIyqUm6DFu3BahWpWr6EwbfF2kBD
	 LyyMxgzBBKeiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: haptic: don't write an uninitialized value to
 unhandled usages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260808190417.87415-1-kmehltretter@gmail.com>
References: <20260808190417.87415-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 19:32:06 +0000
Message-Id: <20260808193207.615CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a Use-A=
fter-Free of work_struct when destroying the haptic device.
- [High] This problem wasn't introduced by this patch, but there is an unba=
lanced put_device() and module_put() in the initialization error path.
- [High] This problem wasn't introduced by this patch, but there is a probe=
 crash (Null Pointer Dereference) in `hid_haptic_init()` when a device omit=
s `HID_HP_AUTOTRIGGER`.
--

--- Patch [1]: [PATCH] HID: haptic: don't write an uninitialized value to u=
nhandled usages ---
commit 969510b84661436472ff272c9047594db1487c3c
Author: Karl Mehltretter <kmehltretter@gmail.com>

    HID: haptic: don't write an uninitialized value to unhandled usages

    fill_effect_buf() initializes value only for the four haptic usages
    handled by its switch, but writes it to field->value[] for every usage.
    An unhandled usage can therefore receive either an uninitialized value
    or one left over from the previous usage. hid_output_report() then
    serializes that value into the effect's report buffer.

> diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> index deadab28cdbef..66d90f0f78a3b 100644
> --- a/drivers/hid/hid-haptic.c
> +++ b/drivers/hid/hid-haptic.c
> @@ -187,7 +187,7 @@ static void fill_effect_buf(struct hid_haptic_device =
*haptic,
>  				value =3D waveform_ordinal;
>  				break;
>  			default:
> -				break;
> +				continue;
>  			}
> =20
>  			field->value[j] =3D value;

[Severity: High]
This problem wasn't introduced by this patch, but there is a Use-After-Free
of work_struct when destroying the haptic device.

drivers/hid/hid-haptic.c:hid_haptic_destroy() {
...
	if (haptic->effect) {
		for (r =3D 0; r < ff->max_effects; r++)
			kfree(haptic->effect[r].report_buf);
		kfree(haptic->effect);
	}
	haptic->effect =3D NULL;

	destroy_workqueue(haptic->wq);
...

Will destroy_workqueue() attempt to drain the queue and access pending work
items that reside inside the dynamically allocated haptic->effect, which was
just freed by kfree()?


[Severity: High]
This problem wasn't introduced by this patch, but there is an unbalanced
put_device() and module_put() in the initialization error path.

drivers/hid/hid-haptic.c:hid_haptic_init() {
...
	if (!try_module_get(THIS_MODULE)) {
		dev_err(&hdev->dev, "Failed to increase module count.\n");
		goto input_free;
	}
	if (!get_device(&hdev->dev)) {
		dev_err(&hdev->dev, "Failed to get hdev device.\n");
		module_put(THIS_MODULE);
		goto input_free;
	}
...

Does jumping to input_free invoke input_ff_destroy(), which then
unconditionally triggers hid_haptic_destroy()?

drivers/hid/hid-haptic.c:hid_haptic_destroy() {
...
	if (hdev)
		put_device(&hdev->dev);
...
	module_put(THIS_MODULE);
...

Will this unconditionally call put_device() and module_put() despite failing
to acquire them, causing reference count underflows?


[Severity: High]
This problem wasn't introduced by this patch, but there is a probe crash
(Null Pointer Dereference) in hid_haptic_init() when a device omits
HID_HP_AUTOTRIGGER.

If a malicious HID device advertises a Windows 8 Multitouch class and
includes a HID_DG_TIPPRESSURE field with force units, it appears
td->is_haptic_touchpad will be set to true.

drivers/hid/hid-multitouch.c:mt_input_configured() {
...
	if (td->is_haptic_touchpad && (td->mtclass.name =3D=3D MT_CLS_WIN_8 ||
	    td->mtclass.name =3D=3D MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
	    td->mtclass.name =3D=3D MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
		if (hid_haptic_input_configured(hdev, td->haptic, hi) =3D=3D 0)
			td->is_haptic_touchpad =3D false;
	} else {
...

Does mt_input_configured() leave is_haptic_touchpad set to true if
hid_haptic_input_configured() returns -1?

If this is bypassed, and mt_probe() subsequently calls hid_haptic_init():

drivers/hid/hid-haptic.c:hid_haptic_init() {
...
	mutex_init(&haptic->auto_trigger_mutex);
	for (r =3D 0; r < haptic->auto_trigger_report->maxfield; r++)
		parse_auto_trigger_field(haptic, haptic->auto_trigger_report->field[r]);
...

Will haptic->auto_trigger_report be NULL and cause an immediate kernel panic
when dereferenced if the device omitted HID_HP_AUTOTRIGGER?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808190417.8741=
5-1-kmehltretter@gmail.com?part=3D1
