Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA5492E23
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908299; cv=none; b=mVZ56W2AJ23dfE0IH7ubGmsb5LSASG/NCEmA3BIb0gNJuLOOtcYx9F0jMd/c6zDF+TcaDQOjU3i3eZQ4sZnvgrAHvpH2DkkQER3Be11wd/PmIgyuIBF9FIVn/Q2GErqXZSji1PI8bzoQgRch5pSmQ1UKxpIj1X72NOT9ZAZRi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908299; c=relaxed/simple;
	bh=Fey99ecfNOMqijtao9trvI8iznBabLnmWcEc0XQbJ2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mM79rPmmW9i2bCys9B1GWRe/MwgUxM980NpwBxfk5EikIRDP26Goyt67zPVfwz5VBSgNTn6fcN8kSEdGti9aN9D6fSEOc5axijIm5E2VNraV4HaMb18Bpm7lIMYCtm6mVhe4mbJFc9Z75sNzUPhjzXsRzwIrTY1bqVxWuBg0SR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvVbp/Qb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvVbp/Qb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952CE1F00A3A;
	Tue,  8 Sep 2026 22:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908295;
	bh=koU8JR20w27IGji2J2H62pImRw4a3Om7xFLAx3M+a4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LvVbp/QbRoLP/EaQdNpdd7vtTVK5n7isnGIgao8lTHWv2yQC69LNMdV4Y7U1DMNny
	 60Mc+krnFVkjEyi3u+wacGhavcJAo2ZTCRcP3dbetNoQoJvWsJ8YNiGjJXSEGWWFfF
	 uVw7C3yaAMg2MSkis+Yv5w56ukKmUDcKwmHS24cmbAKUNrCLGStNpZY4LD6gT1RrLh
	 fA/IMPr9EnuVvyBh5Vz81BrYlAn0t/nOQTT2yL2QrBSlaCXUIa4Yj+07o47wEUqGXP
	 mCtxVT1uFEVYxZy3RHqMkqWqAq7pLOr2Qhfgxzgo8pO1+5nifqdCFHJ3rKgACyqwh/
	 tsEf5aY2JmRCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: nintendo: relax subcommand limiter until cadence
 is proven
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260908224532.114357-1-mike@fireburn.co.uk>
References: <20260908224532.114357-1-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:58:15 +0000
Message-Id: <20260908225815.952CE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Concurrent unsynchronized access to `subcmd_rate_exhaustions` and =
`subcmd_rate_relaxed` permanently breaks the rate limiter fallback mechanis=
m.
- [Medium] USB controllers permanently bypass the transition to the strict =
rate limiter due to an unconditional override of `consecutive_valid_report_=
deltas`.

Pre-existing issues:
- [High] Probe error paths fail to set `ctlr_state` to `REMOVED`, leading t=
o unsafe I/O on stopped hardware during workqueue flush.
--

commit 4cc815d1cbd63a9a8e0cd2d3dbc8b1bf1a713dfe
Author: Mike Lothian <mike@fireburn.co.uk>

HID: nintendo: relax subcommand limiter until cadence is proven

This commit modifies the initialization of the nintendo HID driver to
start each connection on the legacy flat-delay throttle instead of the
cadence-gated one. It transitions controllers to the strict limiter once
they demonstrate a valid reporting cadence, preventing warnings caused by
early rumble packets being sent before cadence is established.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 43e0f2aaea3b5..0a169d0aa7195 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -1797,8 +1797,12 @@ static void joycon_parse_report(struct joycon_ctlr=
 *ctlr,
>  	 */
>  	if (report_delta_ms >=3D JC_INPUT_REPORT_MIN_DELTA &&
>  	    report_delta_ms <=3D JC_INPUT_REPORT_MAX_DELTA) {
> -		if (ctlr->consecutive_valid_report_deltas < JC_SUBCMD_VALID_DELTA_REQ)
> +		if (ctlr->consecutive_valid_report_deltas < JC_SUBCMD_VALID_DELTA_REQ)=
 {
>  			ctlr->consecutive_valid_report_deltas++;

[Severity: Medium]
Will this permanently bypass the transition to the strict rate limiter for
USB controllers?

For USB devices, a preexisting block at the end of joycon_parse_report()
unconditionally forces consecutive_valid_report_deltas to
JC_SUBCMD_VALID_DELTA_REQ (which is 3).

On all subsequent input reports, the delta count is already 3, causing the
if check above to fail. The logic that sets subcmd_rate_relaxed to false
would be entirely bypassed, leaving USB controllers stuck on the legacy
flat-delay rate limiter.

> +			if (ctlr->consecutive_valid_report_deltas =3D=3D JC_SUBCMD_VALID_DELT=
A_REQ &&
> +			    ctlr->subcmd_rate_exhaustions < JC_SUBCMD_RATE_MAX_FAILURES)
> +				ctlr->subcmd_rate_relaxed =3D false;

[Severity: High]
Could this result in a data race that permanently breaks the rate limiter
fallback mechanism?

joycon_enforce_subcmd_rate_strict() modifies subcmd_rate_exhaustions and
subcmd_rate_relaxed from a worker thread holding output_mutex but not
ctlr->lock:

joycon_enforce_subcmd_rate_strict() {
    ...
    if (++ctlr->subcmd_rate_exhaustions =3D=3D JC_SUBCMD_RATE_MAX_FAILURES)=
 {
        ctlr->subcmd_rate_relaxed =3D true;
    ...
}

Meanwhile, the new code here in joycon_parse_report() executes in softirq
context holding ctlr->lock but not output_mutex.

If joycon_parse_report() reads a stale value of exhaustions (e.g., 3) just
before the strict limiter increments it to the maximum (4), the softirq
evaluates the condition as true. If the softirq then writes false to
relaxed immediately after the strict limiter wrote true, the flag becomes
false while exhaustions is 4. Subsequent failures will increment exhaustions
past the maximum, meaning relaxed =3D true will never be executed again.

> +		}
>  	} else {
>  		ctlr->consecutive_valid_report_deltas =3D 0;
>  	}

[ ... ]

> @@ -2730,6 +2734,10 @@ static int nintendo_hid_probe(struct hid_device *h=
dev,
> =20
>  	ctlr->hdev =3D hdev;
>  	ctlr->ctlr_state =3D JOYCON_CTLR_STATE_INIT;
> +	/* Promoted to the strict limiter once cadence is proven, see
> +	 * joycon_parse_report().
> +	 */
> +	ctlr->subcmd_rate_relaxed =3D true;

[Severity: High]
This is a pre-existing issue, but does the probe error path fail to set
ctlr_state to JOYCON_CTLR_STATE_REMOVED, leading to unsafe I/O on stopped
hardware during the workqueue flush?

If nintendo_hid_probe() fails after hid_device_io_start() (e.g. inside
joycon_leds_create()), an incoming input report can queue the rumble worker.
The error path then calls hid_hw_stop(), tearing down the transport.

The error path subsequently calls destroy_workqueue(ctlr->rumble_queue),
which synchronously flushes and executes the queued worker:

nintendo_hid_probe() {
    ...
err_stop:
    hid_hw_stop(hdev);
err_wq:
    destroy_workqueue(ctlr->rumble_queue);
    ...
}

Because the error path never updated ctlr_state, the worker bypasses the
safety guard in joycon_send_rumble_data() and unconditionally calls
__joycon_hid_send(), invoking hid_hw_output_report() on the already
stopped hardware. Executing hardware I/O on a stopped and partially
dismantled HID low-level transport can cause Use-After-Free, NULL pointer
dereferences, or kernel panics depending on the underlying transport.

>  	ctlr->rumble_queue_head =3D 0;
>  	ctlr->rumble_queue_tail =3D 0;
>  	hid_set_drvdata(hdev, ctlr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908224532.1143=
57-1-mike@fireburn.co.uk?part=3D1
