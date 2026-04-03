Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0612F39AB
	for <linux-input@vger.kernel.org>; Fri,  3 Apr 2026 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204595; cv=none; b=M0UyUD5eGS6WtqGQR/sxIPTcdRseciGkizAmjFS2/jaW+AzmWrb3qoI3tTxHVdxAWtHMryv3DhvtngkrASEdLazXo5v90+Ef8ao0K8js/5VWR5kgEot7XAhnSN8GlwH8BEJhfUSUQ+iqmSkGnJCBAIm4qiA9CXBeiSF+MB40Q2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204595; c=relaxed/simple;
	bh=23lg71SS1ypLE/10It2aQYW4KhKP+2cYmx1DGLGdzjA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=P5BJtvg/+WiYh5+T/Y7nX8As8cPe20wVn4rdX8LafaqNA8CMEXJljmjQ1L4QsX9LXKF9Zo6+gC/2GNLEZExOJ67ElcpG9mY0ckRYnnb3Vrv/EdnvnsPPb8uDVrP2MkvjLRAXwn69IvxW2gNmSW2b0/9+SkvflJ3Al0ocPUOkVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=x281Uxd+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="x281Uxd+"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66dece07f3fso2612999a12.3
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 01:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775204593; x=1775809393; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23lg71SS1ypLE/10It2aQYW4KhKP+2cYmx1DGLGdzjA=;
        b=x281Uxd+O1epRbfuICmVyPJkXA5SYdzMCZSDDYsaDeMWFjMZydJgqdSsBiP4QkdMTH
         wdwKFSAQ7txNW6HyUljdoUrfpaGIzbIL8Bd4WlM1ry+xIUjOlpPr48DdUXY9Lvu58rTc
         O74XJFcQG7oAytQiloE4qjmhbU1siHb+95qe+uXBaLqAfpLPhAJpLeUhqAWeKprmhtia
         zHIe2TK9cg/K07gEjcgtRR/e3fjO2HTYc5OZbziBYtWFctlonKUrc6ZD1JZNY0PIa3eO
         M4/wUPjbs5zxDjzf3g25tDZhbg0hUrf2dAOMw/W+2yXnG7EMOd1EGrOJR4v2pLWagNS0
         ujKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775204593; x=1775809393;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23lg71SS1ypLE/10It2aQYW4KhKP+2cYmx1DGLGdzjA=;
        b=GG+23dIMoNUWxA0y97lZ5C8/d3SJaQ4vnMXxAHIHqJFIN4PhzfIvV4x0wVujphr8wP
         Yu3wWbOlAw8X6PghuK42HHH+XHTBTaUbTQmBhzXMugqiCirDpUpfeK7NYOO9BocoE2q4
         3WM39H4aRuOiyHiTny2T7wTjddBHMj7loFzN5270yaOdbG6WjIKjoXmVPS5WEqgJ5QAb
         lP+kC8V3OcvCWtQmymGOeLWx4J0fcHCGiOhtn+XwkWfznF6J2g9xspAgOYSnhXeuyQQp
         1XjL3noJXt+7yE92K4h/HCRPUDJZSpcI5WE1j8RPIItSXa4U5lH18S/DM0LvWfgc9VP1
         u9XA==
X-Forwarded-Encrypted: i=1; AJvYcCUu34wCrUNYe14Lw6Yd/nOohQYK/kyk3lCuI58a+owFgHi5CRwzZbSMj3WK+0WkTgCsH3+je8JeTeoD3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAnfTQY6kj0HZbw3FRBeSAaRVBFaGcRTm+urf0c2a09+VePGm
	mitcpaVVTj2gcfA+MuayyqNi3KBJ6C4V73sh4nzJMM2KSvn0ceeudQcZWqz9+MipLaI=
X-Gm-Gg: ATEYQzwB4ssBYzBkR6sizqinyd0Pb4Egn9iogkIsSRyY8Kz23jp9qiw8vp7EWFEa6vm
	cdOZe0x+BY6B2prDZgvJJbN+Opd0IMu7t7JIglMf6RJ/BNSv2PHIyEb4F6hkfjts71Sgjv29c2M
	jMt3R9Qwp4UP0njx+xbbYkDqKlMxd7RcdCL4FansVe27YDmLSQSkYziEuZEw3S/l4l2bSVbbill
	fkMF8w4OTk+TI205qRwsIFrc5wLkCFUO+NzYU1LoatBfK+ZCVJn/FVfatQ750KRrJFednIsd/Vg
	p5iPmP8LFDYJGXjU59TaJy0u4Y6G6TlXSQn/jzpiJDxH3vGEupfJbpyex+w9NhmJyGpv5mpTPfR
	2ZCnpDD19HS77xvIUYqwBCfveRqwNPh/AydL5m73iz0Li5kv+jQSe5sdkIZDCZMgpdN0c38nsou
	XvJmLOFut7+ycPGERDJ0aO99hmjyNWo5HxML8J6BeQDWVkzpcZQdkpRrS046Jv3hQawAculjYxd
	LehJa70ZUuIPI/on93mwgETlgCEbaBHCcsV
X-Received: by 2002:a17:906:b391:b0:b96:e593:fd32 with SMTP id a640c23a62f3a-b9c67308377mr71993466b.12.1775204592537;
        Fri, 03 Apr 2026 01:23:12 -0700 (PDT)
Received: from localhost (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl. [2001:1c04:504:7401:4b2e:1820:6d24:b264])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e034d60desm1398832a12.31.2026.04.03.01.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 01:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 10:23:11 +0200
Message-Id: <DHJDIAVJ89XO.2OH312F9UMLXN@fairphone.com>
Cc: "Griffin Kroah-Hartman" <griffin.kroah@fairphone.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, <linux-input@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] Input: aw86938 - add driver for Awinic AW86938
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
 <20260302-aw86938-driver-v4-3-92c865df9cca@fairphone.com>
 <aae7fRYaoDHMptyu@google.com> <DHHWDE7QEOTO.1AQ85UBLO8IQG@fairphone.com>
 <ac1DclNOl3ZA5bUg@google.com>
In-Reply-To: <ac1DclNOl3ZA5bUg@google.com>

On Wed Apr 1, 2026 at 6:11 PM CEST, Dmitry Torokhov wrote:
> On Wed, Apr 01, 2026 at 04:44:47PM +0200, Luca Weiss wrote:
>> Hi Dmitry,
>>=20
>> On Wed Mar 4, 2026 at 5:56 AM CET, Dmitry Torokhov wrote:
>> > On Mon, Mar 02, 2026 at 11:50:27AM +0100, Griffin Kroah-Hartman wrote:
>> >> Add support for the I2C-connected Awinic AW86938 LRA haptic driver.
>> >>=20
>> >> The AW86938 has a similar but slightly different register layout. In
>> >> particular, the boost mode register values.
>> >> The AW86938 also has some extra features that aren't implemented
>> >> in this driver yet.
>> >>=20
>> >> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
>> >
>> > Applied, thank you.
>>=20
>> I'm curious, where did you apply these patches? linux-next doesn't have
>> it and I don't see it in your kernel.org repo either.
>> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/
>>=20
>> Did this slip through the cracks or will these patches still appear
>> there?
>
> My bad, I think there was a conflict with Dan Carpenter's patch and as a
> result the series got stuck in my internal queue. My apologies.
>
> Should be out in 'next' branch now.
>
> Thanks.

Thanks, appreciate it!

Regards
Luca
