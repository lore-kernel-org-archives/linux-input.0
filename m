Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB132B2D7
	for <linux-input@vger.kernel.org>; Sun, 10 May 2026 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778385329; cv=pass; b=Mq8wy9iD92hd93qpywfoUWf6Si2dqQgzjU9229heChZ7B4URUSsAswzsYq1/FRNRrZzWb58ViKUPu8lgK+GkLU0qXy9GSCV7rDA0hZ1g2kb+Su/jvf5ppg+8TvRFz9pzxHPsNXvqIz0yRPTxNLaxgEdMgV+O5DLLCycKjvR6Jks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778385329; c=relaxed/simple;
	bh=Sm3QoIzBAGhbdcC7wWKGSnMpeN5ZALJn3udc/iZ0x+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGln0UslBWX57PQgZxEy5Jh00p/jQZmAv2/quBWhXawZ4jV+1idlFhU2jj3XV2IK55FmyNsgY1tkqVYky8Y+Or4h14EkHZenJPzuHKhfIlFwos0QypHNgLZc0kgzhaM/W9g+Khqi0tDcDw08O7AtnI/dW0L17SJJwX12exb+gcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beI+zz14; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beI+zz14"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so37699866d6.1
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 20:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778385327; cv=none;
        d=google.com; s=arc-20240605;
        b=KuPdIt0yc1W0YV04rNMP7AlXXtIrJAGZi51U2bVZ42qTRN6QZJVcaznmwWluvX1rRy
         TTe0UENmnrjx21ijey9TgsCof6aHUWpUGa7/NfAg5kYRflFCHBZXqi7rUO2TzHeFqE9e
         jJG1kZAxmHZObhJguISt4Lm+ePlm7WiPC028QBqmKiJmZgQuqfAWW268uKIQCz0G/5Ce
         RQqvLw5p/rW7gAqZ5tYIy9VbaIqxND5kynmvaFxz70hyFwnO6fzIINfYLDXQkfTzZvbz
         Vqtsuf5Xbbhze8dZdsSHDPHEZALAOXH9xlhPAIzp/qMm3rSqvDOTBSgPQT55m/XSjglf
         FrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sm3QoIzBAGhbdcC7wWKGSnMpeN5ZALJn3udc/iZ0x+w=;
        fh=pfrF2UIixBEJzWAHHwv3VdfIzr/xhJCcUapDiG8ojyQ=;
        b=DFckkpUUp3huj38sQ8Arb5KMDMRItckSWxMbFuEbJD5krBN4NyFQRJDSeKf+v+XrCS
         MdJWmbcewP9UmLX+BXU6qhWKndgIolIIUCdkTPj3Nbc8M/kvKBvlAGsDok44g+0UmJDd
         QWuPwmYrm3OaUCwgufTRn9IpQQqXdnDp4U3h3CrNfTitiuZaE6wo+JTjeFrNkEue1yIy
         3iJqzk2Sx+5TffFbfB4PwGgBA6eCyOaxBlE2tPC+imFk4BJL+TwJQ+UElSqdJsNoSdmI
         DXF6R7D+Z7iTwV5HGgx5+UquRoB1lHM3WcoBUL+s4mn9E9nqkXfjR+w956RNMkTPcndl
         dW7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778385327; x=1778990127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm3QoIzBAGhbdcC7wWKGSnMpeN5ZALJn3udc/iZ0x+w=;
        b=beI+zz141aWKh7sa6Cp1ATrN2t3SlY48yKff9d6QRlQz9CLu0aKtYqVhSY56Chk5vY
         G9cGZOdXYR3UauMAdyOeBRPHNScZRwVRb5vbltn3Tty6TQ7iLFbyaNqyZtLGj5g/hWYe
         DY8kl7VRANDF9232CpOYDkk7eSqcRUwFbbkWbVYtX3L0qifuL+k5q9g3IkNhJHhDelIj
         P1FhTTurO3nMzQCfD4GZFTyqcuXUW1bHANeeCfPRUsXHkd5vvPgYp33BVgcoNY96Mfkm
         ZgNz8fZunmDSyrA96z8j6euOvTCgCFkcYsCzRFERIQOs8d2FOSXxvidUjHJ3rHSOz1KG
         X64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778385327; x=1778990127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sm3QoIzBAGhbdcC7wWKGSnMpeN5ZALJn3udc/iZ0x+w=;
        b=qUqzudCn58Bs2rXbj3ESiQf1dZIE1J97UUTylW/7N94iD6Drv6JV3WtENAGdndQ/SP
         pEh1fUEdc5xq0F7+JTVgfVJwHP1uKG4kU/9PwoTbG3RN7F7yykNTnrkpZze0RGRov1tE
         uISvA3nPEAAVIuAXQxIzS6zBugtoBY4nM61++k9fRILofbXp8mC+TMOg+pxbNCqFlct5
         zOsX4tReOXEZlNUc5i+wWafF1hqAAWL52C5wKR8EZlubs+IwxxDfqL+1lRSe3WRVHPFI
         S1MP3PWR+iOGZSjddCLn5Rpowh7yCI8uEEQXL4/FlSAY1P7D2odeXFYS+VIXtQPi/yvE
         30Tg==
X-Forwarded-Encrypted: i=1; AFNElJ/M4/q0GL9cFMJSq+9MxdAgBLn3oiAp1rzKmYXwLas6RX3hBwnsjNeifj8auKb2smZ+iJu1kX13sFAOsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdAHlUsDegXXqN4F9M/pmxv2f/DGHCKrV0r5mbeBt/Ebx8k27s
	ut6AjlrHTsKw7YrzX72YMXRaOjxn5URm6JPt6ccfyQB2Vrn/itklEbpklhlb0vxkbUqZtQCdfLH
	blhrzBdtP+2DjKvxQLZUJbpKoiB5Npuk=
X-Gm-Gg: Acq92OEIB0bcAzPF679g2QOgLz71zc5cY0lbpwnTY0didheJFT/kE/scXcm0ngQ4I1e
	Akx7zX9seEw8HOR+m1RQEyzjRjIrNtfUq4l11cBzJoBt/KL0iwpMoSNDts1aC1/61Ngz0evhSwG
	o7F/jDs2F9xABNYDR2CBFAd506vRuOuWlgX2lVr2NZQYywtBXV+Q0rheq2qUOjtBatfTzUDXeLp
	YqpgOHoEtL3+cQ/pu5gbYW6ZemQgrpZ/5GnX7ZEeG6KBfWbmvCWOei6TycQjU1hXmB999KcvPLu
	DZ/fPMHiBJviUiNLnNMKEi0JsqiTBDeEX4x1QrqBoN5/F3Gjlo5oXtDHaW2/OFofptM8
X-Received: by 2002:a05:6214:468f:b0:8ae:6d63:3066 with SMTP id
 6a1803df08f44-8c1af2eec23mr74681536d6.38.1778385327146; Sat, 09 May 2026
 20:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510034652.349166-1-enelsonmoore@gmail.com>
In-Reply-To: <20260510034652.349166-1-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 9 May 2026 20:55:16 -0700
X-Gm-Features: AVHnY4KHAcxaV8_IVOk9z2g6T2k_L88IWIdSF--hWqkOCrjjQZ05MhMkD9iMeTU
Message-ID: <CADkSEUhTJnHJUTtSrcKAuG2506OexCEFxVAvZ08ThkeL=rnDBA@mail.gmail.com>
Subject: Re: [PATCH] ARM: riscpc: convert to sparse IRQs
To: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 8:47=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> This commit depends on my previous submission "ARM: <asm/floppy.h>: fix
> build with sparse IRQs".

It also depends on these commits, which I neglected to mention,
because it modifies the same sections of code:
ARM: riscpc: use iomd.h everywhere and remove redundant ioc.h header
ARM: move Risc PC-specific <asm/hardware/iomd.h> header into mach-rpc
