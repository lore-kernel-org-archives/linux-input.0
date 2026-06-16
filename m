Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291142EED9
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607680; cv=none; b=p7jETLvxZrBC1uYZqr6hnKylMpsMzjXFw3GmwKZYaIJIajimeIEinYl/ut1mtCNUQ2UwsSbS3UcNatz83KZDbowDhCDdx0aehZ4gE8V0Og+ItWoxe657ODqYnhVXV5IMFg5BVxcxb3C1+OxYH8YBnAN/lTUVohSZAxGWEskPkes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607680; c=relaxed/simple;
	bh=vapRSSgjKgpucYV/YQNBaE52QhXakTyOK6JOBlOCMm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMXimXaYO4mJGLML0pTi8asOQ39aRKKw3yQSWJyyy6rTTJHG47OBRddPUmC8nTPcPuSLY63kocf++xRXNe2Q3xkHXgWB/b0UQkkBLCHepGrWxou2WUew7i/XzI843WPOImDIh2UZJSBQ+k0SWFrvm6RraErZ1rtWltO+Vly0e3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnVRe2VG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnVRe2VG"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef29c5561so2379118f8f.0
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 04:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607678; x=1782212478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6r+E+bnqD7lkr9osmWZzqrT/Q+dlZe8ew9RwaM2N57Q=;
        b=PnVRe2VGDcyn1pJwUn0wsfvU9Z8EvNqAJl+Vg7N4kjeN/2tFueLaWIQc6K6B4BI8wD
         ahka17NvqGxblXgQY4joHJHfA1gFgHRuNdTOjSf/ze+KHO5fMfRqWXGinhweKycfeTth
         LQFGoAlfyW3i5eKKgb+j/t+m8zG02Uyi7aMcxMwPx1RCprOAQp2Phv9m9LlgKSu20SyO
         MX2ErpCzj27KfO/M+Hy3sitFw5ZqXiRH8JqOiaNpOc09fgGr8T3hWCdfYfztNKs9b/Cw
         I8/nqhYCgOfwGti6iOaMFSJnGL0F2X7tXopCM3oc6jqFfbpzkCe9Gj/dsPIGsDdpQr3O
         DW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607678; x=1782212478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6r+E+bnqD7lkr9osmWZzqrT/Q+dlZe8ew9RwaM2N57Q=;
        b=oH3ZXoaDJ1/Fp//AWkFxRoObUR5QGapwzqBW4mayPOykM3LvO/95OdpneZp5uvfroF
         fHCIcHYUIXn1zUUOfgPGgr142ZbhDSEjBIwPgUR/OFjuF7991xYVYcE5C/lLS37aF3Vm
         F7CY3T6D/whasUXS/BnxW68gK70tsr/93AggzsyeEclw9jrkcTlLp+Rg7SDpPaKfcGWZ
         TZibsjZ59pyVM5/PaTtnjClx/Vd0UXGVzGC7zFGcUy3OhnydKjXDBlOBnQFcspSwoqS5
         vbemxm2ny0BSSVagRYLQgwQnDCq+i0tLNhUCE5XWIEqgJDqd7RNEpFyQ890ctVUs+x6m
         bj7g==
X-Forwarded-Encrypted: i=1; AFNElJ+XxTa3d3qAuaLBhxvpSkJpFV6BoWVowyE//McHw13U1D2g9nU2XIkPLsYei4vP+VLNYJHgM9dBPo41dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN+a3IQcrvX4TDxpUwVVnrf4i34/DXZoN0WzQ2eZRIElKxhTfN
	wVuRF/wiIo1xSNROeKTAGmYtkA22yueJarBV+Q1Q/ZfpGAw3viwr1oG5+WrnsOR5
X-Gm-Gg: Acq92OG4lPRMzbOVAzG1mU0khQJ2tB9CErFINDZHVTj+nbpXj1pEmpKU99SSH/7lXj7
	LzNRyDl6XLJFgIrQDMNYN5utfFPND9273Yq+Drl4pUYXnjHeERPqoLBGap55SGC51VyEvZ4HyUH
	uIwqSKNJ9xsslMKgo5+ybiXMR5fVjXucAL0sYUI1lE/M2RIEhftBKxZJQ5Qdqogf1RHg/bOfrEr
	8DTL69LkN79WhMWBb2agFJ2+cSCslmJL3Vaz1a7lWMJpqL8ycsGFxpRDdgwj7SxcBvNGaxtnn13
	Jh8l1Dntz9TybbmgkiPI6x8C2ZW8A3LPnGV0jDRONnNmzjz3A9y/35tmZRxBxpS7qY28goQ1i1j
	sKUHC9sG8pDeMXeSAlZGUwxkeGVBvtp1Vg4XuQ5HA9UVqCDaSseF5f7g22C+ZLQiZdUaV3l812C
	fDlckuPt27/RgRkoS0AYxEyDl+zC4XofBFCh5AuFK2ntkB34Bz99j5s82FYR/24Ov4zAMgtlyua
	ws0LlPy4RHGns3kdAwNctkn2qjKEaZz8PUD/ALO40BviL3yFWp0CoSL0/Sx7BvuH+VhdKdZJNzp
	zhA067B3hJZGCP99Vd2XSEr6AAfKOWKmtFUGidthUboXgwrHW7rh7XIxlhl/lYEcEQ==
X-Received: by 2002:a05:6000:4201:b0:460:5022:8a76 with SMTP id ffacd0b85a97d-46077f2bed3mr20985676f8f.31.1781607677690;
        Tue, 16 Jun 2026 04:01:17 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3782sm38824083f8f.25.2026.06.16.04.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:01:17 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:01:14 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH 08/11] iio: hid-sensor-magn-3d: use ! instead of
 explicit NULL check
Message-ID: <20260616130114.00004d27@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-8-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
	<20260616-15-jun-hid-iio-alignment-v1-8-0cd544286575@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 15:56:13 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in to follow
> the preferred kernel style.
> 
> No functional change.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---

Couldn't all of these null check patches be squashed into one,
considering these are all the same logical change and affect
HID drivers? Surely this is code churn a bit.

Same goes for the parentheses alignment patches.

--
Kind regards

CJD
