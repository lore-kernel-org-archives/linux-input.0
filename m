Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087333A9E1
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312842; cv=none; b=Nq8y+c+4+eBD4zJVCROLPR2J2rPp7kFHwEQjpgAVCfZgJMTCpvQUxFn2iEaDjt2oafSOPkUI3FM5Mf4/9c8jlGpXdmUF/abH72RgtZircmwJlMyY9X8dsL0zPKBI4BBmyRWV9VdUuyxypTDo9S6W0SUVFrWNIv6LiKDUGuS2MP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312842; c=relaxed/simple;
	bh=h6n35aCTmpytn2EpiFI0V0BS93BRg028tcOgUDK/LV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HKPjFpvrynp2DvRzkh26B4Rio8EjkGa3wWtQIGeRKgtSeuD/513YG0Zd7U/fAGhCdFxxMumwXsaG//srUH5wThFsp9jpXioTZMET2nVXSygaCMPCYrWNG9Zm7B72EUKrpfbD2WW9L5E4WHoihGpjq0g8iRp69Pf48cqpF/fyIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwTqX8Gf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwTqX8Gf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3131F000E9;
	Wed,  2 Sep 2026 01:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788312839;
	bh=SSMOhCh3jGccAkuo/WTiNboyNTBq4tTQRwoUfz/ZboM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nwTqX8GfnYEZpIsS/BtvVXE+31vRdaYGWQvqbG7s71ogP6NqHhsMoFuJ6QhEuX+vH
	 nvTioClAAlxBMshxVcrWXXSJXdM+55VEaDGabFBxIs/eMGCGZdQm1C0NY2A7IfI0D+
	 Xl2NM/LCA+HxKXAJd8qOBGSWmmTj8G/QcUdG2IBGmci7wCDHGWK3d4+IQ2NPM1SxyB
	 x0kVkoQ3qreVmJ42GqdOldX7ss0dOu6hh9ODsAhIycBypoxPtlko9C+a1pegDBd09L
	 uKxbCyGwwX5PL+SULjSamNAd38IQl0GJBMpc0b+caE7DtL2ly++UtsD6jNcxEoll+1
	 oSlgNvPi60lvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/12] Input: xbox_gip - Add wheel support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260902010237.865772-13-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
 <20260902010237.865772-13-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:33:58 +0000
Message-Id: <20260902013359.2B3131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Improper wrap-around calculation for REL_DIAL in TrueForce wheel=
 driver.
- [Medium] Packet length validation happens after partial event reporting, =
causing input event desync on short packets.

Pre-existing issues:
- [Critical] Workqueues are synchronously cancelled before killing URBs in =
gip_disconnect, causing a Use-After-Free.
--

commit f290772c9ca66efd1e7d5ec4dd73e7af098deefd
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add wheel support

This adds preliminary support for racing wheel support in xbox_gip,
exposing them mapped to the newly added axes.

> diff --git a/drivers/input/joystick/gip/gip-wheel.c b/drivers/input/joyst=
ick/gip/gip-wheel.c
> new file mode 100644
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
Does this cause input events to be desynced on short packets?

If a short packet arrives (between 2 and 16 bytes), the base navigation han=
dler
above successfully processes the first bytes and queues events. The length
check here then fails and returns -EINVAL, which causes an early exit before
the core can call input_sync().

This could leave the device in an inconsistent state with phantom inputs or
stuck keys until the next valid packet arrives.

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
Similarly, does this early return skip input synchronization for short pack=
ets?

Like the base wheel handler, events are queued by
gip_driver_wheel.handle_input_report() before this check fails.

[ ... ]
> +	if (dial =3D=3D 0 && state->dial =3D=3D 7)
> +		input_report_rel(input, REL_DIAL, -1);
> +	else if (dial =3D=3D 7 && state->dial =3D=3D 0)
> +		input_report_rel(input, REL_DIAL, 1);
> +	else
> +		input_report_rel(input, REL_DIAL,
> +			state->dial - dial);
> +	state->dial =3D dial;
> +
> +	return 0;
> +}

[Severity: Medium]
Can this calculation magnify offsets if the dial is turned quickly?

If the wheel's dial is turned fast enough to jump multiple steps between USB
reports (e.g., from 6 to 0, crossing the boundary), this falls through the
1-step boundary checks.

The fallback calculation of state->dial - dial would then result in a
reported offset of 6 (6 - 0) instead of the actual -2 steps taken.

As a quick aside, I noticed a separate issue in the core code while reviewi=
ng:

[Severity: Critical]
This is a pre-existing issue, but does gip_disconnect() have a Use-After-Fr=
ee
race window during device unbind?

drivers/input/joystick/gip/gip-core.c:gip_disconnect() {
    ...
    gip_shutdown(gip);
    usb_kill_urb(gip->data.urb_in);
    ...
}

Since workqueues are synchronously cancelled in gip_shutdown() before calli=
ng
usb_kill_urb(), if an URB completes in that window, its completion handler
can reschedule the work on memory that is actively being torn down.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902010237.8657=
72-1-vi@endrift.com?part=3D12
