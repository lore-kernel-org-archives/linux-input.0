Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD934F27B
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972632; cv=none; b=ZuF00nCucBt+s2RzpRN3pY0+v5haKAt8YCpRW2iXzBtvLlQjvjpjl5CukeZzQs9uSdvNdee3ahRgHM5dd5EY2sFIaxCPAujbaH8zd62lcM6ZVLjt9mjIyHZYSJeuBctj/9/uCRrYwXZFr47BcpXKzHcsEP9HQHcCcXkiQPdjQG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972632; c=relaxed/simple;
	bh=dbFs2eXBnHbbxt3KtzQ4t5nPQsEfBYZPRtyLWQYUTzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNQb5uso6jPLbEeYJXEQONyiGyKNzzEAQlKWJqP3xC9AOhVnwC3o+Y8I8Y+Tiigx/gekUVQen47XDK93Cz05wItGHC2bBOhnmmX7mq+X+CFrNIZLmVCj2Uiyv5/xnaDpo6KaO6nq0LTKa+7GWOR3gF6gsHi0Gl04qiHubP/EKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb9U2xwX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb9U2xwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC47C2BCAF
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 22:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771972632;
	bh=dbFs2eXBnHbbxt3KtzQ4t5nPQsEfBYZPRtyLWQYUTzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lb9U2xwXEFGVjt9rPVZqO1rcWxIlGV5xrXRGnN0t4ucUoqUCPhOA8PtFayLKBgw6f
	 FTRr9MoHrie+CFU0jwnHXcqS1ct6Fa7hnoRS6yTGIgviB5PYwzzfGkrEpzDicvFrhP
	 30V8N5cm71RBR6YkmZb+ycHrsSYCvZL8oWh58+PS3P2CoOiScWlEPmXB5QeRgLIUde
	 hvi8Vlvt3qfEGIS8wqbsPb5HcPR2Fm5I+KHtBxwwaW5vPv+orjpw/+f3HvhnmnNCZk
	 VGzGXZsV3BLRMI36CCHft9VJwIioN1u+92ZOQvwz1C3K2j1bF+Cag//lI7lnPuEPUr
	 j0s4jDsImO9Mw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8f8d80faebso40003966b.1
        for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 14:37:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXa/w5BfDYHUOemzulSeo8Zj8evcZWvZkXxOpcvuXoMuMsaMHjhfoTXMtj73ZGfnriydcqhlLdohgqapg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4USVk+hIOOK6xZcNFo6jkAqdMjtmmoAXbqQuEutULkHxdPvI
	aBeL5gTvssVNubW7sN4r8TzXuAtAJJ2djC8TVtxjEjUJObLJGjn8ckKu3A51UPycznUvnqaw/4A
	kEP7rA61q+49JApLV3B0AaXmx5I0H3A==
X-Received: by 2002:a17:907:6094:b0:b88:5894:6ba1 with SMTP id
 a640c23a62f3a-b9340f99206mr26057466b.28.1771972630517; Tue, 24 Feb 2026
 14:37:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213171431.2228814-1-hugo@hugovil.com> <20260213171431.2228814-2-hugo@hugovil.com>
 <20260223175706.GA4168417-robh@kernel.org> <20260223134738.00988a3d87165cb130292c89@hugovil.com>
 <CAL_JsqJNASirEqqcT-Sv8h9JC74e+XJSRsAki1ZWeKY8j2zbfw@mail.gmail.com>
 <20260224154027.0f81b1aa13fe779776e6d58f@hugovil.com> <CAL_JsqJtwM33G4qdzpnp6nNtc+tNr6VOKvTB8y6Xv04GTKxymA@mail.gmail.com>
 <20260224173247.65ac1b195ff8bab4e8af3163@hugovil.com>
In-Reply-To: <20260224173247.65ac1b195ff8bab4e8af3163@hugovil.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 24 Feb 2026 16:36:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKUCUfbEBQLmS9sGxM9XUmP-+SUHbjzCVa0RsL--eQdgQ@mail.gmail.com>
X-Gm-Features: AaiRm5087_WrRoE8dZVQfdmhNvlCYK2PGAdorMoCk_Lu_WzGIyCNRIsczIopzgM
Message-ID: <CAL_JsqKUCUfbEBQLmS9sGxM9XUmP-+SUHbjzCVa0RsL--eQdgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: input: add GPIO charlieplex keypad
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: hvilleneuve@dimonoff.com, dmitry.torokhov@gmail.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 4:32=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> On Tue, 24 Feb 2026 15:06:40 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Tue, Feb 24, 2026 at 2:40=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.c=
om> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Mon, 23 Feb 2026 17:23:33 -0600
> > > Rob Herring <robh@kernel.org> wrote:
> > >
> > > > On Mon, Feb 23, 2026 at 12:47=E2=80=AFPM Hugo Villeneuve <hugo@hugo=
vil.com> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > On Mon, 23 Feb 2026 11:57:06 -0600
> > > > > Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > > On Fri, Feb 13, 2026 at 12:14:25PM -0500, Hugo Villeneuve wrote=
:
> > > > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > > >
> > > > > > > Add DT bindings for GPIO charlieplex keypad.
> > > > > > >
> > > > > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > > > ---
> > > > > > >  .../input/gpio-charlieplex-keypad.yaml        | 82 +++++++++=
++++++++++
> > > > > > >  1 file changed, 82 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/input/g=
pio-charlieplex-keypad.yaml
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/input/gpio-cha=
rlieplex-keypad.yaml b/Documentation/devicetree/bindings/input/gpio-charlie=
plex-keypad.yaml
> > > > > > > new file mode 100644
> > > > > > > index 0000000000000..1672491a75a85
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/input/gpio-charlieple=
x-keypad.yaml
> > > > > > > @@ -0,0 +1,82 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +
> > > > > > > +$id: http://devicetree.org/schemas/input/gpio-charlieplex-ke=
ypad.yaml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: GPIO charlieplex keypad
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > > > +
> > > > > > > +description:
> > > > > > > +  The charlieplex keypad supports N^2)-N different key combi=
nations (where N is
> > > > > > > +  the number of lines). Key presses and releases are detecte=
d by configuring
> > > > > > > +  only one line as output at a time, and reading other line =
states. This process
> > > > > > > +  is repeated for each line.
> > > > > > > +  This mechanism doesn't allow to detect simultaneous key pr=
esses.
> > > > > > > +
> > > > > > > +allOf:
> > > > > > > +  - $ref: input.yaml#
> > > > > > > +  - $ref: /schemas/input/matrix-keymap.yaml#
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    const: gpio-charlieplex-keypad
> > > > > > > +
> > > > > > > +  autorepeat: true
> > > > > > > +
> > > > > > > +  line-scan-delay-us:
> > > > > > > +    description:
> > > > > > > +      Delay, measured in microseconds, that is needed
> > > > > > > +      before we can scan keypad after activating one line.
> > > > > > > +    default: 0
> > > > > >
> > > > > > Isn't this the same as "col-scan-delay-us" in gpio-matrix-keypa=
d.yaml?
> > > > > > If so, move it to matrix-keymap.yaml to re-use it here.
> > > > >
> > > > > It is used in a similar fashion, but for charlieplex keyboard, th=
ere is
> > > > > no concept of "rows" and "columns". There are only
> > > > > lines, which are all equivalent in functionality.
> > > > >
> > > > > > If not, there's a bunch of other scan delay properties just fro=
m
> > > > > > grepping "delay" in the input bindings. Surely we can define so=
mething
> > > > > > common.
> > > > >
> > > > > Most of those delays refer to something quite different than what
> > > > > "col-scan-delay-us" or "line-scan-delay-us" are used for (it is a=
 delay
> > > > > that we wait when activating a GPIO before we can safely/reliably=
 read
> > > > > other GPIOs connected thru its circuitry).
> > > > >
> > > > > Maybe "col-scan-delay-us" and "line-scan-delay-us" could be
> > > > > combined into a common "line-scan-delay-us" ("line" is more gener=
ic
> > > > > than column), and defined in matrix-keymap.yaml.
> > > >
> > > > What about "scan-delay-us"? I would assume all the scan delay
> > > > properties are just the delay after changing the outputs to reading
> > > > the inputs.
> > >
> > > They are for gpio-matrix-keypad.yaml and this binding, but not for
> > > others. Most scan delay properties refer to the period or
> > > interval between successive scans.
> > >
> > > So for my binding, "settling-time-us" would be more accurate and a
> > > better property name (it is also used in adc.yaml).
> >
> > Let's go with that.
>
> Ok, will do.
>
> >
> > >
> > > Looking into a common place to define this new property, I stumbled
> > > upon gpio-delay.yaml, so maybe I do not need this new property at all
> > > and simply define a gpio-delay node if needed (and add it to this
> > > binding example)?
> > >
> > > I tested this and it works, although it requires a patch to the
> > > gpio-aggregator driver, because for now it respect the delay only
> > > when changing the output value, not when switching between input and
> > > output like I do in my driver.
> > >
> > > With my patch, it works ok.
> >
> > I would not use gpio-delay here.
>
> Ok.
>
> I also observed that debounce-delay-ms is re-defined by a few bindings,
> including mine. I assume that I could move all these identical
> definitions to input.yaml and reduce duplication (in a separate patch,
> of course).

Yes, that would be good.

> While testing that, I found an odd situation: if I reference these four
> dummy (undefined anywhere) properties in the gpio-matrix-keypad
> binding, I am expecting four warnings when validating it. However I get
> just three:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git
> a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.yaml
> b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.yaml index
> 20b5371fa21c..733458bf4d13 100644
> --- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.yaml
> @@ -36,7 +36,10 @@ properties:
>
>    linux,keymap: true
>
> +  bogus1-delay-ms: true
> +  bogus2-delay-ms-bogus2: true
> +  bogus3-my-property: true
> +  bogus4: true
>
>    linux,no-autorepeat:
>      type: boolean
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Validation result:
>
> ...
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> ...
> ...input/gpio-matrix-keypad.yaml:
>   bogus2-delay-ms-bogus2: missing type definition
> ...input/gpio-matrix-keypad.yaml:
>   bogus3-my-property: missing type definition
> ...input/gpio-matrix-keypad.yaml:
>   bogus4: missing type definition
>
> any idea why?

Properties with a unit suffix like "-ms" always have a type hence why
they don't ever define a type.

Rob
