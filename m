Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720A36C5A0
	for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889579; cv=none; b=TbXELo16Yzuh/lpcHHh832JF9UaJ6oXqpblo3lEc7UmAfvlu93rQdNG4afaBZfS9BKrfYne1wMyXZu+uqy7Z4EJr4OubnxOHg+EYIS2mE9TgaF41b9IN6yYddh6iMrEV1DhUa7tyhk5p+ER5DpFgonqfFRD6HijUtyRR2Iuynwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889579; c=relaxed/simple;
	bh=y501ybWHBgGRKwznvyi4r3Ot4gsoNEcrqXIf0H2+IFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T82vmqf/luW9IO8+zzKpUbIeT/HzAP7YdWE2eaa9svdgGu/g1jamSIoLMiOowWEjSIryGlur6Nm3TFi+ON1htVE9JG6AuabCIdN04mBXApu04yQhoO6vxq3ZsYWiXsIoaR/+7RZdbFLD4vejwbpWR2V14E7Yzo39q/6Db+AtXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yOaOumtW; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yOaOumtW"
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-4042fe53946so1139464fac.3
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769889576; x=1770494376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElQ4mZrKFvJjO3Pi3PK+S2VsoWxu8vErX54kiEsiHyM=;
        b=yOaOumtW2KbV4JjPlFFWE8iPUmm0x1fmK1VHg/d1znD2UzoVlBV2D8o67cGSBS6WkV
         T9azRTRRCU4OUe88g98GcBjFZtUxeHfeax9jOEbAYsS0cz2MMVJf6BmhS3NNUR7eMFbp
         hqqdzSgzqi4bF6hpw1Jnc0h9t2ga5U8QEzxgOFOauAjLWR1LDDFOLcSA7gsLe/mOgtAz
         SBdnqtaMDpjMQY2Vg+wkDrBCxhFx3dG1T36scs+wRTI8q2ePNv+eQnjOpHfDtN4vIsty
         R+GwQpSnDFsjHOe1gwoUceJ1phB4P53OxRWzhN6uwd6F+ndgqw09kWw8o3x2sZJcfa3c
         Azyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889576; x=1770494376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElQ4mZrKFvJjO3Pi3PK+S2VsoWxu8vErX54kiEsiHyM=;
        b=TGjkMLZAf8cULyD4VgjPumtUbjXtqJbG7bUNKPUvfcw0uyFGV/jPZpnLCm7ARdhhi9
         OBSjhvnrtdmvd3hQOW5IPmZyYaMw90GZZwj/Fd/jE/OXbizoEQJPIEY1chCMKZlrSESl
         oSnnVE6vE0neFk6kSYbYH4oCXpv4SpySNCRRrXeZpW6LdeGwNYbwu89ALTUxJPNgmyQc
         NicqlddasyGmw6qo02d4SR1mfjwpo1+U4Bgauq007o9XmckQ/3/+PohG/XeJ67fdgwr3
         LLdIsoqsBNH1QkjhOz+npLhVCA8c9RDpXf54TOijW2jJwqoC87Oc3DtIfWd9O0/3WUz5
         NX9A==
X-Forwarded-Encrypted: i=1; AJvYcCV7Er10Oua8MczCMwirgX062WTu0KQuUV98VoGlZahLYz5c47WyUJHBxuRQTprNM5WV6YQR/wTlhQjnPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfsxEJ18WT62LhpyvbIJ/y1nzhB7nAzEEbsU7eNuDxzEBuk+f
	6PZfEHX3LK/l6upA+6gzaAFz9Jm4O3krsz6GA65SImVFLNmm8Yt/a23phd4J9DNglSs=
X-Gm-Gg: AZuq6aLpHf1EqHUlWPXYfFFvjxT5GEw1BwKQd+OoqLIhK6cb+IuDTv0k2dg0hyfQypK
	Cb730oHOmSOqqhJmusxD5LkVXN0z3Gkl6vuM/2BLh7w/cSQakhK99CnyIJdcEOv5WPxxiCpO4cS
	zH63UwZqELJOMYlhg5H7RFw0l+WWNU8OX9fw960wuR3NGjBpz+X0rq9mZEp2tWkMkCmzaXD3cz5
	QnVA1JPqo3T6p1Q3gyvcEwbYWjg4TfFczk6yhMdbsZKEn5KB1yzafOioeDYmUWrzoodBCGFzwfL
	7d+7g3/FwtnHHYoAGaGN83tRu9P7KBmv22faJe+w09ZcoiBNSdZyWdYPrdBcrE2xIbm2Pol6Y3e
	QYxC9QxbMDoIfgbulxog3Ve9yLSjup2PliMiUpTINgsB1ShYCYPigLf6WVE52UUHIxnxvDuinU1
	HosVRLZM85in2aojmEssp3LYgRusdijFWJ7+KCuvVgNVKxEh+B1xCI4BsftRB4
X-Received: by 2002:a05:6871:c968:b0:3f1:664f:e8db with SMTP id 586e51a60fabf-409a6ba324emr4043538fac.23.1769889576024;
        Sat, 31 Jan 2026 11:59:36 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-409570f1413sm8612306fac.2.2026.01.31.11.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 11:59:25 -0800 (PST)
Message-ID: <51d07338-6ddd-4893-986f-7fab96ff6802@baylibre.com>
Date: Sat, 31 Jan 2026 13:59:24 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/10] dt-bindings: leds: leds-cpcap: convert to schema
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20260125134302.45958-1-clamor95@gmail.com>
 <20260125134302.45958-6-clamor95@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260125134302.45958-6-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> Convert leds devicetree bindings for the Motorola CPCAP MFD from TXT to
> YAML format. This patch does not change any functionality; the bindings
> remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/leds/leds-cpcap.txt   | 29 -------------
>  .../bindings/leds/motorola,cpcap-leds.yaml    | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-cpcap.txt b/Documentation/devicetree/bindings/leds/leds-cpcap.txt
> deleted file mode 100644
> index ebf7cdc7f70c..000000000000
> --- a/Documentation/devicetree/bindings/leds/leds-cpcap.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -Motorola CPCAP PMIC LEDs
> -------------------------
> -
> -This module is part of the CPCAP. For more details about the whole
> -chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
> -
> -Requires node properties:
> -- compatible: should be one of
> -   * "motorola,cpcap-led-mdl"		(Main Display Lighting)
> -   * "motorola,cpcap-led-kl"		(Keyboard Lighting)
> -   * "motorola,cpcap-led-adl"		(Aux Display Lighting)
> -   * "motorola,cpcap-led-red"		(Red Triode)
> -   * "motorola,cpcap-led-green"		(Green Triode)
> -   * "motorola,cpcap-led-blue"		(Blue Triode)
> -   * "motorola,cpcap-led-cf"		(Camera Flash)
> -   * "motorola,cpcap-led-bt"		(Bluetooth)
> -   * "motorola,cpcap-led-cp"		(Camera Privacy LED)
> -- label: see Documentation/devicetree/bindings/leds/common.txt
> -- vdd-supply: A phandle to the regulator powering the LED
> -
> -Example:
> -
> -&cpcap {
> -	cpcap_led_red: red-led {
> -		compatible = "motorola,cpcap-led-red";
> -		label = "cpcap:red";
> -		vdd-supply = <&sw5>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
> new file mode 100644
> index 000000000000..8dfc98a1ef99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/motorola,cpcap-leds.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Motorola CPCAP PMIC leds
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:
> +  This module is part of the Motorola CPCAP MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. Leds are

s/Leds/LEDs/

> +  represented as sub-nodes of the PMIC node on the device tree.
> +
> +allOf:
> +  - $ref: /schemas/leds/common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - motorola,cpcap-led-adl # Display Lighting
> +      - motorola,cpcap-led-blue # Blue Triode
> +      - motorola,cpcap-led-bt # Bluetooth
> +      - motorola,cpcap-led-cf # Camera Flash
> +      - motorola,cpcap-led-cp # Camera Privacy LED
> +      - motorola,cpcap-led-green # Green Triode
> +      - motorola,cpcap-led-kl # Keyboard Lighting
> +      - motorola,cpcap-led-mdl # Main Display Lighting
> +      - motorola,cpcap-led-red # Red Triode
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - label
> +  - vdd-supply
> +
> +unevaluatedProperties: false
> +

Should keep the example here.

> +...

