Received: from e234-50.smtp-out.ap-northeast-1.amazonses.com (e234-50.smtp-out.ap-northeast-1.amazonses.com [23.251.234.50])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B930566D;
	Fri, 18 Sep 2026 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726243; cv=none; b=E5tha/0tm0UXvvD2uzu/BA+yLC+LU15YNoKelY3EkB2i/RGh5LDnj/ea2+003mfu5q57DL73/cysk7RvghFPnMKy9jR180mHlf/dYJXUjZWKYOFIvDve8xN2Tz28vZqhZj03L5vkRUdi/CVVI+pGHedV23AaBXsAsLdDKAStR5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726243; c=relaxed/simple;
	bh=3k0woI/2Pe49Zy+kpvH7k3E8P11LFDlzapFiXAfYPJg=;
	h=References:In-Reply-To:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=p2AZctmL3mlF+5BloCS03kYSEs8FwTDxKATObSRRtBRJZjOHBuA55O7QmHxqIpX1Q6MOfdKA2c+2+VI96y6a9kH1tBejGupjuKKs5w10UXqM5XzKtuW8v5dHZuFPFzwrK+BSNmGBFDrQJbiVQ5KrAOmGCdwL6m7WpxG12Z4Tatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=sadRIJUP; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ZrV3vPHm; arc=none smtp.client-ip=23.251.234.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="sadRIJUP";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ZrV3vPHm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1789726236;
	h=References:In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=3k0woI/2Pe49Zy+kpvH7k3E8P11LFDlzapFiXAfYPJg=;
	b=sadRIJUPGaNBwXEF4Y9g2pekeWtieOJsxIPnwcOu3zMmnEOdisJcMZM3fronz/e0
	RHY/8vmeW+9F8WHdzbRzT/I24cLulQgskeHpBvT+CHfc9naM2rx83sqi55ObM0XhooV
	3jwmjVaW/d8xZQk67F0WLB9fC+s3a8DaXZJWOkJU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1789726236;
	h=References:In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=3k0woI/2Pe49Zy+kpvH7k3E8P11LFDlzapFiXAfYPJg=;
	b=ZrV3vPHmBoRF8ofVNfovRfpsd6mPmBQDMdXTPoSPMoIrDblW3mh4F9e+3MvcN4O7
	LlnOuvYN5RGMDf4tzDoIdv7uaDs+/YSfciTN5U5Jyks3gudyfUo5IsnTuTdG7Pt6P4U
	7DzEsQpvgpCxG+/Bhv/rQpmwu1hwwDe+KOA1GFG0=
User-Agent: Mozilla Thunderbird
References: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
Content-Language: en-US
In-Reply-To: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
From: fQwQf <fqwqf@fqwqf.xyz>
To: jingyliang@chromium.org, jikos@kernel.org, bentiss@kernel.org, 
	corbet@lwn.net, broonie@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	hbarnor@chromium.org, tfiga@chromium.org, jaschultz@microsoft.com, 
	dmanti@microsoft.com, acz@semihalf.com
Subject: Re: [PATCH v4 00/11] Add spi-hid transport driver
Message-ID: <010601a0b3ff1cf6-944e2ad5-0ad1-49d4-9e89-c8ab03bbc62c-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:10:35 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.09.18-23.251.234.50

Hi Jingyuan,


> This series picks up the spi-hid driver work originally =
started by
> Microsoft. The patch breakdown has been modified and the =
implementation
> has been refactored to address upstream feedback and =
testing issues. We
> are submitting this as a new series while keeping the =
original sign-off
> chain to reflect the history.


I am working on Linux support for the Surface Laptop 7 (13.8-inch, =
Snapdragon X series), whose touchpad is a HID-over-SPI device behind a =
Qualcomm GENI QSPI controller. I noticed that v4 (June 9) is the
latest revision of this series and has so far only seen automated review =
feedback, so I would like to coordinate before preparing any upstream =
submission of my own.

Current state on my side:

- I have a working =
touchpad using a downstream Qualcomm GENI QSPI +=C2=A0 spi-hid stack =
(originally from scuggo's x1e-nixos work, imported=C2=A0 via ELLX-Kernel). =
My local adaptations move the transport to spi-mem and add framing, =
response matching, and DMA/error-path=C2=A0 hardening.
- Normal touchpad use works on my machine. The latest hardening currently =
has only build and software-test coverage; I have not validated s.
2. The SL7 adds a different transport requirement (quad-SPI via GENI, =
through spi-mem) on topuspend/resume, and I have not yet run your v4 series=
 on this hardware.

I believe our work may complement each other in two =
ways:

1. The automated review of the series raised DMA cacheline-alignment=
 concerns for SPI transfer buffers and unchecked reset return values in the=
 init/resume paths. Both overlap with the hardening I have been doing =
downstream, and I would be glad to contribute fixes there.
2. The SL7 adds a different transport requirement (quad-SPI via GENI, =
through spi-mem) on top of the same HID-over-SPI protocol, which looks like=
 a natural fit for your generic driver rather than a standalone one.

Questions:

- What tree or series do you recommend working against? Is v4 =
still your current baseline, or do you have a newer development branch?
- Would adding the SL7 quad-SPI transport requirements to your generic =
driver be the preferred upstream approach? Is anyone already working on =
this?
- Are you waiting on maintainer review before a v5? A second hardware=
 platform may help move things along, and I am happy to provide testing on =
SL7.

I am also tracing the downstream provenance of the Qualcomm QSPI code=
 with the original authors to ensure a clean sign-off chain; I appreciate =
that this series handles its own history the same way.

Happy to share technical details or a preliminary diff if useful.

I'm not subscribed to the lists; please keep me in CC.

Best regards,
Jizhou Tong
