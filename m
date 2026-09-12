Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F9938E8CE
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183688; cv=none; b=MJeQ2HsLfX3FwpsNjEokWdgxu4S3jyf4feZwWScjod6pxnIGhzXpAVj1OUqUSHkKjwJ50WuAA8tkccoLdrYWQrOnM99v279ZsbZrMS8URESsnM9gZ0eYHVvXIhTYt8drLLrej8AOgg8Iv9kks4kzXs+ihI5WhSR6/bUadf7/NM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183688; c=relaxed/simple;
	bh=7E3bIEc9xHaYgIVYnrbHh6UeJ3oGXbOFEU3udjCUNYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cnyzlrnMuvcaUlhGseGO27OP2xtnM4FXayGbGj+DABKazbqV9xngvVRpnjAAuz6pgdUzoUc7M+f3g7rxI/6FLLTUC5I3FK/nJ18JQgHw5IvTMoUye7HJZBxYkenMo1wTdrZice8W7fsFlcdPF/Nk06d5oFqJ3Ktqp5EqpKsFx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9BaDgd0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9BaDgd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107F11F000FF;
	Sat, 12 Sep 2026 03:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183687;
	bh=WdSyH3yvi6rv6LJrFdJDLZO8uSSuVOqR5xR+U7+NMmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m9BaDgd0b2Kg68KllWe7aSLk0319KY0L/uIrEG3es6f+Cg5RFgBoZGG/GXWb/UXLY
	 XQkqz7B5ytY4ci9sNzjl6HaEm/Qw4NwkkY7enDGQfKSJ0Xc7ByyZBfnqubOIh7LLj7
	 YPj4ZOQya9oe7qNx0mNTchDMsh9fobtlbGF3EFJW4ek1pvSWG2Z3m0EwTV2NJo2sai
	 E3W55j2V0/c/9rn5PbAnzD02z2gH1Uzv46ufYNu8qGntAr6/NpUNC7gd4nBkoDC8TZ
	 /8emvKBZUOqjUMRu3tUHCgcmEOJ5vuIH5a2/Bl1DkXQNKZlJ8yOEQNjWwam2vTrQvg
	 f7Tmcwc8BDpcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/12] Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260912030426.2997003-11-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
 <20260912030426.2997003-11-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:28:06 +0000
Message-Id: <20260912032807.107F11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The loop adjusting fuzz and deadzone for racing wheel axes in hi=
d-universal-pidff.c skips the newly added ABS_CLUTCH, ABS_HANDBRAKE, and AB=
S_SHIFTER.
--

commit 95df0be5d5d52e727b1a90b0fb81bb2a045e5743
Author: Vicki Pfau <vi@endrift.com>

Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER

This commit adds new absolute axes (ABS_CLUTCH, ABS_HANDBRAKE, and
ABS_SHIFTER) for racing game controllers.

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
Does this leave out the newly added simulation axes from deadzone and
fuzz adjustment in hid-universal-pidff.c?

Looking at universal_pidff_input_configured() in
drivers/hid/hid-universal-pidff.c, the code loops up to ABS_BRAKE to
adjust racing wheel axes:

drivers/hid/hid-universal-pidff.c:universal_pidff_input_configured() {
    ...
	for (axis =3D ABS_X; axis <=3D ABS_BRAKE; axis++) {
		if (!test_bit(axis, input->absbit))
			continue;
    ...
}

Because this loop bounded by ABS_BRAKE implicitly assumes it covers the
contiguous block of all analogous simulation axes, adding ABS_CLUTCH,
ABS_HANDBRAKE, and ABS_SHIFTER after it means they will be skipped.

Could this result in inconsistent default axis behaviors for the new
clutch and handbrake axes, as they will not have their fuzz and deadzone
parameters adjusted to match other racing wheel axes like ABS_GAS and
ABS_BRAKE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912030426.2997=
003-1-vi@endrift.com?part=3D10
