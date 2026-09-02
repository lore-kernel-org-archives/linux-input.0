Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A264A8C
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312208; cv=none; b=tBtkWqPJqtiuZK/8I+Zd/H8oCDpRa+ahAV1YSs6+GWxKmfaC1cQN9EifBYbpViMp+W6mpM0YRN4zaXM+qcYMCe6Hbk8Xeo8yAznqVXZgNmUnmsA7f1PtPRF0yyaSVKf77U981UgQaeEizmzM2M6xP4mCHsX3oE/d/01+2rgoE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312208; c=relaxed/simple;
	bh=UjNe0q5pWeHZyEXtxWM3FePYnfL6Ka9/uiVjF/jDcRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tQHOgGF7aHdpip3qVTqnSDSoI/2q2mPaJXin5J8qmjhT7Caj0pJMXJ4sxh7s6g9qlhyoh5vV6t7OgW2aMy2W/XhWDjYWtb0w0lNvP5iyjlA9de3aydCFfXnAOq9whmYyFTyLHfqbXNt1lsPywXeATedSe7qpQJKB7OL8BfdDg3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW8xvCQs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW8xvCQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D341F000E9;
	Wed,  2 Sep 2026 01:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788312207;
	bh=9PVTRxxbt3S2cvCQAXojU9xklLe3ljQl/KtCSY3D5NE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PW8xvCQsNzM8wKs2hvQn+vQTi9BKFvsx0942Kb0YlHwW5GSzVlhI0jZ2rkPuhOP9r
	 TMCgYtDSxaM8fxqO2i7JTdR/aWzTWOz4SpYEYxwCFgEE1tWdm/hijLrOTdUmt73eE8
	 TEc4l/X1CY7Sl6r0acqqEPn0KLlDs3OU9nqUv8j2SQnnedhrlnhRBCJUINTFWDpXSj
	 CQ9ctvhrXt3ghd6pudhqlN17Rmqgy+K4aK25IYg1iVx0QIC821VM1yewFRVZK8oEkx
	 oRVm4cR+zGZCS//3bpIfil3R/xOj9LFYoB2fPKWDvm7mCcPuPixDOvtnDZ6RRRDx8H
	 PZ/6YUCsyy+Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/12] Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260902010237.865772-11-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
 <20260902010237.865772-11-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:23:26 +0000
Message-Id: <20260902012326.C0D341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The hid-universal-pidff driver fails to adjust fuzz and deadzone=
 for the newly added racing axes (ABS_CLUTCH, ABS_HANDBRAKE, ABS_SHIFTER).
--

commit 6be790038ce1202a4794a1e9066e937b7c0b308a
Author: Vicki Pfau <vi@endrift.com>

Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER

This commit adds new absolute axes for racing game controllers.

[ ... ]

> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/=
input-event-codes.h
> index 3528168f7c6d7..5c881ed441771 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -879,6 +879,9 @@
>  #define ABS_WHEEL		0x08
>  #define ABS_GAS			0x09
>  #define ABS_BRAKE		0x0a
> +#define ABS_CLUTCH		0x0b
> +#define ABS_HANDBRAKE		0x0c
> +#define ABS_SHIFTER		0x0d

[Severity: Medium]
Will this cause an issue with fuzz and deadzone adjustment for the newly
added racing axes?

Looking at drivers/hid/hid-universal-pidff.c in
universal_pidff_input_configured(), there is a loop that controls the fuzz
and deadzone configuration for racing controllers:

	/* Decrease fuzz and deadzone on available axes */
	for (axis =3D ABS_X; axis <=3D ABS_BRAKE; axis++) {
		if (!test_bit(axis, input->absbit))
			continue;

This loop stops at ABS_BRAKE, skipping the newly appended ABS_CLUTCH,
ABS_HANDBRAKE, and ABS_SHIFTER axes.

High-resolution inputs for these newly added axes (like a clutch pedal or
analog handbrake) will retain the HID input core's default large fuzz or
deadzone values. This could lead to "steppy" input response and dropped
small movements.

Does the loop in universal_pidff_input_configured() need to be updated to
include these new axes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902010237.8657=
72-1-vi@endrift.com?part=3D10
