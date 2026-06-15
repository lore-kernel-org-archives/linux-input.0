Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4153AFD09
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504381; cv=pass; b=lDFyQ8A6l5ZNLxD/HgjrR529BqNIsVK2Rd4ffLoU2cNbx9qOe1BgktMiPjap9sfiaxkOuNUg5BtyBTAo6BTtbXL5vZ+kPd3hK3eXiOpQz2IEVD6I8V4Fq0sLnyExLOIDY5ByeQBvnVoTduprxhPaaoUWNiaC9yeMASrMbOJ+ZjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504381; c=relaxed/simple;
	bh=uKORwtqYpfXR4URW16kzwBGgnHmTyYEZYYWGYWsyxdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZ4dDsbZar7p48drWB4+SeIs+xNzNCDGcoftvHMUzUEnPQZ+3cVa2D+4iFlGrDhmYORjIO+3GtIZ08PC9wFLN1OOdrC7pt9PgQNUu9hf6xR2J3PX8y6wX1IlbhsA4FtkXbLemdepK/hPVP5AjY29GYtdyDEqA/T8PO0F5I5V59M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUAXna2m; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUAXna2m"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304ec41197bso3244404eec.1
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 23:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781504379; cv=none;
        d=google.com; s=arc-20240605;
        b=MpBb4ta6BB59f8yMwGtQqG/NgL5cbMVJysFDctVNN57ShZEoa3eN5NvPuHmlzKByYV
         P3BI07CIMkjUDJ8hoW/YeUtjk1Vn1AuLWID3PBnhKKoJIY7vE9ax3UxRwM86VhI7GWVy
         lApFGpSi0VBGGaRR9L6TBxAj/lOHAylk2eWXVB19FHTwSnQ9xPpimQigImmHxTN2h1pC
         nRpWicDPPI8rLXfLYbgDDmaWGq7xoFJ/spA5SaBktoDdTzLJBKElOFO1vvc12WrYSIgK
         4qxyQFq7yBv/Qylz3iw/S1o74rUu0tgqIAaADBaezzLyiFVkykeV/vyYnlHpKOHsP6wx
         tqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KkQasuouwuEak96wMIXgS6fQEBBTQ0Mb+VZ+Zy0vKsE=;
        fh=RbOIwcPwMZiIWgZb4izUWrG842my8mUon8lZKI8uh38=;
        b=POm6cwC8yapZlb5Vxl4nAnb3kohjjugdUwhNBoUEuRlH46rrLod1E5S3kSn1KcaoZA
         pgX/u5oJwgeezjg9FzOr0efHQbWHEqS0d3AxwHGlBWuTWrBV2PxoqRqZcy9sLmzl/g2i
         5WuBiIP+nU7a6azTPRSqKZYIOyUNsCicnzO0nVsw2B7u8YewWPzIwzedqbtMxfIEU/Pk
         BM7WQJHfna2Ww2ToIXgtsH3xdF123xMr9rVDcdd4b2tHFFJYszj1T/fFFNZZk8kYRx0W
         iocp2k07Ao8e0gesiBh4WF4rsasjAUkpcpCHNHOBAP+/cBeACWz+N91BQvfFiyTD6eYB
         ziuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781504379; x=1782109179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkQasuouwuEak96wMIXgS6fQEBBTQ0Mb+VZ+Zy0vKsE=;
        b=KUAXna2mDQqYUQvBtDp4PU49mmg7pm+uWUa9hwXiNnw06y6YrWRmoBymxpae6IhcUU
         hWvU3FIQk2Ke/GCblignyu3rOGUiMSsijfAWFrilNfjZ1c1/BgRESNkBCaYme4QkgU/X
         Fv6/GK3uflpe/j0Gpgi1tF/qWRefEdayTBvfIhQ4oTW7bhbV9wmq9UiB1oG+zTt1Kak1
         +FSRIPo29M8/8FLOx/ApJxFbF/Pgd5btBkvSQWWtQaoyvShGzj2M/k6Y89tI0UOUhrhC
         0jU09xjcecPUqBFlGfac/Puhhn8poGwA6WhG/J1Z5y4Wyy20PPYwiKF9xnud2lfV6mxr
         3jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504379; x=1782109179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KkQasuouwuEak96wMIXgS6fQEBBTQ0Mb+VZ+Zy0vKsE=;
        b=GQD8BER4/r8j9fMNyMUtbzGXLbihKiGmbK59gGUf7jIGhHdt+7dKCYQQbg1RVTuQRP
         r2we6bXpVl8H/Rx9G1xP9olNhZPy3KRXUG/Ej3YlnTQw6TL8iPFSD7yVrtV3hQGOGPIv
         P97T7qg4CNF3+rtmxbB/FvKHjKPp1FnvIPZcXARexHORaRUZi/9nppg13cr2KWOR/LTQ
         Mb997Ud55xikdxNtBTWZUpoU5afj1LAlz0otFWFOk5dChRsvvHKc+j0OP1wxX9aqanrX
         UT9KHZPpOXp5gqgCv5+FSLGqcofm9gVE2vp9Bo+UnjPzcmIp76nedlornSEUfJuTyjM4
         20JQ==
X-Gm-Message-State: AOJu0YzPFXDVuMFrffXL8kiVsJu1UWWLrJWb41Nm0oA0CRx1raKRt+xW
	2oaRTuXcEHRuVRsTD2Kwl6Aty6J+FAIOl+42GZ7/TZJhi2cWNhlhosYnU817vqQZYEW4atZXe4l
	6AuTr802+G8Kc0nI6qCdI7SYzlBQozXE=
X-Gm-Gg: Acq92OFaB/9GuOJ6t/POONLcCu/sTXRHJWrFR6I5r9gwDZ78QgXL5vvpscoFKu8W4Vu
	NoQs7194SmSw21vG+wz4Rw/Tie3Mh7e2AHMu5sz7PrLJ0Sw7J3DdDHkVPsvvQtI0WyFf+ABuxQz
	z3LHzAOy44IGaCib0u1wDpP2gvxZzV1V/vY+oPIiIcD198xMPLZaERO2tjI/6sXzLUI7otBegtx
	oXS/QQ+ZQTA6iE/4X1ZH2zHdBP0id+bTVX+BE/2BEcOcrco7x/iLLNssmU56j2Xsgu4sCAKr4S7
	k3V88MNs
X-Received: by 2002:a05:7301:578c:b0:2d9:6373:ad24 with SMTP id
 5a478bee46e88-30820096097mr6464257eec.26.1781504378983; Sun, 14 Jun 2026
 23:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512102445.55372-1-clamor95@gmail.com> <20260512102445.55372-3-clamor95@gmail.com>
 <CAPVz0n3Dw6Vtqqn8if=MYkBbYittXqsBKbDvrs1ntbD5Zn6iig@mail.gmail.com>
In-Reply-To: <CAPVz0n3Dw6Vtqqn8if=MYkBbYittXqsBKbDvrs1ntbD5Zn6iig@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 15 Jun 2026 09:19:27 +0300
X-Gm-Features: AVVi8CfLJdI-JlhNPqLeAzg6IgycKqp1cAjmQHr2_cfTHiJbI2u6XdfnMNWcOyw
Message-ID: <CAPVz0n3iCSeT3xJ2XkwZ6PYofwSLkc0gfm+iYo4xbKBkAtihcQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 28 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 08:3=
8 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=B2=D1=82, 12 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13=
:24 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > From: Linus Walleij <linusw@kernel.org>
> >
> > The ISA1200 is a haptic feedback unit from Imagis Technology using two
> > motors for haptic feedback in mobile phones. Used in many mobile device=
s
> > c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Be=
am
> > GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.
> >
> > The exact datasheet for the ISA1200 is not available; all data was mode=
led
> > based on available downstream kernel sources for various devices and
> > fragments of information scattered across the internet.
> >
> > Tested-by: Linus Walleij <linusw@kernel.org> # GT-I9070 Janice
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/input/misc/Kconfig   |  12 +
> >  drivers/input/misc/Makefile  |   1 +
> >  drivers/input/misc/isa1200.c | 524 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 537 insertions(+)
> >  create mode 100644 drivers/input/misc/isa1200.c
> >
>
> Hello Dmitry! Do I need to make any further adjustments to this driver?

Hello Dmitry! Do I need to make any further adjustments to this
driver? This driver is hanging in LKML for some time already without
responds from input maintainer. It is still relevant and I would like
it to move forward.
