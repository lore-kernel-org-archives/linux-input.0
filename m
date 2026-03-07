Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA85B640;
	Sat,  7 Mar 2026 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772868358; cv=none; b=tASjG4FHVnFs9bwG/5JcuzGcoJCrm2JL/P8DPrBwJiwcwExXG7cK50WHB7dcjg2FYyHD4dJF5LC0vYPswZAfsY9+s0lSHkuhs5ng4Zywxos0/nPXGsDO+EJBSWa5y+3oO6ESd4TiKhXRNQYv4qtSYuX/XX6hsY49foB+sfm8OOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772868358; c=relaxed/simple;
	bh=Mzr7y4QH1IzyO44ZlhNV88cM61KS6U7bP9zhV9sW7JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVyhFrMf2dbKBm2WSmenZBsFGb08xQ2Fbh+HSRtO2pscP9zKUkTjXo+rHiyeMgMDkiZzXIZ3oMgWsYPwFVv9J5q1sYs7WZbbWRZWNsNvX3UgLY5xe0GUqClEhbY5Um5aDkQo9GfKIaQMFAIm0tBg1Y/maG8ruDRqA/EABPHpNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=F6Cmsd/B; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="F6Cmsd/B"
Message-ID: <1cc6de61-8b56-492e-ab78-e3aa448f58ad@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1772868354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2+6NWzTpol+frWt/3c7B3LJfpEfyNZMXCdsBfpvUEw=;
	b=F6Cmsd/BYepDn38XmUEHEczMxHTa1zURkFgn8+XYAvwoAIo14tvO2fl9Fzi31PO3nOsU/L
	d2hbN8PlvzxwKNerfH3vDN1Wv+JVYu3LF0gRjJQ3z8UVNDMiu8Zzpum79j+L1JrFR861Si
	9j07WFQZ4qPZEd5be0waEn2QT1FT2nQuJea4kKu1UJZ1r8c/Gspbv86LUDLE0ejTPml2eo
	aQEt/Thkha2LmzcANcfO9pUjNNZzqmuQ1gCQeVzpzvX832SUrTVKvNfbluVVFv8EZiaJ3h
	x/lHgZbT8nap0ngrW02gfr1c2s/2WP1I0Ol0Q12hbf+lB9yW0sXdpmcWMHeBtA==
Date: Sat, 7 Mar 2026 04:25:44 -0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 09/12] dt-bindings: input: Document hid-over-spi DT schema
To: Jingyuan Liang <jingyliang@chromium.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 hbarnor@chromium.org, Dmitry Antipov <dmanti@microsoft.com>,
 Jarrett Schultz <jaschultz@microsoft.com>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/3/26 3:13 AM, Jingyuan Liang wrote:
> Documentation describes the required and optional properties for
> implementing Device Tree for a Microsoft G6 Touch Digitizer that
> supports HID over SPI Protocol 1.0 specification.
> […]
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - microsoft,g6-touch-digitizer
> +          - const: hid-over-spi
> +      - description: Just "hid-over-spi" alone is allowed, but not recommended.
> […]
> +required:
> +  - compatible
> +  - interrupts
> +  - reset-gpios

Why is reset required? Is it so implausible on some device implementing 
the spec there wouldn't be a reset gpio?

> +  - vdd-supply
Linux makes up a dummy regulator if DT doesn't provide one, so can 
regulators even be required?
> […]
> +        compatible = "hid-over-spi";
Not following your own recommendation from above :)
> +        reg = <0x0>;
> +        interrupts-extended = <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> +        reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> +        vdd-supply = <&pm8350c_l3>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&ts_d6_reset_assert &ts_d6_int_bias>;

Heh, "reset_assert" is a name implying it would actually set the value 
from the pinctrl properties, which is what had to be done before 
reset-gpios were supported. But now reset-gpios are supported.


Thanks,
~val


P.S. happy to see work on this happen again!

