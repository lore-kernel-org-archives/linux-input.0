Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A42F5A0E
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312264; cv=none; b=pW0LeSbt+4P9WZB+RWbxeHGOZWP6j87xJe+F67uCEMaRkKT/Xh5xYLL8812+te9oa3rsbTQ8QhKsKLGj3+Gfo94/FbD6geNTuPpZdqJhPO2+sraB84HWorEWv6+RVi3swhP3DV1TI1Zs5roX5NBVxabgEQjhJv1ZMp4lTvEoTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312264; c=relaxed/simple;
	bh=GNLZGtL2hG2Kgy1M3kIQXRolsCiEngvrLSw05ZBGXFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ASiGQ0ZHBzNLcu8Eubk1YavgaRUNhU9RarAfvqmFILRSAvsEYTSUjW9jXV0E1lUXNxRcIE807AW2rswx0QWDiXY+QYgN/l9PtywncuC4PJESlCy0QfXTseVunTZkLx9ccgJqAPZ7sFWlL5YJBi87daINtDLSatnI0DTx5gA0Q7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrvVdVU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrvVdVU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983921F000E9;
	Wed,  2 Sep 2026 01:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788312262;
	bh=Iw2Cq8n0WJHqethHgYTEkEDqac0YiKd28Oa/RxREexI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VrvVdVU9CmQGT/fw3pK0V2I2x4qYuqUJVHxoz222VBLYhN1h+9ocipUU2UWo3Akrg
	 it9W5+z8mYVnRRaDKWLjveDsSIgliAcZu49h+j4C7hfGwG+2pKyEpuWcWlPFbqWJX+
	 T4TgYpgbCEB9sidzeeObgkdGnc9os3YEl4pbTL7rfeIbghOxwvDwx54JKMhvJVsgZX
	 xDPiQENTzBjmq1PBYHqCvgR0bHOKOnBdy4e4WIJ+m2GFih1nuP2AVbbMQ8DQeWO71g
	 HzFkGUOX5s/98+ZK0uHgQvYreoj8fO/o7AIte8KgushDSWEBQfKuzN0UBN9SMjSzo4
	 ZoLe4roMfj2xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/12] Input: xbox_gip - Add arcade stick support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260902010237.865772-9-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
 <20260902010237.865772-9-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:24:22 +0000
Message-Id: <20260902012422.983921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing `input_sync()` when discarding too-short reports, leavin=
g events stuck in the input core buffers.
--

commit 11239c49a7f8de98682a983be88f926f7595b94d
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add arcade stick support
   =20
This adds support for the arcade stick device type to the xbox_gip driver.
Currently only the Razer Atrox controller is known to use this type.

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

[Severity: Medium]
When an input report is received with a length between 2 and 5 bytes,
gip_driver_navigation.handle_input_report() successfully parses the first
two bytes and calls input_report_key() and input_report_abs() to update the
device state.

If num_bytes < 6, this error path in gip_handle_arcade_stick_report() retur=
ns
-EINVAL before the device state can be synchronized. This error code is
propagated back to the caller in drivers/input/joystick/gip/gip-core.c
(gip_handle_ll_input_report()), which then immediately returns without call=
ing
input_sync(input).

Because of this early return, does the driver leave the reported key and ax=
is
events buffered in the input core without flushing them to userspace? Could
this result in missed or delayed events if the hardware sends unexpectedly
short event packets?

> +
> +	if (info->actuator_bias > 0) {
> +		input_report_abs(input, ABS_X, get_unaligned_le16(&bytes[2]) - info->a=
ctuator_bias);
> +		input_report_abs(input, ABS_Y, get_unaligned_le16(&bytes[4]) - info->a=
ctuator_bias);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902010237.8657=
72-1-vi@endrift.com?part=3D8
