Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06E3E2754
	for <linux-input@vger.kernel.org>; Thu,  9 Apr 2026 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755015; cv=none; b=eib6pG2kygqVjRg6hV0eh+bbX6jatBrZecFZm+SQDYj8xLsAwhxFLaunUw3Y53AcgMAk9xfxgSvRxc5QZh3xCdu9vqBXC4hhoBVY1jplh78e9gketMi91LXr8Dr6ZksRwzcw/DZUA50qHwafTct6z8l3GWKqZaBIv9ErjxHspDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755015; c=relaxed/simple;
	bh=S60+iELf201hWfWsA0+5HzASsARSxTciNv62Lq5+S90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q86OSEAiKtqKREpGrO6l17VfrsNwXDe+qttHV701JPCJc19irOk4t1cCjzjy6vF8QZYBvKCOZwO/kb4vzH7bgmSUeuvqb0dJiX3q91C9xBAp1HMXt4CjadO3YXmuEXZvHUSZzMs+ZQUtW7HrQAD2v8N+6RIyRuzVT5Cdt3aOzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix9GuZZA; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix9GuZZA"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2cc4c693d59so310954eec.1
        for <linux-input@vger.kernel.org>; Thu, 09 Apr 2026 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775755011; x=1776359811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OiUmxJypMk7dUgMF/8X+eU6lB0Kg/0QHff8vgI/w/kA=;
        b=Ix9GuZZA7oD3oe45n0dpQmNG+x2p3bO3hgebWxOV2WoySs6B/HLyE6lPOdXKM1guQQ
         /O31QDbYhoG+obtxcw03evTeIhKf2vU5JrIIsH3ylr6+RunTX9vpy5NCRAbgZwSIpp/S
         7jftrBtpowJOe9riVQ60YmAm4o8MBNkll0nXQSaDvYZ9Dks9RVCswpJNh69uNQWg5q37
         zfMGmpM1OMsSrCn2tU+iFMQ9X5gjw3DBc0MLFOzmkCCaLM4qbjjVHhdfAphEfet8yso9
         yrjwYi+No1UGdcvaX5/yv2aYpsEGlQVhs20REHeZWDCVsnDWKMBRiuPw86e02y/L0Cps
         WQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775755011; x=1776359811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiUmxJypMk7dUgMF/8X+eU6lB0Kg/0QHff8vgI/w/kA=;
        b=fosMVX37f2KIVXZbGjOFJTL6kBNtL02ZYkhk64hnY73riQqO4En4wxedyIKcYFpTye
         mXdf+eRk/rx4F/nMcVoyvf3nD51S9NpU78FA5af2RQtejfR2B2SfonPwTGDTEHvjns3O
         Urrf6vgJrN9HwefHCL4qsHMQkfTpD+StFbj3Gs6yUGg599kGJjarKOzV2kgxb477pJ2U
         BG+5hCdQKvtbvsbXq92XPyqyErCFz4odeObUNiFD/1vmU15dWaPY0z1WnCI+/jIIHN5W
         cuwAga20wmfsQb+gIFeibL2mKxxjSW15E7UoqmvZZVuajaDZ51RZxGK3bUMQ8MrD1oFW
         FYsg==
X-Forwarded-Encrypted: i=1; AJvYcCWmDyw0GnSTRKMHRwElkgR3H8Yj90UVD6qJaqolGQTVVuC4CjEmp2fwWP3oZPaswCis9TkOcL/hIGFdcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQOaw9ksKKUHTtbTXulpLVoBaPMHygx6IWFErp0FMEqSgMmb8
	koQc/Pm+d2p0aMQR2uvm1UyKhmD4G6HB9Zl5kmNKEFkwvnzD7J7T6ilp
X-Gm-Gg: AeBDievMMMA/FmHfg0/DfZtLo5PRvgtgH4KU8xetysRQAf9h6qvDeHrB1wGmqHcqmvk
	oV6Z9mYbh4nSPqwXY1R22HWKvMr+bLQUZXdAdjH03+pRTeNL0L1A403xaf0RXyLhaa79tIvPd+o
	pkoMERuNhygjAISYC2DOon1cB/vj5dXJ7Q0dSfDx+YmcknTPO6V3Nh6huhyipsqxaPi8RSitQcU
	DJvjdWvqGfZo3sOhS4DfojbfU4MBR4ifmlM0OTwJHsQsdwoiRu57W7hz5uHGaH8bILu9LsNXfVf
	t43UOqA7lb/08kkp83NupWBNLfdaTQGTXHqlODUiWIYUVuLYkd9otEPng9MTEG7xspemiukrHgo
	Kxe5UNfSsVUmMvSudZp7780QiE/+lUKhgrsju3Q6ZBkbq1Wa43zotEw/q73soJ39SjJeS+hKw0i
	SmyALVv2utYbN08Hil7011nhL5giIsAHgj58doT0k27dejivzbB90rMrQhuMnVVul0
X-Received: by 2002:a05:693c:2b17:b0:2c3:5dc0:a06b with SMTP id 5a478bee46e88-2d40defc97fmr3118618eec.20.1775755011019;
        Thu, 09 Apr 2026 10:16:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:12ff:7738:6560:2618])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55ff826dcsm484882eec.13.2026.04.09.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:16:50 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:16:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jingyuan Liang <jingyliang@chromium.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, hbarnor@chromium.org, 
	tfiga@chromium.org, Dmitry Antipov <dmanti@microsoft.com>, 
	Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH v3 09/11] dt-bindings: input: Document hid-over-spi DT
 schema
Message-ID: <adfdkwq_bF9dirAq@google.com>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
 <20260402-send-upstream-v3-9-6091c458d357@chromium.org>
 <20260409-defuse-thank-4b038128fac5@spud>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-defuse-thank-4b038128fac5@spud>

On Thu, Apr 09, 2026 at 05:02:11PM +0100, Conor Dooley wrote:
> On Thu, Apr 02, 2026 at 01:59:46AM +0000, Jingyuan Liang wrote:
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> > 
> > The properties are common to HID over SPI.
> > 
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> > ---
> >  .../devicetree/bindings/input/hid-over-spi.yaml    | 126 +++++++++++++++++++++
> >  1 file changed, 126 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > new file mode 100644
> > index 000000000000..d1b0a2e26c32
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > @@ -0,0 +1,126 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HID over SPI Devices
> > +
> > +maintainers:
> > +  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > +  - Jiri Kosina <jkosina@suse.cz>
> 
> Why them and not you, the developers of the series?
> 
> > +
> > +description: |+
> > +  HID over SPI provides support for various Human Interface Devices over the
> > +  SPI bus. These devices can be for example touchpads, keyboards, touch screens
> > +  or sensors.
> > +
> > +  The specification has been written by Microsoft and is currently available
> > +  here: https://www.microsoft.com/en-us/download/details.aspx?id=103325
> > +
> > +  If this binding is used, the kernel module spi-hid will handle the
> > +  communication with the device and the generic hid core layer will handle the
> > +  protocol.
> 
> This is not relevant to the binding, please remove it.
> 
> > +
> > +allOf:
> > +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - microsoft,g6-touch-digitizer
> > +          - const: hid-over-spi
> > +      - description: Just "hid-over-spi" alone is allowed, but not recommended.
> > +        const: hid-over-spi
> 
> Why is it allowed but not recommended? Seems to me like we should
> require device-specific compatibles.

Why would we want to change the driver code to add a new compatible each
time a vendor decides to create a chip that is fully hid-spi-protocol
compliant? Or is the plan to still allow "hid-over-spi" fallback but
require device-specific compatible that will be ignored unless there is
device-specific quirk needed?

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO specifier for the digitizer's reset pin (active low). The line must
> > +      be flagged with GPIO_ACTIVE_LOW.
> > +
> > +  vdd-supply:
> > +    description:
> > +      Regulator for the VDD supply voltage.
> > +
> > +  input-report-header-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 0xffffff
> > +    description:
> > +      A value to be included in the Read Approval packet, listing an address of
> > +      the input report header to be put on the SPI bus. This address has 24
> > +      bits.
> > +
> > +  input-report-body-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 0xffffff
> > +    description:
> > +      A value to be included in the Read Approval packet, listing an address of
> > +      the input report body to be put on the SPI bus. This address has 24 bits.
> > +
> > +  output-report-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 0xffffff
> > +    description:
> > +      A value to be included in the Output Report sent by the host, listing an
> > +      address where the output report on the SPI bus is to be written to. This
> > +      address has 24 bits.
> > +
> > +  read-opcode:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      Value to be used in Read Approval packets. 1 byte.
> > +
> > +  write-opcode:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      Value to be used in Write Approval packets. 1 byte.
> 
> Why can none of these things be determined from the device's compatible?
> On the surface, they like the kinds of things that could/should be.

Why would we want to keep tables of these values in the kernel and again
have to update the driver for each new chip? It also probably
firmware-dependent.

Thanks.

-- 
Dmitry
