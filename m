Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B7416842;
	Mon, 14 Sep 2026 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380796; cv=none; b=cGHckqyXllMp3Pe2G4nXB2jOTCsIFSYBr1RdKP+XxV0Y4WsrSvo/XctYtRhxXqwo25/crXe/2AyaaaBd8GBUGCbql9IljLdwoQmwGLOvQf2EqmXsNSDaxIB6479mC/SLrmiPZigsr6Zklt+ZEoWCu4XRgD3INz/0gI0uTnRCzy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380796; c=relaxed/simple;
	bh=p3MHpP9L2h4NSh23hZXbG9StBW1JEU76V6iGvZ4xT5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nkjke6Ob7PsZhII8IBp1GifvY7nJONad/dXfRCCB+QL/CpBdeYgzRln+q0GqDf41Ynz88mwnjb43DqEc2ITeUqul4esZXjm3FvvfeKDOK8yOJZ9+ZQimcbNyZU8fcEb/zZIqY2hjRERBCcvBQd99LNAi6DX7Zig9ySTQ5p+18G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU8pQXGH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU8pQXGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C154A1F000FF;
	Mon, 14 Sep 2026 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789380790;
	bh=KziBL/RQexdHJSvJhyvbXso5/0MGMJfNKZhImFiaXos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FU8pQXGHGnjckjPevaXzsZcXYwj5QT+YMN0v6HSeFGxzcFRXqKFMSlraqBjRc8GPV
	 v1p++SN7z37yD1W0zb/WOPKON3KfUJC/zHSNfbinY6IS7ZQjzbrXWzvu13nfOR2T/r
	 c3qcV2NuIpihxczueovivI8n/9BHxXYv9Ra8lZXnKpUpwU5mW739nksDW2kBNDbUdu
	 51CRUOdRykv23XkAPkAXUNEs8OENtWsejSZTY2oMwAwKCB/U2CXhwjY9XvYN5xcFkD
	 2zurx6gB/80jG5gS5fU+j4t5YW0Dgs/90zWHUwDUC0qjZPWK5Lufwen5Borzx44C3P
	 ByzOaxotZfckw==
Date: Mon, 14 Sep 2026 12:13:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, msp@baylibre.com, s-kochidanadu@ti.com, a-kaur@ti.com, 
	s-tripathi1@ti.com, vishalm@ti.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: gpio-keys: add pinctrl states
Message-ID: <20260914-unbreakable-competent-beluga-efb5ad@quoll>
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>

On Sat, Sep 12, 2026 at 04:33:53PM -0500, Kendall Willis wrote:
> Document pinctrl properties on the gpio-keys device node. By using the
> wakeup pinctrl state, the pins are able to wakeup the system from a
> low-power state. The default pinctrl state describes the default pin
> configuration.
> 
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> index cc78c2152921308fe0cad3e29ca78a5fad08f066..b554933e93412d8b6c2ec401dc1e1eeff57d4190 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> @@ -22,6 +22,22 @@ properties:
>  
>    poll-interval: true
>  
> +  pinctrl-0:
> +    description: Default pinctrl state
> +
> +  pinctrl-1:
> +    description: Wakeup pinctrl state
> +
> +  pinctrl-names:
> +    description:
> +      When present should contain at least "default" describing the default pin
> +      states. The second state called "wakeup" describes the pins in their
> +      wakeup configuration required to exit sleep states.
> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: wakeup

This will introduce new warnings, which should be being fixed in this
patchset (e.g. at91-kizbox3-hs.dts).

But nevertheless, isn't second state the sleep state? How can you
configure pins for the wakeup state - like being in the wakeup? You
configure the pins for given state, which will be a system suspend, so
sleep?

Best regards,
Krzysztof

