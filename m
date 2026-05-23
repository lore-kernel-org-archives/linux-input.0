Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545719E839
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779533134; cv=none; b=qqbYDfES8z6sdltWUylc3Tf97NGppUREtRvWGdWj7VRO4JKpeC8FEzH/h09Ibh2z6/Ch2CZvtT288iRzkHH+N+UuFuj/9u37ALRb3uEqjwYhmdU5cfS09vUPUOrdyGCYvJhdNaVs7j1V/At2Ts9qWs/Hok6QXUQf8xnsOC7kvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779533134; c=relaxed/simple;
	bh=YFnArjUruQNK0A0y3s63Zm2NTyGLfTfpWi3go8NGfMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YrnkoSLm+cNCYaHBoHtmhtmvhE43y1mg5JxLpZdgpJxhq31FM2RLq5wAe7igF6bq5Rud0zHgbrCldiH08Xo54ctq25BqWuV8U9JvDdt/mxFkI70U4MDy7JN0511F3vaww/NnB92I3fPurd5GcQPvHhCCrY6Rq1LCwvpveSjYrEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkxSuQcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkxSuQcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8117D1F000E9;
	Sat, 23 May 2026 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779533132;
	bh=EuN8hVFQIRqa/xYtPX5ba/6U2x2qJjuNEI2vf8ps0gc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lkxSuQcmRC5L6G1e5y+Rv8/Yp2YE+T6sZHL1PKhB2LoVQ+d7I8FYNjCGefyc3HaJd
	 LbCzcICdrltdel14+FT8M1t70jY9qtWHxZ9Hjy77ZUeECpl+LEz7mgdddDRuangrOI
	 msb08jeaGOZzGYOfw8nZtUHkAfL6B1wPiKDTKfMQzy04wtp0Rgc/S462vq2WCJrtrz
	 L/MRxohh2OoSB8O3zU1bhSpSm7iFDtBEwRzaCXYH5JbS5iqUz391okcJj+FnePazmB
	 5Y+IAvjGuswl3E7lvZjgv8utBx79QZN2+RooSARhG/FSEQIcrkPmn1mvcuolqTwQvC
	 44bosBZjEi0Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: core: demote data shortness warning to debug level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matteo Croce" <technoboy85@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260523103806.60480-1-technoboy85@gmail.com>
References: <20260523103806.60480-1-technoboy85@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 10:45:32 +0000
Message-Id: <20260523104532.8117D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch modifies the wrong warning message, failing to fix the=
 stated issue and inappropriately masking a different error.
--

commit a5df696ba5cc949fba165e62139d8984b9884331
Author: Matteo Croce <teknoraver@meta.com>

HID: core: demote data shortness warning to debug level

This commit intends to reduce syslog flooding from devices that regularly
send short reports by demoting the "was too short" warning to a debug print.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 41a79e43c82b3..76cfed8b93c15 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2050,8 +2050,8 @@ int hid_report_raw_event(struct hid_device *hid, en=
um hid_report_type type, u8 *
>  		return 0;
> =20
>  	if (unlikely(bsize < csize)) {
> -		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d v=
s %zu)\n",
> -				     report->id, csize, bsize);
> +		hid_dbg_ratelimited(hid, "Event data for report %d is incorrect (%d vs=
 %zu)\n",
> +				    report->id, csize, bsize);

[Severity: Medium]
Does this change modify the intended warning message?=20

The commit message notes the intention to silence the "was too short" warni=
ng.
However, this patch modifies the "is incorrect" warning instead, which trig=
gers
when the reported size claims to be larger than the actual buffer size
(bsize < csize).=20

The target "was too short" warning appears further down in the function dur=
ing
the bsize < rsize check.=20

As a result, this might leave the original syslog flooding issue unresolved
while potentially hiding a different transport driver condition.

>  		return -EINVAL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523103806.6048=
0-1-technoboy85@gmail.com?part=3D1
