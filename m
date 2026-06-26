Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13193DC4D0
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782459935; cv=pass; b=SeKhBzgj7MSSRHKy6uvnoeDncl/HqjHV5pEJNHOWdHZ+5GF2j11uN3gl9YeAJj95k3ZqtSOB4sjEHlKqa4MiEgRqMm2hVyy4jhBzSX2xYxIAeakmIYHTXCmKQO3qJjtMhZ+Z/MrQCtDRnmmmvIYhMXDsrziimuBgaTZLBzubWIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782459935; c=relaxed/simple;
	bh=ge+ySkSvSTzpeQ1S1iz53f9gihYI4+PsNWb353vU1hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrEWtyyYPL1l7lAJ9qqUm/BUU3cv2ttxKee/IfS8QyYs6V/QHOi7aCaAO/Z8e187vxFyRtQR4zyHPWizRTL++eEHNZ5an0VdHEyIGiGb4uvaYcUYM3qfd0W/VMhjf8YjBbPtvGPP7l4mXNC/AdWZkngNX1ZOLDp9yb+FlTfjZ54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxfAayX7; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxfAayX7"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30c99ccb1afso640943eec.1
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 00:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782459932; cv=none;
        d=google.com; s=arc-20260327;
        b=g9R2GUNvcvdUwnUCr6lXNuoSdBDY0143yYc8sBa8aUPq4rpPsgekgwTW4MNcrueoHm
         q/Uw9fw7HBiRWDft0iXjtp5NrvoqRqdyxNM6vB5NgIbjt46R/9F+lSprs9aD3yJjXqCS
         5gz6TBOjDoIiATM9pftlCGTK5whGYUOoF+V0CxOFDGnH8eWv96sDz+uC9dzOCNnvMCgT
         YJQIZBOCX++LjA51rpGB5u4k+UU/z5BpdQidNPsjr/qKZyD+7ywvjqAnQAZOXiFmP9JC
         wnyj2ybvpNtvlVrMQwGcKo0SwPv/L8oUA/6n+DdFyjg+SNRLNNoiOW7nOBbp+IFd408W
         rcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hSE+T8Vd1MLikSGDmSCJ4AKkeGzaDcArm4bG+QIsXTg=;
        fh=tq/O9CLE4kQZ/pldVqi8lXjscQM5vRvqMIz1HWhrQoo=;
        b=rx+6XCAfimB+8rYI9Sa+4RiNtgCQo+tLuHNtt3eyo103LJVSaCTSPLsqW2V87cvNLz
         pm4VBeFh6+QUHC1fSDR1lMgmV1TIyL1mGNqd6YPhLMG3zG7eUpaRzp2bFVQeoIrgbL+6
         r7P546C0p5bJVPqLDhnUlN7YhZhcRNJ82R46Pt3mgka/b0kaicspdon0izFmt8qN9HBp
         r5Y8vZG1TFNhS9V4vOxof6nS7ycXArujodrGl7isMWJR76ZXKToen57owFBUiFqtV27Z
         ITup3T2kZ/QQusPUvTGg/ylY7dlx/5ZRkQSxJK7+1uvDx/oNaA4uVA7q4S7JIz5PlpyY
         XhKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782459932; x=1783064732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSE+T8Vd1MLikSGDmSCJ4AKkeGzaDcArm4bG+QIsXTg=;
        b=jxfAayX7c7L53/cL2q8lINv/3hCoh0beRvAv3+2rHLLvkUwNCT+IVtzruSc83kCWvv
         DJNs/2YuCAl7dC3tb4hIHh5/BayzqCvwcG1PLYs/bAB1ndhpXrOCC3UMKb76bLJti3QP
         CrjUPOS3QDUJSLnDLMfBLMPvy1XwZ9XWu9LnILMRLY0bQ3aRdCATAdgNZYwO+cxSWtgl
         iHw+rYwaQYV0uHECkHeazUngxT4G3bXPoueAsmejtMt/kQlnJ/f42BWESZPstf01qMRh
         378FEhUrD0b7/c4iIO9x44svzmqC6BZWTcrUkiu8Rij0xF5RTYtUAzO9oOf4cGEM9BHr
         xZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782459932; x=1783064732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSE+T8Vd1MLikSGDmSCJ4AKkeGzaDcArm4bG+QIsXTg=;
        b=ilpuTcKamm+Xw83cxNomDXXhd6KOoumXDUSQgJqICNlMn6CjBfpJj8DlkwIR5YwDZR
         ZUzG7PN9tqH3PnNWBj7d6kjXZRgTh+JfCLOiTcvUl/mxZ5aL8Q17x/qwqLjpP5AAql7X
         OdYEJiE7BrusSp4bciaIYa4Obj0CbcpYsjhQ1wqIgiZEayzmXtyjooNGk8bDizbWlbIe
         kBrhqvT1/5OHJZR/dtk7OyYfwrCzp5xuP37BbalcfzkDIC4z6P+nk/3/+SmvOIU+XYQz
         a4KjdN7UL4ceQtgRoSRkkg6D449BRjwH1EQmyo6yQQ/Zx620e8jK3MpRkBYLKlpYZBAo
         0g7w==
X-Forwarded-Encrypted: i=1; AHgh+RoZQkAUGWEGykZM4eqKz6eHaLRoYiNmBbk4AVQm3/Cz3fZjW3KjbCNJr+qo47UG73BSSZSS5ODyIeBvGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+CikYS7NIncqWzl2W+2JmS8VZDx9LGqi3nOKfj21n61tiTKD
	NhXbdJLC8NZ3t4N5Ztb6nQl83YLuVq2vMW72WL0d5+8xN2zjQbiHS8Onwu9I+7P2nKdlTrCImWz
	1gwEbhbf7P2SIxTUNZSATKpgjOwK7XVM=
X-Gm-Gg: AfdE7ckvJifxuCpZqibeMzdtBIMTUzsOdP7VmzyaZS72v8pclhzryq0Vye5n0TYy2iY
	t15DU+OFLJ3PCiKaYpNSCiEr6aY+/ouqmJ1JmuJ02/uGDYb58F9gu1vLlK9RjHZnzkmd5Q4b7U4
	jOSxeIYctoGQWDubidafhTwUj3gDSebsLxhYjDBcIeCOW5f51tJAXV+K0WhZXsX3kLB0ptJ91Z0
	XFR5M7a+eXJSxxXAVSIJ9SOULx2YvvNpcPybY9Pl+YfoHN47I13IsUxAZIDZ4kM7dKWff3gBksA
	jqSV/QFzhDXhzFoa6zLUm088YP1UzA==
X-Received: by 2002:a05:7300:d08:b0:304:ccdd:594a with SMTP id
 5a478bee46e88-30c84d12a7cmr5988818eec.5.1782459931718; Fri, 26 Jun 2026
 00:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617070528.35006-1-clamor95@gmail.com> <20260617070528.35006-3-clamor95@gmail.com>
 <aj28fvj34b4_VI3k@google.com>
In-Reply-To: <aj28fvj34b4_VI3k@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 26 Jun 2026 10:45:20 +0300
X-Gm-Features: AVVi8CccXP_mAYvaQ06OenJXyIA8FoomOKdGLmNiaJ4doTQTPO6HkKiB97iqG30
Message-ID: <CAPVz0n0Ja0eKrpirtMxK8bkTV0NY-UoKU0c09qLEF-xMWmOzKQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 26 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 02:4=
5 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Wed, Jun 17, 2026 at 10:05:27AM +0300, Svyatoslav Ryhel wrote:
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
>
>
> Sashiko convinced me that using mutex_trylock() in the playback work
> handler will result in dropping requests and that we are safe not taking
> the lock there at all. Can you please try the following modification?
>
> diff --git a/drivers/input/misc/isa1200.c b/drivers/input/misc/isa1200.c
> index c61adc4b605c..fb7f68fa0a2b 100644
> --- a/drivers/input/misc/isa1200.c
> +++ b/drivers/input/misc/isa1200.c
> @@ -253,15 +253,12 @@ static void isa1200_stop(struct isa1200 *isa)
>  static void isa1200_play_work(struct work_struct *work)
>  {
>         struct isa1200 *isa =3D container_of(work, struct isa1200, play_w=
ork);
> -       struct input_dev *input =3D isa->input;
> -
> -       scoped_guard(mutex_try, &input->mutex) {
> -               if (!isa->suspended) {
> -                       if (isa->level)
> -                               isa1200_start(isa);
> -                       else
> -                               isa1200_stop(isa);
> -               }
> +
> +       if (!READ_ONCE(isa->suspended)) {
> +               if (isa->level)
> +                       isa1200_start(isa);
> +               else
> +                       isa1200_stop(isa);
>         }
>  }
>
>
> If this works no need to resend, I'll fold on my side.
>

It does work fine. Thank you.

> Thanks.
>
> --
> Dmitry
