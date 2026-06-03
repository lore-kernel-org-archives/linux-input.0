Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C03A873D
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500874; cv=none; b=lsEDNSJrnkv4dhMRYJfkUtrk4+ocXVL+87ok3i3Vp8zjBxdemt8G5rbE/eLOfYa9hdCov/dllut18rmp+CWtO63wHjcj91cXsfSI9hOmc5dwwEtL2dWah68SlmY3dwEe9UvztwWvKrK60KuGgtSS1/IIRWdQOx2eq9LHKEywTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500874; c=relaxed/simple;
	bh=Rjs9nrmKV0sWlPvxgYYCBTLAmQewcc+w6WGZqjTykzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WEanLxypV0N76Pq4oFhfFxV9nbiWwMguCsWMroiXuhfGvxyb3tiO3Cm6gvQ/lrH5fDXmpgT0a0GXU6VgfASRZRYaM9lCTiI5ZK9fWnxzH7UQWH/PMlgaeJRfeMc8ZZs3aIdGIiVQbzIKlwPlb4S9YzyiLs4egkc+A7qrKgUolwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2cnr4Wn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2cnr4Wn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C931F00898;
	Wed,  3 Jun 2026 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500873;
	bh=ddqer6hU9GsxtFifjgO5fbfAOIjUWbBFKJDdryRNfwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i2cnr4WnnU1D3k26pq0yr2Mr74qIBD9Icv2HKgjhQI66GhRk2aQpndlqzntje+1Wf
	 WxUbacJYUcC1KNZsjt30v89sBL8gsTdsJEXoYiZ4gVpSc92dTOWpR44r+St/0YRgik
	 zm3x4ZjrQJyYaCi2/qLsye0GUBRami7xkqZemXlRRLSRSfTrw0D+iikEc6xDgOYyw2
	 hfAsqTrjxajZqnMDd1Gj6jC/yZtsaLHi/3Lo8hoK+V0DWSRHV+TxfysgTNNIofQ+4Y
	 N/wdY1PRgSrWb+7PfklxCmGxfKLHG2v4f6xDF14LIMwvlHUvTVzms8h9EBwxGlKVZa
	 QBg36lORlqoWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: nintendo: Fix imu_timestamp_us double increment
 per report
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christos Maragkos" <whitetowersoftware@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260603152134.94439-1-whitetowersoftware@gmail.com>
References: <20260603152134.94439-1-whitetowersoftware@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:34:32 +0000
Message-Id: <20260603153432.E4C931F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing dropped packet compensation causes cumulative IMU timestam=
p lag.
--

commit ad128b0e7b6200fd6acd6f6287071433e2058d5a
Author: Christos Maragkos <whitetowersoftware@gmail.com>

HID: nintendo: Fix imu_timestamp_us double increment per report

This commit fixes an issue where the imu_timestamp_us variable was incremen=
ted
twice per report. It removes the redundant increment at the start of the
report handling to ensure accurate timing for userspace applications.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -1453,7 +1453,6 @@ static void joycon_parse_imu_report(struct joycon_c=
tlr *ctlr,
>  		dropped_threshold =3D ctlr->imu_avg_delta_ms * 3 / 2;
>  		dropped_pkts =3D (delta - min(delta, dropped_threshold)) /
>  				ctlr->imu_avg_delta_ms;
> -		ctlr->imu_timestamp_us +=3D 1000 * ctlr->imu_avg_delta_ms;
>  		if (dropped_pkts > JC_IMU_DROPPED_PKT_WARNING) {
>  			hid_warn_ratelimited(ctlr->hdev,
>  				 "compensating for %u dropped IMU reports\n",
>  				 dropped_pkts);
>  			hid_warn_ratelimited(ctlr->hdev,
>  				 "delta=3D%u avg_delta=3D%u\n",
>  				 delta, ctlr->imu_avg_delta_ms);
>  		}

[Severity: High]
This is a pre-existing issue, but while the timestamp logic is being
modified here in joycon_parse_imu_report(), the code calculates dropped_pkts
and logs a warning about compensating for dropped IMU reports, but complete=
ly
lacks the logic to actually add the dropped time to imu_timestamp_us.

Because the driver only increments the timestamp for the 15ms window of
the received samples later in the function, dropped intervals are silently
omitted. Over a gaming session, will this cause the controller's timestamp
to accumulate permanent lag relative to real time, breaking sensor fusion
or gyro aiming in userspace?

Additionally, does the existing formula for dropped_pkts undercount by 1,
yielding 0 for a single dropped packet? Would it be better to correct this
formula (for example, (delta + avg / 2) / avg - 1) so it can accurately
perform the missing compensation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603152134.9443=
9-1-whitetowersoftware@gmail.com?part=3D1
