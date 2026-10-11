Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203A22DCF74
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791695627; cv=none; b=EUK/WrTu6JvfapugWEmLV3YeVCNfyQCYkWILmC8a2sxdBPgRERRuWo5yRmkhUEdvka2OaI4jc8UfjyAozU2PplVgVSDNvEFZNDg+xpY4feaO7q0gCwC8uIqV9NdSaXrMjJbbVz8sfD5rqo3bAaH9FFY1vQNtrrKTtL6o8qJ4uBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791695627; c=relaxed/simple;
	bh=yjj+GEMBuBRVvavplchcH8uaXDQxZ2w7EtUDess9Elc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=LeRcz5fC/fMCqC9ZsrJjZ8Rzs4f+tOmKL49V7PHDJsFOKMrJs0Ofbma+akTmL5eEa9o8cCHfGmkDQMMDP6Bqn4ronter1am8+ck1Cn/gz0gscFAYtyM7GKoeb+TZ4WmUKaBmchGtpj8iY79fBYFrGhcnAJb/ZH9WAg+jC0rOcxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mivFBBm9; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mivFBBm9"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3550c917fd3so1390567eec.0
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 22:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791695624; x=1792300424; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jGwiSM6Jw7fQY0scgIdwmNx4g3Nb53u28uyWu2p6TTo=;
        b=mivFBBm9fSwc0/j757Fw9E4ROGNYoaFrsrwXW1kuvn7HPvPunacD+Cv2h9uU9srizw
         tQ2j5tZnMU7JZ5NAgarhBBfPmL06/FMMRxEILEDXFwBWV09sY/wdFZugC7X6AU2sVbvl
         UtE5wet1Oslo3L7A6EpfgPmTn5Y2VhIHlNN+A8/EdbOodg35JIbL8JNAxPnotvxwGy+Y
         ln5JVxChpYz9HKqK7kfF7c/o6FXN7KSscVZZpNgFR12qsKw8HFRGyo5ip0f9NL/pq3/G
         h91SS/+lwerZawVgmkIR3bWHdq7QunmILHHi7c8BrjyZuhRF9wvcdTJziNMm8i1o5Or8
         RnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791695624; x=1792300424;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jGwiSM6Jw7fQY0scgIdwmNx4g3Nb53u28uyWu2p6TTo=;
        b=CP+/L7cIgXrxeBQVqDR4Mbiq5LIWQOvHT6CDXLEFhn6u1Wj052fZ0fhs8Vj5O9QhB+
         33LXWiYYG9coxEyQbPliWiifX+SXi2zmbJG8FgFZzUhhKW239fWbs9L8FohrxoHQjUA9
         FgaFYF0ViiL4fnVk0iqa8n6sXfHUJBId6wWTIN+MvOaC1HQJavUdvvsoHQ+m5wEpJlUe
         FxAOsEf/06EhkoUzWC80Ufqt+TIPVYH7j+0/bkVjnuBgfk4F2K5Rk3pHYRH0xqZYwWI9
         yNTvt+LjURmLz+yJA7VQt6+jxc5Gl0PZdRrwDx1mhd+9GH3bTs4YEUpJvrONtBvlrIDa
         skTg==
X-Forwarded-Encrypted: i=1; AKwUvBwQIfKZAkwj9PgwLSKtIFBlVszpFRPVXSlrmH3PFzA0PH4ufez1SFkaKqAMRLX9PWxILrfOfu3x4sKZPw==@vger.kernel.org
X-Gm-Message-State: AFq9FYK5b+JHz2M2kvc4gXEcGFEey0nD+zWvCa7xOzZi+77at8/Pgjbq
	4e+dDu0K4uLmeAnhEt/hbhVExFvd874sxx8GXqZhXhWKxISq8OMuxXJR
X-Gm-Gg: AYBFou1oXgodK9Td5Mw5G0DTkVJLssokKTvVEDo0ogLP8GDzqRZMFb+piZNy/EDhhk8
	9VkeOsLxiTsVe3sDaWPLYUqZE/7LPjvm/9FP9NKrROMLMxJ45/W48FdI4/5VZHx4ka+gtsXUZII
	/HCLSCySp0zNgI+6cn0L+boUYxz3Yix3gFkX+O8zwho/acyX3yXcmAi4qmFdypkAsKqZByLmBMY
	w4fVxmhuT4SPI32vL6cA4pexceWyQXFK7uyHOoWBUkSchCNxTlMfIIsAMvEbCaoXOv9FYwXDQec
	j9sEDP/yM+JuOc8xdfpIAquLFrzhj5kZciFOnwsUKxaziBspHEWa2lJ0WPZ9AGVbu/I7P6L4LjY
	GXybqT1xMhyn+4bGdoc4UbbL8a3nFNP51GVT6O6ukq47iqaufSN3Yv60/3QOMeLWgr32F5SPeow
	Z5p1QQ+XRlzsXG5FTF956Z11wbyTZF4Y5G8I5MmXOgDS91AxwrLGhULcFcQBIojm7GrZqspnsvF
	p+Xk4hmpo9QSuhjVjMpTCntMv6Rvycrrgfljx98SIGMUQ5hrA==
X-Received: by 2002:a05:701b:205c:10b0:149:49c:233 with SMTP id a92af1059eb24-16a60811394mr8606020c88.27.1791695623826;
        Sat, 10 Oct 2026 22:13:43 -0700 (PDT)
Received: from localhost ([2a00:79e0:2ebe:8:99d7:6eb1:9874:c6be])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becf08sm20632400c88.5.2026.10.10.22.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 22:13:43 -0700 (PDT)
Date: Sat, 10 Oct 2026 22:13:41 -0700
Message-ID: <30c56291bac612db47c6ced73dff739f@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Miotsuki Mizuno <founder@crepuse.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Icenowy Zheng <icenowy@aosc.io>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: input: touchscreen: add Nsiway NS2009
In-Reply-To: <20261009144729.85832-3-founder@crepuse.com>
References: <20261009144729.85832-1-founder@crepuse.com> <20261009144729.85832-3-founder@crepuse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Miotsuki,

On Fri, Oct 09, 2026 at 02:47:43PM +0000, Miotsuki Mizuno wrote:
> Describe the Nsiway NS2009 four-wire resistive touchscreen controller
> and the properties used by its polling driver.
>
> The controller returns 12-bit ADC coordinates. Use the common touchscreen
> properties for coordinate ranges and orientation, and allow boards to set
> the raw Z1 contact threshold through touchscreen-min-pressure. Limit that
> threshold to 1..4095 because zero cannot distinguish a released contact.
>
> Document the historical default of 80 and a board override of 150 in the
> example. The Z1 threshold is for contact detection, not calibrated
> pressure.
>
> Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>
> ---
...
> +description: |
> +  The NS2009 is a four-wire resistive touchscreen controller connected over
> +  I2C. This binding describes polling operation without a pen interrupt.
> +  Coordinates are 12-bit ADC readings, not display pixel coordinates.

Devicetree bindings should describe the hardware itself rather than the
subset of features currently used by the Linux driver. According to the
NS2009 datasheet, the controller has several hardware signals and
capabilities that should be covered in the binding from the start (even
if the initial driver operates in polling mode):

  - interrupts (maxItems: 1) and wakeup-source: the controller provides
    an active-low pen interrupt output, which can remain optional for
    boards where the line is left unconnected.
  - vdd-supply and vref-supply: main power supply and external reference
    voltage regulators.
  - touchscreen-x-plate-ohms (along with touchscreen-max-pressure and
    touchscreen-fuzz-pressure): the NS2009 supports touch resistance
    calculation from Z1/Z2 and X-plate resistance.

Could you expand the binding description and properties (and show an
interrupt/supply example as well) so we do not have to revisit the
binding when IRQ or pressure support is added later?

Thanks.

-- 
Dmitry
