Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66966318B9D
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967214; cv=none; b=ZabVCVT+hNyNtGhyAVyVkTMJZYIleCTakJPsvANAI6pblNUPaQ4SeDYmJEnxxVz3r8omV4XPuTRo3pDLaqZtw0ksAfVCX81NfGBaQQCClqX10OsiBjbOPPH0b+S+7IIm/3mEfRiyVmNRibfupRraWCRBKUb0jYSeMvD4qv6dJCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967214; c=relaxed/simple;
	bh=5ZxyFX4fJjxsiFTNWut8UPOcbg/MXWt0dmag+uX+KVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QE39bXAcQ++hawSGSQC+poMGf5Q3BSSgMFJCd/YjvJaap0ioxhr4KIGyR0oBtJyDi2cUZ0XoA5Ul1z3v3mSkRLByT7yweV5HopQCjYVK1BBLQEgJvsLBy9YDGWw9y84bcuargyaKIo8Mae/MTXU/Z1TQfdpSKwrxdrHYDkOl4u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkD+4w2f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkD+4w2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18393C4AF09
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 21:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771967214;
	bh=5ZxyFX4fJjxsiFTNWut8UPOcbg/MXWt0dmag+uX+KVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BkD+4w2fUyFUne3zKmZGKN63GKbWJRhEZjmXAvlshNzoiZNHa96wucgFaaEqs3oQh
	 RfRoFrtmn76KpEFKRsA0WBAL48JP/DUrxUvLiuM0l6e2bnnJKeHZmv77Dk6RElCLvM
	 hXLbMZph1CgMYsCDBAnqYZ6gIMLbBOuhnbopc1EXVitnfDMzd2t+5ulNtfbNFHunKW
	 DcpbkKEaN6X4YnSSnw2wlpYJXcjlc1JC9SXF2cMHp0YR+OL2ZXNQEqYm0cBffstg+z
	 mlm8ZcqSdf7CdOGvxbIiKsnnVFmBQgOwjRKiv0ACRABICBcvJu0gFq6Iz84vKXzyih
	 UNx6Lu+SkPVkw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6580dbdb41eso7924725a12.0
        for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 13:06:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcjb1kALpVdvj5YJifDHXzMhJMGn9QQYzbZFHSovuVgKaKMVv6aqNULY0KfoN8uu1pzoesbBuPQHVT7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpaopHy+vt+VjWP/tMj7Esfr2kRzultPcum8obz/YdxveW43Fb
	+R7JF+m7GFk3lvilfQJmAQaqmjCCJ/IIMdktTpJTCi50KC1tPR5pf0C+sR+XSeIfsbOaV5+hNzx
	0pQzuUdTsWDivQsOuNyS7soFiRcrssw==
X-Received: by 2002:a05:6402:210e:b0:65c:6d0:d9fb with SMTP id
 4fb4d7f45d1cf-65ea57cf1d2mr8220326a12.29.1771967212581; Tue, 24 Feb 2026
 13:06:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213171431.2228814-1-hugo@hugovil.com> <20260213171431.2228814-2-hugo@hugovil.com>
 <20260223175706.GA4168417-robh@kernel.org> <20260223134738.00988a3d87165cb130292c89@hugovil.com>
 <CAL_JsqJNASirEqqcT-Sv8h9JC74e+XJSRsAki1ZWeKY8j2zbfw@mail.gmail.com> <20260224154027.0f81b1aa13fe779776e6d58f@hugovil.com>
In-Reply-To: <20260224154027.0f81b1aa13fe779776e6d58f@hugovil.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 24 Feb 2026 15:06:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJtwM33G4qdzpnp6nNtc+tNr6VOKvTB8y6Xv04GTKxymA@mail.gmail.com>
X-Gm-Features: AaiRm52LmPO-MXpNgXdXVgc_DaDgUM46UDbVP5s_hdKHWmV3eddJh2tV_YqD4vs
Message-ID: <CAL_JsqJtwM33G4qdzpnp6nNtc+tNr6VOKvTB8y6Xv04GTKxymA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: input: add GPIO charlieplex keypad
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: hvilleneuve@dimonoff.com, dmitry.torokhov@gmail.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 2:40=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> Hi Rob,
>
> On Mon, 23 Feb 2026 17:23:33 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Mon, Feb 23, 2026 at 12:47=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.=
com> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Mon, 23 Feb 2026 11:57:06 -0600
> > > Rob Herring <robh@kernel.org> wrote:
> > >
> > > > On Fri, Feb 13, 2026 at 12:14:25PM -0500, Hugo Villeneuve wrote:
> > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > >
> > > > > Add DT bindings for GPIO charlieplex keypad.
> > > > >
> > > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > ---
> > > > >  .../input/gpio-charlieplex-keypad.yaml        | 82 +++++++++++++=
++++++
> > > > >  1 file changed, 82 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/input/gpio-=
charlieplex-keypad.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/input/gpio-charlie=
plex-keypad.yaml b/Documentation/devicetree/bindings/input/gpio-charlieplex=
-keypad.yaml
> > > > > new file mode 100644
> > > > > index 0000000000000..1672491a75a85
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/input/gpio-charlieplex-ke=
ypad.yaml
> > > > > @@ -0,0 +1,82 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +
> > > > > +$id: http://devicetree.org/schemas/input/gpio-charlieplex-keypad=
.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: GPIO charlieplex keypad
> > > > > +
> > > > > +maintainers:
> > > > > +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > +
> > > > > +description:
> > > > > +  The charlieplex keypad supports N^2)-N different key combinati=
ons (where N is
> > > > > +  the number of lines). Key presses and releases are detected by=
 configuring
> > > > > +  only one line as output at a time, and reading other line stat=
es. This process
> > > > > +  is repeated for each line.
> > > > > +  This mechanism doesn't allow to detect simultaneous key presse=
s.
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: input.yaml#
> > > > > +  - $ref: /schemas/input/matrix-keymap.yaml#
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: gpio-charlieplex-keypad
> > > > > +
> > > > > +  autorepeat: true
> > > > > +
> > > > > +  line-scan-delay-us:
> > > > > +    description:
> > > > > +      Delay, measured in microseconds, that is needed
> > > > > +      before we can scan keypad after activating one line.
> > > > > +    default: 0
> > > >
> > > > Isn't this the same as "col-scan-delay-us" in gpio-matrix-keypad.ya=
ml?
> > > > If so, move it to matrix-keymap.yaml to re-use it here.
> > >
> > > It is used in a similar fashion, but for charlieplex keyboard, there =
is
> > > no concept of "rows" and "columns". There are only
> > > lines, which are all equivalent in functionality.
> > >
> > > > If not, there's a bunch of other scan delay properties just from
> > > > grepping "delay" in the input bindings. Surely we can define someth=
ing
> > > > common.
> > >
> > > Most of those delays refer to something quite different than what
> > > "col-scan-delay-us" or "line-scan-delay-us" are used for (it is a del=
ay
> > > that we wait when activating a GPIO before we can safely/reliably rea=
d
> > > other GPIOs connected thru its circuitry).
> > >
> > > Maybe "col-scan-delay-us" and "line-scan-delay-us" could be
> > > combined into a common "line-scan-delay-us" ("line" is more generic
> > > than column), and defined in matrix-keymap.yaml.
> >
> > What about "scan-delay-us"? I would assume all the scan delay
> > properties are just the delay after changing the outputs to reading
> > the inputs.
>
> They are for gpio-matrix-keypad.yaml and this binding, but not for
> others. Most scan delay properties refer to the period or
> interval between successive scans.
>
> So for my binding, "settling-time-us" would be more accurate and a
> better property name (it is also used in adc.yaml).

Let's go with that.

>
> Looking into a common place to define this new property, I stumbled
> upon gpio-delay.yaml, so maybe I do not need this new property at all
> and simply define a gpio-delay node if needed (and add it to this
> binding example)?
>
> I tested this and it works, although it requires a patch to the
> gpio-aggregator driver, because for now it respect the delay only
> when changing the output value, not when switching between input and
> output like I do in my driver.
>
> With my patch, it works ok.

I would not use gpio-delay here.

Rob
