Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578943D504
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623977; cv=pass; b=GLm4xNudH/37uVSwZi8Z/1ix9qo5YIw0mR6/w68AgorBf73KxAQoe+owHyS5rEdUBsIVo1keLVjJUL7dTkDS8QRmcW9Q2r1AyxnM0aXFF3P/+C6E58NfeXEnUYV7xbGfU7UoB6pdrC/ASXSXAPpngdxesNjpXkSvhNaLcC4Wl4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623977; c=relaxed/simple;
	bh=9ryEeEKN34qoxZ5iOwtkmdOLrQqqwl0md2Lu6yLAkww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuvRuqqpxDvzpxnECpy1DrFhGR+Mul5gIP87mo3HhLBCpknLQ2vV8FafqDRXj6BNZq1vxO9DfqSBKVwJqbM0EyVSegBhPvDZjjXjVbUJXzKAXLRyh1ZlnVz0P31UFa5iC3wBEv16XLk/ZZR7b7DLcF8reW4G2c2o6UoqT/3O604=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Onak4tcL; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Onak4tcL"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68d23396ed3so8003844a12.1
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 08:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781623975; cv=none;
        d=google.com; s=arc-20240605;
        b=J8gF8u6yYG060b8dfIf47Ta0TOsdFQ+s5seP7eBFjPE/LkWcYLaD0vZpDqLY7ycBzX
         HPyIDa25bq4UHLgfMaPvpDK7ITQzUhCw0n8vswaA55lp4Ucw6+0HOljPFgbt9wVc6PPt
         f/xW6e71XhIf2ph8pNBMY6d//8AomzWygaQpoiJSCb1gUl2IcExdSM108fso5FLGkRv2
         tB8HiD+UCQcueHMThq5U6wFJQojOPCU+7Ojcd2tER/IJHB7dVZtgypcd3+yNuIoxyGOH
         GKagXR7Phjoi8bLyLavt8UuG4sCPLqG0SFVa4zY2DmTfwtIwbSUpK6rOL6/iIMQSXUHu
         QNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pfw1ICkm7+kbiLyNwGHlM24bHrY+azb4TocUjKCxBR0=;
        fh=SkJuNOZdZt2NxbZZlM71LKoTOxKD/q6T00t5a+bTmtk=;
        b=hMF3cw3K+6QnlLlTGHzQGBwd6qJxVvOLXaL286a6eY8mzAmdWv/KNeMUiq/tGqXd/6
         0vuQ5LqaZvmGtKXoM8XZZI3i42N6KYpR4u9Ip9grtSYYz4H99jl/z6mHpObzExoUHjiz
         DQGC7V8eow1AuI2XOte2ey983mHKZj6sSGzwnLWGjbocV9HCzlk9GoEwPq1ZYVpKpRlu
         rQy00dhiU1YnRUtKpAFQB8MXuSuXSe8JGQzUjxpQxQLoOkJ+nXqHnc42F/1SgLb3n5v3
         V1uoHtpRA0KuLls3cf6bSRKNnWnSS7ShE2qsBBHnatPRNYdLc1TPrWSrncCgpQPmdMPY
         I2pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781623975; x=1782228775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfw1ICkm7+kbiLyNwGHlM24bHrY+azb4TocUjKCxBR0=;
        b=Onak4tcL5vSFVX9zbAMb5EL2enSwZMolN7dPWdBSvZ1YfGpRrRAmfSvARvhFef6wof
         cC1Y57VJB8c+fnIbL1ggRxC/ShwE7AfDkiBBgip58TToDiFW3fA3wUAG661aMIgBZy5E
         SvYJygCDWsbciA7gnkRjAf0+6qbp5J+oDrUfJJ5CuV89vaDeClKgzEYShVIN39M5na9F
         MtV6ZOalGVHYMCzSzsjn8b7nV/wOPpSRMDIDsiqHMOOnPd5gw80xGoQ7oxiDqIn59UeP
         HaACvImgUJGUu0jZ1c9ookZx7k8MQ1W9qy14X226sVAmTI1chWtEuNtxtyZhbUXP+Wvc
         exyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623975; x=1782228775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfw1ICkm7+kbiLyNwGHlM24bHrY+azb4TocUjKCxBR0=;
        b=dRNIjAUd5cuMfL2mklFUb1PWVCp3xKijJAkOu88XfIYcI9ND0KqpxEYwevHTLDZx4h
         q71/jNH4/DTAQe1S0AdisZB61BjnwUYG1KzlnxkfGREWb4OjKpp94jsX3fuikMZDXuwT
         ++jxYFg926GHJ8Elj9r3gK+DMzTobqun89kgmYRJN8Gbhfg+TUBs3KTdUtaJ7PBqXAIy
         TqwpWM014WKY/d2E4UJQHugug5dy39ifxj/8nfqQn66Y14ZL7GM/bfc6eGEPAa8tMwXL
         Z4GeTNC4LvvbgrCtVLdLZ5MmbS+NJOhPYdZxe+Lfx2rJ91S9hMP5YK/FpKtrOLAMvOUD
         Mvww==
X-Forwarded-Encrypted: i=1; AFNElJ9R501/g9viPr4jAB4m4nVf1lGdWJyLMnMCgmB3usfE3rM4b/Jhu1G0VPxrPsVh9XTJHXnUumP9HCMbYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyotIwiQExTzYfGtS1iKXMU5gsQ6JF2/6R/SNPvhLOeNsE/V7hg
	5oKrUfFyrlk8ZQV1V74sC+nEFei2IeapvZdSOHVOZgjwlr2xk5pVHnU3On5pu05Wi/Fx0DagZXI
	f/ltKOsPEvbJ5dkdJMASH5zFTWWi9u3s=
X-Gm-Gg: Acq92OGa0DEloqmrCKpFm58c9JdL0vwHXUH+cM/0YZJ2pe364v9rTjVTOO77NzbYfg8
	Wd3FjCyfxHHeNeWRXPXlBVu/Ky0QBoss+lzlek+4S6/jORJ+ujYioLHDKGUytZTtuD/rUAVO/DX
	Vv9TZyT7E4hA4PpxZ1/HBQn6C9FoYhJWTy5WccBfWcxXaIwbDtbsRPX3S+tEWDjFqruF8yKoIQy
	H8ml7XLEHo21FzDZseVfbnkqynXMsL6tcnfCafxrj8JghlumBA1zhnb1v6DIrLnjR4BrmY49s+m
	UkexLg==
X-Received: by 2002:a05:6402:3488:b0:68a:c8c8:bf70 with SMTP id
 4fb4d7f45d1cf-6950875d069mr2423072a12.26.1781623973864; Tue, 16 Jun 2026
 08:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615071836.362883-1-l.scorcia@gmail.com> <20260615071836.362883-10-l.scorcia@gmail.com>
 <20260616133918.GA2335264-robh@kernel.org>
In-Reply-To: <20260616133918.GA2335264-robh@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Tue, 16 Jun 2026 17:32:43 +0200
X-Gm-Features: AVVi8CcxGgSJDcwyWDi8AM7eUTYUD6802ufCx2_1yb4EtV-skFio6HexhMd5f18
Message-ID: <CAORyz2LiMHnaTK6QnsLxJDtw0fZ_N9LELw0iCorOZwHuWXus0g@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
To: Rob Herring <robh@kernel.org>
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

> >  arch/arm64/boot/dts/mediatek/mt6392.dtsi | 75 ++++++++++++++++++++++++
>
> Nothing is using this so it is a dead file that doesn't get tested.

Hi, it's not referenced as the dtsi inclusion was removed in the
original patch from 2019 for an easier merging of support for mt8516
pumpkin boards [1][2].
If you prefer in the next revision I can add another patch to readd it
to the existing pumpkin board.

I am working on a few boards with MT8167 (Xiaomi Mi Smart Clock,
Lenovo Smart Clock 2, Sony Playstation Classic) that reference it and
these have been used to test it locally too.

[1] https://lore.kernel.org/linux-mediatek/20190323211612.860-25-fparent@baylibre.com/
[2] https://lore.kernel.org/linux-mediatek/20200229170401.1287324-2-fparent@baylibre.com/

Thank you
Luca
