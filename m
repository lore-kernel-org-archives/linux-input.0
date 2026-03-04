Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52F37F8B5
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772600360; cv=none; b=aDKv+WXaesGOinBVCuy9d/ndTGv7AgECw6uGUhi9pSAIqfZ0aiYnRIZQ2TJP7oS20nsaRQ0I1OzWIGbPKaJyRU9orgMDYtKWyt1/LZtYdjSZjllnADKMQCLG1yx7rHk7N+8qdsTGHJ8OLlDGXlqJI7cOpB8k2amY3A9RWZZkIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772600360; c=relaxed/simple;
	bh=NhgmQKsMwB8zEIpgqpqtkcZaPSWUSfgat9WpBVwGKAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+71IIF+cl1Fjp5IaeMkMZSIFMFgfQr2e1iCvdfmhFcIi0lXGDo0X5nrE/m5A92WvgoLHhMWCu0/AGizmrYdFMrl7a59seEK3yv3CjD30eOGFJf2r70PosIwSF8JEsLjnaP0GrAns2wZUVOvKDRg7VOMd2cDk48MHzUrNQ6JPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyEI9ya7; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyEI9ya7"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2be19f05d7dso4637894eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 20:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772600359; x=1773205159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EDBrUhFaFc7wQVcSeZc1Bi9PtbigcT50WYnul0mkrvw=;
        b=MyEI9ya7zKkbFBeQuXi8fryJgwOLRbyihfcv3WqPq1MmHZoayNdBz6ibNQiG+v2gtT
         84Lq7jDN9wDabHZJRdmZYKDe8xS7ZDgIUOhV8FZftArPoEgEufvOZGwcM7Vtq77jZoPq
         oRe1lkMDGHFu1y3PISoJOL00nacJgB45S5h7r6dVgdmL4AHyz3jjIULYszizXs640glN
         +ofqxaNTcS7Bz0qa9Gt8t+hMYMxDAxPqZ06z5orgfWIBsFVMfGBctEkyJcSYb1NenGmH
         v0nIg4IWPHGLkhHSYr6LcHVGqOrQQsdFVVD6843djzM49wjqsqtdKPnt/3nWl2jQVFNh
         A2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772600359; x=1773205159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDBrUhFaFc7wQVcSeZc1Bi9PtbigcT50WYnul0mkrvw=;
        b=sh1SZ+jdu2tvaKVhwfIWL+mVe5Y+xjmfp3G0+RbzqCSLW2Um9GifSzfUuU6rHEMtHZ
         3AV3L4iFSHT0bBoiL/0qruQSc5D9GOG2AEU/qkgVT6kiwxh+SY3LeMd05c3UzaF5RDW3
         vb1jLZsdTmv9EkSvqhY8hyKudVx1MFmy67j7ZjdujXxKIQv/o5E6+VYu61CTgOW59vV7
         53XaBtvyJdkVqsVHvetJLtfz+cxXJcDmlptra31++hcUrrhsxj2gulfp7jplBc05mMaY
         aut7WHfB+DmEVkMfbnrbGtgQcFGD9xMqroqsshLpCxTiTRUnnnQUAc+QbLMRZNaVfoTO
         ynxg==
X-Forwarded-Encrypted: i=1; AJvYcCWsFy0zXxVdJC6WeTTFG1s3XPzm6HpBuoi1wTJ0RFXIVWkQ+qBlpHEfDy0G9ibRyvwI4thrgGu5F6+DUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0vEDIjuEw88zKx1LaRcAn0hopdgiJ02877sT9LZmUxyrMSITQ
	rk3jcJY+kmf9QWyRiZesniTj1XP6tJJKRGDFqaSjuQW+aXeUsSuRYV2V
X-Gm-Gg: ATEYQzy4sai7pvpdh7AG+rfQnldmHay00nZjuN79fw71I53fLX+NypBxzWA7Lr7Jlcs
	0vsMlDubX4iKGBaYniiGe45eioiIAh1qTOiFf1XG/B2e00gT0rFiPTuHsnRQugNxBUKkxUOo0wK
	UHlibVzk7EhWessrqI5OTfjczp9Pl0TwQ9hHEu2R/bumX4Bh0r5VVVr9JQoCzrzMRXjRVDwJObx
	9VY2Jm0U9sBTwahE0zzbkErLpL25yLu4k3knfbqDltZpsjAyajbZGQ5VkYXYf55VHdJPqbkj9R9
	+OtTg+0Z7CAgLAUYWIgiTe0F47HJIC9CJ/HqWvIbDqwKXQelmxhWVMnIe5KypkACc5jVxNgtRbW
	4RhN8+9K25T15iavpto4eYzGNZZpLnaP87WiskQ4mqY0q2P9mJRkZXPRHvhBo8mdZ1y/q3pomg/
	ebVc7WwcyTK/2OsVs4zlPy328vXqoRo6Z/glAkU1/XlOiNJIvxj86AOpy0sG2sAQq2
X-Received: by 2002:a05:7300:a887:b0:2bd:b961:7e8b with SMTP id 5a478bee46e88-2be310975famr422928eec.24.1772600358821;
        Tue, 03 Mar 2026 20:59:18 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:a048:d9ec:d217:7d59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1ce921dasm3981312eec.10.2026.03.03.20.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:59:18 -0800 (PST)
Date: Tue, 3 Mar 2026 20:59:15 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Petr Hodina <petr.hodina@protonmail.com>, 
	linux-input@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH 03/10] Input: stmfts - abstract reading information from
 the firmware
Message-ID: <aae7zuSkAgNaciUK@google.com>
References: <20260301-stmfts5-v1-0-22c458b9ac68@ixit.cz>
 <20260301-stmfts5-v1-3-22c458b9ac68@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301-stmfts5-v1-3-22c458b9ac68@ixit.cz>

On Sun, Mar 01, 2026 at 06:51:17PM +0100, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Improves readability and makes splitting power on function in following
> commit easier.
> ---

Missing signed-off-by...

Thanks.

-- 
Dmitry
