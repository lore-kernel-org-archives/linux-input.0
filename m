Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6914A60F;
	Fri, 21 Aug 2026 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280744; cv=none; b=JKgbLK0kHy0FYo7GCanBeyJcyGIUI9YWuVJjWC+9+YvrfzCwIBy/CzzjKDoEIF6osJ+N75PFQOcMKXpTwz3HpA9UVf03vAZ6bJGs8y5bC/S4fc2tpsF2Fn5L8RsvK828p1kbFr5c6IAIy3LPf0hEFVQzx5n4E2tc0YyvruRoT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280744; c=relaxed/simple;
	bh=gk3zayrsNJIH8iTnusLRHRVJg9Mg/IWFXxAttEoX/pE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c8FloUtNJOPmvkafY6kEg49trYh7lYrEhl33zNcL0Q3pn8hrFPdqY5YvwuOzw6S+mPAdU20Gmr3vCGOSrOjiBTQc2dimSIItyR3N7gf58gGEgDD9GYiURvQdoQy80dZoM1eIm5qTkjIfDm6SefRkSJ9s1QFi/Eo64VQ1mp0uwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6hgTAva; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6hgTAva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42151F000E9;
	Fri, 21 Aug 2026 02:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787280742;
	bh=8BmB3WdlJUMlvl3RLqiENjUZSqhmoLvAXGVNBsvp1iQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E6hgTAvabgnpO6ldLUd2n/ABEotkZJQODboNh+Uo1UFe2DUqv8i3i8n9tsexrSQAZ
	 p2goz1fGinZmMp3ztLWBoWNGMLGxwOsvg+m7q7yAzK5pNc0vyo0L6T8KypJ7QixVqc
	 zr/R0u39qZBV6c1C30U1RzT93GOyJBh/H+YtDGLCHblJIXgBXzrYW8b1c2bGW8NvXS
	 QlJzW60VRQxiRLWAtlPDOLywvqP46apN7mK+E32nvmi2Wx5kh41VkyIORfeuRGNU5T
	 5d/YZICd6pVU6+GIHAsqtfXXvFm7BOX0i0c2L0u/TGat5W4XEhSaLGv+RxnnGFRExx
	 iCDcBG6Dqh9dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] input: keyboard: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-input@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260821023951.53199-1-triet.hoang.dev@gmail.com>
References: <20260821023951.53199-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 02:52:22 +0000
Message-Id: <20260821025222.A42151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error handling on devm_event_notifier_register allows prob=
e to succeed with a non-functional device.
--

--- Patch [1]: [PATCH] input: keyboard: Convert to DEFINE_SIMPLE_DEV_PM_OPS=
() ---
commit 88eacffae6d3079bb9f5aa0b29b554341484a82a
Author: Triet Hoang <triet.hoang.dev@gmail.com>

    input: keyboard: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
   =20
    Convert deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS and
    pm_sleep_ptr(). This lets us drop the __maybe_unused annotations from
    the resume callbacks and reduces kernel size when CONFIG_PM or
    CONFIG_PM_SLEEP is disabled.

> diff --git a/drivers/input/keyboard/imx-sm-bbm-key.c b/drivers/input/keyb=
oard/imx-sm-bbm-key.c
> index 96486bd23d609..7fbbd44878be3 100644
> --- a/drivers/input/keyboard/imx-sm-bbm-key.c
> +++ b/drivers/input/keyboard/imx-sm-bbm-key.c
> @@ -187,7 +187,7 @@ static int scmi_imx_bbm_key_probe(struct scmi_device =
*sdev)
>  	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the probe
path I noticed an issue in scmi_imx_bbm_pwrkey_init().

When devm_event_notifier_register() fails, the error code in ret is
printed but then immediately overwritten:

drivers/input/keyboard/imx-sm-bbm-key.c:scmi_imx_bbm_pwrkey_init() {
	...
	ret =3D handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOC=
OL_IMX_BBM,
							       SCMI_EVENT_IMX_BBM_BUTTON,
							       NULL, &bbnsm->nb);

	if (ret)
		dev_err(dev, "Failed to register BBM Button Events %d:", ret);

	ret =3D input_register_device(input);
	...
}

Does this allow the probe to incorrectly succeed with a non-functional devi=
ce
if the notifier registration fails? Should it return the error instead of
continuing to input_register_device()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821023951.5319=
9-1-triet.hoang.dev@gmail.com?part=3D1
