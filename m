Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10AA37F32F
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851075; cv=pass; b=uCX8r9iVtUhVlnNRlwYDZ7rIH0NplhtSIItGms2Yrnn9MBeFYJAJ5quemLlN0Vdb7g/g0ueeQOa93qDnXgv8NKQUEXIRVQbXt5cJY7DPrvqZW9AeuTgQETjFH/KEqiqgSjLY4xNe0/H/xuNTM56A5LMbQsXm7XxkRcwXTbBFmN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851075; c=relaxed/simple;
	bh=nx6pzOW5pT8Lijs8fAgCGx8cLsTrEkgcyr1BexTuz+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEj7SynJyIQSgSvO7jj7WWw1JzinxRAbiczmpvbjJkPimYxkvv8pYs5xqHUGe5W3QiPiZuaCw8M4x1tXRlAsVG2ljGNvVEKJD61P/IX7XBVhdeOOQeqWVEDuvtWwi/CH8p4p4W/8mf4LkfrBWr5Nz3wuyRNnc8yduHp07MW9i0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnaunlPV; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnaunlPV"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so307698a91.0
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 10:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787851073; cv=none;
        d=google.com; s=arc-20260327;
        b=oVWrs4Z4TIedLv1RMmHGxKdw+9HLWdeRjesvZVycf9u1dpAZ7pBo91mETEXNjF0GN4
         7g4JIl9J6CeaC1Yvz9+/hy/eMpdPxlV6sn0/AHMHNE9DrJZ1BHgp6MhvMC4k7D0Dwn5N
         fI2jMXy4BlsLmBz2Zr97m7w2M8paiOUrTtoSrNWCnGZVHYxK/NuJXmLzMjW6G2U+NrVK
         AdxDt9gaordu+YRoKLvg4/DEkoqJCirKq+Sx+glMu0bMVCnSJM9K9QuKKppKSnsRgpZf
         Nrx7cc51GQX3mwMQoACwioAC7qnblFl1PRnMDNB6VL/WO6rkxMfnY+uENkoNcRFd8kiU
         WbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M8SDq5h0rGl3va3b86tmLr/VrLxThW4gkkY/ckQ/2dA=;
        fh=EJ+9Av54rp4Ay28Kgs/0lkQT4wULHOwbltDLjiytrzw=;
        b=YqESRQ/2mF+Ec95huoY2XIYIK0hqDyAKRh14neGtP0DeseMI+KqG6u1ZrhdBIYBTNG
         46LGNTzTh7kau3yX4MVhvESbJcrz4mhmZAaHvDgJ1VNPPJ8S6SOZsLSS0FY4EuuNiNSD
         +r15IjbK+OXIdbhdMZLQ8g+ZONzZSMSprgMijYZdWx4OOcTFf+qhx7ZYm/HnU4+j9CTP
         28LK+g3dhGwnExrLgcYi9bOTEmFaUOadoG6RSBluJvMJI0iJ6PvuOr1pyPX47943Pa2N
         cQsp2AWY9BDjwYjHQAbAz0sE/MQGK8x0qd4qU7OW4rcE/hg+VTzKsPW3sr1VZhFSdblk
         rUWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851073; x=1788455873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M8SDq5h0rGl3va3b86tmLr/VrLxThW4gkkY/ckQ/2dA=;
        b=PnaunlPVlR9vSA3adN2cXs0v4MY+HMHLDn2/pIypwBIYua3I/ulnZEUMKMQAQPf883
         SpxK+yLnrph0EMCsHuAkUI0LlNxLEy0avxjVucLz+4g9OcZBIairx1PNko8FHw+jmjzZ
         +vE3/vlrwTJCE9xd3Citp+EmaVINBvk6nd0onnvEoRukFcrSe2V75fGL+VJxWK07Y162
         dezI13xM5r9LoXwqGPQq51/1p82bm9LjSCpHHnaqkC/JuyxWrZbJYl9041Pn6ISiLWhG
         r/19omgJZHjuu6gI3Qi4h5qTcXk+0UWOl/ws+7jd2/h2N43zn3LtP13TtBOBuZiTO64K
         N1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851073; x=1788455873;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M8SDq5h0rGl3va3b86tmLr/VrLxThW4gkkY/ckQ/2dA=;
        b=YvTbZBLsqry6lVYR59Nq1ewd7KCy0theN2dxZ0P2Ehk53ybqBifCIbHb0UGt7r6hKM
         M7f2wqi7OCf0EoGQ3bjAVjiBNoLL2hE8/w27XjQ6ny6FDZs2rUiSONzc1MsLr3Zu7D4Q
         lTdJWRXrei85uqG54oIRkhkikSV5jyyC0V3W0VHGmtcTCwImaIC60XxBQqSWPSeqhKeq
         y8LmFGl5QZc9RjKZiahz8E+INYxXD5yEKZV4sCUT/8mtql+VXFTz6x7ndYPASjkcUkqw
         t+RPe6H0GR+wW34OY//QPgGWyZyWb8vQFzTAZ4+RIJLAM/SnXyXaH7zUFBY8A+pJCyMa
         yDBw==
X-Gm-Message-State: AFuF++k3CIs6PsdipaXSyOZUszIxubeE+BcqzRJykavNX4ZcmzKnGojj
	gYzs8rkrMc09sj3prV9aalLEYQdD4Q49juejLkJT+8iu3OOQJOUjev4E1BuT23m1KpB1iaXXowi
	FwZdm6coYpJtF+D2aToHiGBbTbAVPPtE=
X-Gm-Gg: AR+sD12lvwkuS/qMBqM0/BKbzL2bd5ryFH9dm6//zLaAkMupMRywfFzmz5vEWdrrZbw
	KZoglv14hIiBeZPkIDDvMs6JrDhwwiyEtiSyvI3oqzqaNZZRUerZhqVa5VNhDwjzuhdv2vfXYZ8
	gj9G1t+pt/YdQVTCi+7iBodW8Er9NyPFC4Q7tj5p6X1Pxllxv8TqLPLTG5WN76b5g23UyXMR8Ri
	lx5R9uG3X64bC03vl3l+6LtUI3aLsJWJNHHGLMXtgNzknWGdmlgS6q9E/lx4ZZyb2kueRSLF7jV
	7Y1sQe+CLSG2AC0lc+MAgbSkfMFNsV/TcWIzJKE7CDjYdML5wB96RJPT62fzXSYW5fua0YHtTfM
	yTg==
X-Received: by 2002:a17:90b:1c0a:b0:396:54ba:8932 with SMTP id
 98e67ed59e1d1-396d104e722mr868167a91.16.1787851073075; Thu, 27 Aug 2026
 10:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095654.429346-1-clamor95@gmail.com> <CAPVz0n3u0D=0swsO4n6LROFurO=as1w-ZRwaje08BN9dY=JhXQ@mail.gmail.com>
 <20260827141457.GA2943942@google.com>
In-Reply-To: <20260827141457.GA2943942@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 27 Aug 2026 20:17:41 +0300
X-Gm-Features: AcwNN1WUBCKfKNTF0yfYVgSgr_Ph4Fu9hbLSdLwMiZnrAraJvVZlotiakM6hXUQ
Message-ID: <CAPVz0n03znVtUaO9qo9zoC71NQsiVJK4sMLcyi_TWCUL8V1O9A@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] mfd: cpcap: convert documentation to schema and
 add Mot board support
To: Rob Herring <robh@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 27 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 17:1=
5 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 19 Aug 2026, Svyatoslav Ryhel wrote:
>
> > =D0=B2=D1=82, 21 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:57 =
Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > The initial goal was only to add support for the CPCAP used in the Mo=
t
> > > Tegra20 board; however, since the documentation was already partially
> > > converted, I decided to complete the conversion to schema too.
> > >
> > > The CPCAP regulator, leds, rtc, pwrbutton and core files were convert=
ed
> > > from TXT to YAML while preserving the original structure. Mot board
> > > compatibility was added to the regulator and core schema. Since these
> > > were one-line patches, they were not separated into dedicated commits=
;
> > > however, the commit message notes this for both cases.
> > >
> > > Finally, the CPCAP MFD was slightly refactored to improve support for
> > > multiple subcell compositions.
> > >
> > > ---
> > > Changes in v2:
> > > - fixed code style
> > > - rtc conversion was picked, so patch dropped
> > > - added audio ports description into mfd schema
> > > - splitted schema conversion and compatible addition
> > > - minor style improvements and typo fixes
> > >
> > > Changes in v3:
> > > - added regulator node names list into pattern
> > > - filled spi_device_id with driver data
> > > - ADC patches were picked, so changes dropped
> > >
> > > Changes in v4:
> > > - dropped regulator patches (applied)
> > >
> > > Changes in v5:
> > > - switched to MFD_CELL_* macros
> > > - switched to use determinator of model
> > > - switched to spi_get_device_match_data
> > >
> > > Changes in v6:
> > > - removed address-cells and size-cells from main node
> > > - changed macros formatting and OF matches
> > > - factored out common devices and made device addition staged
> > > - dropped cpcap->variant check for 0
> > > - EINVAL > ENODEV in variant checking switch
> > >
> > > Changes in v7:
> > > - adjusted spi_device_id entries (name/driver_data)
> > > ---
> > >
> > > Svyatoslav Ryhel (6):
> > >   dt-bindings: leds: leds-cpcap: convert to DT schema
> > >   dt-bindings: input: cpcap-pwrbutton: convert to DT schema
> > >   dt-bindings: mfd: motorola-cpcap: convert to DT schema
> > >   dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
> > >   mfd: motorola-cpcap: diverge configuration per-board
> > >   mfd: motorola-cpcap: add support for Mot CPCAP composition
> > >
> > >  .../bindings/input/cpcap-pwrbutton.txt        |  20 -
> > >  .../input/motorola,cpcap-pwrbutton.yaml       |  32 ++
> > >  .../devicetree/bindings/leds/leds-cpcap.txt   |  29 --
> > >  .../bindings/leds/motorola,cpcap-leds.yaml    |  42 ++
> > >  .../bindings/mfd/motorola,cpcap.yaml          | 408 ++++++++++++++++=
++
> > >  .../bindings/mfd/motorola-cpcap.txt           |  78 ----
> > >  drivers/mfd/motorola-cpcap.c                  | 143 +++---
> > >  include/linux/mfd/motorola-cpcap.h            |   7 +
> > >  8 files changed, 571 insertions(+), 188 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwr=
button.txt
> > >  create mode 100644 Documentation/devicetree/bindings/input/motorola,=
cpcap-pwrbutton.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap=
.txt
> > >  create mode 100644 Documentation/devicetree/bindings/leds/motorola,c=
pcap-leds.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cp=
cap.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cp=
cap.txt
> > >
> > > --
> > > 2.53.0
> > >
> >
> > Hello Lee! May you please pick this patch set? I have included changes
> > asked by Rob and Uwe. Thank you!
>
> Nope! =3D:-)
>
> There are still a bunch of unanswered Sashiko reviews and one from Rob's =
bot.
>
> --
> Lee Jones

Hello Rob! May you clarify if those are relevant?
