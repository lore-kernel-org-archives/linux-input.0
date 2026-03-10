Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFF40DFD6
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163796; cv=none; b=VCmmOAyEeMPDsw09InYA1mRekx457L6ts90qbnjyz4Xv6F35JDenpbeRZfVZ33UzsO1APGjGBeY56TsCq7L6nmhjwX5+/ddutx/8NC8ISrZ4qSl9PY9oIjogsw4SNFHWFt71PRE841rulG/dvXPeTgOdOOuQ6WsysQrwLpSFiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163796; c=relaxed/simple;
	bh=l40j+jh2f/kpVEDQ2DTL5uvYSW5+99uEq+XRihxp/6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFa78GufrkmLw9ygmY5Drnumf5xgrXRyv4kWyypNNAUEwQpafNc8lZ0LG6DNfPE6+MTRzYFV5Qw0S5+xss74rQXFoQF7jU0AtNqlSRrFitfypaTnrp0ymKnjdNRSLBfeXMZJd4/vVMoQ/zfNNq/5PJZzMZMJ09S5VT61KM6fTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhA7hwQE; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhA7hwQE"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2be8828e632so89644eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773163794; x=1773768594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFoQjCDEAsTOhIGMONGAgxTqqQAqRiz05x57wOuY6Hg=;
        b=lhA7hwQES2dw89ms3TJB/CliS8ApIqv2UUYA5DCObt0H54sBE//ys1CbQluHLbI7IT
         eDC3as/v+IrKYZ6A5U0z+vY53P8KzguUwSf3+IPZzms4ISoa8GVe6I9C+kNoLshPSoCi
         Qoe2F5eCmQhaYHdfBxN+XRQDsqUzou1kY1Lnm6lIulBgR3yZpQ+ym+R4RZ68wPOUMeK0
         /pB4V/WnpEWwb6qHs2O3aNwisRiNobBjFMOH1HKP9yg1DlIi1AuqiM0K/2Ksq+uhQy0Q
         B4G9jb3WNr0NE5qBnluFxXzFRc7mJHTt9mt+9q9nNCsz/bNPga5nkc3E4z5XamITjkGZ
         Ru6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773163794; x=1773768594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFoQjCDEAsTOhIGMONGAgxTqqQAqRiz05x57wOuY6Hg=;
        b=XOm9oUHQhP2wkG3K9yX8cYPwsGiOd+wnaiw0IP/DnHamqvzk/LY1mALi16IbFcsC4B
         ESDw16td3U6wxWZsQscZNYGC1gJVjsdDTxAd78HEkXxX2HZ3HnMv4oafR51Ifp4Fud7i
         9jcJdYSbMP3l7/zL+wrogE9x25LpQ7tfV1vAy75IcumBXZXGeSKTelYmOy28osOl5wu2
         fhlb3421+vBfQQ6iEnf56SrCudWM0lo19Y+5HNJZocmJZLZDMNMXtw/2gyTVjZ/OnReC
         83nim0TuxbzsHAZyCYareGYYUDt0dxSLfJcqfq8rdcGqJoemyZaMEDwD4MC/sVaI38mb
         GGdA==
X-Forwarded-Encrypted: i=1; AJvYcCVN5Um58mRnXlxbXtISS4srAyTbMSixes0r0AophN2eIALxmANy3e7rov5v3s91dDLPjwhr/wJPtTgtQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzopnyB0Rzb6aFmowAt8VUWGdViwgHAKvfdHjsiU0zjcLM0wVQH
	ZoxpToxJxpxlwjRn2lRCrM1C3Jns1cs3YazY5xkirCkEszJqZhDGfklo
X-Gm-Gg: ATEYQzwL9nyZ15lkiXJHwJ9mr4JLAjgM6thl2JyXWlont7qL7+83ykK9dn8qS1uXyqH
	QnHX7gn/GFXkeACB8GkN4B1paMK8KqFpvKOz4cicDLanT8na9wS1PF6Rg9gZ37T3SJFWS7tBJRo
	h74Fnsr2nuQv3ss2SJYa7YhbESzgJOZ5GjtNcEo8FeR9EWjuEUExx6cOY5CxrGpNc4BIlFr6m4p
	HUm7Qdk3OQeyUJTwTCi5Twr9L1XLUIIMf3qobMeoMH2m7uJxwMRjp6xoDo23HRmjRVBUhUHLJyh
	GhzeNUOls8NCUr/By86Zb7wlMFU++oF1hef56Pg6UrZngb9RlsRy9agvewiaOoh/89f2LdofIxX
	zmFRjLWzkkmtrujVP0G94W6b7awlNdT8rUyZ9xA255aSNrxwXly+d4kQuBVNt0vywGYR+Uo40wf
	eOdNu5dltD93/9U1cgP5kMc5P2TPkw/A7C1qoM0KifkUR1QX6jSUec4sF3xgk+/rIg
X-Received: by 2002:a05:7301:3f19:b0:2b6:bb18:c70a with SMTP id 5a478bee46e88-2be7a28d93cmr1648507eec.15.1773163793971;
        Tue, 10 Mar 2026 10:29:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:9:a7a5:8370:70f2:4b53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8790b198sm711734eec.14.2026.03.10.10.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:29:53 -0700 (PDT)
Date: Tue, 10 Mar 2026 17:29:50 +0000
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hendrik Noack <hendrik-noack@gmx.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ferass El Hafidi <funderscore@postmarketos.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: Input: Add Wacom W9000-series
 penabled touchscreens
Message-ID: <abBT3jZtpey4-9M7@google.com>
References: <20260307181557.66927-1-hendrik-noack@gmx.de>
 <20260307181557.66927-2-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307181557.66927-2-hendrik-noack@gmx.de>

Hi Hendrik,

On Sat, Mar 07, 2026 at 07:15:32PM +0100, Hendrik Noack wrote:
> Add bindings for Wacom W9002 and two Wacom W9007 variants which can be
> found in tablets.
> 
> Co-developed-by: Ferass El Hafidi <funderscore@postmarketos.org>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
> ---
>  .../input/touchscreen/wacom,w9007a-lt03.yaml  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt03.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt03.yaml b/Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt03.yaml
> new file mode 100644
> index 000000000000..feb87f5db39d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt03.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/wacom,w9007a-lt03.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wacom W9000-series penabled I2C touchscreen
> +
> +maintainers:
> +  - Hendrik Noack <hendrik-noack@gmx.de>
> +
> +description: |
> +  The W9000-series are penabled touchscreen controllers by Wacom.
> +
> +  The firmware of chips between devices can differ and with it also
> +  how the chips behaves.
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - wacom,w9002
> +      - wacom,w9007a-lt03
> +      - wacom,w9007a-v1
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description:
> +      Optional regulator for the VDD digital voltage.
> +
> +  flash-mode-gpios:
> +    maxItems: 1
> +    description:
> +      Optional GPIO specifier for the touchscreen's flash-mode pin.
> +
> +  pen-inserted-gpios:
> +    maxItems: 1
> +    description:
> +      Optional GPIO specifier for the touchscreen's pen-insert pin.

Looking at this again this has nothing to do with the W9000 touchscreen
controller. The behavior is applicable to any device with a touchscreen
and a pen.

Rather this is a generic functionality/policy to put the pen
interface in low power mode when it is put away. I think this should be
done by userspace through combination to listening to the
SW_PEN_INSERTED events (via gpio-keys driver) and toggling "inhibit" on
the touchscreen device.

Thanks.

-- 
Dmitry
