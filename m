Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27724E4C3;
	Thu, 26 Feb 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117302; cv=none; b=ZrhkRis1Gp2M4So8gBQVo1OMcVT82PBwP/QaZYhR9T2IBCNEwTDuzplAnx4u63XF33Zx8m7+qK4tyK4oPb4TBkY2jrNcpCHu04w3q544eS1iMkvqAQwW4PsMImvX4wnPqZ6KItBVoj/zT1HMDgLkD2TmLcAO8rz83D9EMN1eiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117302; c=relaxed/simple;
	bh=p1sd2y/gxKTiFVquzMChHA8eoQQkh/5qTOpvKH77ywY=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=Lt97TIigclYfatlGuu8ibD35zhCmojA56g9c3GaufmUNxyO8xuEL8QJFcQ0UDhiveFNOBSHaRY3etpLoJcCqBsm8Vrk6yTHcN/jMAtq6syL7dypBAhrDQ+B1Bazy3wwwhwn4zXrEf7WrAdz2zg1Yyw4s6s6a5gQB308ULoc5NZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=G7U75ipV; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="G7U75ipV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=LF1zAuSNqXIs/9ctoJjEp+VMTDcoeXF/IvZ3mF+jESg=; b=G7U75ipV5fNWP5LU5UL5Flnmb3
	6zLQjZqQFHHR0I9QbeAm5xdxA0aAYpZwxMWMuWd+lTBYR9zz77wfUTqGUMroszRXqY0rBLM6XFJ6Y
	Wi8BEr51t14dNJwV7zWaxcCWrWAl0ro7lMrZprtKB84ogNWycVyJTVQBsfLF9NTyTzk8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:47368 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vvcew-0004LS-Jk; Thu, 26 Feb 2026 09:48:11 -0500
Date: Thu, 26 Feb 2026 09:48:09 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: robin@protonic.nl, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com, hvilleneuve@dimonoff.com,
 mkorpershoek@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, lee@kernel.org,
 alexander.sverdlin@gmail.com, marek.vasut@gmail.com, akurz@blala.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Message-Id: <20260226094809.ce24cde2622c7adb84fb4410@hugovil.com>
In-Reply-To: <CAMuHMdVdYX9p9DfDoyMv8qEm52kY51QULkEnuxRBH2OyWyYf6g@mail.gmail.com>
References: <20260225155409.612478-1-hugo@hugovil.com>
	<20260225155409.612478-4-hugo@hugovil.com>
	<CAMuHMdVdYX9p9DfDoyMv8qEm52kY51QULkEnuxRBH2OyWyYf6g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -1.9 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3 3/4] dt-bindings: input: add GPIO charlieplex keypad
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Geert,

On Thu, 26 Feb 2026 10:32:30 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hugo,
> 
> On Wed, 25 Feb 2026 at 16:54, Hugo Villeneuve <hugo@hugovil.com> wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Add DT bindings for GPIO charlieplex keypad.
> >
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Thanks for your patch!
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> > @@ -0,0 +1,106 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/input/gpio-charlieplex-keypad.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: GPIO charlieplex keypad
> > +
> > +maintainers:
> > +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > +
> > +description: |
> > +  The charlieplex keypad supports N^2)-N different key combinations (where N is
> > +  the number of lines). Key presses and releases are detected by configuring
> > +  only one line as output at a time, and reading other line states. This process
> > +  is repeated for each line. Diodes are required to ensure current flows in only
> > +  one direction between any pair of pins.
> > +  This mechanism doesn't allow to detect simultaneous key presses.
> 
> Indeed, e.g. pressing S1 and S2 simultaneously will show a ghost
> S5 keypress.
> 
> > +
> > +  Wiring example for 3 lines keyboard with 6 switches and 3 diodes:
> > +
> > +  L0  --+---------------------+----------------------+
> > +        |                     |                      |
> > +  L1  -------+-----------+---------------------+     |
> > +        |    |           |    |                |     |
> > +  L2  -------------+----------------+-----+    |     |
> > +        |    |     |     |    |     |     |    |     |
> > +        |    |     |     |    |     |     |    |     |
> > +        |  S1 \  S2 \    |  S3 \  S4 \    |  S5 \  S6 \
> > +        |    |     |     |    |     |     |    |     |
> > +        |    +--+--+     |    +--+--+     |    +--+--+
> > +        |       |        |       |        |       |
> > +        |    D1 v        |    D2 v        |    D3 v
> > +        |       - (k)    |       - (k)    |       - (k)
> > +        |       |        |       |        |       |
> > +        +-------+        +-------+        +-------+
> 
> Don't you need pull-down resistors on L[0-2], and/or a way to specify
> in DT to enable internal poll-down on GPIO controllers that support it?
> Some controllers may support internal pull-up only, but I guess that
> can be handled using GPIO_ACTIVE_LOW?

Yes, I did not put any resistors in the diagram in order to keep it
simple and clear.

You need pull-down resistors either on the board, or specified in the
DT like we do for our board (we use the PCAL6416 with pull-up/down
support):

  line-gpios = <&gpio20 0 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)
                 ...

I will add this to the example, and add a few lines explaining this in
the description.


> > +
> > +  L: GPIO line
> > +  S: switch
> > +  D: diode (k indicates cathode)
> > +
> > +allOf:
> > +  - $ref: input.yaml#
> > +  - $ref: /schemas/input/matrix-keymap.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: gpio-charlieplex-keypad
> > +
> > +  autorepeat: true
> > +
> > +  debounce-delay-ms:
> > +    default: 5
> > +
> > +  line-gpios:
> > +    description:
> > +      List of GPIOs used as lines. The gpio specifier for this property
> > +      depends on the gpio controller to which these lines are connected.
> > +
> > +  linux,keymap: true
> > +
> > +  poll-interval: true
> > +
> > +  settling-time-us: true
> > +
> > +  wakeup-source: true
> > +
> > +required:
> > +  - compatible
> > +  - line-gpios
> > +  - linux,keymap
> > +  - poll-interval
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/input/input.h>
> > +
> > +    charlieplex-keypad {
> 
> "keyboard", as per Devicetree Specification Generic Names
> Recommendation.

Ok.

Thank you,
Hugo.

> 
> > +        compatible = "gpio-charlieplex-keypad";
> > +        debounce-delay-ms = <20>;
> > +        poll-interval = <5>;
> > +        settling-time-us = <2>;
> > +
> > +        line-gpios = <&gpio2 25 GPIO_ACTIVE_HIGH
> > +                      &gpio2 26 GPIO_ACTIVE_HIGH
> > +                      &gpio2 27 GPIO_ACTIVE_HIGH>;
> > +
> > +        /* MATRIX_KEY(output, input, key-code) */
> > +        linux,keymap = <
> > +            /*
> > +             * According to wiring diagram above, if L1 is configured as
> > +             * output and HIGH, and we detect a HIGH level on input L0,
> > +             * then it means S1 is pressed: MATRIX_KEY(L1, L0, KEY...)
> > +             */
> > +            MATRIX_KEY(1, 0, KEY_F1) /* S1 */
> > +            MATRIX_KEY(2, 0, KEY_F2) /* S2 */
> > +            MATRIX_KEY(0, 1, KEY_F3) /* S3 */
> > +            MATRIX_KEY(2, 1, KEY_F4) /* S4 */
> > +            MATRIX_KEY(1, 2, KEY_F5) /* S5 */
> > +            MATRIX_KEY(0, 2, KEY_F6) /* S6 */
> > +        >;
> > +    };
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
Hugo Villeneuve
