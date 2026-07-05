Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34227CCE0
	for <linux-input@vger.kernel.org>; Sun,  5 Jul 2026 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783279930; cv=pass; b=pQ5jCpfGCZbui/U22ISUskSaZGzQqEwQSoBSMDPhygcI5NSCsok0nT5HKcEvxjKuvagEjIY3pWHNGKnLeVF8FD3ciaHXBiBum8honnN1UDcAjuMCTc4ZiS+FNQUss1gPe0rIV6lIrV3fErpHduuhs0iC2u6iNRxY7UZFNsUvx28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783279930; c=relaxed/simple;
	bh=LYZXiJ+Rs83JAuhPNbbWnteX8T0Ox9HzXuJDtiB0HKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kj8rlc8d9ThCgLBsqxNrRX+Y5UY4quf+jqucC3gGe866jIyGU0kIRrlkMaXsa1+gJyWiRxbMqa79tX4IJd5syKJJqwOKpqal7b+LFRLlsC2kQtENtvcoi5+S/MRMP5M1pdVhtX7JtnqG9TJ3UbCdHKT92DpE1nswxtVLwWalpHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayYxeEHK; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayYxeEHK"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-476a130c138so2358821f8f.0
        for <linux-input@vger.kernel.org>; Sun, 05 Jul 2026 12:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783279928; cv=none;
        d=google.com; s=arc-20260327;
        b=PgG88cxpbNVRyluRJ4NLc+uZXUPi3UWIFQwSso4xcPdeklmf0sWExsRUc9LFQHMJmW
         2CUzVX9R/H4iq9tTjBZuL4wsw8bEjyDNkvzN9MCoqKqMOPzMBKAWWrKKvNh+ejHI6RJO
         7k1q5E+ky1TRjAAa6uPAwpcbEgd4MQQ2LjIbT+O0Yz0zAcfQkkbSEA9CAkwk6WRVQ8f6
         W/T1BrFlW52KuwIk+9xjljwQ3nPOIBOEmnTdmOFwdmMRmsxeOpAvipEjafvPuoof3eUv
         0dK4iql1NaUnNVtDjGrfMLNQxOHpfQCkomk1bFatX0vJtG1fyygZKEJzAeW2ZFH4vxaY
         xHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GwT9n22fG/yr71+Qou8NPs/HxovuWX/nw54buxwMf10=;
        fh=9FIB76i8jY9s3xT1VoZ291AoAhw4jGjacVHKHednSUw=;
        b=Lf1lUpTUAJ82JZMir+d2xa5r7OiU5U4IIZ6nVzyD/CblNYD/nlcx49rTX2G2PIa9Xh
         mihfb9gAye1VuNcmta654JiOLRpkKGYI9uTKA/y1U9HRKg37COiVTt+T/vDEuniMlBxj
         hY4HvrRWZL4Z6kZwprJcDc8sD3EvXwOf8NYE6S1qkr7zTih2fg3vwNokryU1QLL++pUW
         xYGfcyU4i5MKyIhTGm68UHQTAznJXzPEN7VeQHQj1xT6fRz/gIQZGWgvo474S5OiCnOQ
         PqsKeFmgN2nSzZ2+ReClASXtuZ95xL6xDSd067wSPSFp0HCnxmGVis4HoE8Yde/bmEXe
         O2IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783279928; x=1783884728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GwT9n22fG/yr71+Qou8NPs/HxovuWX/nw54buxwMf10=;
        b=ayYxeEHKsNrxkTr08URUn+ovzwCpFOMs0wh79SR+YejBEguKktxXmmnsq3lG6xr3a/
         FesEHH+JV0KGAM5GSu3m/H4GmN2WEnAatai9cP88H2splr2qlWKT2Vn+RWW+mOqkX/53
         +3yRMR5aKYFkxfYIsp3fkZh1bWBZMNp3iIqm7ZYJMv66FtMbS3I29D/1nRcq3kbm46xA
         VO6sYkc3XJHoUKLX5SD+xffn2QqXXGhZnJbKQyAFuRRjrjVetXeSCfnqTd3WOJ1+f6Bp
         Zu9X5/+T0P3jRHNYyUCSBN3GkFZvTYqPzLYYPvkhFc+Pz/MBnXZPy9YL/bJdezdim7ll
         q6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783279928; x=1783884728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwT9n22fG/yr71+Qou8NPs/HxovuWX/nw54buxwMf10=;
        b=GG3aY2pc5fGUqiYHe20+oSCJwiFVJbovJfIopCk3SfCDx1GGK1UMrC4PTCiFn/GaFj
         w/R5j8L4xjS+HB2qgyjpBvaaZX5zKea4TKOMBlqeptFgwAftgLong13mpbiRRQ3VHp6d
         TMMylU4RLU3aFZmafJUCRLEs8HhTNHrYrH09vzfSNdNKXqBWKAJ2Mi5q0fsdBPv3HKGC
         aB1RurchAeSfB5hUlZZSErx22BTsLTLbogGXK8e7pJ6ZvUS633ErGH/a6ieTgdUPUnhj
         cacNsGz4J4KWWKZqf9QT5wHfY390DU/PQwzfqK76busKYu9AbEH57inE7WT4mWEaIWEv
         1IkA==
X-Forwarded-Encrypted: i=1; AHgh+RoC67mU8iJ97ZKPJ8sjSaubHGOW6Ob2PzdpGmUCLjnlQR+AO6s454Nn8gpdogUHD2/yxDrxNXMKm1PGMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yycov7jr0zjWe1d8g3KaA5c6kMeO5XxLT5lsZV9RCfV1PAVRATo
	P2Zlxi5OeXGAQvl3RFHX6+EXz3kPsc4H20pvSP1/Ao5JXArmj4GN8pgAKvPtPVMqejGZ+IqueiJ
	6mukHPgis1UcBHNHVi9tkE0tUN9nrzc8=
X-Gm-Gg: AfdE7clBPxZtn4fzE1wY2UqZ3XIY+E1awhzC1hh9AAuU80lltMBV9ZDfcQG7hFEl7tw
	mI0L0wbwCujnY9v4hLdQ7L1QG3Zj1BtI4njsll2e3sPCZichQHxFMIeO3CQgarzmJP3n1dndRqa
	fMEfAfTPHeHsISLvDdSxGOcI8FSWYHaFS6FjJ/BmmFg1ugD9/KL8gUsEeDSjeR4XKQkQp6rOLx/
	WU1qzBBxxnWTK3V2ZTYWfG6k59HlayKcidttvxZS1bybzQi1I9mY8vGn5JmeQvYvARZVKWoFV2p
	YEHcmUPNTnJ2NSsM+1grU164rXXSDk8NAab2cNh1WQQNl52QK7A8GmySHKmxMYAeLi+bmSC1dYk
	a0F3SKjsQryPslL3ZAhnfk5uWz1abyIeq14a+fgwskitcCqTnxSFGcgmkptPiDSfi+HgOcplXXQ
	5Z7H/+BewhMNNHqJpuQF/BxRm3VT75trtr0m2hEPpSJJthNTJecmoPLDkH4BxWZn4=
X-Received: by 2002:a05:6000:4203:b0:477:80fa:f447 with SMTP id
 ffacd0b85a97d-47aadb13c78mr8524276f8f.43.1783279927535; Sun, 05 Jul 2026
 12:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
 <20260702-15-jun-hid-iio-alignment-v2-3-b87f01f5efbc@gmail.com>
 <20260702182205.388efe24@jic23-huawei> <BF19024B-D73A-4185-A963-516D0574E416@gmail.com>
In-Reply-To: <BF19024B-D73A-4185-A963-516D0574E416@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 5 Jul 2026 21:31:54 +0200
X-Gm-Features: AVVi8Cf75_SzN2fEHjfHXicsKvv5otrzKJC7UoPu5AQnM92pGFcWxZlA6a58s_g
Message-ID: <CALoEA-wkbbvPA02JFCTuCEQrpGKZfu3NeBScTErTT07U7zJZ_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] iio: hid-sensors: Use implicit NULL pointer checks
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Maxwell Doose <m32285159@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 5 Jul 2026 at 20:17, Sanjay Chitroda <sanjayembeddedse@gmail.com> w=
rote:
>
>
>
> On 2 July 2026 10:52:05=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >On Thu, 02 Jul 2026 21:48:00 +0530
> >Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.=
org> wrote:
> >
> >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >>
> >> Replace explicit NULL pointer comparisons with implicit checks across
> >> HID sensor IIO drivers to follow the preferred kernel coding style.
> >Is there anything in the kernel wide style guides about this?
> >
> >I do prefer this style in IIO but perhaps we should document it
> >as local IIO style rather than implying general guidance (unless
> >there is some!)
> >
> Hi Jonathan,
>
> I took reference of existing IIO commit message and followed the same.
>
> There is no kernel coding guideline for NULL pointer. If you think it wou=
ld be useful, I would be happy to work on documenting the preferred convent=
ions under "Documentation/driver-api/iio/", for example as a new "coding-st=
yle.rst" or similar document.

Not sure whether any coding style kerneldoc mentions this style,
nevertheless checkpatch prefers (!foo) over (foo =3D=3D NULL),  see the
COMPARISON_TO_NULL section in the checkpatch kerneldoc.

--=20
Kind regards

CJD
