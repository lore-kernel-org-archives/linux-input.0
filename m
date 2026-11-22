Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795329732;
	b=p2NgNFG762dHwXN8sa0UaEQQUDuUOIoYaCk4tpguIMnbBDRvgE1lKuuxTwSxuoKpSvme
	 BFtY6AEGt/uECWuuvZ3rLjf5VDhGGt4GO/K9KuOEkKPb7PpphKSDXm9ilAMpZ++n6l2Dr
	 7uqsQlhSWDJA5U0xUH9IZ8IFlMjPBPwB46XGJr0QFoxV3ZX7VNBGAyVfiQC4/pLttLrh1
	 JrU3dSx+7wdti91uwkinNBewrhUUsAztx1mFjrc1wDGfsfhg/ZH132sJryOMCLdWgA00M
	 BN51LRJ6h9V4xAj9KYOi9bdaPqv0BzpX8gKYV85VeZ28O1Gmzk+2u3loxPxXObuHipA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795329732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=uFwt6mW+1RfJR5QBxZ88YeWE43yBZuAMkFsXG5rT/+k=;
	b=cQa8RxYV01VqxjdHw5aC1bvYorCavAFyNUrBvYNLRqpoTOI1cS1et5k+8J7LhloGn7xU
	 c8KKY4Nu+cUt84GUBNiQin4yQ9GayXSVSzOtxzhQQcY9sEREDcBuny9CD/1xVmbn4wVt+
	 7K1T/Jt36nKYEQozMmQh0RUY1T1LyMJYsEnR9+GDSRWOijwEGJdHAOyq3NmMUpKa4mis3
	 INHpFdFKMXGK2E+1Y039tofcwRfE22rQXhNY0qmwe78HKdz6bsjS+y80UbINR8dXOQpAK
	 IcPcuGqvOf7Pkba6tbeTISSVAXLnT/5/RvramVdb0+xHkb0OWZp5tdcQKJUb257h6dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=enser.io;
	spf=none smtp.mailfrom=enser.io;
	dkim=pass header.d=enser-io.20260707.gappssmtp.com header.i=@enser-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bNZB0BOo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE0606A32C
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 06:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69EE0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enser.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=enser.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enser-io.20260707.gappssmtp.com header.i=@enser-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bNZB0BOo
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67bec17daf1so244919d50.2
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 22:42:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795329731; cv=none;
        d=google.com; s=arc-20260327;
        b=LkaK59iIr5ZMxhoi7QHOM9Nxn99jqBsx5RtGYuZ5P0/AW5moV+15cy+XPI7uNGiZe5
         xM/zjLDHzZGHzd5KlpR4C7eMFUmtRMVsHZAivngqWAMoRMJSu26QiSRHc4TXPTfisIbj
         Vip31uaPG9Z34t+QtIWng4MdBXXf5tAMpAWn1fZ+eKIW5C4IH5nTrrJ26WtVhxRKn0JD
         x8zOtnTN/eogF7P5xwyHxOF7bpJ2OBWWuOitsHBgP1C1hjfq7qn9q39UtpddlAB9kEOU
         rU34k9zjnEJ8mOd1Aluxu9Ikq6u+9QFSxlMJwxL3ADSqOOtx0dqnkwG2BBl+TflRcYRX
         ya9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uFwt6mW+1RfJR5QBxZ88YeWE43yBZuAMkFsXG5rT/+k=;
        fh=5hiyMW3zTy6f0deBmE7Hi0iLsyarFZFW/iW5KxHjKZQ=;
        b=UskN+yApCnDLfwb9GwNy0WXmn/vlA0tkjHp8LhMBSZpFe9dOwgBmRZKZoxGFNMh6HL
         QN4Ck4R5RsV+GfgNaeuXzKOYPl1HYJklhREmhiw8amvmPQpTILHuD0SO4XXOm4UXADZM
         UoNAhFNrUvVlhGQqiMe4VzKxrTmXSeDML6FVP5hfzqEy4PszY7Sej9BXuTMN4u9+Xhyo
         o4+FA3ZYXGgFeOlLDcWbICq5BTJz+HesPzfFSbb6ejmQbueRixfaWpIjdf2OR5b1GT//
         NPqxSNtkWjX71zo0TuJ8XIN+EkWJUj2KqAcUPbu16sc+Io2GnZjz1ihGfA1rHO0anZg9
         AMEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enser-io.20260707.gappssmtp.com; s=20260707; t=1795329731; x=1795934531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uFwt6mW+1RfJR5QBxZ88YeWE43yBZuAMkFsXG5rT/+k=;
        b=bNZB0BOoRQz1FxNQ2GzB9WUdytrvsG+ktDXAS+RgINcwH+MVX9oU42NXCMDUJNqgXo
         IbNDMZrLOztY2Y9+FQ6sFuzDI8orCzvtG9gSXn058LDGgYiFFDFR7WGDp0QRUwHsYIx8
         JRdlCafvMIQXvdaIiQWFkHVnMX2hYnrBTmt1IsORCctzHga66b5xk3cnDPni7ym8g6K5
         W21tiuMMwzFVpDGHTR8AFlIrZ1QfZFgIjnN7YSNziuFdgepwmYdbNBPDkgNPwGXXsb2h
         QSFjWVfcgs/ZDFq2xVYWaHV5LaAygLOhGDKgHMvzVrq6KnbJj14PVdkz+pwKpuv2w86O
         8J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795329731; x=1795934531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uFwt6mW+1RfJR5QBxZ88YeWE43yBZuAMkFsXG5rT/+k=;
        b=pcEEnIDgrclvRxs/mJJiH18VtApy0ujIfLFuyQUJeVFG+15XIY1BXYhncoZbP1iU/l
         47MZ8puUwrK2YlZTQ5pZwAcudkkHR12K8brkTZ75mHSU7CfXABUhnoLUKZNYLmojtjMN
         XEj/y9uxhyppBS92t/6r9RgEREerVWa/Nt38tavEEZb/YDxRkLwJy8VNWhSBrCFqUJF4
         ePg9f/sOD1efjCCGmqVyvpl375N7HUZ2Bw+LLXpTciNi6Ndn1RvQyaYIrnDsMXOr0y0L
         Mo1tHwljeVLGJg2VMDch+9pDg+kWIfsR2vEvbkgfK58v1vEcLevwDxW25mINcQA3RqpI
         MMtQ==
X-Gm-Message-State: APuU4Z+4RTlDxtgR9NbhBu8/Rv7SoGr2h4NW2vr+m0WUvJl7wXO/LjlM
	R+zcEjYZiq6LPo04QbcPGN2+D4rz+4oVNWgfFNiiiVdaPcGxy2T5OczL6Jnv3aJ1aPmhQEuDfyn
	lND+UdvBMEo0qzABLtcgEhOX0rviSLiI4LRrv1Q3P/0QgNkoT+C56GKqjmA==
X-Gm-Gg: AZFdTZcWX8sVfO5fsJAeB/e0pcKbSX+wd9kkMZ1t64VYMPXrWQrPpR/7JMIykW3GP4j
	g69ZVaLHBxoATGTMhMruZkEwa4Cy6/SlFPTlgSLKOb1PpSmKA+sxu2sFSTmETfntiEppYdMM8Bl
	ltBH2h+uzctOIWDKUc6xkvoSTwwA4pHC2ozOSFMuwISNSPEQ1UbCQ024F5hoaJA9rVdL2d7j0ZC
	9+Ixn1tBFSQ5LHanLyywoeakKpNzjqUIQgamwlleG1FLMwAFImuQcK7Sba3udfG9KkaxygJDGQQ
	paP07gYf/dqyTwXiPQ3BBj0uYttEZWuhe7N3kQOjPeY1zRmb/XDZ+Px5LyruLsmdx7z+mSqonv0
	58pjVKacxQMaW8N0eQ0MMRCN5cBze239tupSernYSO/Sj+5Wc8Vo7BBydnm4=
X-Received: by 2002:a05:690e:bc5:b0:679:8c5f:3fc6 with SMTP id
 956f58d0204a3-67df43af88fmr6006818d50.3.1795329731209; Sat, 21 Nov 2026
 22:42:11 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-b4-rmi4-wakeup-v1-0-1b662be4a9d6@enser.io>
 <20261122-b4-rmi4-wakeup-v1-2-1b662be4a9d6@enser.io> <sashiko-outbox-227741@kernel.org>
In-Reply-To: <sashiko-outbox-227741@kernel.org>
From: Erik Peterson <emcp@enser.io>
Date: Sat, 21 Nov 2026 22:42:00 -0800
X-Gm-Features: Aa3M54o4H3dZxCmAiIO7gvw6DhWgTDlv3S5qgVksMYPQ1wzHp1Iq6bG55ke5jY4
Message-ID: <CAOY-3nAwYxgAeu1zUPOBO_PQtswKtsEOnV6a8hfnZf312ALT6g@mail.gmail.com>
Subject: Re: [PATCH 2/3] Input: synaptics-rmi4 - keep an I2C device that may
 wake the system powered
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E2=8F=BA (Resending as plain text; the lists rejected my first copy.)

  Thanks. 946c8432aab0 is where rmi_i2c_suspend() started disabling the
  supplies after arming the wake IRQ, so the tag is right. I'll add it in
  v2; Dmitry, if v1 is otherwise fine, could you add it when applying?

  Fixes: 946c8432aab0 ("Input: synaptics-rmi4 - support regulator supplies"=
)

On Sat, Nov 21, 2026 at 9:23=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] Input: synaptics-rmi4 - missing Fixes trailer for commit
>   946c8432aab0
> --
>
> commit 83b2656443640f5726e0dae2d6e9d52155752d68
> Author: EMCP333 <emcp@enser.io>
>
> > Input: synaptics-rmi4 - keep an I2C device that may wake the system pow=
ered
> >
> > rmi_i2c_suspend() arms the attention interrupt for wakeup through
> > rmi_driver_suspend(..., true) and then disables the vdd and vio supplie=
s.
> > Unpowered, the controller cannot report a touch, so the wakeup it has j=
ust
> > armed can never come from the user. Where the attention line is pulled =
up
> > from the switched I/O supply, cutting that supply also pulls the line
> > low, and that falling edge ends the suspend by itself.
> >
> > On a OnePlus 6T (S3706B, attention on a falling-edge GPIO, vio from a
> > GPIO-controlled fixed regulator) with the touchscreen marked as a wakeu=
p
> > source, every s2idle ended within 3 to 4 seconds with nobody touching t=
he
> > phone, with one attention interrupt per suspend.
> >
> > Keep the supplies on in system suspend when the device may wake the
> > system, as edt-ft5x06 does, and skip the matching re-enable and startup
> > delay on resume. A device that may not wake is powered down as before.
> >
> > Tested on a OnePlus 6T on v7.4-rc3 with 'wakeup-source' on the
> > touchscreen node. With wakeup enabled and nothing touching the phone,
> > "rtcwake -m freeze -s 30" slept the full 30 seconds with no attention
> > interrupt (2 of 2), and a double-tap woke it (2 of 2, 120 second RTC
> > fallback). With wakeup disabled the supplies are cut as before and it
> > slept until the RTC (2 of 2).
> >
> > The code and this changelog were prepared with the help of an AI coding
> > assistant. The submitter has reviewed both and takes responsibility for
> > them.
> >
> > Signed-off-by: EMCP333 <emcp@enser.io>
>
> [Severity: Low]
> This fixes a bug introduced when regulator support was added to
> rmi_i2c_suspend() and rmi_i2c_resume(). Should the commit message include=
:
>
>   Fixes: 946c8432aab0 ("Input: synaptics-rmi4 - support regulator supplie=
s")
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-b4-rmi4-=
wakeup-v1-0-1b662be4a9d6@enser.io?part=3D2
