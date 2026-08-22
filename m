Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143922D0292
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787365827; cv=none; b=cD+6EzPougMU4KcoNzkbX8uWdvM3oKOckUGUxecZwT6++5bgAgd1rl9ASebMDtbf/UWiXuM7TLCPWrq1cLEhPhNgg0nmv0Rmzr6/pKIvwV0uHYtE2pTomKISoD9j57GSxiR5Kfe01rgkBVL1rf/79/MYgJCG+2MjAqp5TRDh1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787365827; c=relaxed/simple;
	bh=8DlYYkbBbl7OS6RZTqa2OMSfoTV5iSORl3B3wKdEytE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MX18bgpvQZkgziBwu9x8t1QSQMsLx4dM7QE64hxWlHruhAMQB91un/xkmB97RtQQuTeo/LO7mx+r3TCfpqAJpoXBfOQL3X3bTLPFyV0tIwLnNgn5Ps2j7PARnuXlGPJhbmgevZhKCr71b5Kb1WGz1F0SV64m2ubh4HB3cgPgCuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz+ZaCcX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz+ZaCcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C591F000E9;
	Sat, 22 Aug 2026 02:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787365825;
	bh=xzszKUX+LstNuDYI3OTEkzUUGNj5dRoxbfatI2G7Rfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jz+ZaCcXK73DqOjxQXXZRtwFfPflAUYp7TWbLWtL0ra418vZBDQm2ei96RJZorMdQ
	 OG+S6EGuyE7rCiKEfpGbnp4ay4NiKvmmJkRJwb5ljS81DFT3zhIlvD0mzg77fnfw38
	 HtBmh7feoZLQquJZwFy64oHzxoqfHD2yGjK8nJ8c9KwEuGsFeUAiHQW7xOBk5zUBtj
	 HzcUtbTReR02VMfBWucy1LOKQnJLM/yXC2LH1RzdDd+2E5BmbJxIHvGSFfXh/K067D
	 QOVmTcW5rl+IRoOkLmEkNJdMxngAvWeLYO+BBlZGJ/+bhpvyKlsJ32yljEGgiAUEUA
	 XG64VA88G6w3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/12] Input: xbox_gip - Add support for PDP guitar
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822021140.1149546-10-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-10-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 02:30:25 +0000
Message-Id: <20260822023025.82C591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dynamic protocol detection relies on payload contents, causing fac=
e buttons and the thumbstick click on the RiffMaster to trigger ghost fret =
inputs when no frets are held.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a dangl=
ing RCU pointer and synchronous free of `input_dev` on registration failure.
--

--- Patch [9]: [PATCH v4 09/12] Input: xbox_gip - Add support for PDP guita=
r controllers ---
commit 6b8e97ecc5fa40007c8c5bf1a4aa892abddb06cf
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add support for PDP guitar controllers

This patch adds support for the PDP guitar controllers, namely the Fender
Jaguar and RiffMaster models. These use mostly the same protocol, but the
RiffMaster appears t use a slightly newer variant.

> diff --git a/drivers/input/joystick/gip/gip-pdp-jaguar.c b/drivers/input/=
joystick/gip/gip-pdp-jaguar.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-pdp-jaguar.c

[ ... ]

> +static int gip_handle_pdp_jaguar_report(struct gip_attachment *attachmen=
t,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{
> +	bool lower;
> +
> +	if (num_bytes < 4) {
> +		gip_dbg(attachment, "Discarding too-short input report\n");
> +		return -EINVAL;
> +	}
> +
> +	input_report_key(input, BTN_START, bytes[0] & BIT(2));
> +	input_report_key(input, BTN_SELECT, bytes[0] & BIT(3));
> +
> +	if (num_bytes >=3D 7 && (bytes[5] || bytes[6])) {

[Severity: High]
Does this condition cause ghost fret inputs on the RiffMaster when
no frets are held?

If face buttons or the thumbstick click are pressed on the RiffMaster
without pressing any frets, bytes[5] and bytes[6] would be zero. This
causes the check to fall through to the legacy report logic, which seems
like it would misinterpret the standard face button bits as legacy fret
bits.

> +		/* Newer report version on the RiffMaster */
> +		input_report_key(input, BTN_TRIGGER_HAPPY1, bytes[5] & BIT(0));

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but is there a dangling RCU poin=
ter
and synchronous free if input_register_device() fails?

Looking at gip_setup_input_device() in drivers/input/joystick/gip/gip-core.=
c:

	rcu_assign_pointer(attachment->input, input);
	rc =3D input_register_device(input);
	if (rc)
		goto err_free_device;
...
err_free_device:
	input_free_device(input);

The input device pointer is published to RCU readers and subsequently freed
synchronously on the error path without clearing the pointer or waiting for
an RCU grace period. Can concurrent incoming USB packets process and
dereference the dangling attachment->input pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822021140.1149=
546-1-vi@endrift.com?part=3D9
