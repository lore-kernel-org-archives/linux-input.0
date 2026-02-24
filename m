Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B5330641;
	Tue, 24 Feb 2026 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972375; cv=none; b=okaqkPREIyhCjdOw1yd2oFdOVW2ye4LsDXyx/h+s550UdSSxJF1zZnj09AkPoILrZ7wNDU+8atFVInHTIBf9KrvTEmx6nHoTlpz3iDC+REJlsD4fkD8/fhYkK4uVW2WgTRV0mBN6/b6Wb3+ZUggAKThEkcYsPkp6rkpB11wGhZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972375; c=relaxed/simple;
	bh=CzhJ8MQLlTom+TD5aFyXcY/siHDRgDbkiu4o5MEvNtY=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=IlXC/l8tDrvkSYruavFbNZkXNLDYlZ4nB9C0MnV6ksewuEK6T5/eP3leSxw7eWVwJPNcRNGKqpQe+R6raHRJFhVGjU4gOXBdtE04moURd4V6E+r3M76mbg5W+GBPXwVzjfOWmCAGbKLQ4bQeQ0AeH2G7MFi9LWTG8tnBM+dl/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=TxQFl4zN; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="TxQFl4zN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=Vl8I7cHWw0hfrmEzAKbjzAqqzO/ZEZYz7C7i0mVLMQQ=; b=TxQFl4zNUEdBP5FMkjfOpXqSPY
	h62I8ORLe2rIC8ZJqWvqH6ERGSJTQslrWRqsaMdQZxXb3Y1Hc8hVQhYKRd907H4YqmleU1z+bmSbL
	8MtvER7V12d6mMk2hKAANM0qdQKnaGQSOBVD3cNhkk+txLQiu/e2te3XCTcIpqNjFGvQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:36866 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vv0xV-0001XO-LT; Tue, 24 Feb 2026 17:32:50 -0500
Date: Tue, 24 Feb 2026 17:32:47 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Rob Herring <robh@kernel.org>
Cc: hvilleneuve@dimonoff.com, dmitry.torokhov@gmail.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20260224173247.65ac1b195ff8bab4e8af3163@hugovil.com>
In-Reply-To: <CAL_JsqJtwM33G4qdzpnp6nNtc+tNr6VOKvTB8y6Xv04GTKxymA@mail.gmail.com>
References: <20260213171431.2228814-1-hugo@hugovil.com>
	<20260213171431.2228814-2-hugo@hugovil.com>
	<20260223175706.GA4168417-robh@kernel.org>
	<20260223134738.00988a3d87165cb130292c89@hugovil.com>
	<CAL_JsqJNASirEqqcT-Sv8h9JC74e+XJSRsAki1ZWeKY8j2zbfw@mail.gmail.com>
	<20260224154027.0f81b1aa13fe779776e6d58f@hugovil.com>
	<CAL_JsqJtwM33G4qdzpnp6nNtc+tNr6VOKvTB8y6Xv04GTKxymA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -3.0 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v2 1/2] dt-bindings: input: add GPIO charlieplex keypad
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue, 24 Feb 2026 15:06:40 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Feb 24, 2026 at 2:40 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > Hi Rob,
> >
> > On Mon, 23 Feb 2026 17:23:33 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >
> > > On Mon, Feb 23, 2026 at 12:47 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On Mon, 23 Feb 2026 11:57:06 -0600
> > > > Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > > On Fri, Feb 13, 2026 at 12:14:25PM -0500, Hugo Villeneuve wrote:
> > > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > >
> > > > > > Add DT bindings for GPIO charlieplex keypad.
> > > > > >
> > > > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > > ---
> > > > > >  .../input/gpio-charlieplex-keypad.yaml        | 82 +++++++++++++++++++
> > > > > >  1 file changed, 82 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml b/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> > > > > > new file mode 100644
> > > > > > index 0000000000000..1672491a75a85
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> > > > > > @@ -0,0 +1,82 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +
> > > > > > +$id: http://devicetree.org/schemas/input/gpio-charlieplex-keypad.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: GPIO charlieplex keypad
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > > +
> > > > > > +description:
> > > > > > +  The charlieplex keypad supports N^2)-N different key combinations (where N is
> > > > > > +  the number of lines). Key presses and releases are detected by configuring
> > > > > > +  only one line as output at a time, and reading other line states. This process
> > > > > > +  is repeated for each line.
> > > > > > +  This mechanism doesn't allow to detect simultaneous key presses.
> > > > > > +
> > > > > > +allOf:
> > > > > > +  - $ref: input.yaml#
> > > > > > +  - $ref: /schemas/input/matrix-keymap.yaml#
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    const: gpio-charlieplex-keypad
> > > > > > +
> > > > > > +  autorepeat: true
> > > > > > +
> > > > > > +  line-scan-delay-us:
> > > > > > +    description:
> > > > > > +      Delay, measured in microseconds, that is needed
> > > > > > +      before we can scan keypad after activating one line.
> > > > > > +    default: 0
> > > > >
> > > > > Isn't this the same as "col-scan-delay-us" in gpio-matrix-keypad.yaml?
> > > > > If so, move it to matrix-keymap.yaml to re-use it here.
> > > >
> > > > It is used in a similar fashion, but for charlieplex keyboard, there is
> > > > no concept of "rows" and "columns". There are only
> > > > lines, which are all equivalent in functionality.
> > > >
> > > > > If not, there's a bunch of other scan delay properties just from
> > > > > grepping "delay" in the input bindings. Surely we can define something
> > > > > common.
> > > >
> > > > Most of those delays refer to something quite different than what
> > > > "col-scan-delay-us" or "line-scan-delay-us" are used for (it is a delay
> > > > that we wait when activating a GPIO before we can safely/reliably read
> > > > other GPIOs connected thru its circuitry).
> > > >
> > > > Maybe "col-scan-delay-us" and "line-scan-delay-us" could be
> > > > combined into a common "line-scan-delay-us" ("line" is more generic
> > > > than column), and defined in matrix-keymap.yaml.
> > >
> > > What about "scan-delay-us"? I would assume all the scan delay
> > > properties are just the delay after changing the outputs to reading
> > > the inputs.
> >
> > They are for gpio-matrix-keypad.yaml and this binding, but not for
> > others. Most scan delay properties refer to the period or
> > interval between successive scans.
> >
> > So for my binding, "settling-time-us" would be more accurate and a
> > better property name (it is also used in adc.yaml).
> 
> Let's go with that.

Ok, will do.

> 
> >
> > Looking into a common place to define this new property, I stumbled
> > upon gpio-delay.yaml, so maybe I do not need this new property at all
> > and simply define a gpio-delay node if needed (and add it to this
> > binding example)?
> >
> > I tested this and it works, although it requires a patch to the
> > gpio-aggregator driver, because for now it respect the delay only
> > when changing the output value, not when switching between input and
> > output like I do in my driver.
> >
> > With my patch, it works ok.
> 
> I would not use gpio-delay here.

Ok.

I also observed that debounce-delay-ms is re-defined by a few bindings,
including mine. I assume that I could move all these identical
definitions to input.yaml and reduce duplication (in a separate patch,
of course).

While testing that, I found an odd situation: if I reference these four
dummy (undefined anywhere) properties in the gpio-matrix-keypad
binding, I am expecting four warnings when validating it. However I get
just three:

==================
diff --git
a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.yaml
b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.yaml index
20b5371fa21c..733458bf4d13 100644
--- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.yaml
@@ -36,7 +36,10 @@ properties:
 
   linux,keymap: true
 
+  bogus1-delay-ms: true
+  bogus2-delay-ms-bogus2: true
+  bogus3-my-property: true
+  bogus4: true
 
   linux,no-autorepeat:
     type: boolean
==================

Validation result:

...
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
...
...input/gpio-matrix-keypad.yaml:
  bogus2-delay-ms-bogus2: missing type definition
...input/gpio-matrix-keypad.yaml:
  bogus3-my-property: missing type definition
...input/gpio-matrix-keypad.yaml:
  bogus4: missing type definition

any idea why?

Thank you,
Hugo.

-- 
Hugo Villeneuve
