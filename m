Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127106;
	b=EqnAlzEBFucnUBAV6DNkN8erlTHpgP50IDXFLX0HhFw1kE2RiFncH0DSKxwGvYX3Jkhc
	 TMGjpvu0+qJmwGTXEkNf/NBd90QYBfLrLQD9Rol7k6RsRPPRQ9w5zM6SU6SSSRn3yltU8
	 LlckFqluKvPKONXOUjZe/S5KV43FohnYOTGYIYJJkt6pgCoO3Df2W38/P5ADR4nVIjM6G
	 2FbjPAdVkO41NMJmx7ocK5jlfoBAilQs54lHiEhKmqeWZCop7+wO3Ljrc2tInzdhiRt8V
	 BWlj7UvAxJBu4iw957/wBxntZatcybFrahtp+/2CP6PqsIfgoZEmn6/mVmZYStMkZCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127106;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PCnTU0bPnZoYP61MOOP0I7GmeR3FhHRoVdDqBzgiIxA=;
	b=D2o+B76SSJCeStzdiMqdTX7so912Yf33iIXxbI1RcF7r/KzEaWbmushIOekFBVh5M0s0
	 RdwpFcHkg4zb7i/rPanzt00hjvhLm/V4sy1XHJr6sYRTxpnaPZdQ0Ek1GR9NYT92OhgCL
	 U1Ptj7YIKrrFgKGHAiA/+eoQYdILNLqB1vB0xWe3htvPEZmf7qeM5rJWa+ri0vYOH6Imx
	 7Yszwy9Qd74hdiwXBVzxtbIro0S0kfvKe6DDDLEW0z3fuf6vaeeXdOEeLsGGIs6Nycwud
	 98z00QUKKJV311iv8XmI2l5+FZS/Vw+kaK1ykoihF/2jYinhOZpgqj/Jqn4w8QX6+Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btvaz0if;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC943606A31C;
	Sun,  8 Nov 2026 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btvaz0if
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323171F0089F;
	Sun,  8 Nov 2026 08:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127105;
	bh=PCnTU0bPnZoYP61MOOP0I7GmeR3FhHRoVdDqBzgiIxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=btvaz0ifs19p4mxQ9/gixGgsSPqbm+4ujlAMd1wmzrjMojeRppAJNKOZVtswSfsPf
	 uDUHO0u1fympyOfEQEDW+dYFEJYRF5OMnyb/xU/izVzITfcUHb/Dl4HBsOEP23guHt
	 20BSFdFWmJ5DnETCBDvubi/JuzWYkmiEIk4GJoUp/0PM1GwthcURS2QCCYUcd5bkRf
	 R8IOAW5g8OUgIqLIXQpisspm3L1hiiqt8Dfm1TfjxlKllACJ9JJSC9Xr8H3wnz1Yvj
	 wJPnxi4yuUactMP655Uxs4Pj+j0kzuK1RyyVg3/CVDzDg1QPdQTsbik3oVlSKUpoRF
	 KZbsY01eJ9NyQ==
Message-ID: <sashiko-outbox-203649@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] Input: s6sy761 - apply the touchscreen inversion
 and swap properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nizat Mikayilli" <nacht@dxdmail.cc>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261108-b4-s6sy761-fts1ba90a-v1-1-999b3cfaf82d@dxdmail.cc>
References: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
 <20261108-b4-s6sy761-fts1ba90a-v1-1-999b3cfaf82d@dxdmail.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 08:38:24 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] Input: s6sy761 - premature input_sync() in
  s6sy761_report_coordinates() [1]
--

commit a5e7ac4e0cb3d02e12af7f249f64b3074df9f280
Author: Nizat Mikayilli <nacht@dxdmail.cc>

Input: s6sy761 - apply the touchscreen inversion and swap properties

This commit replaces raw X and Y coordinate reporting with
touchscreen_report_pos() so touchscreen inversion and axis swap properties
take effect.

> diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscr=
een/s6sy761.c
> index 1afa38850f12f..967fd222f0d62 100644
> --- a/drivers/input/touchscreen/s6sy761.c
> +++ b/drivers/input/touchscreen/s6sy761.c
> @@ -153,8 +153,7 @@ static void s6sy761_report_coordinates(struct s6sy761=
_data *sdata,
>  	input_mt_slot(sdata->input, tid);
> =20
>  	input_mt_report_slot_state(sdata->input, MT_TOOL_FINGER, true);
> -	input_report_abs(sdata->input, ABS_MT_POSITION_X, x);
> -	input_report_abs(sdata->input, ABS_MT_POSITION_Y, y);
> +	touchscreen_report_pos(sdata->input, &sdata->prop, x, y, true);
>  	input_report_abs(sdata->input, ABS_MT_TOUCH_MAJOR, major);
>  	input_report_abs(sdata->input, ABS_MT_TOUCH_MINOR, minor);
>  	input_report_abs(sdata->input, ABS_MT_PRESSURE, z);

[Severity: High]
This problem wasn't introduced by this patch, but does calling
input_sync() at the end of s6sy761_report_coordinates() and
s6sy761_report_release() fragment multi-finger updates [1]?

drivers/input/touchscreen/s6sy761.c:s6sy761_report_coordinates() {
	...
	input_report_abs(sdata->input, ABS_MT_PRESSURE, z);

	input_sync(sdata->input);
}

When s6sy761_irq_handler() loops over batched events, emitting SYN_REPORT
inside each per-slot helper splits a single multi-finger hardware update
into multiple torn frames for userspace.

[1] https://sashiko.dev/#/bug/linux-c1c813ff-e5e5-43df-a3c3-af15e2a7dad5

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-b4-s6sy761=
-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc?part=3D1
