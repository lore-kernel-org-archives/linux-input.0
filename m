Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794781315;
	b=fYr9GWWXoZGJpPJOHzNAca4zngiviyAw2GTkJVFGTso5yhaONeOoja+DcNzxqXgGzv3t
	 phkhh32cSGLw50xsTYPILq9eTv+/HTEHduP1MtFnxDES7Jzzbg1t0Zxee01oFdRKjR18z
	 K+2rehd4MT+Du58L0a7kRA+cdU1AJEOr3MwdAshm5sBaFnGqI9piVMaGIevKjQEXL+pIw
	 Z6Ge1lJnLmBgdpZjzMgAfMlpX2fPamZbnFEiFySxGAzG2hp8i6VOc89gpgqOVeUjCNKDA
	 8sf337I6BZzjnfDpXHI7nm6tQQ3XOZNlWMANjIDjR9veS1GZJnMejIf8PKkcdaHDVag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794781315;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=okQNacVGW0GUvXWHX1z1j8nSeLN8GKo8PtYO0Ji0Mc0=;
	b=ee4B//As/VyfZXGSbpFOv5FEUHQ6FwryVD/18lSXu27X0Ieo0oAJpt1GP+1dcg5sBSXE
	 3bMK0fMzbpv5iJK2gvU0XP+TTObvbMnjHDPSYhxsfaDPwOBZl6oz/4wt7cF5iBPeiVKYI
	 HHTVmCVfMeS07NHSd6o9MhYsSCojXeAnde4iPPq5qFx89IGn6hMBqvesek8RNx3k2SFr7
	 i3YR1OPbL6JCmm7IqOqDPrgy4c465LLuGM5CMDqUKb92WQOsfNbybWc8IgRpNn8ytMgc6
	 cYKfJ6JYn/K3AvoghmE4WB+ChVO3zEWJPBwGahsI+ZygYbjm+Hfpu3go7YDNBr2rMgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=5jGnU8sJ;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A615606A323;
	Sun, 15 Nov 2026 22:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A615606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=5jGnU8sJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=okQNacVGW0GUvXWHX1z1j8nSeLN8GKo8PtYO0Ji0Mc0=; t=1794781314; x=1795990914; 
	b=5jGnU8sJMiBDHvn9IaaJFJb1bM9aE59qJ4L/p1p1zDXS7E9U5XWYgX042oThWu84m9QfX7FBDC0
	pT7rKvIVFIE5Fr6TuY/+DDGooh5Ujmzg39DuI7cyFoQxOwG4rYH3JPTfYSBpDgRvOuukywueXidrW
	kIsFCwSJTL0xcZd88zveOpehs/E/Bozsr4LnemW0gSiLl29H++oqFQKt2RDXHTElaqXRX9wbv1CRG
	LJXHtN1a5BPSHZ37UmroUQnsb7d7PpE8FugIIXNOlfIXu+/MThKA/aOx+pVWbQS/Y4hJFbC3ca8NZ
	1vF2kT+66bZUTCm34UXh1XP9URSfPcWfnFxQ==;
Date: Sun, 15 Nov 2026 23:21:34 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, "H . Nikolaus Schaller"
 <hns@goldelico.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy
 Shevchenko <andy.shevchenko@gmail.com>, Johannes Kirchmair
 <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto
 <kuninori.morimoto.gx@renesas.com>, linux-input@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Input: tsc2007 - drop platform data support and
 cleanups
Message-ID: <20261115232117.463f601a@kemnade.info>
In-Reply-To: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 22:50:32 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Now that all in-tree boards using tsc2007 (including SuperH ecovec24)
> have been converted to generic device properties, this series drops
> legacy platform data support and its header file, removes redundant
> memory barriers, fixes minor coding style issues, skips registering a
> non-functional input device when no interrupt is wired (when the chip is
> used purely as an IIO ADC), and uses IRQF_NO_AUTOEN when requesting the
> threaded interrupt.
> 
> Thanks.
> 
> Dmitry Torokhov (5):
>   Input: tsc2007 - drop platform data support
>   Input: tsc2007 - remove unneeded memory barriers
>   Input: tsc2007 - fix minor coding style issues
>   Input: tsc2007 - do not register input device without IRQ
>   Input: tsc2007 - use IRQF_NO_AUTOEN when requesting interrupt
> 
>  arch/sh/boards/mach-ecovec24/setup.c     |   1 -
>  drivers/input/touchscreen/tsc2007.h      |   5 +-
>  drivers/input/touchscreen/tsc2007_core.c | 183 ++++++++---------------
>  include/linux/platform_data/tsc2007.h    |  23 ---
>  4 files changed, 60 insertions(+), 152 deletions(-)
>  delete mode 100644 include/linux/platform_data/tsc2007.h
> 
Tested-by: Andreas Kemnade <andreas@kemnade.info> # GTA04
