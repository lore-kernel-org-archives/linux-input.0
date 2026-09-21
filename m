Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A94534A8
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980671; cv=none; b=STKHFx2WnXDlTRTHDDhH40jc77oawlFst30dYP8dHDXaOivDZhd5tHA5d+Rbh1PFz7oUk1nVg/avxf9yVXHjoOPZ42siByD+k2aa76y4nqvBnCiCjZbqX8r2sXGYrzzskW1U9e3VyuDZmI1kO80IT4U8MyZERjDqho6mHplLkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980671; c=relaxed/simple;
	bh=sdZW/G8qTawlI/Os8mwlWWAIJQkgOz0cUTS2dlNUP1U=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGLyA4yw59AyAkRT8K5m3Uonw4QzAwgtRyMh1wXB7yI/30H1XQ9sd0oKE+tXcIZFnfWXcGA2+XR7kDI0BzrPvono21YVj7bw5o1IN4RjoxodxWKfb4YcrjizOgNWUHhtuSI7wymgVurATxofasqzkttf3eTcH1JdjWPqTRlIlg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3Y+zyS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3Y+zyS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52411F00893
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980669;
	bh=sdZW/G8qTawlI/Os8mwlWWAIJQkgOz0cUTS2dlNUP1U=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=S3Y+zyS5Zd29bBZJqG5qzsOd730j0jhF74C+8NP3PifN+27Y01c/UGxcBXJAzSc1J
	 qvG5UDb/UlUIbDlE47+KxjCRVTINmxAjVNH05cAZMzAUaVhD92d6WN0faAxCr4JVPG
	 ImfPuTKgayS0CNHE3Iw1W/AdDXvv5VE3fkCyCOeEsxY1e/qPkShMhA0WKCCSgqJANd
	 yksO2ZHH2Io68VuBw4mQPjLQVsknG6sclQRJm4uPGipKn4O0UiLc430I+8yv5YjqDG
	 i6NWFmR4SenrP/HZBPXIE4ash9ljZipszgJQa9qASOK1k2KiC/N8kOTZ8Y0qMdlcyn
	 e2LO3upfTDB1g==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5b6840edcso23209161fa.1
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 01:51:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxgywsxzRy/wwBgNS52KaM+YkcMsJgAJIx4W2xtUPx6/vGM0HF2VJLflH7Eba/E72TImpNVi3fS+EQqDA==@vger.kernel.org
X-Gm-Message-State: AFuF++kOev6/PKrRaszBpSNqk+2LY2bWsYhshJ84fY5yrw2wE2LqixnF
	DLK8JLkVJ5ssI2ekFCqy7Lci0jyjO+ieBL0MHJ1VueoKuqh9YKnFA7qPEF+CH1yFiCxrv+MbNdL
	ECIQzp6SbfeOhVLg79SEaYv+b/LVlR4/gLyGQ3jchqg==
X-Received: by 2002:a2e:be86:0:b0:3a5:f6e2:47d2 with SMTP id
 38308e7fff4ca-3a5fc10f251mr22211991fa.29.1789980668654; Mon, 21 Sep 2026
 01:51:08 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 04:51:06 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 04:51:06 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAD++jLmuuLXpWsiZAFEA-QWZsB_6qcaM3PomhtKhHFHbzse5iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919083655.586922-1-enelsonmoore@gmail.com> <CAD++jLmuuLXpWsiZAFEA-QWZsB_6qcaM3PomhtKhHFHbzse5iw@mail.gmail.com>
Date: Mon, 21 Sep 2026 04:51:06 -0400
X-Gmail-Original-Message-ID: <CAMRc=Me3-cFQr2kqHyPHYx63Aht3kK2Y0-h0--WjeZGpbsGDFA@mail.gmail.com>
X-Gm-Features: AcwNN1WueoBLY3SSKN39I0nyHfXknArX0yblXzJ6NPhctoeMb5IuaBrvm_4Jo9o
Message-ID: <CAMRc=Me3-cFQr2kqHyPHYx63Aht3kK2Y0-h0--WjeZGpbsGDFA@mail.gmail.com>
Subject: Re: [PATCH] Input: gpio_mouse - remove driver that has never been
 used in the kernel
To: Linus Walleij <linusw@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andres Salomon <dilinger@queued.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-input@vger.kernel.org, 
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Ethan Nelson-Moore <enelsonmoore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Sep 2026 14:12:05 +0200, Linus Walleij <linusw@kernel.org> said:
> On Sat, Sep 19, 2026 at 10:37=E2=80=AFAM Ethan Nelson-Moore
> <enelsonmoore@gmail.com> wrote:
>
>> The gpio_mouse driver was added in 2007, but it has never been
>> referenced by any platform data or DTS files in the kernel, and it does
>> not support ACPI probing. Therefore, it has clearly never been used by
>> any users of unmodified mainline Linux. Remove it.
>>
>> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
>
> Why though? It is fully modernized and probably has a value
> for people like "makers" who just want to connect an oldschool
> mouse to their random Raspberry Pi.
>
> I think it's better if we focus on removing code that is just
> using platform devices and hacks and is hopeless
> to maintain. For example the OLPC...
>

Agreed. I support removing drivers tied to specific architectures that were
also removed but this is very generic and may see some use.

Bart
