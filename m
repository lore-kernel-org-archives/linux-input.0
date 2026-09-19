Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986939D6DD
	for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789819942; cv=none; b=aPl/9b1gwLe+HkHIeeaVhLWtujcpkOQQydtxZCAuP5D03M5sVjC8lr6nofkYFln6TGJq64jtV0O1MAuAa94+/dV5mYFuuvsWFNRmu3KF2x1AMtOGqZ9hCXd6L6yfZ/qmlWfIiyeae53P6lPFWbKTK4jKo/VA1lLCLEY13I9eiR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789819942; c=relaxed/simple;
	bh=/dP6Foxr2cz/VRSoJWfh8xjp9pExqYsiAGiqghEOIt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnTAOjhQPBmtxr1jXcwddH/C6waKreBZt0vz0uzkvSt3o00G+r2cOmJXRQKuNolebohjQoIyG3mKxKH+gUG0xxNxM+TzZIgozn3/IxMYb0bnGrTlltaEPGS827dY6D0lWW7hhfDnm1nlrRgzXyO2d+yiQOFbb8lTzUgIcGNRfl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1/cMQpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1/cMQpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392331F00899
	for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789819939;
	bh=/dP6Foxr2cz/VRSoJWfh8xjp9pExqYsiAGiqghEOIt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=b1/cMQpcJhsKytJuM7JEgbI4KeqNnmBBLuDK879+NBS/Nh2o3m0mMqrYeZJk/C2C+
	 lZRiFM9yIqrGcfpMY/sihNgO5tXvF5Fk2WmI/Mz/U/fbQHj1S317FFiAon8W3aPY3h
	 uY5iIJthzfA6r8pFZIdTcKkXxfVsLKKIzs6V2EbxrPIIs9emjhHSHoUoi9PhgP4gy/
	 QuOFuGauxiRiAHB86al3r3TxUwuPGeNRM3f+dmQfhAhDBoS8Znr/sclOkza3XODS5v
	 PCrJiVXOmeAeXuinPi5clzMDvIk6YZgxFbKUyz6o0596BF+OGcPblxq2h/xS2oICuA
	 0M4R+s1e2zncQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1744eso1321117e87.1
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 05:12:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByrFCw0Dzfvz/3wTNb2gsjocuyu05aQwyDquRhGUNwZZ250lLcDjhOcSwGQI1lJkrN3WVYE3si/Qn8yQg==@vger.kernel.org
X-Gm-Message-State: AFuF++m7tOIwq+aD3/LY4TAj7PoBBpRM0lma8JW+qiMV2IzTVhsasxt4
	asBgWVX7+KsTDjmF74OoAKTX4s7Z1w0eiW1C4rrGAzhV+XxqvPl4oncZMq+F03BIMpubugC6agz
	AB+BbOyh0TeJ8+k4v2Tg+zWclzi+XpV0=
X-Received: by 2002:a05:6512:641c:b0:5b8:c225:80cc with SMTP id
 2adb3069b0e04-5b8c22581cdmr1498495e87.34.1789819937701; Sat, 19 Sep 2026
 05:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919083655.586922-1-enelsonmoore@gmail.com>
In-Reply-To: <20260919083655.586922-1-enelsonmoore@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 19 Sep 2026 14:12:05 +0200
X-Gmail-Original-Message-ID: <CAD++jLmuuLXpWsiZAFEA-QWZsB_6qcaM3PomhtKhHFHbzse5iw@mail.gmail.com>
X-Gm-Features: AcwNN1WcbEa5s45pl8xKokl0F87v5ydLmBxQXHepFYy0K13mjtIq3kJABiaLKa8
Message-ID: <CAD++jLmuuLXpWsiZAFEA-QWZsB_6qcaM3PomhtKhHFHbzse5iw@mail.gmail.com>
Subject: Re: [PATCH] Input: gpio_mouse - remove driver that has never been
 used in the kernel
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andres Salomon <dilinger@queued.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-input@vger.kernel.org, 
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 10:37=E2=80=AFAM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:

> The gpio_mouse driver was added in 2007, but it has never been
> referenced by any platform data or DTS files in the kernel, and it does
> not support ACPI probing. Therefore, it has clearly never been used by
> any users of unmodified mainline Linux. Remove it.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Why though? It is fully modernized and probably has a value
for people like "makers" who just want to connect an oldschool
mouse to their random Raspberry Pi.

I think it's better if we focus on removing code that is just
using platform devices and hacks and is hopeless
to maintain. For example the OLPC...

Yours,
Linus Walleij
