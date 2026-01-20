Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612C4279FA
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942165; cv=none; b=nEMhbSDIM8TWxVis/PMoy+2daLgdmRJ/QA3U7Zvr2fqIa7gbKR8tqapzciyVVH3csiNO8I8C6qbvN/XJA4Dz9TP4ePbTTsoqmnNq+/Ua+4rSvlpP2xZlxD9P4rME7TwylGBYzitJGRf7Ju8V/sCQ1PigRTeMKHztMNyfK8JuDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942165; c=relaxed/simple;
	bh=5Iv+ca/uJDit/d5p49jcE28Q3jHl0h3CWrCotdTGMLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDpddf+PHNmsDetnTMomBjaCILdgFPx+v1sm5STVa342cUvaGCKSEGsOFw9kW9kwyNNYsPhVCwAbkF/eQXRF6/ucMARCBODUx0LhJk8jh8T4QW7OsX0i/cVeW5QSQWeteqdcTRPOoA5LZASmK/bjnLHKxBe+ylauhnrQ8bwaVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsHWbSpS; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsHWbSpS"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b1981ca515so6334179eec.1
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 12:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768942163; x=1769546963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BkOtsJUC0RJhhiWFtcVE7j7+L7GxiLl5iekZ/3+GJ9w=;
        b=QsHWbSpSb5HIXP6fjdnVnBtXJH05HEv5g6disUmmZeNISz11ZLQ+EAV+Iv/aKiviSs
         FKlLGCTahpr53b0c7TFVO4VaGIIVdwzHIl4EsGII8alleFTa7te9x+ktsvckWymEtl68
         tfvE7TqWuom0NQSd0awQrpoiR7FxsiXyKR2DptbAT+9opTMl4m5swE2GPUBeJ2rYn7ZW
         XVdsxe5l/MzINLog3ynA6yIgyMx07oNSh1k5yuBzc7MnfgC/RwV+KDh5rHRxq1AU6GEn
         Ft3WSA9zE6gGFgmnnbE/NwUKtd1ycEFyNuCuwWa7mysW7BASBDcEOgrPgirIXsCsn+/1
         u22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768942163; x=1769546963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkOtsJUC0RJhhiWFtcVE7j7+L7GxiLl5iekZ/3+GJ9w=;
        b=dRYOcWVN1F78jxTYiESHteruV7jEZiP/5ooMyDlKHJfc0L09ob+Uat6mH7r9a1WKRh
         y0IRXFK65v/iLTrseJMizoAfReyPZv5hqdclpVKr5zBNDGAEXhd24K2QLp1Q2TRDBxuj
         GJXlnmJitWN93AwIFrvwODXSPsCMRrDS4tyLlnYQTNaXm2sFYW9mgeWH5uRAe/yj6UI9
         2LKsBFR5R/ubWZsVBf+DqJdanMmiEfMR1zzzr2sxZz7RIOcXNN8EWz3yS+g1FCaY6aqn
         sc75Jmvm993rWVB+H2tyAVN0KvscZOpSkalX1th19CWDEiR149SSh8KkcCsEtZOllnUx
         sMCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmHVbOg+JXjSwk5L3oqD3APa3OPCGvpQtNzDu4wqfRUmcwH5uGp1FrtvyUE+sw/f8kzA7rj4KKo15uZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7tq+4E93ukaKF2u3e3sQ3Xl5zLTwNep6q7OUo97K/1BLCIaj3
	X3z6FrtN3MB1yocWpVt5+CB5kOcEfCvZ2n0fym5GDkXhn/6R2qlkzpCS
X-Gm-Gg: AZuq6aI2wUO1Nt6GHMtuubfYr9nRRguERGNZd+zd+hCN5j9eZGt4roP7xzAWpVubBUc
	wjMeRXHtPsKLQXHH9KcFwUqMKPP6BiqqACYkBELw1tYuXgJNMCDjqJRd114+dmA+mQWaKo2UBYy
	7Q31M7Jg9Gh2lJRt8Z/Q9VWKP19R9Txw2y+0Mc30UmyeR6vjQMtBWCU+HvX/WhR5WVp//sP0HDf
	P6npMq/bs5jbU1uSPNM/yPxAFRRZDPujXoBHu1CnQod8H5P5N1jeKAnKcUiykjF2B0KOekbRc3v
	nu90OnISthlIKJ9apn44nG9TaV0x2FMTCp5xq28/PLxkosRiYIiEhR6dy30YUOF4ReQmipe5qaL
	z23Z/uhG16uFLmSktdQMVxL2oH2hacnnL/95h1lvyruweh3lY8dUrSgWRMZorNGakasAk3DHwNj
	x2y5ndOd4KKnwLWvScNWyYR7REP13qkUbuAFLpE/Ot4ndF3dBkDjn/NHCd6HM/1ig=
X-Received: by 2002:a05:693c:2d94:b0:2b1:7486:3a06 with SMTP id 5a478bee46e88-2b6fd74750dmr2110658eec.18.1768942162520;
        Tue, 20 Jan 2026 12:49:22 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36550dfsm18741806eec.25.2026.01.20.12.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:49:21 -0800 (PST)
Date: Tue, 20 Jan 2026 12:49:18 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wentong Tian <tianwentong2000@gmail.com>
Cc: erick.archer@outlook.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: serio - complete sizeof(*pointer) conversions
Message-ID: <jhgcqd2awejgtr64ezaqbo6mltbn4sgnoghg6emshvrhsy4ced@x7ftu7zkluel>
References: <20260112162709.89515-1-tianwentong2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112162709.89515-1-tianwentong2000@gmail.com>

On Tue, Jan 13, 2026 at 12:27:09AM +0800, Wentong Tian wrote:
> Complete the sizeof(*pointer) conversion for arc_ps2, altera_ps2, and
> olpc_apsp drivers. This follows the cleanup initiated in commit
> 06b449d7f7c3 ("Input: serio - use sizeof(*pointer) instead of sizeof(type)).
> 
> Signed-off-by: Wentong Tian <tianwentong2000@gmail.com>

Applied, thank you.

-- 
Dmitry
