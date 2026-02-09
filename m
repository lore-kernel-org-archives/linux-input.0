Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810637C0E0
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649184; cv=none; b=T3gvM1y0cTdLMkNVtFv15XRfm16pQo5phsV7hfAQhGctddxtkO7GHx1vi39m9ifGkeiJyQovbiQlGL8az7fsMQz2Z/32vlw0t1IdfXCE0cSvMiVn3/SR7jnf8uZdCAGicPopsGcfY/l+bt/r+NNvj5LqH+3amv6KaQHb31cMpy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649184; c=relaxed/simple;
	bh=DDbQySwtY8GnVjkf5RDP5/xDtisakVvfL2uYOituzWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOPxJ2m06aBvyTjd7MpK80m7V3lT5IKWlMtAqj4L+0bqXyeg/T7M/BobgO4YSNNi4Wrbqw16xTfg9bvI2Af+YOLEisJ8DQUMCqiWLdNh0blfeDk6MNXpAYqPI7ydE0rr3yricTaoSlxsZ3KPc7EITuqoF2SHzWVLg2L4Q2GKqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioMmyrKf; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioMmyrKf"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba76579640so771679eec.0
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 06:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770649183; x=1771253983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=or/TyMMcDi3QCF02Finwtjs3ACbwOGSvS0XrkKNuUkQ=;
        b=ioMmyrKfaGKgoCEbo91HtdX6Tv6+f4SO2xAc0CvVqi9Pq342rOe5hOXkNjvKtnu+ma
         QKEqN+ir8/VjIS1RB4SVi4FQ12563/owQqCYq6IY7lR4cVxyOn+GGbR8cWiS16ll1hte
         glb4SEM/iBEZG+IoXNjhwWcIuMibvQZ436hMHmTOYvP0ibEkYNfj3p9EixoDD+9/CeFl
         6P/1tGKtnYhz+RvDTap+wB4RL4ucaKgSlLOdBqr8JTa6HTNc1ETwlYSKEvQqLsaD0R9q
         IrmArc3jMcCdb/6nN4yZydLTTCnPtykDMDi3lT3PXqoEF02U1wF6Mu9m6fPnukXLVuNq
         EEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770649183; x=1771253983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=or/TyMMcDi3QCF02Finwtjs3ACbwOGSvS0XrkKNuUkQ=;
        b=JKF+38Vw+3e0Cy/Bg+x9xNnhnQSfRQss4E2iDWZHTVBTxZCVPueEOMtRLW+vx2EUHY
         G+9UCgrQM7u+OQEpSWGceQhg1+gr9sdxbu1v6nIXIEbEPt4tIoMm14FKqalja8PtWizL
         /ytt77DIh1ZAfmH3ZITriKiO9dC3C9rIO9AkZyWIiAvD1/T5niMhgx+7Npz1wTvUv56E
         yDJqGtOVy2ilDdDfod/HjMfF4XQVUiQG7X4CmTy21fB00KjCFej+gUstzhWht2YxkPUw
         n7co3/Mdd/Ea4pbSHrpFv+x6MSssf0P7dmQatW3R4BHPT9F2rGxVFNX6VGfF/Fv9tJUr
         GZ9w==
X-Forwarded-Encrypted: i=1; AJvYcCXt+/FGoNQRAvXNu3nRZngTNjHjjSSOwtnh72mL7YP/pGeZsz/SNqaDgaEyS7m5ErNHU583F67plBjA+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHSzCPvordOEeYG1Y/CzZTyn3YB75iepoHoVnURr1+EKi4FGLs
	51bkppI9bTMaLNKxJwZFQsX+rF/HwEi4tU3R3udOd11b0sPfQro98ZAm
X-Gm-Gg: AZuq6aLfx90UTfbyrSrYznRgVJOSX/+diCfJBnrgA+R9lwn2TkWVXmVsulJc0d7uYZs
	nHkKhZb9kDwlYjUaR3iS1wMSuepVnoe/j06TpBlt/AYsudQif0FyV06ZHsz+xrmj8NC1DDiiMm9
	iYw50Wz3edyLh0ouNcBXChsOcmWTNVWP7aGdj5U5e1IPRhC10wmTeMiFogJS8so60696ZF/5JUA
	XOIHWRiPO34s+Z8n4on99HFwPj9gfxnj17PVbbBskLL2dK0lh1tNxeymf4vEh+atT0qZZcrBgKn
	GBW/zn4fVl1DrO3QMJsg/e/NCb7UNXGrGYTfUM0LoErs4d5UUSnO3KjZfXpIjqF30XZfZM7GXCD
	lNwE7ThHzeJblcBnIo3P7ubjjoYmFO3RTFh4RDeO7uDPv3C4p7iLM3oTDaKQkrSLoMZsCCK/6qD
	FI+E5ah6Lf8qlme2a6HeaqagV1iAJyTxKMXOzsDkOQzMs+y5a10A==
X-Received: by 2002:a05:693c:6319:b0:2ba:37a2:4aff with SMTP id 5a478bee46e88-2ba37a258f9mr1540224eec.14.1770649182911;
        Mon, 09 Feb 2026 06:59:42 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d70d:15:1011:7b14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c3daf7sm7817736eec.20.2026.02.09.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 06:59:42 -0800 (PST)
Date: Mon, 9 Feb 2026 06:59:39 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Input: aw86938 - add driver for Awinic AW86938
Message-ID: <aYn13PdUF9MXhmE_@google.com>
References: <20260209-aw86938-driver-v3-0-5c79cff30492@fairphone.com>
 <20260209-aw86938-driver-v3-2-5c79cff30492@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-aw86938-driver-v3-2-5c79cff30492@fairphone.com>

Hi Griffin,

On Mon, Feb 09, 2026 at 01:59:46PM +0100, Griffin Kroah-Hartman wrote:
> @@ -377,7 +390,7 @@ static int aw86927_play_sine(struct aw86927_data *haptics)
>  		return err;
>  
>  	/* set gain to value lower than 0x80 to avoid distorted playback */
> -	err = regmap_write(haptics->regmap, AW86927_PLAYCFG2_REG, 0x7c);
> +	err = regmap_write(haptics->regmap, AW86927_PLAYCFG2_REG, 0x45);
>  	if (err)
>  		return err;
>  

Sorry, just noticed this: does this really belong to this patch or maybe
it needs be split?

Thanks.

-- 
Dmitry
