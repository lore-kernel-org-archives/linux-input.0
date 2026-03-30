Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BC73B47D9
	for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863369; cv=pass; b=pnS4VbBm7AS/uffrnydlZRIR3hflxBlaIL/cA1fEwm9bgqekT0zGX83FWVYMr7GK3Q4/I52IM1inHmyHr3i0CRqTi8twzhNclijZPWhXKlQNi+rI8cx8+691x/660itHUly+/AYhQw3vyfMAyMpaxNDiKRUykEZs7gU/V+nJC5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863369; c=relaxed/simple;
	bh=ONNvpnHIrrlZOFnwwhyENzcT4/Pw+OdMUWkbXsdiH4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZU5gPI8cb6t2kGSM55G0X/4EpvHSwgjK8K+NKG6VYfb+9yhxly7doBdG6BJhDRJcgaZzLtUMgqcN7qnOgBoZXyUdfaHPOAktl2RF5roD88WyFcpM189T4RbmGfHagm6R9z4Tgw0SZLzcYOmpWSOlX8ZmYU0iKqvVWDQaj/pxb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CRSi/7ZD; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CRSi/7ZD"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a0faa0d15cso4465554e87.0
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 02:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774863366; cv=none;
        d=google.com; s=arc-20240605;
        b=MTyTDbNummiB1w+5Z1Tee7ECIvQyZZttSeTFSD3SY9j+CDS3c3Rt2KCDizeqn84Xgn
         OGwKDmtXkjN6Swo2fdSrn+qpPDif8V3s1cJAz0nEbdYzFSoB05oJ/nHDS/8DkPWJ3u+h
         WqztUHCjBUZLLfM8mYC/Sy4KewYw6pHbGRv5rp24QuMDgaMjdgghAAvtk5QcGr7EpSHO
         1K39ny+Uw622Zlu0gnpEH37ast4nIn98gJ7VcqLeRU5ieL2hO6egLEt+q2f7j0x0H5gT
         JcLqQUbsYgIgmA2puxKSFVZMGttgjftRzx+2T8O7oE9HKOmVQghk1+oaNFEtkeXaiC5h
         ylAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ONNvpnHIrrlZOFnwwhyENzcT4/Pw+OdMUWkbXsdiH4Y=;
        fh=iGDCAC/9XluhfGuYGwZ814Kzlt2BuT4cXYRAUYbCBws=;
        b=J0goe5qltX8wY2fwh0ZVh1oK3g5QkFA2+w67TW+DIvtSjLnYnBd5NtafYP4k0z7kIw
         oUdJdvRgwZg/EmJar2bvw4A6DFcExHEqAgiwKnH4jnl+tJqrX4mYEz4H/FpZ/T/rXCT+
         nEeROQbpza9a6BLQzN802O1TJ2xxsa3z13YqNUXlqCB/g8C9njLqDcWz5IxBuwskCtjx
         gVAoaSvojo8AZRlIKzNmqiqo0I3So4BkO3X2cUSar+p3JTYfEhb70od08yq8fSrUZh15
         +/GJjPjOh4i5lo2Qzzjz86tLoYxL4ch6g7ql3/DHHlmpWHbDxlg+oGwvEaaiAFGuZyz/
         M49A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774863366; x=1775468166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONNvpnHIrrlZOFnwwhyENzcT4/Pw+OdMUWkbXsdiH4Y=;
        b=CRSi/7ZDuKWXilmc3FY+3Bnk1VRP9QLydDioAxl0zVSANh9b3dNbIkgLYE7FI68ATx
         yQvP0+gZtynI/Q1XoCp3oQqWbcR6MGRFHYdRrIz3J7iFqtFI7xxpTZ61l66YqDHcplnG
         SfBkf0byTHORQQ5Ym3pTSE+56AiX4bTMlrk9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774863366; x=1775468166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ONNvpnHIrrlZOFnwwhyENzcT4/Pw+OdMUWkbXsdiH4Y=;
        b=NcqnVe+DerkaqWrnudv3VfZkUAdtUwP3QEidJF+8GRkIhLgFo4NSr/VMYfSkFQMdD7
         AtaMR2ga7SxBE8XcoJqhmo/FXUDuLRTXSqXr3hU4vg1RrHQDp8xJME151vP22R5doYx8
         7Qq2AuzbVE4KGDoUdPvAO5qphgAeIJY7ioqdAftt8wzXWVUH0Lhp47k06V2+b6GHGmcW
         EVCZggMWmrmc2uzXKhl9SujsbBnh+Lhwfz+oTWJdJjt5EXoKyzNsv5Oz0COuxtwuyLeB
         En1KJMdMC/x1OLvpymfHBVRWeNl9O8qJ03NdH89Ls7ZajpFlgZE3UdmBWU58qaHjvnnb
         oKMw==
X-Forwarded-Encrypted: i=1; AJvYcCXd4fREbusWQmlFHiBwf9hX3iRrGEu5DpEOXourI6csDTYPbaV0A51xJ0GTj68MkIuWpMrktrNv+SLPFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLyAWHPNF1j0uRnFS2gjkoUSG1jqLzSR9pjxo4TkJYI1Np96OE
	tUafILrPsJ0LR6pmWhpzG3UhXBcuPHRX2wxnDH3NEKknuWHzg/fA/MSzIbIcL9Zh4QVYQhpbarY
	M/kpllecwHBtHXj0iOncp+5tGwJ+9VqcI8kyGIhhw
X-Gm-Gg: ATEYQzxrXLSSr2HEuehf61b9wW/+4XxkHbBRZuTwKZPJlDOdo3++HEYYcRiZThDjiMi
	bBNAYvxGpWRSBuzRvs45DBJwTCxq/8RvxYjx7DcLh09Bo3KNisfUXQJplrIYM61SltGCXO4VnJ6
	Rk2UmicV6POJA/iVw09kpg2qNYJdxWPPZewYFfDK0MFJeMG8qcekjDe480olKXCJg2VkBjC3uKH
	FxtdhmcE9qCWV4y59fx9qj2iexkl7Ymss+ubZxLt9v2d35mge+UrNg1SC8lu8TwhmqaOr1xEWnH
	X3wfqgwmSTDxPbE5STMGp4siJI8f8dwhM23I
X-Received: by 2002:a05:6512:3f12:b0:5a2:7aeb:e7b3 with SMTP id
 2adb3069b0e04-5a2ab92ae11mr5011592e87.29.1774863365955; Mon, 30 Mar 2026
 02:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317184507.523060-1-l.scorcia@gmail.com> <20260317184507.523060-8-l.scorcia@gmail.com>
 <CAGXv+5GmDtrtFHJXs+fDyF+dZ5YW-TSEqXnPs2xCH8cu-Xcn9w@mail.gmail.com> <CAORyz2J355NZH=7iQ9sTDBhAmtjP7xTpXe21_3Z9J_R5YvdXAQ@mail.gmail.com>
In-Reply-To: <CAORyz2J355NZH=7iQ9sTDBhAmtjP7xTpXe21_3Z9J_R5YvdXAQ@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 30 Mar 2026 17:35:54 +0800
X-Gm-Features: AQROBzDDuO289B2CM0DmVnpmaCFifXhpUymo-5rQ6aPBkZTqTiIMBWQIo9x2VA8
Message-ID: <CAGXv+5HRWRW=+Mk2z4qCPrF7zFax9zQJ70Q4ihR6PkWJP0OUrg@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] regulator: mt6392: Add support for MT6392 regulator
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Gary Bisson <bisson.gary@gmail.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Julien Massot <julien.massot@collabora.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:39=E2=80=AFPM Luca Leonardo Scorcia
<l.scorcia@gmail.com> wrote:
>
> Il giorno gio 19 mar 2026 alle ore 06:04 Chen-Yu Tsai
> <wenst@chromium.org> ha scritto:
>
> > If this PMIC is anything like the MT6358, then it has 0.01V fine
> > tuning for most if not all the LDOs. It is sometimes needed as
> > a rail may have a 0.04V boost that would otherwise be invisible
> > to the system. And then if you have something like 3.04V set in
> > the DT constraints, you end up with something the regulator driver
> > doesn't support, but the hardware does.
> >
> > Please see how it's done in the MT6358 driver. I spent a lot of
> > time on that driver to make it actually support the full range
> > of voltages, and describing the supplies.
> >
>
> I had a good look at the datasheet (MT6392 PMIC Datasheet v1.0 08 Dec.
> 2016) and unfortunately I did not see any fine tuning option in there.
> I'm sure this data sheet is not perfect as it's missing some regulator
> registers that are clearly used in the Android sources, but there's no
> mention of fine tuning in that code either. I guess it does not have
> that capability.

Well, thanks for looking. FWIW on the MT6358 / MT6366, the main voltage
control and the fine tuning are mostly in the same register. The fine
tuning is described as "calibrates output voltage" from +00mV to +100mV.

I looked into this because the LDO table shows some of the default voltages
with 0.01V precision, but the main voltage controls only have 0.1V precisio=
n.


ChenYu

> I will shortly submit v4 that hopefully addresses the rest of the comment=
s.
>
> Thanks for your help!
> --
> Luca Leonardo Scorcia
> l.scorcia@gmail.com
