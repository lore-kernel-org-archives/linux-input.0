Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047B328B64
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770628028; cv=pass; b=JQRHluQaxFdTkB9soYb4ULjvHz0pvPtegCdJR/LfLKaYRvfqiafmRSg88hY0PNhJCC2uvpSgVmWGKafFa/Y15oligD7+lSxycy/JIHZuYy00KYPQ4d8G1Rsi2PX3QPkCTC1JmJC30L4G9sPuFRUjyPJACYjFN7jUiItSYuKubjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770628028; c=relaxed/simple;
	bh=ARNZTT0ZHaBrZDbctujL9G/d4o2dbqa30Uva3TCyzX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXhcI2VhI1BBGS+qgRxWs8/LPmv3NIMHdLykV3R5S+bRda+6ityx1nQudeE6hkCxeddWLaVksHcPC5ZjXJoK4/hrvwZWKgL+7jKcUB+UMqZr7bt9+HT1MzFtd9O77bhsOklHPUkawO4E/VYzFLdbl9dQsKoxeCnlghiD1vYVFXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPYJolRd; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPYJolRd"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4376de3f128so500149f8f.0
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 01:07:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770628026; cv=none;
        d=google.com; s=arc-20240605;
        b=QFZeQn3FZgipnOiIbFrifWMBlxoZ+lfySKulrV2m7ZFSgHw3RAbWzYpWONXjiQoRoL
         JIzN4oFJA3/H55NF5Zhk5l2yaU65o3207B2ZVZ78GXrFQJKjCb5F1d/9707VcZM0UqGh
         SPyNPkNgRp36GHLM2E9ISTRbrHVHiMWkO/7OLukA7xD9P773bO/kLHMCoD6Q1bwg5mN1
         vYnJaks53CMol2pW3EC5rkDv49i2B/Vm2e5jn2+3GccPVemdOmjiHoodDkn8P3k5VEnO
         MchC6+4Jysdibu5xLtiiM5zEtQfBqTMRrf5Uydn+AJeAkBQu3QHjMTxHWCeYmijLAz4H
         dPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ARNZTT0ZHaBrZDbctujL9G/d4o2dbqa30Uva3TCyzX4=;
        fh=ngdOeAZ/D41BJJ7VyexCEcQuNJuhh/LwQXFD0tN+0bE=;
        b=UyMGypaoFZuShIJ3QBvxm9G/sja2dplxMuB87zFIpIBr3d7e/Wwe2hd/4h9w6CD3G7
         +RygdrqEZifeS2r+TSmspB4yTddW/qx42DRhfmg6ccIznMMHdn1rtA2mDYLesDo8tGvc
         toh0scYduP/SKTWCChgnb7ohnrTfs/pYak4ps4NBtP5J05vaj3fP3YumXLPeX+K2hmKN
         YZ8661ZffxN6e81MMPUu1kDzUMf10dY04d5Eka8uTrmVSRM5ncQWKnu+lofgiuBLexf9
         liaYVXccT/6GUb51t9VqeihGzwOV1Y+jSv9uzZfY6CNQTFBgmek15jV0EixumimwYu+w
         GVAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770628026; x=1771232826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARNZTT0ZHaBrZDbctujL9G/d4o2dbqa30Uva3TCyzX4=;
        b=LPYJolRdSSRxYinDkCi8JHgOkqNUZp76bD7EU177xUHiKXM35vsveBHoZzt6v47BEc
         qRYpoUeeMhtVogm4fl74RxdQTJN/ScwZUSw4ICCqDIKS9fVbB0/XWfxT2Kej7tWpWVK0
         0zoLN4iS4SRV5PKuKeMaojzs+cC8FVgVUlyc+rQ1flBNTFV6IKvYZ1aUuQVd36Do/bX3
         X+z9pF2PlsICvgaQCDJ1hCr5RTS4X2d+wm709uOgQaWiZP5GqayqvEyB+hEVQjc5d/1+
         sVnF0K2Qmb84CjkXeWkwn/IKD8PUIUr/Nn05TX/aTz4/ojqbtGLzYlqwfHN/xS78LLOV
         YtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770628026; x=1771232826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ARNZTT0ZHaBrZDbctujL9G/d4o2dbqa30Uva3TCyzX4=;
        b=bQMbH4WuDj0/ssz7T/3sVM15phKavz9VhrUbPy66BpnKa5NZyVUaWeskbtDFELqYqR
         +dEVL7d7qlXRaKj3AU2fD1Uo9Qq5/KZQ+oM153Z48wUiN0hHKOx5rWEq1h+yF1KuLB5p
         UmoV4U3KOFpb8dvzzAwgVB12YA1ugBuW2zMaRlfzCdKSdGxWOf0/6yetiycWp1GLawp+
         yt5KBH0cO4TNPo1XkSkDhSN+9CS5+UE6WWAANovhSkRq865gkMs46f2F4oMInlwp9MNv
         bHqs9RdCNfEtsmX1aB0Zm9ZxOg39pm/u6ixXNdziTY8J84+fzSw+m93ypfBm9Do/C22Z
         afug==
X-Forwarded-Encrypted: i=1; AJvYcCUQSeezdCIj3uYXLu79uVl9GFILjHmONhR9SaW9oSxJQCBCdCV/2gLlgPFkVoLIAWywFqU1TIDj4/DYzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiS9kxvFQZCe73uXmf00dBIm6CmgNleqp7b3YKHE/hyhH2okY
	wilLb0JBjBFQ6uWYJUQdvYwlSEnxZ/Uojy+zEX/g0K4dyyKFv0LJOXt6AnmkjjCzOD7T9gPDjeH
	d4jtOYQz9oLltay+r5iRaNGqh5tf/ePY=
X-Gm-Gg: AZuq6aLggjxW3HRcktdkz4zefnZ2Tze1JhQy3VKWTMYPZlgVSKPFdkDLqVm4wYuMzDs
	x9S8lmL024OxIKU9tCL7EfwBm9JTuKHq2Fl1eVCk/eEd0wZ02o1c3sda44Ehwdn8o3CAkIuIfp+
	ZeeWz1HQC3rH+Ha9+31PfbECyN/Cg2Go0J0HOmDqFOjSBLlfi9bZ7gte54/YDaV6rt1NKOPvPdu
	9elp8PfB/K4sZBpEcWvlvYihRspGHJKgmYs9LdlWA9GpIhy6CLV50g8gDuZzgHjn6fdYt5d
X-Received: by 2002:a05:6000:2913:b0:432:5c34:fb32 with SMTP id
 ffacd0b85a97d-4362933f436mr17440511f8f.23.1770628025680; Mon, 09 Feb 2026
 01:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-11-clamor95@gmail.com>
 <aYiHnUW93AB0ARJH@smile.fi.intel.com> <D8B3E97F-3405-4EBD-882D-677F530E4EDB@gmail.com>
 <aYmYcd0431P5sUtq@smile.fi.intel.com> <5AA39777-F5C8-4AD5-A5C2-47265C8213F5@gmail.com>
 <aYmg_7uq2rAWJgGK@smile.fi.intel.com>
In-Reply-To: <aYmg_7uq2rAWJgGK@smile.fi.intel.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 9 Feb 2026 11:06:54 +0200
X-Gm-Features: AZwV_QgwoS53VSYtsaxPBt7zkNokx4yMZnC0-ZnRQ3AbohXwTZvajTpszTk4bdc
Message-ID: <CAPVz0n0+UxdocZdLtqPz=5m5RMV_K2Ldqsf53-13hUiLpV6c6A@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] mfd: motorola-cpcap: diverge configuration per-board
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 9 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 10:55 Andy =
Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Feb 09, 2026 at 10:42:02AM +0200, Svyatoslav Ryhel wrote:
> > 9 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 10:18:57 GM=
T+02:00, Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=
=D0=B5:
> > >On Sun, Feb 08, 2026 at 05:19:49PM +0200, Svyatoslav Ryhel wrote:
> > >> 8 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 14:54:53=
 GMT+02:00, Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=
=88=D0=B5:
> > >> >On Fri, Feb 06, 2026 at 07:28:44PM +0200, Svyatoslav Ryhel wrote:
>
> ...
>
> > >> And please, may you contain all your reviewing in one iteration. The=
n both of
> > >> us will spend less time working on the patch. Thank you!
> > >
> > >It's an impossible request, you should understand that. If you want, u=
se AI
> > >or your robot colleagues for that, I'm just a human being, I can't see
> > >everything at once.
> >
> > Ability to see only nits and don't see the possible issues seems to be =
a talent.
>
> Paying respect to the reviewers requires some talent, indeed.
>
> ...
>
> Also, train your logic a bit, why do humans have so many professions? Acc=
ording
> to your "logic" one should be a doctor and a cook and a programmer. Why n=
ot?
>
> Or even closer to this case, a doctor must be a surgeon, a dentist, a the=
rapist,
> and you name it. Why not?
>

If seems that my expectations were too high. Apologies, my mistake. I
will keep in mind to spare you from wasting your time on reviewing my
patches in the future.

Regards.

> --
> With Best Regards,
> Andy Shevchenko
>
>
