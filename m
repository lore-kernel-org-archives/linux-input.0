Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC492D9484;
	Fri, 11 Sep 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117262; cv=none; b=lbCh9vfwPLtfKCg+roNLWaPnrqcwreKr4TdcEQW7sMvG1iveHnXEyuj6aeo9D2Xqq8/awO9GTO/4O2NQmV68ut68Fo0E1Ax+mcsAbTg3utY+oesnXAT/48t7sV5eJGY0NlBtHZo02/+U9giDhPFd6MHMzPiiJ5PknTwNEHgwMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117262; c=relaxed/simple;
	bh=yRAsvyz6AzQo7y9DV54Z1zbnZfRnk5wHreYo1KM1CUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cm3g7VEI/4CAQuxN7vO62WJQWtB7VHM14UkWRd3wZBGM5BpnlQYAv/llWSjw4uX0FKK3bpIWPR1H9pl/EUE9I5MQgQYIn6OiOVkH3y+Q5WcySXZAjvFZL2PcObsTcWNd8EV5oLV/um77YOzO4f+VxhYz3wN4ljZ8OI1qI4c9uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+v0b+uz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+v0b+uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F841F000FF;
	Fri, 11 Sep 2026 09:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117261;
	bh=JSTLaIpol2c2AGdsBeKclWJkp1orIWNqnA4PSU2jf/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l+v0b+uzOP6PP1+oA/sLVzuXoes7+tl5pwi5ZQHlKP+uQxyoOcFbXjTkz4kUiwsk3
	 Kg8E53OHJWWEGTYTBf7mnFAX5dkw/wnZLYNTVHQwG9Yq/0e/U1DfRFVZmKGWKXwve6
	 WhDEkD71I2dcFlz+jIdFUNukctLh/6cjfwZQ0Pq7dYBGRlv1d+9QbmIeoJYUTsOa68
	 Zkfzsooj5OtIj5T3Oc/TeVkU238NWwryrieQBF1qIZwd7ob4Jt3RkuDs3ZKe8WzBPp
	 GehGvoirWMjZQHV99shX06xPDz/3DSYmpHyM1xi623AIU00cuCOvBGNh8zJJeu+7NV
	 B7rfNBPyD6k/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/10] drm/msm/dsi: make command and video mode
 configuration mutually exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: lee@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-8-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-8-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:00:59 +0000
Message-Id: <20260911090100.77F841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch silently introduces an undocumented change that incorrec=
tly configures the `REG_DSI_ACTIVE_VSYNC_HPOS` register by assigning a vert=
ical timing value (`vs_end`) to a horizontal position field.
--

commit 2bb1060f4bf71f32baecff799ef80f36dc371942
Author: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

drm/msm/dsi: make command and video mode configuration mutually exclusive

This commit ensures explicit mutual exclusion between command and video
modes by clearing the opposing enable bit in dsi_op_mode_config() to
prevent hardware collisions.

> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1094,7 +1094,9 @@ static void dsi_timing_setup(struct msm_dsi_host *m=
sm_host, bool is_bonded_dsi)
>  		dsi_write(msm_host, REG_DSI_ACTIVE_HSYNC,
>  			DSI_ACTIVE_HSYNC_START(hs_start) |
>  			DSI_ACTIVE_HSYNC_END(hs_end));
> -		dsi_write(msm_host, REG_DSI_ACTIVE_VSYNC_HPOS, 0);
> +		dsi_write(msm_host, REG_DSI_ACTIVE_VSYNC_HPOS,
> +			DSI_ACTIVE_VSYNC_HPOS_START(hs_start) |
> +			DSI_ACTIVE_VSYNC_HPOS_END(vs_end));

[Severity: High]
Could this inadvertently corrupt the hardware timing configuration? It looks
like vs_end, which is a vertical timing parameter, is being written into the
DSI_ACTIVE_VSYNC_HPOS_END field, which expects a horizontal position.

Because this happens unconditionally in dsi_timing_setup() for video-mode
displays during the DSI host power-on sequence, this might lead to display
tearing, sync failure, or a blank screen.

Additionally, since it uses vs_end instead of hs_end, this appears to bypass
the bonded DSI scaling logic where hs_end is halved, which might feed
incorrect horizontal synchronization bounds to bonded configurations. Was
this an accidental copy-paste inclusion?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D8
