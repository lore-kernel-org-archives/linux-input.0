Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060847D935
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636235; cv=none; b=b9o72GphTMMKGFimmNUCIPo/k7OVkp6eEOjB/5i647BYRIRut/6u7pg4ifdof9m2mgKB5+k9hyZm71z9mNblUblO0sC0ny58hl1TOpcBuk17xId1MIPD2bCV46YwjtaZ7SlT4/z8oBqJxImYvkshxhVuVy/wPRN8KvrzYYwxZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636235; c=relaxed/simple;
	bh=6/bCaUbtfCncrtxzychO2vuRtHH/oCHj4qDutkWacWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rzkw8NUCNFBmfwtIDGIay8EZO6UnjN9EwyuJfkllQGJ0xcn/umRlecJOr6Ubvj/eRK/GluOVdiQ2JOCNILebjnjGJkakdSH0X1pL17TzYXZdMHS5GGVaqP4irsVboNmE3EqOcLCNHDEm4zZcsQfe880edvJPXvL3Ya2H/Jn3A/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luQxn9cl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luQxn9cl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEF21F00A3E
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781636234;
	bh=Kg5urtXwHhG5NTd2I1ePWdoMCidQs7lsiIoCNc/Lh1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=luQxn9claLnfUGUe4BPO/rKUJCKvbYkdDQ+j2wsHIRz6AQVNGuQHOD9FBHPCskdqe
	 Talz+wHwrzepupIp3d+SdJigCtw9Lh4qC8oi7IQpB9SCoXxl+LgU4f66IuqYKOZtf5
	 tieRGEMDoKYR2r5sJZGKvXFJ3dDoywYVOh4JEgDYatvyfewTCFwCT8sbizwxy+HVbk
	 rsBMS51Q/mz88WQrG5h+I90N7HeVmYm0ykIqXd5MmHWUHpLkCkLf8+fuCfQ0j6EYWU
	 WkKYh5OPblH6nMNoAMO8dNfO4Ja8DM3ZVM3VCiavzuHNaL4KlPW3pK3MdD6JQMeQT1
	 1u5RACOzy2rzg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-695427c153fso516148a12.1
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:57:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8UpPq0bGOVjqj49CL+/M/vuhb3fBFBK+bziPNgRR7WqDmumxrIAeGdnhB5olrDT1JEEekcvWbIXWoVmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqI8CH0NQLdVujqX2pESKvVNs5gjpjyikdTiIPxgFcdGW/MbSi
	5zLIhxpUM5JUzUFD8cE2nBwOeoVeAGGqLIhy6isdkQV59qRAkn8M6uMHfo02ubUGcstGMxgZ4Bq
	3u+zj9uy1F9UnZLylWZJ1UJyXHc2rqw==
X-Received: by 2002:a17:907:aaa:b0:c04:1977:1025 with SMTP id
 a640c23a62f3a-c05a128a414mr47141766b.0.1781636233441; Tue, 16 Jun 2026
 11:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615071836.362883-1-l.scorcia@gmail.com> <20260615071836.362883-10-l.scorcia@gmail.com>
 <20260616133918.GA2335264-robh@kernel.org> <CAORyz2LiMHnaTK6QnsLxJDtw0fZ_N9LELw0iCorOZwHuWXus0g@mail.gmail.com>
In-Reply-To: <CAORyz2LiMHnaTK6QnsLxJDtw0fZ_N9LELw0iCorOZwHuWXus0g@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 16 Jun 2026 13:57:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLGqqyDoGskgmRLzQC=UkFEXgW=cDazc=frO2KBaSri=w@mail.gmail.com>
X-Gm-Features: AVVi8CcwnrM4llpoEzOBnyyyWauL3xCmDN5lvRxGwwKA_noSBsMx_Zki1jU8Teg
Message-ID: <CAL_JsqLGqqyDoGskgmRLzQC=UkFEXgW=cDazc=frO2KBaSri=w@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Val Packett <val@packett.cool>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Julien Massot <julien.massot@collabora.com>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 10:32=E2=80=AFAM Luca Leonardo Scorcia
<l.scorcia@gmail.com> wrote:
>
> > >  arch/arm64/boot/dts/mediatek/mt6392.dtsi | 75 ++++++++++++++++++++++=
++
> >
> > Nothing is using this so it is a dead file that doesn't get tested.
>
> Hi, it's not referenced as the dtsi inclusion was removed in the
> original patch from 2019 for an easier merging of support for mt8516
> pumpkin boards [1][2].
> If you prefer in the next revision I can add another patch to readd it
> to the existing pumpkin board.

That or move this patch to the series for the board(s). If the board
is already upstream, then add the include in *this* patch.

Rob
