Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F34BEE2C
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789182979; cv=none; b=QhgZgRNEy8HlPtZhgIZ6IWym0Dd8Agit4gr4njYquo+Xzw92nhfR4AVs+OxDi3xTqJ0eV2iM/fOP6cIKWBjSOglHoVCZTIzg2hG0ZU5Xb6+F9IyjEb2w3ngEfdjw+3mCKD4IbWlcacN06u2dBJJ1lkDAJldLIcRiQoROEa0Nrzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789182979; c=relaxed/simple;
	bh=DkC5GP/7KnRpWTakMChq0vi24FWDOtqr2D+A6mzdcgY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=POaO9iZjAf63c5ft7sY/wVC0JdfpEOu9L4Wmtpu3/yoWjDgFSWeeCDwjUeccFUrxEG2bK2oNWzCT8hb42Vwf65CkpK7qizDOfUYA7GqEso7rNE+mTPqYzeB4jsv7iAJSvChbiX16tZuVLM0fcRHU1+LvNMA8ACOxz6GiZsBBAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9GWc0do; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9GWc0do"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFC41F000FF;
	Sat, 12 Sep 2026 03:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789182977;
	bh=TFne4vVEP3zjs0pUFwxt2avPPkmTt3WfiSRaNcUkXfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9GWc0doBMXmrJG65blgJL4Kq+w5Sg2ii/Wi70xlnzXMcf23luPEdukROeiE1Y0XL
	 5mc0bfHCIl/N9vfWV7MHUcMen02EfkwrU78w4XNhzseZytBAo61Bb7SbTSPt7pkVXM
	 6LxuH32VIGO1grgD7GX54vSUCuFnZeFONdH4MFqMHj6Zh9YORBDIYvi9C52a/nPc8g
	 fBRyiad094YoUL1Bvo3+zj/RfyqbMNlKDztvuiaXtlCZCQBttXjrZld7SDyLrhRSKC
	 XnbXvrY/cqZSSgpKGJbPBuGopG118T7PQ4zGaZ/lrovbHp9Ga10lSQD7vWjSs8/3MQ
	 qn3UxC3EL0eBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/12] Input: xbox_gip - Add arcade stick support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260912030426.2997003-9-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
 <20260912030426.2997003-9-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:16:16 +0000
Message-Id: <20260912031617.4BFC41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Delegating to the base report handler before validating the report=
 length causes unsynchronized partial events to be injected into the input =
core.
--

commit 40e27212434b70f4e87708396c3c1b8a00c35e55
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add arcade stick support

This commit adds support for the arcade stick device type to the Xbox GIP
driver.

> diff --git a/drivers/input/joystick/gip/gip-arcade-stick.c b/drivers/inpu=
t/joystick/gip/gip-arcade-stick.c
> new file mode 100644
> index 0000000000000..11ededfab8555
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-arcade-stick.c
[ ... ]
> +static int gip_handle_arcade_stick_report(struct gip_attachment *attachm=
ent,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{
> +	struct gip_arcade_stick_info *info =3D attachment->driver_data;
> +	int rc;
> +
> +	if (!info)
> +		return -ENODEV;
> +
> +	rc =3D gip_driver_navigation.handle_input_report(attachment, input, byt=
es, num_bytes);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (num_bytes < 6) {
> +		gip_dbg(attachment, "Discarding too-short input report\n");
> +		return -EINVAL;
> +	}

[Severity: High]
Can this sequence leave the userspace input state out of sync?

If a device sends a short input report (between 2 and 5 bytes inclusive),
gip_driver_navigation.handle_input_report() will process the events since
it only requires num_bytes >=3D 2. However, this function then checks for
num_bytes < 6 and returns -EINVAL.

When the caller sees this error, it will return immediately without calling
input_sync(). This allows unsynchronized partial events to be injected into
the input core, which could lead to inconsistent input state in userspace.

Should the num_bytes < 6 check be performed before delegating to the base
report handler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912030426.2997=
003-1-vi@endrift.com?part=3D8
