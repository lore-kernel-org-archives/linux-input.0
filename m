Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9C5505DC
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924564; cv=pass; b=V+RdphAs4USG1dzeecUIrJvpaeYgOCLo4EhDKGDHGoUMI+shc9KU7vMcrna2uoxuOhc/hgeuMwEFoIRvlxiZ9CtX5hgAlDgba1PVW8XF+lqMpP8X4CkjkF6clATYn3T/0uO5/4uSQqO5OoW7eR+YpMAu0L3/bpcFDhrEl4CIryY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924564; c=relaxed/simple;
	bh=VCb03VA6LjpMHOfUp8pvf/EGXGe3r0X2vnJKPUWICB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVOPgPlKofGes9MCFnfsAl9PcfLRZ1M9BVocBcZkY5B5iCukkCVh3dFmRZIojEgFFZnVCKzsHuIRMemq9TvkjFSJwDOk7lJf2hALuofxQo2pAeYIbNklFKIhGnYLmilPNi9d+33E5MZXDCRWoY/r1/Qq5AeuMfPFSKWzoY9BLgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hq0WLQJE; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hq0WLQJE"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6768a9fc0e8so3182689d50.2
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 13:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924562; cv=none;
        d=google.com; s=arc-20260327;
        b=HEc35oW261EDao7vZTHp5v7V77JeQBH1O5Qx7xGnJlD4/9Rtf+D6PNG+zEC+1Zd19N
         bCSEEknrVAD3W1SVYpbdRnejYSmOXaJ1E18w+N/2pirVhwiUNQ/3YXZnaAX3RQYm4vPj
         /ftE3qy4bzikGggEHcU1enG0M3+RynqvymKHUa1VWGLvCPolPBSAPSdTZsTeTWqWZoZD
         H6P3OD5/nifsPo/G4M0D1ks3ZA3tGEnoUXxKPYA0M7Asfu/7v5C895eEN0iqCX2xNwlT
         MoB7Z4Np2KT1XQljAb0J34ph9a48ZX9sc7PY3u1wtZBbQhH6ZkHfXVRA5kuMo3loWaRu
         eIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VCb03VA6LjpMHOfUp8pvf/EGXGe3r0X2vnJKPUWICB0=;
        fh=IS8/dC4+KlC9NNO2Tqf9f3OIooRorCo8m0Ck4bYDB9M=;
        b=HY2/S9L1HMJfP6eWyL8X6rOGu1kgIb8/m5w6Cskr299XZOe8lijlZ6KbkDQhIKAHJZ
         q6j3itHUnnOyqbL2Yn6KojksmvbRqv65X9AziBChd0hHcxArGOytP022mfWVBaihcIp1
         iCJsnqR+ej1uTL+CpPnUiNMcgvVM33UWInpcBv2jw879qFNUBUvBZ7gS/pTMKyGblzkA
         zoQUnVk/bkcmcXuymEKjTorWSo4dkDfGI78vWo4X+AoGRu5lM+PXtdjG/cEnGKVaWRFX
         tA9BnCpYdP+CSzkNgeYnfAn+1KJLvv+godghLH/WljcIj6tbIO2ahFi073VBQz6Ewp1k
         hyPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791924562; x=1792529362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VCb03VA6LjpMHOfUp8pvf/EGXGe3r0X2vnJKPUWICB0=;
        b=hq0WLQJEF6QP73pmJ6c8FJeMVwrlj6kQptWIXaj1nw7k4uKBOCtdqhFa4ZEx1U9iI5
         2noQBoKQenrv5zmZJK06HyjM7oJBoTx6T6GOFZDkIBKYzCTH4eq2ThweRjcfkv9OdK9g
         gmGNRBbxuOwIzL99EqhlmFKi50HlDL2A7kFw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924562; x=1792529362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VCb03VA6LjpMHOfUp8pvf/EGXGe3r0X2vnJKPUWICB0=;
        b=NTRViWhhqP8eQ7RDnaDWJhyQrIz7gHFSTsACUbnI4eIrZL5cxQtVPhzOqco3gOJ0tb
         yDOsDAoSAyLR2OLHc2tL0ZSpf0qjZrepm7oZAU2gQ9Rg0UUtR1/Suv1Qnx6bP7svBt8g
         jbtN4ilZaVLkkjufY2X1Hrk+w7W2hx/5eFXs4EwGwi/LhJYV8m9UHpRya4+EiApy+lyZ
         HW01wqJgtnxu9DszRzwuBSN5LDefIzdeMxMYm15qrwEf+1BAuBRj/NhzpnelSpi4N+i0
         VppWHCQyrpQ3tWt7peGb409coS8evVQSuKEwywXi7bG6XPOCltNeC1ynq/blucJltC+e
         jrrg==
X-Forwarded-Encrypted: i=1; AKwUvBzUKsAbGxjKSpIsImvdf8Hk1+BqzHjeFpcwGAl5TeVG446PNnlHQ86YOTaTp/0w997rztrKsG7rqQnJNg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLC6lwf/c8Zr4U/UXYiptiO4xXDExuiO7IqWnCZZMiDn1Olevvt
	V6G9LMzoQj1k4EWBIkX0JloigDAtsK6y7xZRDZNzE3o1zym65vUufXdOEqTcq6RX7Fb0gZDmseG
	3IKx0yNHIod6lWKy9zXExlS3pb7YGEDTbiIwqfYgh
X-Gm-Gg: AYBFou2lTiJ84W4FPtNpwmbjVrCQPagT8+BowCJ1XOpir9lI3KlfGkebaclBcuwZYAd
	bVY8PF6KKnccLOnoTPHz4tlOREr32QkRBIXhrfjSEuOaG/jj1yjOI0Y7LGARK2m6ycrkB33EjjP
	Rvne6ZAUKM0rRz7LL2vljhIywMAAKTSXitez//tZGAyVSwv+m9gHj9GGjZGRcEuemMoE9/yMIFm
	b59rH2t23Rh6UfMpo3YUjNmJVxuvKn3BOHpyMjiwXs6G4mTwgviWY3bbmVrWG4eMGcSTDgcdNNW
	vGpIYrvbRUvdDF+pnaE6TkJyqrCueLuKlKymbF38a5sljaCKLwF2/sn5q7XZNcqw8dw/u3ywqNU
	aLgSjl62Png==
X-Received: by 2002:a05:690c:3346:b0:89a:63da:fab2 with SMTP id
 00721157ae682-8b07ee2c80emr43041947b3.109.1791924561531; Tue, 13 Oct 2026
 13:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-1-384af01da3ee@chromium.org> <be3f853e-8b37-4b41-a998-94de1cb552f3@kernel.org>
In-Reply-To: <be3f853e-8b37-4b41-a998-94de1cb552f3@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 13:49:10 -0700
X-Gm-Features: AclHuK9ox7K2COGXrl-FRR9cM2pKj2PME_s-ad7oALLfV1KkNB6t3-cZk6Vgeos
Message-ID: <CAEe3GZE-3rCTw-2L-dzXqim5qHxLs1BKjpbmo9aT85ZBLWm5_A@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] Documentation: Correction in HID output_report
 callback description.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, tfiga@chromium.org, 
	fqwqf@fqwqf.xyz, daleyo@gmail.com, Jarrett Schultz <jaschultz@microsoft.com>, 
	Dmitry Antipov <dmanti@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 11:04=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 10/10/2026 00:25, Jingyuan Liang wrote:
> > From: Jarrett Schultz <jaschultz@microsoft.com>
> >
> > Originally output_report callback was described as must-be asynchronous=
,
> > but that is not the case in some implementations, namely i2c-hid.
> > Correct the documentation to say that it may be asynchronous.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Tested-by: Dale Whinham <daleyo@gmail.com>
>
> No, you cannot test documentation. Do not add fake tags when they simply
> do not apply.
>
>
>
> Best regards,
> Krzysztof

Thank you. I will drop the tested-by tag in v6.
