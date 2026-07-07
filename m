Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E041DEC5
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431458; cv=pass; b=Cvg9BSJVq33YPdCxTnLx514M9qlVwgsFu39tvqCO2vh3xEpuAzKc6KIS1WK+P7YeHI9nswrRcywgqXWHS1ts58xIhITPqkmt6k4fCB6CiyCBkzQCXM+4dC/DfR39IdDXAn+X0B5jW0xjtC5ZwhfSyVLxqGYyzUWV8i6p/wk8RK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431458; c=relaxed/simple;
	bh=YxxW/DgyJ8n8X4s2Jk8Sgjq3BzhWt1t3dn+FQ+NVOBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIAW867UF/nR2FcqhIpN0YFjpL9ZaSqDvVUNS8E/O3xliRCAfI6i1nlfXaw6HL0NHTdcUSyEXaAlIpyu+fsD+x1S3xBdDKasamccDQJqyGZll0gYHRjEMAW+SREcZz4D/hT3mjhYPiLz7YAeotZxW5QhzO3EsXlhlBBPzLlwovo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAaPlxUA; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAaPlxUA"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6675db463b9so1967024d50.3
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2026 06:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783431456; cv=none;
        d=google.com; s=arc-20260327;
        b=d2+BOt14MF4HH/8YEBcln69fbo15b9Ih2xQ6ggmIVkaIjz7G7iUM+bL348IT3kUxex
         PnYpoWltkN1yRp+Ug3WD/rJAw4WKUB1PBbnnKSZzE5JbZuFAv1TE/Nc0oX2P/MqmBn4n
         dmudIYWhmjWhas0xH/tREXUBCrWSpR6d6kGfK9yBPYivtQ1DNUNprDMKiGYfiVEkmbEI
         Inx4XY1DW74Cg/xfG7N1jqouHq0kZ4VEeELlNpBqtx0PgC1agnv8KgW5xJq2b2rVoZgx
         4KLi25vB/XHHGKDxJXBYM1dJwsoRHLlt5/ybvDwORTL9YoM6e1QhBx2sISE1JOpOD1fS
         f9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YxxW/DgyJ8n8X4s2Jk8Sgjq3BzhWt1t3dn+FQ+NVOBM=;
        fh=TpR+qdK146Ae6avsz5dZnqHqFJofsg0kAh7eFQnSPYc=;
        b=IJbn2k5WyckbFQhe4N6w1DhMfCvTfg9FMxv70rUkyuPldpza6gNJbWwyjANi9zaF1/
         GJ4UQKfMfCSFslyQ5hLcOQIMKh5o0Rim6KMk4f4qz4FS1zVAULm8xC3Ue38HrLEedPhT
         TuaS93M8D+dVn/UVnB96E2LogYtNCFRgcglcPf7+7GG7eOYnWcbqC/N9O5153yAxcEFy
         W74SHtcoHnYYUveEKcDANCWy+s3Zjj3JrhK4KnnhOY/JQq9D8PccEw8MqEum1C9mZawk
         g6RvsUqxHllLqHkmzp95enrNq4T+kthdrX4/Vgo7thSBud3tnp3b5MRm2Yk4L/rFjh/z
         B7+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783431456; x=1784036256; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YxxW/DgyJ8n8X4s2Jk8Sgjq3BzhWt1t3dn+FQ+NVOBM=;
        b=UAaPlxUAFFrxu0oHiKSjwLu1QY/PnDxAteQHIRK52RKfSroz8xttLIJ6JCID45rFHh
         KkoQg5COgA6IDztr3LxajFXnsqLA0ppsmMWW114ap9+5ysuIayD5ljctIy8EdeVShzWB
         SXNO8+/4YGK5YF25AdMRKtq7qDEWpT2diI3ViSCKK1AiOHx0Oejmihhecc5AUeNaIgvd
         16CWcAVqttHrrim+ADoD4lBhps4B0boFAMRqFNUT6B89/gc9Ui+FoxJW/jWzPAdfzBXp
         yszAb0bLCmRpBT6UNvfK7PuJ7HowvVJX/GLPV4mZtY75bDlQy4OtQvjt3kXekKRs/zQP
         AhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783431456; x=1784036256;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YxxW/DgyJ8n8X4s2Jk8Sgjq3BzhWt1t3dn+FQ+NVOBM=;
        b=iT0CApPl2iSiEgBoapJcaaur60Nl+NTnb2xi+jgXABOlfPyQ7ryDnKRhqS6nfc3pWR
         7iHm1QDBfL/nw7g/UTXam3mZ5FJEpOCfCye9k0OjEmy8Gq3lcw2l3r3b9Je267cEwnkR
         DKACEW55gvLY04WF0evi3W+ORqACbrJ2LwL/GakP+TirSIDpW/E+bt5yMRis8PHZmTo/
         4zmPUhGZaB2v4myuGqrrw1f9/v4kJgvq9Ft+qjQhKeDUNpIaT9T9MQ5Oyh45G96SQ2ec
         u9+q6L+EJCg1y3hUFJYXxPqEm4RG1MKjZsb8AOzOX/43iA1YgwJ82ZSO19AXRB6D7CEx
         zGqQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMzVQPcipa5IcskpVKO2/LzH9wbrxSVUXnY6nmiypxYE+7a0H3tamqG7xytPkL9cIFs+zogZxoKKSVTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0YUxtYtQJW6o/u2S87NOfp0TPItKwjwSqXt0CmKwp65/ARSCU
	GjdGiiSnU3XBoEiDJ1tnoaic2+BCbS5iBAyuagPQNbNeNb0P9kDaorwTXIdiiMTdRoFIFsZZet+
	kKYlHyi1qL0CU0OO6q80HBSWAQUjsWBw=
X-Gm-Gg: AfdE7cnd3G3lSYUB7fV0oa3PXPA3X9mqBjNLSsQGMRVQn2FCxSjvaZilxkox5IA5fHL
	n0O/Yexuwxhg6iKqkUs83mQkfMnD3yQIJNVlxym2rNewrsgwulazM39qP75NMxzZmdizX8EYG9E
	1opPfFXFFwapeR07CsxNE/bUkrJxGOyaskrymER6/NeSTQkIdLV+WiwquhAg4KjRY/QyRU2NNtl
	kLDu2T+HA8tD6WiVl/QiHcBLhMQ+Qiq2jkKxj0ZzcnpGVB3dZvuWC4Lqm4/kQBDuBGSEsqCAgQx
	4XN+KQI10B1xLZJWdYU4KFexBK3+5S9YRLSVFUQ/rjlgcB3VPSuno+b72yBfcg==
X-Received: by 2002:a05:690e:440f:b0:664:ae6a:ef6 with SMTP id
 956f58d0204a3-6677fe09239mr3207984d50.84.1783431455985; Tue, 07 Jul 2026
 06:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-8-506d936a1707@gmail.com> <a0cee001-7bca-438a-943b-da28528e7df7@gmail.com>
In-Reply-To: <a0cee001-7bca-438a-943b-da28528e7df7@gmail.com>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Tue, 7 Jul 2026 23:37:24 +1000
X-Gm-Features: AVVi8Cc2ZFlYzV97xsPmmL_XYaVoOo2UdWECw6a41ntBKVYGFTDcsFEpeCIlldE
Message-ID: <CANpmGNusmx8NQEu2x07rX-yd33XA9TJR_ZogFVXexAmw+7qq9A@mail.gmail.com>
Subject: Re: [PATCH 08/10] HID: apple: Add DockChannel HID transport driver
To: Julian Braha <julianbraha@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Julian,

[...]
> APPLE_DOCKCHANNEL_HID has a duplicate dependency on HID,
> since you put the import for this file inside of 'if HID..endif',
> and then also gave it a 'depends on HID'.
>

Thank you for picking it up and letting me know!

I will correct it in v2, which I am planning on sending later this week, or
potentially on the weekend if I get busy.

Thanks again,
Michael
