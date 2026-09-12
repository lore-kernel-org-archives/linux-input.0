Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D8433A9FF
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183373; cv=none; b=lP8yR4S0lcyG0AXenExFc+6mWluf3cN2zJLTivk/bTUq/fOWu5pta5qptvOsJffyG6l++HP1J8jiPkxDYYZttEcMtJOoHWShOv31RYHPyKkMC/G21h1eLXGKj2sGSQXSnjT4yLvAWfqRVsqY8KM8ZKvd6u4+GhWFr+4tXQOI7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183373; c=relaxed/simple;
	bh=rrT/vS5bsOU7QFx+g3bNrosyXvELshxKznm4NfmQHSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aRFqFpmyvxGHrcCGB/V4Cih0ql0rmdJuX4N82ALmuDB90HYLmZxwQRe10QM3sB4qgtDqMZIX3Wgr3icj6uI43nMGpP0Oo9arrpBoK5/HWl5au26UDc6sciTDUsIuQf+1TgnaZd3E+yhKifNwV6b2g23XSrwry3jhkeVvW9DQsdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/noPdRy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/noPdRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEACE1F000FF;
	Sat, 12 Sep 2026 03:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183372;
	bh=4X8m4aCWH9MlQBJVEYZZ1ys3qqu6N3ZyYBnFG3t08hc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/noPdRyeZ1bC6emPYDmCFsTCvhMsHPTXgtXoReNFTsbAaPn5cHj/h1UMyMkEkpNi
	 QXuHbYVECpXQ1KmYf/j4pm8doarhwsWHYbSdex+/g7TB8QkpHUqOhniyDn8vejYb4D
	 fnNcN1kx4pXEo8wMELYbKqh0kTVgFHOth6MYSHlLUpJ3aAgSnyur++nbQ6CUIjnN3C
	 eMZqW9KOxUrB0RpNlW7ZbLw4yTAFmUOX6q0esDPxpR7pTOuzqoTsgwEepW+2GXEQwh
	 Yip+1/mOjUN5rcjB7oByvHn5ECWfzrRKKmcHfj9AWQMEkrR/7ZTYSkhWNmTqCs12h7
	 jU8zD8i7kczmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/12] Input: xpad - Remove Xbox One support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260912030426.2997003-3-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
 <20260912030426.2997003-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:22:51 +0000
Message-Id: <20260912032251.EEACE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Accumulation of leaked input_dev structures in the devres list acr=
oss logical device resets.
- [High] Race condition in gip_shutdown() where asynchronous force-feedback=
 work is cancelled before the input device is unregistered, leading to a Us=
e-After-Free.
- [Medium] gip_parse_metadata() returns success (0) instead of an error cod=
e when the metadata message is unexpectedly truncated, causing the caller t=
o accept an uninitialized metadata structure.
--

commit 3f01a3076f0a08c3208bada0c0eb3d4a4be23e2c
Author: Vicki Pfau <vi@endrift.com>

    Input: xpad - Remove Xbox One support
   =20
    It has been superseded by xbox_gip. As the new driver is already at fea=
ture
    parity, removing the fairly rough Xbox One support from xpad is safe and
    will prevent any potential conflicts.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> -static bool gip_parse_metadata(struct device *dev,
> +static int gip_parse_metadata(struct device *dev,
>  	struct gip_metadata *metadata, const uint8_t *bytes, int num_bytes)
>  {
>  	int header_size;
[ ... ]
>  	rc =3D gip_parse_device_metadata(dev, metadata, bytes, num_bytes, &offs=
et);
>  	if (rc)
>  		goto parse_err;
> =20
>  	if (offset >=3D num_bytes)
>  		goto parse_err;

[Severity: Medium]
This isn't a bug introduced by this patch, but does this error path return=
=20
success instead of an error code?

If the offset exceeds num_bytes, rc is still 0 from the preceding successful
call to gip_parse_device_metadata(). Jumping to parse_err will return 0.

Could this cause the driver to accept a zeroed-out metadata structure
if a misbehaving device sends a truncated message?

[ ... ]
>  static int gip_setup_input_device(struct gip_attachment *attachment)
>  {
>  	struct input_dev *input;
>  	int rc;
> =20
>  	if (!attachment->driver || !attachment->driver->setup_input)
>  		return -ENODEV;
> =20
>  	rcu_read_lock();
>  	input =3D rcu_dereference(attachment->input);
>  	rcu_read_unlock();
>  	if (input)
>  		return 0;
> =20
>  	input =3D devm_input_allocate_device(to_gip_device(attachment));

[Severity: High]
This is a pre-existing issue, but does this lead to a memory leak of
input_dev structures?

When the controller resets (e.g. repeatedly sending GIP_CMD_HELLO_DEVICE),
this calls input_unregister_device(), but because the device was allocated
with devm_input_allocate_device() on the parent USB interface, the memory is
intentionally deferred to devres teardown.

Since the devm reference isn't dropped, if the driver allocates a new
input_dev during re-initialization, it seems the old structures will accumu=
late
indefinitely. Could this be triggered by an untrusted USB device to
out-of-memory the host kernel?

[ ... ]
>  static void gip_shutdown(struct gip_device *gip)
>  {
>  	int i;
> =20
>  	cancel_work_sync(&gip->receive_message);
> =20
>  	for (i =3D 0; i < MAX_ATTACHMENTS; i++) {
>  		struct gip_attachment *attachment;
> =20
>  		mutex_lock(&gip->attachment_lock);
>  		attachment =3D gip->attachments[i];
>  		mutex_unlock(&gip->attachment_lock);
> =20
>  		if (!attachment)
>  			continue;
> =20
>  		cancel_delayed_work_sync(&attachment->metadata_next);
>  		cancel_delayed_work_sync(&attachment->in_fragment_timeout);
>  		cancel_work_sync(&attachment->rumble_work);
> =20
>  		guard(mutex)(&attachment->lock);
>  		gip_reset_attachment(attachment);

[Severity: High]
This is a pre-existing issue, but is there a use-after-free race condition
during driver unbind?

In gip_shutdown(), cancel_work_sync(&attachment->rumble_work) is called
before the input device is unregistered. If an active ff-memless background
timer fires right after this, it can invoke gip_play_effect() and re-schedu=
le
the work.

gip_shutdown() then acquires the lock and calls gip_reset_attachment(), whi=
ch
uses the non-synchronous cancel_work():

drivers/input/joystick/gip/gip-core.c:gip_reset_attachment() {
    ...
	cancel_work(&attachment->rumble_work);
    ...
}

If the re-scheduled work has already started executing, it will block on
attachment->lock (held by gip_shutdown). Once gip_shutdown() unregisters the
device and the attachment is freed by devres, the blocked work would resume
and access freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912030426.2997=
003-1-vi@endrift.com?part=3D2
