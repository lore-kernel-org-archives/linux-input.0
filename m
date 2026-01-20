Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6533A784B
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938814; cv=none; b=NCFljY4a7b03syeCcST02Hh3zCJIl0iA7Cu4oPhwzi8+lD21pwvQaD59yqCbf07Qt8tUHtL8+vcyyJt4yPVb2PawyW2T23mE6nRV13FpGwGwfFMi67x31O/8bV01HKKRYPHwZb7RqmQyc8qMiciEP6wuAEwUZbho387r8qsB1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938814; c=relaxed/simple;
	bh=i9uno2DHQ1nNjIlY38+4xqcrHbjg441zizXTxmoxHAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZyS4Ui06DFta8Gdxvtj1ojH8fORk29eBohNOoyn6zdfkNKqR0WMUkx8EyCeYxb48U3fJUcU/eb5GL5zRAQkOO5SRCN4CV82mJf8btBPVsny1zAXdWRdAR/ZL/w6fPJ9ftRk+TInsgCvtc5PFfw4c8HJZVYFsOTRliiDJ3Y6254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7fKGuGw; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7fKGuGw"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-121a0bcd376so2015043c88.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 11:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768938810; x=1769543610; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lQpNOx1ZcnEPWbMG3wgTd66OEZ6aelEDALzfPM7/R5o=;
        b=S7fKGuGwcrOI21eHJh0NbK6F6SFLKD3iF405GqGXar8jtPEPe+FgdIgFclIC845XKo
         tHEraInjWEllipqIiZKOAOO485lrzF0GKJJsToaluO7mQ4zPyMqTClVt9bXFVclJ6UaS
         SboI3HWCN8T9ru8ZtCxBW37rI70I5vYT1FKzDflghJi6GreENejLFczJlhmxEYVGbxwJ
         QWSh0tnVF7ORTJlfX+dMtA6vGv2NAyNEP0dPMsO/LKcY+4Tm816AuZvpGi4LX/vnk3h/
         WMTWImG4CnC4eNzIqIWAGqwHf9JJS7JUlozW9v+aywqz3WzNwk99yKe+X3kZO7nedMry
         SdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768938810; x=1769543610;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQpNOx1ZcnEPWbMG3wgTd66OEZ6aelEDALzfPM7/R5o=;
        b=NQqyEnSKtUV52cF96T7wIE+97wDBqLWbT3XYvGxf0vGIhR7SiSfASg8IlRFn3aca4q
         DpKtnELHq1WOTcQpKnwhvwPHx7GRBgkpjjKxZcSDC8zVf4UwhhGm2jQfEfSEYZ9fkfXr
         k/vDvAhTcfcsc/7pX03HBQezFQKj/qXNgwbom7e+rpEbjoHfLw6MRfN4F0ecgnwyLGKv
         XB6g4ACsBEKW8DuU8qZiH3adF5ZTw/sMSuJIcAQjDdfZPe4pvqBpNNtcRTlWpc5wUMAU
         t2GD0Qn02Q8nKe1as8wgAqlDbwNk705ztPfO35QiHTz+MMsChdFtC6RSL8YX1LjvRPoN
         9lxg==
X-Forwarded-Encrypted: i=1; AJvYcCXau27qvcJgeqnMs+Z+bE+UZXDVDYxWNYOzPRFefDQE+QJ6fx0SNpiD4KNVrg+SH8SETp72fGOgO0PsmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt65f1bnvQY7yq+wr9s2UBrzmAsUopo9/9BfvD7qYbgOb57UtO
	cdMqHFIZmGQjStv52R3v7h+xCYYexXadgX95iC1xAo56wrzQGMSa2f76CyK9BQ==
X-Gm-Gg: AY/fxX5qlRai06hlAASvzJNavFYWbtJXA/ZXkR2/SzCTE2d54ttHLGpIP7E93Zl94vy
	PaD2kflwTVd6XOFP4M0d9+4cJVFNLqFEoyXCU8bJpnS2RjseqynaRV9GereBYwMZTO/alffCQWO
	f19fU6KQtHaKBSufOAbCD25Dyw+cpgUALYZaaAov7422T5g/a4nWudkwemjMRSaKSLuE+Qt7OmT
	3eTGdwM/NT2QbHo+U/aVeKbobPStRTkqyHxehdVYpvWEVSrIyO4vBdKBof+Hlg3ebN/jJHIuWSW
	6a4Xsrsq/0D2f9uH22hUEEbKmLyHxTsVvPFFNGAWn6c8oyqv/KaWvcvnRinDnm4RaKdAgurD8Cr
	uat/8fgbH7MvKp7Q0Dj9zax3kfVrrk/NmCn9NcjkHjrQUJ+T31iulo3ho0w9zQ2rSlaAR6Q9Fg0
	FsTzvoeYwqi+bc/9AVtev2XXYGUzm16iTHPy6b5fNjaL4fDnLwLJRP
X-Received: by 2002:a05:7022:6609:b0:119:e56b:c74b with SMTP id a92af1059eb24-1246aa84bc4mr2106271c88.16.1768938809924;
        Tue, 20 Jan 2026 11:53:29 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac57fd0sm21142867c88.3.2026.01.20.11.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:53:29 -0800 (PST)
Date: Tue, 20 Jan 2026 11:53:26 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: yedaya.ka@gmail.com
Cc: Kamil =?utf-8?B?R2/FgmRh?= <kamil.golda@protonmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/3] drivers: input: touchscreen: edt-ft5x06: Add
 FocalTech FT3518
Message-ID: <uqsj3akfscfucgtalyk7tkm4lfbptw7e4cplhtgl22wjmq77b7@cxyopk7seaq3>
References: <20260118-touchscreen-patches-v3-0-1c6a729c5eb4@gmail.com>
 <20260118-touchscreen-patches-v3-2-1c6a729c5eb4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118-touchscreen-patches-v3-2-1c6a729c5eb4@gmail.com>

On Sun, Jan 18, 2026 at 10:29:41PM +0200, Yedaya Katsman via B4 Relay wrote:
> From: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> The driver also works with FT3518, which supports up to 10 touch points.
>  Add compatible data for it.
> 
> Co-developed-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Kamil Gołda <kamil.golda@protonmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>

Applied, thank you.

-- 
Dmitry
