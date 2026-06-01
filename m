Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06D377579
	for <linux-input@vger.kernel.org>; Mon,  1 Jun 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316858; cv=none; b=gb/D5tojFGxKSde6vQIwdujW1cFq0bYPfV1T2Egjw2uR64Qg5MzzngR8BVWhZxPv016/cS5mCm5TNeRYjjnsomWMgXA3a8Q6szWsg2p3y5DFQ+DZwte97JX7ALJfjjl0djq9/ZbIMa+aZtYNDGk7g4xCN1POO8Y5H1PJoSu99Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316858; c=relaxed/simple;
	bh=2x5B3RuiIKW2zD4DQlkS1+Q2hWIi4thKUdAusndnChc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kpy6K5pzU9RBe/jvAWzBjaFIqm/AJNGIPCL4HIfUBK85XJfH+HCp2pX5IjOeqXf0XqAQDfCfRhQ6b5WQjxQ0vitvxHnFFBXeosEdSWX44P/WjWzkLPg/3hvpYZo8oLt8byRuQKj3nNADnt2qdKR83z6+QhLsgM9V/GkiKB32cjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzx/yze6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzx/yze6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954D51F00898;
	Mon,  1 Jun 2026 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780316856;
	bh=3j49742lkkIQU7H1uYQVRR7TLBffHKhmXyoZvYvGn/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mzx/yze6ZqUpyz35xPZ2blmqzpWWa6vtsH5cUZ6FMiIv3eiKDr5cLbV+l+upr9/Ci
	 L08I7dg2l522T59nCy1q6gxnaWTMJ9Z4Mf698YaVfT2oX6w+nt7l/kX41qhHKJnvT3
	 DBDPq0AeLPhTQW5kqPlJYjQ5wmMSaVIt9ZVRSWWEOO7PbvcV4Wmx01X2hua0SRyyle
	 pGVQ5LIpAKp3xRAliTRiUd8dEdmP0BCn7NPthgh5NF4wC2H3zuEjZTJiuxmb5+uMET
	 vacRxPykefXBX86AzZ6rB0Bie1LJRxkrbJ4dTHi1dOgCQrz9Uh4qcbQoWfzX1fg3D9
	 88Z0dLNah2MoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] HID: steelseries: Add MSI Raider A18 HX A9WJG RGB
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Glushkov" <david.glushkov@sntiq.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260601121118.8546-1-david.glushkov@sntiq.com>
References: <20260601121118.8546-1-david.glushkov@sntiq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 12:27:36 +0000
Message-Id: <20260601122736.954D51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing memory barrier when publishing `sd->battery_registered`, l=
eading to a potential race condition and kernel panic in `raw_event`.
--

commit cc3464e1bd82d31b73852e983e4e3aef990bd1d8
Author: David Glushkov <david.glushkov@sntiq.com>

HID: steelseries: Add MSI Raider A18 HX A9WJG RGB support

This patch adds DMI-gated support for internal SteelSeries USB HID devices
for RGB lighting on the MSI Raider A18 HX A9WJG laptop. It exposes them as
multicolor LED class devices.

Link: https://lore.kernel.org/oe-kbuild-all/202606010709.X0QYNjFZ-lkp@intel=
.com/

> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
> @@ -509,6 +528,7 @@ static int steelseries_headset_battery_register(struc=
t steelseries_device *sd)
>  	power_supply_powers(sd->battery, &sd->hdev->dev);
> =20
>  	INIT_DELAYED_WORK(&sd->battery_work, steelseries_headset_battery_timer_=
tick);
> +	sd->battery_registered =3D true;

[Severity: High]
Since hid_hw_start() is called earlier in the steelseries_probe() sequence,
could the store to sd->battery_registered be reordered before the
initialization of sd->battery_work by the compiler or on weakly-ordered CPU=
s?

If this reordering occurs, the interrupt-driven steelseries_headset_raw_eve=
nt
handler might locklessly observe battery_registered as true prematurely. Th=
is
would lead to schedule_delayed_work() being called on a partially initializ=
ed
work_struct, which could cause a kernel panic in the timer core.

Would it be safer to publish this flag using smp_store_release() to ensure
the delayed work initialization is fully visible before the flag is set?

>  	steelseries_headset_fetch_battery(sd->hdev);
> =20
>  	if (sd->quirks & STEELSERIES_ARCTIS_9) {

[ ... ]

> @@ -855,6 +885,9 @@ static int steelseries_headset_raw_event(struct hid_d=
evice *hdev,
>  	if (!steelseries_is_headset(hdev))
>  		return 0;
> =20
> +	sd =3D hid_get_drvdata(hdev);
> +	if (!sd || !sd->battery_registered)
> +		return 0;
> +
>  	capacity =3D sd->battery_capacity;

[Severity: High]
To safely pair with the suggested smp_store_release() in the initialization
path, should this lockless read of sd->battery_registered be done using
smp_load_acquire()?

This check happens directly in the raw_event handler, so it needs memory
barriers to guarantee that if it reads true, the fully initialized work_str=
uct
is visible to this CPU before we subsequently call schedule_delayed_work() =
on
it later in this function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601121118.8546=
-1-david.glushkov@sntiq.com?part=3D1
