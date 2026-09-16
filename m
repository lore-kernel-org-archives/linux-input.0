Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B0451E452
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573006; cv=none; b=IIFJjnxbgN4okXC3rOFLvQMGKoAkCua6BfARBbFPYX8NJwjvWDwf1TnnxaPEFqjlExse6iyJfEsIgWR4qtnSr1ceYGD2ZOKm4ZsnrD6t+dSwyk5DR+A7zsiiG1GUHCrgDxhpHoe02WJC0yr/1GL0EmpKkBPSN/Fsqu9Y74cuNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573006; c=relaxed/simple;
	bh=j9wPV+/EfbcGsOG8JnEPShKnQO6bUkC+qAb7x5D1t28=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=OX2gSfJC/1ZbFeQqQkbjoPx933pyRFOkg7oEQrGRJl9y4RfT4YkjEZLxiLex/fxpxmeG4Dj+IMG1VdIC2C0pWbI0h8q3VTh8DnXoD4iAPdG0oHrgvvSf/Qfr6SdGwhEEEKVKMhonB6nm++EExJvZLIEpZ7ts2elWDKdHL8H3wJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=cXHdKIqT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="cXHdKIqT"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4843e397f74so1224502f8f.1
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789572996; x=1790177796; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mqmfs62Il41JZdrK4MnJ9AwZ6UV73Ai2ymy+jYr0F+M=;
        b=cXHdKIqTKKDEZPyrNZkyvgiKFAbeOrOwxQ1h9eGsmbtiIRAE5DWeCXlqwOEFyKMxSk
         o/dam5XeR7aby5PHcg+dTTa8vn6Eqfwyt2RiszXBQKWvhcrusjzQWCPRPWLH9mwcTKzg
         9r8EtLLJuRQl7c/wJIJu6On5nZJ9Bx49Bo6bpQtUlqw6LdlAz0KaZrjkPJs8dpP3u4q0
         DauvJmQq8tCCBuOffVDHaHUQYj+nheYr902n89G7VshcaKSk6tmMY5aKITenUB4ONAaP
         0A6w8hAXZeKzIE3DJ45UXQrKnzwPilClxbHUqgadrhF3Q31ParWGnaQffuadxWzQ6h4t
         NDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572996; x=1790177796;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mqmfs62Il41JZdrK4MnJ9AwZ6UV73Ai2ymy+jYr0F+M=;
        b=YAYqFOy1XTDshzE4X3GKe4P4KO2qcSb4UnZg3nxc+wHr1NHaINqQPC719/4xAuVXQr
         If0Vc6Uxff3sukNwuZ/hydt8TtAJNkGsfXzYbP5Q3oOAtIUKVlPqFTdPdimBBFy6Opo6
         MtgosR/45G+CpKRLG/tThdVXi6XrExIkbtjOkaV0xQ0wkigq1iHtqfK68FCGvsAXlChk
         6zmZM8DKASeK2HwDVZemZLhQ1JRXr5/rsUeIZe15+p3dXSmEdvzZy6XuIn+EJ66/Kagk
         DDweA7VT9pE3fAefR/xAN+ix98iZhYPDBCtapJd5m2V7BJaGQONfv8jOX5LMR/W+Lh7X
         D14g==
X-Forwarded-Encrypted: i=1; AKwUvBzvBE55GvwOBd77+ugfWeBQXOYMCqjiVcwsz+Y+S1iJrqZYmjWk3r3ekd5SUrCD1BF30/NlEi0JJwb88Q==@vger.kernel.org
X-Gm-Message-State: AFuF++nOQ2y2TXP91NJLhKxR11JFx0X2ADn2IMuCzmcUsvF/BAfGXLOF
	EaIrNCZgXtSASwpW19Y5MsqSmqPrsH7thixTo2v6yGUzI/QT7Vc5v4+PPwXqMTANEZ0=
X-Gm-Gg: AYBFou2tbn9ZZEezNtGB01D7CSi0IlFpoItjEWNYjOwuio+jHMCL6aqFn+WcUfbhwES
	q1nld0vWse2PaygfTcJHprDflzndVaTQpQnwxOgfBcS/bwlS4tpKEWUxzq5B7I5SPbcA5PvDJkT
	ExVwRiaJNnApFBc0hyoy7uQuJBLK7MCg7U2X98C6CYo428h+LXJCYzi6LMzYwa+1aJIcL+DBLsl
	BrZmCVZuW7uAHL3nt5TCqHiuB3aq6hSMITl20/MbHJ4gXxE3iXU3OJkmr44mVwehrV88Tku30QD
	b9TAj2R8TFQ2o+IC0ABOOOGkUkdyLZi6JQrcFFuWkxufSmOCflBIFDYPMy2wk/+yKHuZqETZK+h
	+8EqwXYztlb5T1WEh1ptE6OHduq2RadSWSDB9kAZu4qkeho6PyMz9wJKS2Nunk7tKxAVKdabBC9
	i1wKyY0OriGxrm1/g27+U8AIBipJuLE+/k2ntytmFBWwecNc5p0+VejLIyUdQrIVjivQ==
X-Received: by 2002:a05:6000:643:b0:487:955:e6c3 with SMTP id ffacd0b85a97d-48713a887ccmr129202f8f.0.1789572995924;
        Wed, 16 Sep 2026 08:36:35 -0700 (PDT)
Received: from localhost ([2001:4091:a245:8029:665d:b7b:5fa4:7ad0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27c65sm7915045f8f.21.2026.09.16.08.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=761cd574ee4d3e49f3377936d80d108455a0226c8fe418a7549df126e25d;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 16 Sep 2026 17:36:26 +0200
Message-Id: <DLGUOGCLFAI9.2JSS4DCFRYTNI@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: input: gpio-keys: add pinctrl states
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Kendall Willis"
 <k-willis@ti.com>
Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, <msp@baylibre.com>, <s-kochidanadu@ti.com>,
 <a-kaur@ti.com>, <s-tripathi1@ti.com>, <vishalm@ti.com>,
 <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>
 <20260914-unbreakable-competent-beluga-efb5ad@quoll>
 <20260915164819.nlgpuvf37rhzgc66@uda0506412>
 <dec4f6e1-115e-46dd-8fb9-a3c67f1a8811@kernel.org>
 <da881fb0-93da-4d75-88da-8898b2c734eb@kernel.org>
 <20260915174103.ad6tjy6w6s24h2yc@uda0506412>
 <20260916-dancing-loud-guan-fbb1eb@quoll>
In-Reply-To: <20260916-dancing-loud-guan-fbb1eb@quoll>

--761cd574ee4d3e49f3377936d80d108455a0226c8fe418a7549df126e25d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Sep 16, 2026 at 9:17 AM CEST, Krzysztof Kozlowski wrote:
> On Tue, Sep 15, 2026 at 12:41:03PM -0500, Kendall Willis wrote:
>> On 19:07-20260915, Krzysztof Kozlowski wrote:
>> > On 15/09/2026 19:05, Krzysztof Kozlowski wrote:
>> > > On 15/09/2026 18:48, Kendall Willis wrote:
>> > >> On 12:13-20260914, Krzysztof Kozlowski wrote:
>> > >>> On Sat, Sep 12, 2026 at 04:33:53PM -0500, Kendall Willis wrote:
>> > >>>> Document pinctrl properties on the gpio-keys device node. By usin=
g the
>> > >>>> wakeup pinctrl state, the pins are able to wakeup the system from=
 a
>> > >>>> low-power state. The default pinctrl state describes the default =
pin
>> > >>>> configuration.
>> > >>>>
>> > >>>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>> > >>>> ---
>> > >>>>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++=
++++++++++++
>> > >>>>  1 file changed, 16 insertions(+)
>> > >>>>
>> > >>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.ya=
ml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
>> > >>>> index cc78c2152921308fe0cad3e29ca78a5fad08f066..b554933e93412d8b6=
c2ec401dc1e1eeff57d4190 100644
>> > >>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
>> > >>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
>> > >>>> @@ -22,6 +22,22 @@ properties:
>> > >>>> =20
>> > >>>>    poll-interval: true
>> > >>>> =20
>> > >>>> +  pinctrl-0:
>> > >>>> +    description: Default pinctrl state
>> > >>>> +
>> > >>>> +  pinctrl-1:
>> > >>>> +    description: Wakeup pinctrl state
>> > >>>> +
>> > >>>> +  pinctrl-names:
>> > >>>> +    description:
>> > >>>> +      When present should contain at least "default" describing =
the default pin
>> > >>>> +      states. The second state called "wakeup" describes the pin=
s in their
>> > >>>> +      wakeup configuration required to exit sleep states.
>> > >>>> +    minItems: 1
>> > >>>> +    items:
>> > >>>> +      - const: default
>> > >>>> +      - const: wakeup
>> > >>>
>> > >>> This will introduce new warnings, which should be being fixed in t=
his
>> > >>> patchset (e.g. at91-kizbox3-hs.dts).
>> > >>>
>> > >>
>> > >> Will fix the binding to work with current device trees.
>> > >>
>> > >>> But nevertheless, isn't second state the sleep state? How can you
>> > >>> configure pins for the wakeup state - like being in the wakeup? Yo=
u
>> > >>> configure the pins for given state, which will be a system suspend=
, so
>> > >>> sleep?
>> > >>>
>> > >>
>> > >> The sleep state usually refers to putting the pins in a state to sa=
ve
>> > >> power. The wakeup pinctrl state is for putting the pins in a state =
to
>> > >> allow wakeup from suspend for that device. Both 'sleep' and 'wakeup=
'
>> > >> are for system suspend, but they fill different functions. The CAN
>> > >> subsystem also uses the 'wakeup' state in addition to the 'sleep' s=
tate
>> > >> [1].
>> > >=20
>> > > So you mean sleep would be a separate state? But then aren't both
>> > > exactly the same states? IOW, if device is wakeup-source, it will ha=
ve
>> > > for "sleep" state pin configuration allowing to wakeup.
>>=20
>> The 'sleep' and 'wakeup' pin states are both used for suspend. They
>> would just be used separately since only one could be used at a time.
>> The reason 'wakeup' is separated out is because it is more specific for
>> allowing wakeup from the device.
>
> If they cannot be used together, then it is the same state.

If I understand this patch correctly, 'sleep' is not relevant here.
But 'sleep' and 'wakeup' serve different purposes and can be
used/defined together in a single device in the devicetree:
 - 'sleep' describes the pin state during suspend if wakeup is not
   enabled by the user or there is no 'wakeup' pin state defined.
 - 'wakeup' describes the pin state during suspend if wakeup is enabled
   by the user.
If the user enables wakeup, 'wakeup' is the relevant state and otherwise
'sleep'. Which one applieas is a runtime decision of the the user.

I introduced these two states for m_can for that reason. This was
discussed here:
  https://lore.kernel.org/r/DCD1YPX4T779.ADK4JCGW1MU7@baylibre.com

And then reviewed/applied in v10:
  https://lore.kernel.org/r/175993598226.3512549.5295923279078928995.robh@k=
ernel.org

Best
Markus

--761cd574ee4d3e49f3377936d80d108455a0226c8fe418a7549df126e25d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaqq3ehsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlM+
ygD/VE+hJFS+CFW3o1xNzwibjxdZyInzKYw9u2YQjwROYfUA/3CUdbcqbBPrKnV4
8hCIpecynxuiT0xYshtL2xPQjcQF
=LpE8
-----END PGP SIGNATURE-----

--761cd574ee4d3e49f3377936d80d108455a0226c8fe418a7549df126e25d--
