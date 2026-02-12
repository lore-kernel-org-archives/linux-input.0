Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C423D156677
	for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770874251; cv=none; b=i0VnYbqD5UfNgE0KKAl10ekjNdok7ioMHwp0F6LpKEUNjiq/I1IL3UGiOR4MMcpJn1gmjyZhSx7RwntGqkzoY7Uqs9ianoJ4l5QOuNub6FFvWxCWMU4Mfs6vlxjE74xHIDPx6ikZX9wAAG1mRYxxQYQ4aCL/0mMZ9yQV0ejXL84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770874251; c=relaxed/simple;
	bh=M9u3F8vMbb8KnjCzF8afvRTHFhneUQC2iutBlxhIGw8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ayHKSOEbEMClnUuS0vZ652gx8KK+3ZTUXL9mSG3IE3ENfcjkiwizQCRN63GQ9z2KN4TWcavR7CY6hCkd7RnUTLUzzPKk4khdW65ChalfmVr24kKjHRNXAEJBziDMrXOcQIsavRjQrzhLgyClKfdrudlHFI4pkQfh9aYWtRgdwug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw1r337u; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw1r337u"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8870ac4c4eso947460466b.2
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 21:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770874248; x=1771479048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aiP8Erv5C7Xj3JXt8nFdVUGp5E+liP8wGy23CnOFomo=;
        b=Fw1r337udEW91F8u+YRGcxg44DHKZEh9G7IyyPaa/BqFhGrU13/FCcjbqwBatHYUfl
         OiDRT6iSKincNmWBYwN0orurS49sPxcfRSF7iKQs0R91B23OoSOCdul49BSIBvhs2NJk
         YA+aHD+IHQRe+q7jUscSiquMH9dVFp8ZIRB45+aRtUiEJtaGIhhDskd8NOqCZDdO/VPB
         51q/uu1VgDzIZH89M0OjoCxN8ZPyAUCdGhHv3IfPB8gklPH5R2c4u/V4Vo3qWydcoQ9d
         BueNeIFYeF/rcu7usGZok0u1SbCz89+bxPWY6WBNSLGDKsOCxg7XjDXciEGFWHCYwtgR
         3jzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770874248; x=1771479048;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aiP8Erv5C7Xj3JXt8nFdVUGp5E+liP8wGy23CnOFomo=;
        b=qtGEU3YPo87iekkbFVuQVHWTupuuSvaMdYhW01UR+nivKhoktZ9eIofsV8CXe1NFws
         ht+xk15Z2b93F8E876QZIBq2spsO7TkBbWrIbul21Miupj/51c7lIQ6eB91G+TKm7yTB
         P9RXt1ODmeUy3T1PxOXsFEPVjSKfnFHmVyl8xiFI4MOna3HeMXAjf+0tIM8KplzZk1VC
         O7d91JTrvj5XzdtSHhF5qMWiVi5otfpbC16pMPaPnR7jwbI+My6w46r2Ad0LvkCIBXZA
         oTyQiBpCbZnm6ljFMXNxGa+SkHknazmL9EX63rX2ulkMQCfDcHTs7F2HmUbmhNasXiFR
         SKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXPGKHqX5MxpR9csyrMx2GcJ1LrmYmAyeZ/gtZSdn6S8A7iVYl7RDl7m2mdGgeIWXRzbRNp/q+uec9Ow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdweac/oiH6zauCnDbs0D97SedHHGKif4HriyJm2TwwN8v1V3W
	YxLyX7iZ3k27/a8njsq2S04Pea2P0Wm1tHX5NCZTS3mQjFwaCAmEHEHr
X-Gm-Gg: AZuq6aKhzzjH85oLNK6FBPlzW7dogN6Zia7Yeh0plEt15HgYaq3YREWoUkPFdEGevO4
	2yBtDm+Z3pOB4MFogZj9Few+Mi7bUxqfNvWWMY0E5BixAqnppjIScj926unKKgzSaY79cXAPcZp
	w/AAg+91ChAnkpcsWMhfpdkXM+M7ZyC0DEK/vYbe0JPTkSk15cyjzLVLg4x81PPWlkzH4FlSXIw
	zKNpNGbdrLXj+k5M4HghS9vWcshO81n1VQyTY5w9caOHYQNbCP5qpXhKtNrBpkVVERFNiKA+XoV
	LWC8ACSgBGQugxnJXieG0jTzGl8ox78p1VuRP9lgriznxGmbojxEVMXOIVZIlG5t47Ntw9LqdDJ
	GzDkWNWYUocDSaFJwAwTFpMxUEm9CxfT+bh3DjusuQ7rgupiFOGLzdJl+opj/Lu2Wu2j7l4Gukc
	ZF6LIZyPeQuGGJzrLQVShk1bb9MAnVvJKT
X-Received: by 2002:a17:906:eec6:b0:b8e:3d49:25db with SMTP id a640c23a62f3a-b8f8f842106mr82989966b.54.1770874247809;
        Wed, 11 Feb 2026 21:30:47 -0800 (PST)
Received: from ehlo.thunderbird.net ([178.137.248.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f6e9d0212sm129363366b.26.2026.02.11.21.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 21:30:47 -0800 (PST)
Date: Thu, 12 Feb 2026 07:30:45 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dixit Parmar <dixitparmar19@gmail.com>,
 Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_08/11=5D_dt-bindings=3A_mfd?=
 =?US-ASCII?Q?=3A_motorola-cpcap=3A_convert_to_DT_schema?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260211212016.GA3910589-robh@kernel.org>
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-9-clamor95@gmail.com> <20260211212016.GA3910589-robh@kernel.org>
Message-ID: <E5BC797C-4362-4C75-BCAC-7C32A51C4725@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



11 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80=2E 23:20:16 GM=
T+02:00, Rob Herring <robh@kernel=2Eorg> =D0=BF=D0=B8=D1=88=D0=B5:
>On Fri, Feb 06, 2026 at 07:28:42PM +0200, Svyatoslav Ryhel wrote:
>> Convert devicetree bindings for the Motorola CPCAP MFD from TXT to YAML=
=2E
>>=20
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  =2E=2E=2E/bindings/mfd/motorola,cpcap=2Eyaml          | 411 ++++++++++=
++++++++
>>  =2E=2E=2E/bindings/mfd/motorola-cpcap=2Etxt           |  78 ----
>>  2 files changed, 411 insertions(+), 78 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpca=
p=2Eyaml
>>  delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpca=
p=2Etxt
>>=20
>> diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap=2Eyam=
l b/Documentation/devicetree/bindings/mfd/motorola,cpcap=2Eyaml
>> new file mode 100644
>> index 000000000000=2E=2E7e350721d9f6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap=2Eyaml
>> @@ -0,0 +1,411 @@
>> +# SPDX-License-Identifier: (GPL-2=2E0 OR BSD-2-Clause)
>> +%YAML 1=2E2
>> +---
>> +$id: http://devicetree=2Eorg/schemas/mfd/motorola,cpcap=2Eyaml#
>> +$schema: http://devicetree=2Eorg/meta-schemas/core=2Eyaml#
>> +
>> +title: Motorola CPCAP PMIC MFD
>> +
>> +maintainers:
>> +  - Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props=2Eyaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - motorola,cpcap
>> +      - st,6556002
>
>This does not match the only user in the kernel =2Edts files as=20
>"st,6556002" should be a fallback=2E
>

Honestly, I would remove st,6556002 since it is not the only cpcap model w=
hich can be used, hence it cannot serve as a universal fallback=2E Some dev=
ices use ST produced cpcap chips, others use TI and range of models varies =
too=2E I guess I have to multiply commits=20

>Rob
