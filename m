Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA954364E88
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995794; cv=none; b=TGHWSzIWfEog+CAoplpVrCSBgBH5S0cm0WNy7Jm1OSEp+IBhXWR58pmTNPQD7yiWavH1mh7OdgaYxOxIQfIxdCBANJQDCN4LMsmfIuzz1eN+w6uvIAsho5KV7XCUtXX0s12MAgKASrZoy/6BFfFwxnVJkUPQtaqFN8DLDl2yNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995794; c=relaxed/simple;
	bh=5NSjks3xPrAV7mpe/a4S/VkxB046tijf468Dm5RFsr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltZJNFvk6/86aA9ADsTSFFA9BT3F09b6qEU0v4kEH5l/aJ9ry5JSMzal5k6dIcpXdRk/o3y89yz6glauGTgh3ZSbu/YErWZKYB6CIG1wAOf09i3TtrIrI6huxGUTws/3ovzoat46viLJVOVkoYPpg15SyOpgE3T1FNqmXmb2shM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZRGJApg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZRGJApg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6366C19422
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768995793;
	bh=5NSjks3xPrAV7mpe/a4S/VkxB046tijf468Dm5RFsr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HZRGJApg2bT5bVia1pJ4gvPFbBK0bytbU9bEhGwmBhCnaaRvpPkeJY/5kQqhNtHGc
	 SZmdTbtJWOy1llkg8bq7FwuKm1atmHwo/n2gxyWZ0M9OUsq2oRyUyOqb71ahUXeRKJ
	 d6Rmfn0jr+B+lLL6jcPAkfkX5WgV4Rc5rHS/60pB/HXmyRxX+QgutwPLfhLiucdj9C
	 /iOW0FkVXgLolWyyV96Lg1daoFy+x1t7/MSzEcmweD/QE74TXyWfk+rFpG+wh3IxjZ
	 I1F5AweGkDZlcIz9kU3UC1m9Gv8/wpWtCu+g0pIcQ6M64bBNi7qsX0hvdM7vfo1U43
	 bVu7fI+IXeV4w==
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64471fcdef0so5300926d50.1
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 03:43:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVVRoTv2lOtkfX2GdUKicFMG7mpwOj9QkIoVuaqw1a7TRKTF1BUvJYP94ArcTGigap9fPzbjEOVLyDHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuaJtX9cb7z4zoLxo4metZGrcty1SuGdkearuWzj+IgIIw2QfB
	PSJjInHXlpfhpncKBxU9heJeclPe1aoAgqfLT7fbWuTt28ki+ukid6QTfpOtK2z5r3cdELlGiOd
	cQPhb82UiVOiUxPHE84oKs4IALydgg5o=
X-Received: by 2002:a05:690c:b1d:b0:794:3be:f956 with SMTP id
 00721157ae682-7940a477f18mr83056437b3.69.1768995793002; Wed, 21 Jan 2026
 03:43:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_3AC818B2FE367BA7DD8940E08827CB146806@qq.com>
In-Reply-To: <tencent_3AC818B2FE367BA7DD8940E08827CB146806@qq.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 21 Jan 2026 12:43:01 +0100
X-Gmail-Original-Message-ID: <CAD++jLnSXPhqnTie9U03B7mn2x9ogUpABBLFwbt9dgtzdb3yNQ@mail.gmail.com>
X-Gm-Features: AZwV_QjxLG1kubGGyIiVaulQUqEfx7eZ9h-hx-ux8QhEnKs1HAMIalcUgqR8Xyw
Message-ID: <CAD++jLnSXPhqnTie9U03B7mn2x9ogUpABBLFwbt9dgtzdb3yNQ@mail.gmail.com>
Subject: Re: [PATCH] Add common hall sensor drivers
To: 756271518@qq.com
Cc: dmitry.torokhov@gmail.com, brgl@kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xuchen,

thanks for your patch!

On Wed, Jan 21, 2026 at 9:59=E2=80=AFAM <756271518@qq.com> wrote:

> From: xuchen <756271518@qq.com>
>
> This patch adds support for common hall sensor ICs used in Qualcomm
> reference designs. The driver handles both rising and falling edges
> to detect magnetic field changes.
>
> Signed-off-by: xuchen <756271518@qq.com>

Why are you going to such lengths to create this driver?

What people do is usually just create a GPIO "key" input
for the hall sensor, for example:

        gpio_keys {
                compatible =3D "gpio-keys";
                #address-cells =3D <1>;
                #size-cells =3D <0>;
                vdd-supply =3D <&ab8500_ldo_aux1_reg>;
                pinctrl-names =3D "default";
                pinctrl-0 =3D <&hall_tvk_mode>;

                button@145 {
                        /* Hall sensor */
                        gpios =3D <&gpio4 17 GPIO_ACTIVE_HIGH>;
                        linux,code =3D <0>; /* SW_LID */
                        label =3D "HED54XXU11 Hall Effect Sensor";
                };
        };

This turns the GPIO line into a "lid switch" which is what you want,
and already supports regulators and pin control out of the box if
you need them too. (The VDD and pin control properties are optional.)

Yours,
Linus Walleij
