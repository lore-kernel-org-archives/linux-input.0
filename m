Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BE2C237C;
	Thu, 27 Aug 2026 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840103; cv=none; b=cu8crQ7GnGj0/g/y0N49w/GAC1QTEnzfj1zx+hrkQvXDUnl0cQ/o8/Uv/1sIy4muQThmqe4DPuIUPvOra/7BPC8ZLTF2jNzk1s+5AKqRTTcZjdpuCCcLaoOFl8P0QFl8FTPH+F0IeriVfhfHLXyhe3RNXBrLMGGzbO7Leebo6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840103; c=relaxed/simple;
	bh=SLdLa0pMFHH+VoCLh4TtrJHtWoNYre5NSKadVwaBbjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqVdryx+p4wSZeFrgOKNQKdhvvm/8gQ+hWJ2UxqNze3bxbCjYK3pSAZNvh23iDjmaPCtDyMxw2MTsSlpQa7juqDVuw/G29HCtgCcaLs411ySHAy+0+X/uwadnjR7bACzlxFLxW6sZIcoIDG1MI6qkpggBKa0HGndQOktSJ7BnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZGVsSOv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZGVsSOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218B31F000E9;
	Thu, 27 Aug 2026 14:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787840102;
	bh=N5Pjwr9q5Lrm7F1jrG3uhSnlHd4yCqTzaLDPEaCaejE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RZGVsSOveZyIvm5WZivDtsmmbIKKsan6tyWd0bR8FHalBmBd1NuVcjQxmWy23Q3Gp
	 SWYpJKb7zRnVxnCcfS682kgTEJrMdqYwqWteMOhNitY5Swp2m5CBVCr61TeKe62L4a
	 NKYzto7QJLMBoJMH2ewhIViXGUJ3cU24lIJsueFdMBJC/FOhIGiWrXeGBVDJ7QItW2
	 qkEgrsFIP3xxyg/WLsdD6jpK3i1wx2eLJlwz2ACzkaS+JJdWAxIQ4ees14I+BMEGZK
	 3iL0NOG5sjhMqFCQS9UC+5pLMLpVuIJU5onA1zO0xDePOpi5VaIN9lZ+Dh/40CHHbZ
	 BZy344bRFalow==
Date: Thu, 27 Aug 2026 15:14:57 +0100
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v7 0/6] mfd: cpcap: convert documentation to schema and
 add Mot board support
Message-ID: <20260827141457.GA2943942@google.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
 <CAPVz0n3u0D=0swsO4n6LROFurO=as1w-ZRwaje08BN9dY=JhXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n3u0D=0swsO4n6LROFurO=as1w-ZRwaje08BN9dY=JhXQ@mail.gmail.com>

On Wed, 19 Aug 2026, Svyatoslav Ryhel wrote:

> вт, 21 лип. 2026 р. о 12:57 Svyatoslav Ryhel <clamor95@gmail.com> пише:
> >
> > The initial goal was only to add support for the CPCAP used in the Mot
> > Tegra20 board; however, since the documentation was already partially
> > converted, I decided to complete the conversion to schema too.
> >
> > The CPCAP regulator, leds, rtc, pwrbutton and core files were converted
> > from TXT to YAML while preserving the original structure. Mot board
> > compatibility was added to the regulator and core schema. Since these
> > were one-line patches, they were not separated into dedicated commits;
> > however, the commit message notes this for both cases.
> >
> > Finally, the CPCAP MFD was slightly refactored to improve support for
> > multiple subcell compositions.
> >
> > ---
> > Changes in v2:
> > - fixed code style
> > - rtc conversion was picked, so patch dropped
> > - added audio ports description into mfd schema
> > - splitted schema conversion and compatible addition
> > - minor style improvements and typo fixes
> >
> > Changes in v3:
> > - added regulator node names list into pattern
> > - filled spi_device_id with driver data
> > - ADC patches were picked, so changes dropped
> >
> > Changes in v4:
> > - dropped regulator patches (applied)
> >
> > Changes in v5:
> > - switched to MFD_CELL_* macros
> > - switched to use determinator of model
> > - switched to spi_get_device_match_data
> >
> > Changes in v6:
> > - removed address-cells and size-cells from main node
> > - changed macros formatting and OF matches
> > - factored out common devices and made device addition staged
> > - dropped cpcap->variant check for 0
> > - EINVAL > ENODEV in variant checking switch
> >
> > Changes in v7:
> > - adjusted spi_device_id entries (name/driver_data)
> > ---
> >
> > Svyatoslav Ryhel (6):
> >   dt-bindings: leds: leds-cpcap: convert to DT schema
> >   dt-bindings: input: cpcap-pwrbutton: convert to DT schema
> >   dt-bindings: mfd: motorola-cpcap: convert to DT schema
> >   dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
> >   mfd: motorola-cpcap: diverge configuration per-board
> >   mfd: motorola-cpcap: add support for Mot CPCAP composition
> >
> >  .../bindings/input/cpcap-pwrbutton.txt        |  20 -
> >  .../input/motorola,cpcap-pwrbutton.yaml       |  32 ++
> >  .../devicetree/bindings/leds/leds-cpcap.txt   |  29 --
> >  .../bindings/leds/motorola,cpcap-leds.yaml    |  42 ++
> >  .../bindings/mfd/motorola,cpcap.yaml          | 408 ++++++++++++++++++
> >  .../bindings/mfd/motorola-cpcap.txt           |  78 ----
> >  drivers/mfd/motorola-cpcap.c                  | 143 +++---
> >  include/linux/mfd/motorola-cpcap.h            |   7 +
> >  8 files changed, 571 insertions(+), 188 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> >  create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
> >  create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
> >
> > --
> > 2.53.0
> >
> 
> Hello Lee! May you please pick this patch set? I have included changes
> asked by Rob and Uwe. Thank you!

Nope! =:-)

There are still a bunch of unanswered Sashiko reviews and one from Rob's bot.

-- 
Lee Jones
