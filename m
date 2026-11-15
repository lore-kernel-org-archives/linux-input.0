Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794736683;
	b=USSCtlddG4LH6RYYKgqtcuMBXG36U+NZ0QeqO4/LMXs0ZVqRhFXJrDoUV7br7GP7V3SB
	 IUUmkz+LKKkeWfIFlfLAfMpDqpaVPYlHzp3sUm5HOuH3Gh1RwVyxuyfwPpnxazU3pqVkd
	 mZlIuljDNCnLKMPT1StASfqmBIxAJfyby6z10NKBCxIzXuE0a5h6yLr2cDVDIctziJ5a8
	 3p2u907gX/doi70OX6H/OtTqqobevgtfiymr6HDb/nEgHWioLFE8q7vLpZ1gcZlg179cu
	 x8A5PrlLuDwG9ibcuSPIFG5rRLm5k+JzjSbW1Vme8sR/sH01+ZfFPBXjNveQbE496ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736683;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=COD171vyvKxxKpwb5czI8gQ1mbPD23UlzxgscZ3Oayc=;
	b=GdSU6RZzDTv3JLYcvKLxHCIFZhCUxhwRza0jQUxbGfVTYOMI3cmFO0vrS3wsc4wLeXF8
	 wnzbuwb4pbA8awErN5rN5I8ZKjBZRrWp5646aXu7VaW+oQP0bfnODcH37TEBC8dOl0sHe
	 gRmAgwP/ssZuyF7nrm0QwTAN2zZ1UvxecxKzHwu7gtUO2yCdM5y1jTawDbz6NdFxOj5xs
	 LHdJafLwzHiunVWdTtRxZen82gTouOzccp41EpWka3zxQP1s11lnBRz3minaAUmmiRKi1
	 L+uhoz9EaGegVUpbz6kJ2V1zmu0btFb/pIEYTFurBOWlwrnaX0qcVsSIv+EYy92O1Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=maryasin.name;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9D5606A884
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 09:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C9D5606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=maryasin.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so3756593a12.1
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 01:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794736682; x=1795341482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COD171vyvKxxKpwb5czI8gQ1mbPD23UlzxgscZ3Oayc=;
        b=I8TXv038pNcPx3YZ51G6gByVpahfW/LYcGm8PGW/3iuUsFAWJDNvwjJ4j81cLDasaH
         uRMC08hxn4N1y16RKTGYAFqIfJrHfFlRQTfSZcA/TTNZcnxg8+NxDTNhC+k+oOZgPE4f
         9wxamhIhgwWa4BM5zXRJvOKs6fmH/aG2M2VoSE81Mv6sqN2ms81SfsH9R3oqGt/E3XM5
         UA0+2KnpAp/My4nTZbGJSHKM1RZj8I4EGqOp2of1WUnaw+x43f/0O9g4E93pGwOaiu0Z
         k10HXto8AZut26nVMklsYFdJPzQO8Favc3iWha354W+x5aImRMyu1Y6CAVwoujoKdo5n
         U2Yg==
X-Forwarded-Encrypted: i=1; AL+hErG/Cah1cWnSd277m4TcIqBR4RTPP1MIHH23/e/pkGUReK+p9e32MVpH6MMEibnfvXSjzUuspkilzBTxdg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9su2jVouYrUTnqjZabjHpY1TsiS1CEnIBNy6ycIWIDGB+Y+LFO
	jeMiV136UOIzPsbOJuSbb5pr8aAmwXTZVrkcfBCcWRGYj30uFGQK9RuVnvge8usps6U=
X-Gm-Gg: AYBFou0p/kP83UoewgCDbIanQdXT3/L8X3f3ugcIDnURVWI7HzTvVoG0SmyvjaiXE0f
	M+tqBFvkOYmLUf6Yq+eE/pbLOuGD+lbEUC/jvIwnWBJj+q+LvbTanDQ92boYEtmHMCB6Wxpzz5E
	Kbmn3mE6PQ35xS0WAz6HhHBe4CPR8pmGeydut+anhFoGrjqMipyD/G74gm3FTHBhVKtUXquP9Yo
	mptghbO0252R2UfLQW6qTuzNBDZ6jZ6KJwkYDI+0WyYq7605MIvRrv4lkrxkxQUlWghrYeaXFzZ
	s706k9YVTlIS+F6WXzM4i50/Jz/wSw5IEh24U1y0gbqrV0w10ApPv19TTzTiG3D9j1UljJ9Z24v
	9ytLYvaag8KeA4VdkV+E/MtUFlWPuXZQ7p5SugGQDVi7G6DZ8V2YVHhh44dlz8I8dKRA43n3r1j
	g/mtR8kCROJIY5+fpR1HPJKtcTsj7ZIgjHXKFRePmqvkZL/dUJO8BD0ijVV+pWBpV6PnlrfnHew
	TV1rm0kq8V62D2MSjF+1FfGaylr2GiO3wyHe+4YuO9uY98eq454Mb/fW/YC131FlXl8RC9qNGf9
	N7T3/SLFuId021JGDjkFz3jVxK7kLIu/SvC6WSeOcRhV3E4wE2ePh2LeLRI00nYUvMHuGoRZPBe
	4wA+GgAeITsEQDENghech7LPUd5oflHLn7agJiv5ODZtjl9FzHwclZqv3iF9Jzr48KCIi
X-Received: by 2002:a17:907:60cb:b0:c4c:d6a3:f4bb with SMTP id a640c23a62f3a-c509634503cmr596290766b.10.1794736681590;
        Sun, 15 Nov 2026 01:58:01 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b8650fsm290697166b.77.2026.11.15.01.58.01
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 01:58:01 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so3108160a12.0
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 01:58:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEketf+8keghGZ4DD6CSNHcrkZvmuXhLWX7f/JoqYbep61carpXWXorzKPbSKm3kGAJJcBT26g2LnH6Pg==@vger.kernel.org
X-Received: by 2002:a05:6402:c892:20b0:6b4:21b3:a407 with SMTP id
 4fb4d7f45d1cf-6b7c0bd9233mr3786660a12.22.1794736681074; Sun, 15 Nov 2026
 01:58:01 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109195949.384888-1-srinivas.pandruvada@linux.intel.com> <20261114222827.4213d48b@jic23-hlaptop>
In-Reply-To: <20261114222827.4213d48b@jic23-hlaptop>
From: =?UTF-8?B?0KHQtdC80ZHQvSDQnNCw0YDRjNGP0YHQuNC9?= <simeon@maryasin.name>
Date: Sun, 15 Nov 2026 12:57:50 +0300
X-Gmail-Original-Message-ID: <CAM2dg7fDiAwbyJ6MdmbEbzCORWOvw3M8PA=DizDVW9dqJ41YDg@mail.gmail.com>
X-Gm-Features: AclHuK8YKYYd7hTDUaScS4yR4PzTj4mTm3WbiHpGDDzYY5tPmdTHWffr9PweY48
Message-ID: <CAM2dg7fDiAwbyJ6MdmbEbzCORWOvw3M8PA=DizDVW9dqJ41YDg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] HID: sensor: custom: use-after-free after remove
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, jikos@kernel.org, 
	bentiss@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lixu.zhang@intel.com, crofts@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Semyon Maryasin <simeon@maryasin.name>

Works much the same as the previous version. When I do `rmmod
intel_ishtp_hid` under an active reader, I get several Timeout errors
in kmsg (8 this time) after which the module is unloaded and the
reader reports "No such device".
After reloading the module, sensors work fine again.

> kernel: hid-sensor-hub 001F:8087:0AC2.0004: timeout waiting for response =
from ISHTP device

=D0=B2=D1=81, 15 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 01:2=
8, Jonathan Cameron <jic23@kernel.org>:
>
> On Mon,  9 Nov 2026 11:59:42 -0800
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>
> > This is v3 version with changes suggested by shashiko-bot and Jonathan.
> > Also rebased on top of 7.4-rc2 kernel release.
> >
> > This patch series is essentially the same version that was sent to
> > Semyon for testing.
> >
> > Following a feedback review conducted with various AI models, it was
> > suggested to break each change into individual, separate patches. This
> > makes perfect sense, which is why this series now contains more patches=
.
> >
> > Additionally, these reviews identified issues in the adjacent probe and
> > removal code when active sensor instances are present. I have addressed
> > those issues in this version as well.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
> Thanks,
>
> J
>


--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=
=D0=BD
