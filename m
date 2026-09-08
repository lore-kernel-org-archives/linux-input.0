Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2C32B131
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839763; cv=none; b=nwzK67L6i94spvGUc5v4DW7CV7N7w24bFUViMbSZfJyBCKz95fSqDpBxak1wrXkF6/O5LN7g3z2QZszzQdB6gNEUDC87VSdbNt3A93ADoV0RlfXvPQSVjRCg+qYTbBwOKQK0SeYtiQe9vkKtUL99il6qw7E3Q1a2n9tkL/M0WBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839763; c=relaxed/simple;
	bh=sdIJaLSbjQYtpKc+3aSXSq05fQxpTCsIyUTfvDkWpuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qd6EY8oOGypbJLz+WSJddjd3Uf11f7rxNWAme5aWyJbQ0hdlxbRR7GMmZuOWndtng5evRW56CSys/xTl2qJLb8OD86H/MwQgHOl42urdfyJ8qCUcrYlSMTQa4ytxAXGoqWtclYMjQObORmft7QmQFUAyj0F/62PBMF+CFPc5i+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwB2Kdf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwB2Kdf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9B11F00A3F;
	Tue,  8 Sep 2026 03:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788839753;
	bh=2YobF9GubG1xvVPSo9JLnPNePf4K3bDH5zDgHd2MCV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bwB2Kdf6c5RoV7Ein3rLS9JSbDVkQ3Nk3MAwVFh0eLb9ycxvKixLcHeCZxq0G2foR
	 vRcjZmiUj85lUpYmddb6hsy54dZOI3iPF3Z9pi4u7fGkwzDH1wGgG8KBtW4/C2NM5G
	 jYnyth9GCPfmqhkfBxspv+e9HJGbkEDLX0mc9EOkcmRREzSYwMlGlnzIwpoTSzNG4c
	 f7ts85zCD6A+yY9TyJVL8S7BqgH9OT9IZqM+Bxr6t3/Wlkci2bfB+2Psp0jwmpvvpR
	 fQdDd5FtuY8uNzr8wHa/Imizd6Q0/jicAs++YtrZKMxeW+wwez/qKUAMmAZR6eASz3
	 6kuFDh8DYCh/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/12] Input: xbox_gip - Add wheel support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908032145.2118234-13-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
 <20260908032145.2118234-13-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 03:55:52 +0000
Message-Id: <20260908035553.0A9B11F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Late packet length validation causes input state desynchronizati=
on.
- [Medium] Incorrect wraparound delta calculation for the REL_DIAL axis whe=
n multiple steps occur.
- [Medium] Phantom REL_DIAL scroll event upon device initialization.

Pre-existing issues:
- [High] Out-of-order teardown in `gip_disconnect` allows URB completion ha=
ndler to trigger use-after-free of gip_device.
--

commit 4a4f1a60a6109caec93af3211950c865f6e16e58
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add wheel support

This adds preliminary support for racing wheel support in xbox_gip,
exposing them mapped to the newly added axes.

> diff --git a/drivers/input/joystick/gip/gip-wheel.c b/drivers/input/joyst=
ick/gip/gip-wheel.c
> new file mode 100644
> index 0000000000000..5de455edff3c1
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-wheel.c
[ ... ]
> +static int gip_handle_wheel_report(struct gip_attachment *attachment,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{
> +	uint8_t connections;
> +	struct gip_wheel_info *info =3D attachment->driver_data;
> +	int rc =3D gip_driver_navigation.handle_input_report(attachment, input,=
 bytes, num_bytes);
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	if (!info)
> +		return -ENODEV;
> +
> +	if (num_bytes < 17)
> +		return -EINVAL;

[Severity: Medium]
Will returning -EINVAL here trap events that were already queued?

If a device sends a fragmented or short report (e.g. 16 bytes),
gip_driver_navigation.handle_input_report() will process the first bytes and
queue events.

By returning -EINVAL after this, the error propagates and bypasses the
input_sync() call in the core loop, leaving the queued events
unsynchronized in the input subsystem buffer and potentially causing
stuck keys.

[ ... ]
> +static int gip_handle_trueforce_wheel_report(struct gip_attachment *atta=
chment,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{
> +	int rc =3D gip_driver_wheel.handle_input_report(attachment, input, byte=
s, num_bytes);
> +	struct gip_trueforce_wheel_state *state =3D attachment->driver_data;
> +	int dial;
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	if (num_bytes < 18)
> +		return -EINVAL;

[Severity: Medium]
Can this similarly trap events reported by the base wheel handler?

Events are reported by gip_driver_wheel.handle_input_report() before the
TrueForce-specific size validation rejects the packet. This will also bypass
input_sync().

[ ... ]
> +	input_report_key(input, KEY_KPENTER, bytes[17] & BIT(4));
> +	/* Dial states only change one at a time, so we can easily check for wr=
aparound */
> +	if (dial =3D=3D 0 && state->dial =3D=3D 7)
> +		input_report_rel(input, REL_DIAL, -1);
> +	else if (dial =3D=3D 7 && state->dial =3D=3D 0)
> +		input_report_rel(input, REL_DIAL, 1);
> +	else
> +		input_report_rel(input, REL_DIAL,
> +			state->dial - dial);

[Severity: Medium]
Is it possible for this calculation to compute an incorrect wraparound delta
if multiple steps occur between reports?

If a user quickly scrolls the TrueForce dial, the step might jump by 2 or m=
ore
across the 0/7 boundary (e.g. from 7 to 1).

The explicit edge case checks would fail, and the fallback logic would comp=
ute
state->dial - dial (7 - 1 =3D 6), incorrectly reporting a delta of +6 inste=
ad of
the correct logical step of -2.

[Severity: Medium]
Could this logic emit a phantom REL_DIAL scroll event when the device is
initialized?

When the driver first allocates gip_trueforce_wheel_state, kzalloc zeroes
state->dial.

If the physical wheel dial is at a non-zero position (e.g. 4) when normal
reporting begins, the handler computes 0 - 4 =3D -4 and immediately emits a
scroll event before the user even touches the wheel.

[ ... ]

This is a pre-existing issue, but I noticed a potential problem in
gip_disconnect() within drivers/input/joystick/gip/gip-core.c:

[Severity: High]
Does cancelling the work before killing the URB allow the URB completion
handler to schedule new work that outlives the device?

drivers/input/joystick/gip/gip-core.c:gip_disconnect() {
	...
	gip_shutdown(gip);

	usb_kill_urb(gip->data.urb_in);
	...
}

If the URB is still active and a packet arrives just after gip_shutdown()
cancels the device->receive_message work struct, the URB completion handler
can call schedule_work() again.

When gip_disconnect() completes and frees the gip structure, the system
workqueue could execute the corrupted workqueue item and trigger a
use-after-free kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908032145.2118=
234-1-vi@endrift.com?part=3D12
