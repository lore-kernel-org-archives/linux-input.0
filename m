Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E0393402
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941742; cv=none; b=A6kJQHwfs5bTpJ0pjEYzEtfp8rcoujBsww66qufZFHWkq5I4g1IXIOIdVtnRA1clSd4rZ965+HqxuqijBsv5i3ZFoxfCx5/1n7RuZ6JekxjaXDEZ7VTjaTudeucdi19QzJYfUyyKWU9ktDYn8Kq+Pf/g7KbHuGNYKNRCHkCHWY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941742; c=relaxed/simple;
	bh=f1WWZLj6tNf5XppILOXDycl5MzXG4ASm/kYTuEI/CCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzizQ/enFL+XT80/+oH6h8n4f0X0+iyTUZNBP/1gLGJOEb4EStAazGkxDCWXZ3bnDFxX9bhdSIwZmwrN4oIJ67w040PUuI0h5hOm+ThBu7HosQJ+ofBFxN/AJpF9iyZxMErwwtGVD1bJ5D3C67xZTCs4Ye4GAitDmI//wC8lS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3uutzgG; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3uutzgG"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1220154725fso247871c88.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 12:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768941739; x=1769546539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K2w6UMS2EwXRbdtrKA6WJ2LPObYH9VsXfYL7068o1tQ=;
        b=G3uutzgGG6yq4H81RBX/wW/a1dh2Eiu5wLK6YKKOCGMOdfgcw1baPa/IpdEZh/m44a
         u8yo5JwvFfnf0cvz1FahhN7lxLqh0GiOaRKNQorkTRnQzqL0GMtKbreabEgwLl5igjXT
         xjD6R36hIWtcDkZ4KhsM4fsqRkNBd+V9eV3ZLWK8l48oyDNjW2E+7jL6P2dyQui4ZNP/
         b3hoWDNlQ0YGWZwYQ6vo3IGXsTrT8AqBMQhF9SHrY76aiHJN4ATTTOF5Bmz8+1S3CPCC
         XbSkRTxg9QTtTZTfLWxHkFQoqnJOor3YDM4AaRv4pd8wy1AhOy13kOFQ0ulW23jMxuIe
         gu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941739; x=1769546539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2w6UMS2EwXRbdtrKA6WJ2LPObYH9VsXfYL7068o1tQ=;
        b=TmzVzMbtcJH5y1l4RqB8x6b3s+wSdZdjM9+YM++y74SavRR+Bj/NjhnbzrJlnd0bDR
         5DozPrCWZdy84QMlDyUlPg16io02UeUbuJiC8B2fRk0FB1n/sArRAxK824GuXiZvWMmE
         QQr9CbJO/3vNWPbKXj2OVfG3fJupe5AWmEW9sz2qBuiTcxpNeejFMjUB1SY6Y65CYurK
         wq6wCpLLZZfomTLg144vvTRGs+fcodAAiyuVM8mxJBKEVQ4+CTs2Lgem2j0xVoql7jNz
         Ljmz+qrA+C3tw80TO7KrCJ8Xsd0mKCg/IhTkj39yNssaSPwk8kWnoKeGlHg12GBpKl+W
         DhQw==
X-Gm-Message-State: AOJu0Yxi3A2Elgo0UGi/sTLKJgWT+xExJse6/Fy48UEGqKq/6zp9f5hQ
	j/vcc6SgztWT2FaNyTtrZsL/+kc/RZjzLRWAfW/UO18uCredWw41zhRz
X-Gm-Gg: AY/fxX7q6Y2zgM5F7S3FEgqEGZkvFxWAh/DEA5ufNHBSr/m8ioLNrXfyzaiUPSG4j3R
	UtLWf7ofy+U0xjRve8BJlNID3ge02b+dTYYCmC0BImcaCfQt/3Tzj12382BddAzL5qBiuT8Vlci
	gmvyoQWNDwIZ+6ADCa5F/GZr0BTEiHMi4tdkcrJ5ham77CW5GaOjLs7TL/4AdI5tB8QoOsAaQX+
	o83RB+5Rck//zGs8HRWuM5e9j5GJwR5QN7r5Sc+xgXhqJpktSlqr8DzLJIjXQ7DxuLczf2uneRy
	KPfZSuXhP0VQtvlB1kjsxoq6NiXrpxNE+6nHdjQPl/PzdUDvdRV2bZsixNeUwCjSm9cNS3bd7EL
	ZpYxwNqa3MS4yB5ksj+9DWWDBClBHIS6k+EwYuuXw2E2C3EJaFlpjSCgJmvE0nLC1dZf2/Upfxf
	KS4nfdMDboQ5gLLFcdk5MwuIKiVAMsF54a9aov6ragG0/jyaXB6Vax
X-Received: by 2002:a05:701a:c961:b0:11f:46b4:449f with SMTP id a92af1059eb24-1233d116b6dmr10048086c88.24.1768941738981;
        Tue, 20 Jan 2026 12:42:18 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac57fd0sm21318129c88.3.2026.01.20.12.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:42:18 -0800 (PST)
Date: Tue, 20 Jan 2026 12:42:16 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: wdt87xx_i2c - tidy up ACPI ID table
Message-ID: <nn6qjsmd4vt2giq3kd46lemd2q2ofdjbb6mmlaao7y2edodm3u@s2qwtwhyhiwb>
References: <20260113082445.44186-1-andriy.shevchenko@linux.intel.com>
 <20260113082445.44186-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082445.44186-2-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Tue, Jan 13, 2026 at 09:22:57AM +0100, Andy Shevchenko wrote:
> Tidy up ACPI ID table:
> - drop ACPI_PTR() and hence replace acpi.h with mod_devicetable.h et al.
> - remove explicit driver_data initializer

With the exception of cleaning the driver_data is it unclear to me what
the benefit is. The driver is potentially useful on non-ACPI systems (or
may be easily adopted) so making ACPI not optional does not sound like
improvement...

Thanks.

-- 
Dmitry
