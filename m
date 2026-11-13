Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537619;
	b=BWP8sGE46vGkrhO1z0Yr7AhHqcVLBaoDYoJTisbTMkU4KlFzBh3SSgGp8uAxFi5noIqB
	 5FtoE1FIxLDexz7t+DGQG5fT+se2CO2EAE4cQla7CLJXP1CxVZcXtNlyfncAAYn/xkBdI
	 1q8oDATt4GgWkv5eulZeL0JhinbS3VQO2Hb3lM0WTosUKqV2SM6YVJlC6Bm8cFH9wJdzM
	 aSE6weUDJLCkrzQydZWNMqILzuhz5dHX9s40iau03p7wB76qVKTQSSNMF91HYxUsZeNwK
	 dLNB17vw2GMc6TWL+paHkcGxkkgwBSFlHYer/LDHvTdCY99Ro6Pv1LWk3OPt7lAm/iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=CPwtUJVd7keNZw6evxXk+bPw16MkL52vmivrbbfL9hc=;
	b=LV4DlC36XQ+mp4O7T4EbmCdWJ7ycfxvNwJal4Xe+WwtzQ+eKEG8e74wWRFyqthA5FNwH
	 Kmq73PdQuo0IKiTn2Ncv6spnJ3/jJowwXGAfzyiAon2Y3U/ef2g4aq8aJKnFz52EbEBoy
	 mar2HiKbKnmWse84fDal1ZG//XOJxWnJ203MHBEbA1LTZoG5nj3dR0MnABqqBirqRcv4j
	 vWNvqjMoy0dFufv9BDpJwlKqoSER8c9dbsJELhjmeoXIWXrQYxE2ADQF9bwsiOzox10VN
	 7LZJbGWtFVl745MFrVGtB7JBj/ijvRvbJebT8siUa0JS/eFhwBgDwiYHuesxq5oe5NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y0ityr8n;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5547B606A323
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 02:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5547B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y0ityr8n
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so1019025eec.0
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 18:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794537617; x=1795142417; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CPwtUJVd7keNZw6evxXk+bPw16MkL52vmivrbbfL9hc=;
        b=y0ityr8nb+mOQyp4/fPEF9+zrJG6mgmdmpJv+Y93RzqZgid2J4tuXTgbIDQdJRgjiJ
         iETDR9u8/s60tJn6y6BcQlC3fAO5D1xyLBbqiXRNIYv6pEdc6PiYfSLXcgUJeRB0JLmk
         s789SYVpcm7+tqlu2p8MiJe0GmTEhIF6xEowEBYim5RlIEIIhlxXhwUW6MvYKp8XxJfO
         zZ9TrsY+3I4ltn5yxgxHQddQvAUtBPOLbVR0N0N3RoiLRa56cnSiXTTJUnR4DBe6H7vM
         YggFCmdVHMUZ5/NRTBbRwKBO6fQjp4+LNS6Ke3jkuC6E3TAX9ceVcdCF4KDiOgXgDkON
         P25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794537617; x=1795142417;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CPwtUJVd7keNZw6evxXk+bPw16MkL52vmivrbbfL9hc=;
        b=cRX9dze7bkqc0w5rrMWgw6w7Jzwk7oUfLflnK7TmXoWVuI9Zv6OK9v9laWCqi2BDTl
         YO6bANVAzCuMA1YTk5aH5ezpJJ0/dMDL1BFoHBbTHixVOXrZtuEwq332R0h/73Kedo85
         rytIC3r1sC5U+pDc05qT2jo8EKRyupTOuYRgOSb+LnKgjlKYWIxft3ypwo89ocGuAzVG
         E+U6TfLYaWHAbQjCAa2p1gVuxkLKuxjZ9qgsBBOYyIPBeXFJwZE77upWg4L9Vim7E4Dm
         BhyWFUa4s4ZgRxF/3GHIJ9EpbL9fpWev4OvPJbAzi5MON+41QWwHPkSw0OTK/WXKgnPH
         GX1Q==
X-Forwarded-Encrypted: i=1; AL+hErGmFA0OgmGuHMgyI0GzGJjcyfzW/rB+QV/zsj4TfFYAqth4cbG2zOCfzeUc8qDMGJ5XeVtTj5sr+apYvw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8R99OJ3lOG2i/KsagbqPzZz6et5jeqVd49Kqpz0JL3RRA8L84y
	YM+oQg7TlL58jyDKFKO9VOgHDbzKe0S6dNy3FsQ/1H4aNnhnqUOC6rII
X-Gm-Gg: AYBFou1AmY8tAb9KcNraPE6B2/5a7qLbjKJvnyVEsZ6zgW9xKipewGlPkMDA8s3F0P+
	BCXRbHdueV/jAiAwRf8ECAJUY6sMhDKYigsQaaCAL4jpWaPgImsjbF8ZUPWsr/UnSxgmthF6oBe
	1dhB0aRoJE1FU7ptj7rzY3P4tzb5u0IvK8uCUeplzbkg9wWAzjmbsc4pZz6wMrci3Qz4tvCjOOz
	bu3RjvteCeCD+ctcc9hguaqJwTGMlmjKcfj7QHuwMlP93G6rTCmm3JEdelvrQix2n493cPq1uU1
	5I4g5nfFnD0G8k5kXQD9k7IAlHnDxh80XPaiFbfOEw4WofH4kdWimujW6buUEkuncbyVv1Gy4O1
	8M2u4wWR3RYsuXUrkuVcBPArPwLWWjpsZLFXA0p3LodETGIhDa279RebIQ6wBJWNmbYaLnuKle0
	55Dhn3ETzwIEDNFI+u8jJBxVq4v/GcqAELdiQ5PsimK0oGzECN/DOqIXIcnANc03txGrLbgJOUu
	baIXiybNgQ4EnFZKTuufPZWi7czmgHsqqTl5szPfb7H95vAq483n8uJlK/AIHP+a2NzvMZkv1B1
	5Wba1KAe9I5NaPXyKLdRzFkLU2rczvbBctggwalpt+v5T9qMUdyUjXSIg7VyA+GLBGkZbw==
X-Received: by 2002:a05:693c:835c:20b0:375:e4de:96d3 with SMTP id 5a478bee46e88-3796721dfb7mr971406eec.31.1794537617110;
        Thu, 12 Nov 2026 18:40:17 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563df84fsm3949197eec.20.2026.11.12.18.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:40:16 -0800 (PST)
Date: Thu, 12 Nov 2026 18:40:15 -0800
Message-ID: <1222b26cfe220b4a9a77ccb8ce82fd35@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aelin Reidel <aelin@mainlining.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@mainlining.org,
	phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 1/3] dt-bindings: input: document Goodix GTX8 Touchscreen ICs
In-Reply-To: <20260228-gtx8-v2-1-3a408c365f6c@mainlining.org>
References: <20260228-gtx8-v2-0-3a408c365f6c@mainlining.org> <20260228-gtx8-v2-1-3a408c365f6c@mainlining.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Aelin,

On Sat, Feb 28, 2026 at 02:56:10AM +0100, Aelin Reidel wrote:
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9886.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9886.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..6307495c2746313cfc32cdbb701455d1596be435
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9886.yaml
> @@ -0,0 +1,71 @@
...
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - goodix,gt9886
> +      - goodix,gt9896
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: Analog power supply regulator on AVDD pin
> +
> +  vddio-supply:
> +    description: power supply regulator on VDDIO pin
> +
> +  touchscreen-inverted-x: true
> +  touchscreen-inverted-y: true
> +  touchscreen-size-x: true
> +  touchscreen-size-y: true
> +  touchscreen-swapped-x-y: true
> +
> +additionalProperties: false

Could this use unevaluatedProperties: false instead of listing a subset
of touchscreen-* properties and setting additionalProperties: false?
That way other standard touchscreen.yaml properties supported by
touchscreen_parse_properties() (such as touchscreen-x-mm,
touchscreen-y-mm, touchscreen-fuzz-x, touchscreen-fuzz-y) can be used as
well.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - avdd-supply
> +  - touchscreen-size-x
> +  - touchscreen-size-y

Why is avdd-supply required while vddio-supply is optional (given that
the IC requires both rails and the driver calls devm_regulator_get() for
both)? Also, are touchscreen-size-x and touchscreen-size-y truly
required if the controller firmware already knows the panel resolution?

Thanks.

-- 
Dmitry
