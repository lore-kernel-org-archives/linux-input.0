Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97A37F73E
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889026; cv=none; b=A9eUz6D88ILJ/L+YpUKskuWOf22idSyjaSrNtb5eiwygtDTQybJ9MyjAObSsMNBgadpZj1FMjy5WsCxuQZcnL/ha+v9RnztFT83TW0OVt+v/7Sa8o5MlMVkA4cmw7QdeYijIyoQF32Hr2zxEAw//mjZrrF02EQQZAENAhaQUR0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889026; c=relaxed/simple;
	bh=Mma3k55Qh/hUNkE7ueeRkYpGEpsZ/KsMKu/TgULG2Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+6sVisr0Cfp7t6kqGZzkh6CJsg4m58p5AryC4Z7DZ/fYz9/5Ssd39V6LPjFNZFKhKnoo9uTUjRx86WpZfHGBi04YedPQiOQX/b8rw/jw+Z8A1NvEMI81l2cNfbQ/XKmbAqxfixuv1hz8ZM8XZUn2ikeiz13LCMd8S6ANIimWGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOqHRbPq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOqHRbPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F157CC2BC9E
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 23:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889026;
	bh=Mma3k55Qh/hUNkE7ueeRkYpGEpsZ/KsMKu/TgULG2Lw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YOqHRbPqXHTLBor8MxJi6FT3zVdInbCwI2eOMIL8euYHimw/2187ESI4FYFzMIdao
	 qcma9uy15IZo61hNy6uVYPfntiayQAPS2Mo+UoI0IBOxQ0sBEWDcNqfTLzJCeAJohq
	 4mQtHfArFQb2eRzVfgwuiGhkAnUNKHTrniXtozHuC4rwo/nkw4ojRg+/+2+7lqZHuS
	 vMkj+2erWL62zt0UGooaYotN7lPG11jUuIEXLsinCmPI3N4F6NjKLxCGJOaEQ7MIVf
	 w8vtUPjyP8NxrpfXo407yG4hunVqayFBsm3Y1saWZORxvHS27i0Tiod2tr/dtyOEab
	 0DpY3cb6uad5g==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8fb6ad3243so689174166b.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 15:23:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5LyFY9zwjs/iaZoq4Ah/s/NL3G6YM1ghP/eIQy5rLquFxW3GzCl0NA9HeJYSpSCkqmb7Sgxy0gqzWhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzALgoaNvhNbFqsDMk6EV3NYLi5pl5ZKTsJsQxgRCGj4NR3gAuQ
	1muTQRHv5Y8+ARXj/Blxz+B01wlHAWmOaepU4ibCoOW7wnuT81hn7se1pwMBuUixT6rnmE6XYd1
	89b8Oh0kqtnfhakdkZPJjl+YIBTU+eg==
X-Received: by 2002:a17:907:6d21:b0:b87:2675:9eaa with SMTP id
 a640c23a62f3a-b9081a0144fmr686016766b.15.1771889024517; Mon, 23 Feb 2026
 15:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213171431.2228814-1-hugo@hugovil.com> <20260213171431.2228814-2-hugo@hugovil.com>
 <20260223175706.GA4168417-robh@kernel.org> <20260223134738.00988a3d87165cb130292c89@hugovil.com>
In-Reply-To: <20260223134738.00988a3d87165cb130292c89@hugovil.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 23 Feb 2026 17:23:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJNASirEqqcT-Sv8h9JC74e+XJSRsAki1ZWeKY8j2zbfw@mail.gmail.com>
X-Gm-Features: AaiRm53RD-e_ZW_JCPOMCP4IeMAXj58VIz__dBQmWI3a3ed4hzTHVMPF-IKyixc
Message-ID: <CAL_JsqJNASirEqqcT-Sv8h9JC74e+XJSRsAki1ZWeKY8j2zbfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: input: add GPIO charlieplex keypad
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: hvilleneuve@dimonoff.com, dmitry.torokhov@gmail.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 12:47=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
>
> Hi Rob,
>
> On Mon, 23 Feb 2026 11:57:06 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Fri, Feb 13, 2026 at 12:14:25PM -0500, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >
> > > Add DT bindings for GPIO charlieplex keypad.
> > >
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > >  .../input/gpio-charlieplex-keypad.yaml        | 82 +++++++++++++++++=
++
> > >  1 file changed, 82 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/input/gpio-char=
lieplex-keypad.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/input/gpio-charlieplex=
-keypad.yaml b/Documentation/devicetree/bindings/input/gpio-charlieplex-key=
pad.yaml
> > > new file mode 100644
> > > index 0000000000000..1672491a75a85
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad=
.yaml
> > > @@ -0,0 +1,82 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +
> > > +$id: http://devicetree.org/schemas/input/gpio-charlieplex-keypad.yam=
l#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: GPIO charlieplex keypad
> > > +
> > > +maintainers:
> > > +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > +
> > > +description:
> > > +  The charlieplex keypad supports N^2)-N different key combinations =
(where N is
> > > +  the number of lines). Key presses and releases are detected by con=
figuring
> > > +  only one line as output at a time, and reading other line states. =
This process
> > > +  is repeated for each line.
> > > +  This mechanism doesn't allow to detect simultaneous key presses.
> > > +
> > > +allOf:
> > > +  - $ref: input.yaml#
> > > +  - $ref: /schemas/input/matrix-keymap.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: gpio-charlieplex-keypad
> > > +
> > > +  autorepeat: true
> > > +
> > > +  line-scan-delay-us:
> > > +    description:
> > > +      Delay, measured in microseconds, that is needed
> > > +      before we can scan keypad after activating one line.
> > > +    default: 0
> >
> > Isn't this the same as "col-scan-delay-us" in gpio-matrix-keypad.yaml?
> > If so, move it to matrix-keymap.yaml to re-use it here.
>
> It is used in a similar fashion, but for charlieplex keyboard, there is
> no concept of "rows" and "columns". There are only
> lines, which are all equivalent in functionality.
>
> > If not, there's a bunch of other scan delay properties just from
> > grepping "delay" in the input bindings. Surely we can define something
> > common.
>
> Most of those delays refer to something quite different than what
> "col-scan-delay-us" or "line-scan-delay-us" are used for (it is a delay
> that we wait when activating a GPIO before we can safely/reliably read
> other GPIOs connected thru its circuitry).
>
> Maybe "col-scan-delay-us" and "line-scan-delay-us" could be
> combined into a common "line-scan-delay-us" ("line" is more generic
> than column), and defined in matrix-keymap.yaml.

What about "scan-delay-us"? I would assume all the scan delay
properties are just the delay after changing the outputs to reading
the inputs.

> Then would it be ok to remove "col-scan-delay-us" from
> gpio-matrix-keypad.yaml and use "line-scan-delay-us" (ABI change) ?

No!

Rob
