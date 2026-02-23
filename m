Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD5330339;
	Mon, 23 Feb 2026 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872469; cv=none; b=B87G7esNON0AHSj0MtFOtEmDUuURxGAOPvApgAZWgi5t8+pykXcz3S/IIbkRQj+3VZSU2vyD6JPh+5QFVHkBntkJRAtEwNFsARGAFGaC7nAnqvUeLkEhyuXqX8gFsJAMApvhAHmVNe9finqkwlTXuHaPCeeDxyHz5+K1am+4T8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872469; c=relaxed/simple;
	bh=S/Fhfeq6c2gSUF6kiD/QQbwOs+8wCBR7LgpY8Ove/ms=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=g7j6X7gqPKnrJvdfPEMOO1mmFfcuStLSV8TWkLLqQA4OIkKICLTZpXHPBeTIy0lvza5+9t96MVC4pe6DyVOWOEePHa/eJn13CEsXbb7XgrGvBZjr4vamIQf15o/C4UoQG71ttZ3J5dKO+oV8uJk1mfMeLcGOemC39maTdkfoALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=vEZfEFuU; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="vEZfEFuU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=Rylvo2MnvMc39pdD64FAsR9cmm3taALDxqNKKcMzTBY=; b=vEZfEFuU3HzBG5a1P4iL5PqYKS
	yWQ62UVfMBJLM/ueb60VnprCujNpcmRe9qb82FZChwhHw3aqIEraXKYyNHoevcqbwYyLJDvjgpy3v
	rdwmlXvAtEpNLVMKCmgd+QT5SRBeF4PSlY9bPq3Y964vPh9xscQAlit4OkD3RYOGuGkQ=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:57654 helo=debian-lenovo)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vuay2-00049R-Vh; Mon, 23 Feb 2026 13:47:39 -0500
Date: Mon, 23 Feb 2026 13:47:38 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Rob Herring <robh@kernel.org>
Cc: hvilleneuve@dimonoff.com, dmitry.torokhov@gmail.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20260223134738.00988a3d87165cb130292c89@hugovil.com>
In-Reply-To: <20260223175706.GA4168417-robh@kernel.org>
References: <20260213171431.2228814-1-hugo@hugovil.com>
	<20260213171431.2228814-2-hugo@hugovil.com>
	<20260223175706.GA4168417-robh@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -2.3 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v2 1/2] dt-bindings: input: add GPIO charlieplex keypad
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Rob,

On Mon, 23 Feb 2026 11:57:06 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Feb 13, 2026 at 12:14:25PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add DT bindings for GPIO charlieplex keypad.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  .../input/gpio-charlieplex-keypad.yaml        | 82 +++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml b/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> > new file mode 100644
> > index 0000000000000..1672491a75a85
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> > @@ -0,0 +1,82 @@
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
> > +description:
> > +  The charlieplex keypad supports N^2)-N different key combinations (where N is
> > +  the number of lines). Key presses and releases are detected by configuring
> > +  only one line as output at a time, and reading other line states. This process
> > +  is repeated for each line.
> > +  This mechanism doesn't allow to detect simultaneous key presses.
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
> > +  line-scan-delay-us:
> > +    description:
> > +      Delay, measured in microseconds, that is needed
> > +      before we can scan keypad after activating one line.
> > +    default: 0
> 
> Isn't this the same as "col-scan-delay-us" in gpio-matrix-keypad.yaml? 
> If so, move it to matrix-keymap.yaml to re-use it here.

It is used in a similar fashion, but for charlieplex keyboard, there is
no concept of "rows" and "columns". There are only
lines, which are all equivalent in functionality.

> If not, there's a bunch of other scan delay properties just from 
> grepping "delay" in the input bindings. Surely we can define something 
> common.

Most of those delays refer to something quite different than what
"col-scan-delay-us" or "line-scan-delay-us" are used for (it is a delay
that we wait when activating a GPIO before we can safely/reliably read
other GPIOs connected thru its circuitry).

Maybe "col-scan-delay-us" and "line-scan-delay-us" could be
combined into a common "line-scan-delay-us" ("line" is more generic
than column), and defined in matrix-keymap.yaml.

Then would it be ok to remove "col-scan-delay-us" from
gpio-matrix-keypad.yaml and use "line-scan-delay-us" (ABI change) ?

Hugo.

-- 
Hugo Villeneuve <hugo@hugovil.com>
