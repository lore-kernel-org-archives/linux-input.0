Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF33D8104
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637740; cv=none; b=s01lnAYuOrVfFRtLUGsB45Syvu/G5VBlkUZgt6z2y48D6fzeddmNkfWg9Tq86jjOA4vhGAirCo0gLdSSEXMP+3/1BEH9oqei5tILtYGR0EDMLzELSY45BC2DQ9wG+HwHTwqKjfA5vFCMqFPIZ2KM1LD7emnnEz/TedX2UvfWMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637740; c=relaxed/simple;
	bh=CzrTjRh8aVFApgaFvhsZxWUfS7HpvI2aH47+Qzw6otE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+2AiuXSBwNWdJN6znDx+tF3gzITAXSzGqs83cWaVwnB7v5Ps22YKyMPyhu6w7lZ4HnuS+oFhg+WPB0qoZ7hUQvhuK4q6bkvNvqzU+CfucCxJedrG9QyUY37hGerSf8NsE8Rf0VGVdVpzzEJDMiFbnJUSjyYOG4ixjUpY+gOALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd01ltZQ; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd01ltZQ"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3042a388168so127418eec.1
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781637738; x=1782242538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F9t9c6bYslGUW0YJ04TH35qJToA/FwEVp7/7In1g8XU=;
        b=Gd01ltZQDw2fa08Q1TvVEP5f0fxdrowwR4s/r5qxIbdH5xRBSf3xV3jF2TlOZ54+W3
         3HA37DDoaZxhja9UNL/pDj4eej5Dnusrcif4BTmBjTJTt55AGJJspTlPdggAxgHHQiYM
         Vot6ofEM+kaQWLuXEhV1JSSBk2j0UgyFNEGxFxCvPcVnt5kVzc70+2imT+9pOvZHUnoy
         e4yaS2gxcpWqxCqkWt0aDJpOChWnfOLuc079xsaigEZ5XZI9NIXUmrFVi+06IHQYOMzI
         M6XY1/Y/jEnSdMzsJh80aEhhT0Hs5pDdNzIr6GS3MiZtzLqTihTHh/smA1Nvq7Jk8hGQ
         Nc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637738; x=1782242538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9t9c6bYslGUW0YJ04TH35qJToA/FwEVp7/7In1g8XU=;
        b=Dl06jFOfscrogtjmPNE9O4MkpbCNVL5cZecRjYBamqJms4X+VkUB26O4ZfAbmjGfVQ
         rDsLycUrTadqNP9DFXVLoSXO+cDniax8zxW+lYDVvgbQmM0ILf8U2yJnxBVoykvjRZas
         g75B5yDGy5zF5RtuMn+ahZrjgZAo1dxldwt+LA63FAmPJlniGP19v/0iBkBv8X+sCB7N
         byHOm1mNzf2bGXbE8NlFsjcaRubUffKeZelvbLToi5OOjDcDfO3JRDcCybaewPZ6FJRZ
         jrD9rAwLJZmivRV4mO01wpwhNBXS9xu+Z6xpByN4XtzGlM+mCLTYY1pg42ebdcj1w48s
         gPqA==
X-Forwarded-Encrypted: i=1; AFNElJ+Trf4MIXko7FfIG4h1v69N/VJQWgc1yUTKboix+dRnkX7rogRKZauwh0J64EbAwvXJELI18OgSNC5pMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH55r7vSKeejbGeRInUjlRnVQWpi+UTLZPbhtLuP0sAZ456Ci0
	0vNFxfn2qtDhYAEfe8fRgUd9czty0Utke4zM6/vfqkRD9QZImq7PbL6n
X-Gm-Gg: AfdE7ckixxAzGCT+J2ZX2DRMakHsSfVe8FRqS1xWNzIKYzOstiiUFnO28FMlQkRBRHD
	tdZ7b4sBc1B+8P0s5thfSX32m/B2aeOSBGK3HUawaB+sKvhUYjngZAjjiHycjNDxHUUSdJg5TB2
	j9ZZemY4iSmL13AFoimUJIEieR/LA9OUV32gkFJ8zXBeGmm6ef5xTLU/gXJMH5YtR+1pgc/60VO
	5/JaRmxg4nAOvCOCOOyjV3/MiDc1rj/7W6W27bVkfCptrMf236pHRpfKKhH2VeOtphoDml/Yp5p
	obub8EaFWXPP90N4UAHuFs9IamUWl2q9V3Hz+NZd6pUw57PBDax67jQcAazNeH2je3LEIw+5KWM
	0jSkW0JcoKFyoar+4OKmAgP9EIh2SpqpgNzH/yoGFYSpco3QzivPgS8ymoYGkGof9Na3Ng42S1I
	Gh9iNXRCQirTY3tP4sTF0FDCE6JdmCR1rkvlTxCi1XPIwRbUsZSUv4s7SCojYtTTE/XOJSSpC9P
	g==
X-Received: by 2002:a05:7300:6d2b:b0:30a:e52f:9b99 with SMTP id 5a478bee46e88-30bce88dc80mr66631eec.0.1781637738011;
        Tue, 16 Jun 2026 12:22:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:cbae:d24:189c:2cb9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea447b4sm18650560eec.23.2026.06.16.12.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:22:17 -0700 (PDT)
Date: Tue, 16 Jun 2026 12:22:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, David Collins <david.collins@oss.qualcomm.com>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, 
	kernel@oss.qualcomm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] input: misc: Add Qualcomm SPMI PMIC haptics driver
Message-ID: <ajGhUY5JpEQWfOfe@google.com>
References: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
 <20260616-qcom-spmi-haptics-v1-3-d24e422de6b4@oss.qualcomm.com>
 <eb693705-c0c3-427b-a924-5aa907fd65bb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb693705-c0c3-427b-a924-5aa907fd65bb@oss.qualcomm.com>

On Tue, Jun 16, 2026 at 12:25:55PM +0200, Konrad Dybcio wrote:
> On 6/16/26 12:08 PM, Fenglin Wu wrote:
> > Add an initial driver for the Qualcomm PMIH010x PMIC haptics module,
> > named as HAP530_HV. This module supports several play modes, including
> > DIRECT_PLAY, FIFO, PAT_MEM, and SWR, each with distinct data sourcing
> > and hardware data handling logic. Currently, the driver provides support
> > for two play modes using the input force-feedback framework: FF_CONSTANT
> > effect for DIRECT_PLAY mode and FF_PERIODIC effect with FF_CUSTOM
> > waveform for FIFO mode.
> > 
> > Assisted-by: Claude:claude-4-6-sonnet
> > Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > +static int cfg_write(struct qcom_haptics *h, u32 off, u32 val)
> 
> static inline

No, let compiler do its job and decide whether it should be inlined or
not.

Thanks.

-- 
Dmitry
