Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906799;
	b=3W1b14+KcUtxwKTEuOqs3ihqvp9453xKJucliEFIUK/mT1bEESCs3vMMg9rfnDdJb3lI
	 uiWLvpjTKr56m20g2ZSD5JmxXnWyuC4f7I3t/yBcXDwgD07Ow+/4T91uXlKWc8TlMZ6mv
	 ol4zOB9nxm+nThVCK4O8nYK964Rt6lmlqpTV9rKTKOd15sxWQAPx9bZJHWpuIqzTWTflf
	 KaOgO1ijXhyF5ZV74PhyUTCpHL2tL1R9F4+5bTG2attxInS5d7vKPrDPhjVBUTCbjOnvu
	 klGjxkh/vy+6ppcOp99ojLqwQB6ELaKJjm4DviocBRmYT0kkoHxu7ISx5XfLk3RjPQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906799;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TZphQxclz2gFW9ezkdnyrlJdzJISPtOa2u0+oLIYQtA=;
	b=H54n/Xmo35HtddQMgCElQAfJwCEdXTssVcPZhE8jn6PI2Stlvuutlv0MB4AIKTNsOrvE
	 KooKqyXUe4+r9hdDru3oEXKPj8/wrlZIfZbOJvdgZW3XASbuywboxDYl3JUhUPPECKG0T
	 8hd9doFBT0hidN6hHdj6+39hbIx58Ri5j5iustSDkow8LoG31gV3Z8xqs1hiuaaRoEdbc
	 +rJtjHMjYm4OR5OfbEeOKUkN5bWMl7D8a8cKpJRzlAvbHlAcnXp0zImnrMXHcEq3gxdut
	 KmwWX92To7pFVtiORHoDTl6qPEeZWM0nsqmRSf9q+x+yUQqYjvr3Lfrp2ggNmcx3WiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=maryasin.name;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF2606A326
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 19:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1AF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=maryasin.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4322d310e7so106281566b.0
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 11:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906797; x=1794511597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZphQxclz2gFW9ezkdnyrlJdzJISPtOa2u0+oLIYQtA=;
        b=yhLCQmMC5ldVAiCyU2JNhE9GLJsMitK55j8x3yHU4hakQIQDjspp+C2lvUkbmpHGMq
         gciyv1tV3jhhYs0if7MMBEU8jR0zIMWpkldaavFz0txnSCO1JK4Q6hIS1uBqv/Vv6hW1
         7d44hYKAend5OgrwhmWWOp1Ab7EPmlrM6Xx8Q+iS/aqLWglQNfK+8cBiMIIJHaK6RIeL
         yvVv3J3kUaPY2JgPC2NjwQ0ZXHmuF7lKl/fM10yhegyMldwKnWe0s809GkIHGdpjyN71
         hbtBNTe+r+NENkrVvReU2cOpmyrZ/8KFNcuA0d05DKeoa3u9Mj76WAEBXiVr1vTEgdJb
         ac/A==
X-Forwarded-Encrypted: i=1; AKwUvBy4qLYKaom1JBGkS5jYWHIRnxPVr+A4nyPMxuGZU9hip6V1OdTyAR/U6KV4mruG2t5cHTzBbSWt8ANl3A==@vger.kernel.org
X-Gm-Message-State: APuU4Z96ZBjRNkrn+iCs+dhjxYL/GnCkhsaNNB5wZTrBJ1CY1INlJ9rO
	Se92XonbesK3FvxstNPn6KpskAl+7DYiSN3v7q/i4IKwcKRBv+k3H6iU5g3EOPecMBDfGA==
X-Gm-Gg: AYBFou2W+RFb+q25keO2gzrabSEVl/xKjeoS5xxmOqrA2Y72K8APCPzBHH67WrFP7uh
	aSs1tTDnKwosCcRyHXu0cdyZObkKKuVU1fOoh278+oVEO6dHOC9VdtkLlDHG/rPsJc2cNrAHWfX
	MNw2aXpYRsuVL1edFX1DGYCh2L3syqQ0xeDt0PUlX8AgX6alW7rMyur4pdM+ohbCtlNDb71+HVw
	jFzYOCTF4eYnkK1tBdW/rs/8zhaI4Ztt/gRyVv5+f1Pm4EyWsfK39GHmsSwTFaJ/pE5/oPADEeG
	1q7S/Me4LnBULpWVl0HpOaSpLV/SGaAxEfKfKkRsEBCCWhOpB35VhG7AkNVGfI86PP+tsAcx61i
	8UmrBrPRjmTixR0H8sBduRBI/B96JySQtcRpuVAe8i+Po7yJQ8dGzvDXlEcyyFujItPf2zVsKTh
	XvU30HqyaNHhONGn8o5idfZGJAWyZ4wSMa/5S6XWA+ajVZEBDdtS9Gm5bXHZxPC35lDMNE1EJ5a
	pw05IBIHxM2T2jHW+w8X7XSMPGmpTlVDBHlaLIgNEs+mEodh0c4IUGLz6QUGm7aERC1Fgu5NXDS
	OAb960/hjT3QjcHwyE8rTf5N+YI7hwVrV5wuac1HZvWc4C9K7S6+Pi88fspx8Hb4jXxB3bztJLo
	Fbn6CBdcpGXxSTATVHWAUfkjOFnN7/9OhDSaN0eJ0WS3n6K9tC6fdyw4ez255xpjR16Gh
X-Received: by 2002:a17:907:9807:b0:c49:91a9:c7e4 with SMTP id a640c23a62f3a-c4d34ce94b2mr42633266b.27.1793906797179;
        Thu, 05 Nov 2026 11:26:37 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356ea58esm10935566b.81.2026.11.05.11.26.36
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 11:26:36 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso3636450a12.0
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 11:26:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxOqJYupHc4jZJW2Lo51rIC6QZTeoiT+uRtC5oq9LHmUCRqpbL46hhUG8Kag2+rFTmR2poCZ3lDNb6ZSg==@vger.kernel.org
X-Received: by 2002:a05:6402:280f:b0:6b5:8674:c01d with SMTP id
 4fb4d7f45d1cf-6b5975277f0mr197220a12.5.1793906796627; Thu, 05 Nov 2026
 11:26:36 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104165319.1890851-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20261104165319.1890851-1-srinivas.pandruvada@linux.intel.com>
From: =?UTF-8?B?0KHQtdC80ZHQvSDQnNCw0YDRjNGP0YHQuNC9?= <simeon@maryasin.name>
Date: Thu, 5 Nov 2026 22:26:25 +0300
X-Gmail-Original-Message-ID: <CAM2dg7dnvj7X3Fo9r_=Pn=EHxUwyFEwQN6XdLLPmOAdaY76JfQ@mail.gmail.com>
X-Gm-Features: AclHuK9weJ0gP1AI6YK6eNmMlqgPCqXQEUZ4hk_XFsi6eDTrhg4oCQvVn1yYuq4
Message-ID: <CAM2dg7dnvj7X3Fo9r_=Pn=EHxUwyFEwQN6XdLLPmOAdaY76JfQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: hid-sensors: fix fractional part for unit
 exponents -7 and -8
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Semyon Maryasin <simeon@maryasin.name>

Here is what I observe with this patch:
1. Enable sensor and run xxd /dev/HID-SENSOR-2000e1.3.auto
2. In the second terminal, do rmmod intel_ishtp_hid
3. Observed result: xxd stops with "xxd: No such device"
4. At the same time, in kernel logs I see the following:

=D0=BD=D0=BE=D1=8F 05 22:19:16 dook kernel: hid-sensor-hub 001F:8087:0AC2.0=
005:
timeout waiting for response from ISHTP device
=D0=BD=D0=BE=D1=8F 05 22:19:19 dook kernel: hid-sensor-hub 001F:8087:0AC2.0=
005:
timeout waiting for response from ISHTP device
=D0=BD=D0=BE=D1=8F 05 22:19:22 dook kernel: hid-sensor-hub 001F:8087:0AC2.0=
006:
timeout waiting for response from ISHTP device
=D0=BD=D0=BE=D1=8F 05 22:19:25 dook kernel: hid-sensor-hub 001F:8087:0AC2.0=
006:
timeout waiting for response from ISHTP device

No system crash, so I suppose this is okay?

After subsequent modprobe the sensor initializes and works properly.
No kernel crash with this patch.

=D1=81=D1=80, 4 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 19:53=
, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com>:
>
> split_micro_fraction() scales the remainder to micro units by
> multiplying it by 10^(6 - exp). The unit exponent of a HID field goes
> down to -8, so exp can be 7 or 8 here. Then the argument of int_pow()
> is negative, which the unsigned parameter turns into a huge power of
> ten: 0 modulo 2^64. As a result, the fractional part of a value read
> from the hysteresis attributes is always reported as 0.
>
> Divide by 10^(exp - 6) in these two cases. This matches the reverse
> conversion in convert_to_vtf_format().
>
> Fixes: 73c6768b710a ("iio: hid-sensors: Common attribute and trigger")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> - Fix __udivdi3 link error on 32-bit by using a 32-bit divisor
> - Address Andy's comment:
> Keep no % divisor in a temporary variable next to no / divisor
>
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/dri=
vers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 9e7c26e37880..d44091faf122 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -96,9 +96,14 @@ static void simple_div(int dividend, int divisor, int =
*whole, int *micro_frac)
>  static void split_micro_fraction(unsigned int no, int exp, int *val1, in=
t *val2)
>  {
>         int divisor =3D int_pow(10, exp);
> +       unsigned int rem;
>
>         *val1 =3D no / divisor;
> -       *val2 =3D no % divisor * int_pow(10, 6 - exp);
> +       rem =3D no % divisor;
> +       if (exp > 6)
> +               *val2 =3D rem / (unsigned int)int_pow(10, exp - 6);
> +       else
> +               *val2 =3D rem * int_pow(10, 6 - exp);
>  }
>
>  /*
> --
> 2.56.0
>
>


--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=
=D0=BD
