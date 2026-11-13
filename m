Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531548;
	b=cOGiTjFvr+2fASYuD4JFTCVqDmEaYQq5xXMPWgkZ27u3o9jas3kawBVXFfpwkLubsmZY
	 86KzSnqjuyyAW4JHeldOuDkcOYFfHMTZvdKFsHX+AzYVbrsQ0xjjGwPRVDxaV5HSOe7gt
	 DF7extnQzde+MmP4+6orxRFDFiwx/Vu+wlfzUE6MMmkdV9uA9xE6lmZnlxG/GVqgXRs9H
	 2Zq7sxYDrMcSIHEYx1jVeQOMSmYoredLm8KW49s3BYftiQCWQokAwufqerGye2Y4o++fn
	 ZrixQ7WCQGlNXHCd0aM6HKMZkknZycaWgPFJrtIU/2aafy7BVvgEwubhtZMxMviRluA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cnHQLMcLsmKQJDyIGTt0mvQnh81+ZXOZVkzwKRQPLt0=;
	b=k9ZdCLKqnEntkFwTdYijeO17s+7sGnH/yq3LM8Ys9Qvb66HTpb6naWxeIKgJOOwSl4/f
	 6S9kxOGk9ZrarkQfEPgxwiJOVPBvkvRcSN/SkPSJVEqv9loMWROYO3trgWja5+nkN/0Sg
	 JM6ywGW9aBDYXYnX+DHuFQxAamUUxriRGMLwxPm9i2oPIjPX8cv8P4lVeq0FVDQRunsv3
	 gsuNd2u4/PMbfQBzgF0FQR5BqheV19CZMGMMWa+kluLPvSyCDuTOxOA9EsFH/heLrNqUK
	 WUp9YQPb5T08E/a2Vpp5xe4Ah1Ff+bxU6e5ccnZ8KD1e80BJ20iOslagsvB7Wh2Wb5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aXwA6C2X;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48B606A323
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 00:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E48B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aXwA6C2X
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2af4c8d00so38756c88.0
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 16:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794531546; x=1795136346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cnHQLMcLsmKQJDyIGTt0mvQnh81+ZXOZVkzwKRQPLt0=;
        b=aXwA6C2X78/aErlxdCDVlDcBhkVNyzQp81N3HP+FcVhJ/FM8Ts6K3OTLEdrDTNlTZC
         PZlGbsKqFdepUhhUwf0PTM4/12NFZOmop3SMoBLlrEo2OKDYLM2AQ+eqSG4n7pA3N1pj
         r5tFkM5LxFCtgMVGCSfAjr7e5Ubz2hvSMv3cYF2jhO92/gHpAxYLlGhuvE8Oam0NBvBW
         3d/2C//L92CiXCNnqw6r0R+4t9XZfGZjwz1VoaqfrCxDktj2prFI3iKcjRF+UXFn16ap
         6K7zLI1kvvv7cxwwJV6+lExKlmTZf4DnCTPEVPaKT1VACLFTNEai51iOa/kMF+qrecyi
         rbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794531546; x=1795136346;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cnHQLMcLsmKQJDyIGTt0mvQnh81+ZXOZVkzwKRQPLt0=;
        b=U2UVrCltGjzHgXZMgB3n024an0DYasyKnnsE++0Ag/JbygQiWjqz+HP6chxxxOVjnJ
         IsCoBqvluy5QLYnxBjNs6uxA10R2pKBqV9WkZ57bPEQehg/6HXdJN5b8wDxSEgGG9EXT
         oHIp/mvgppUieHlpzymjKHc8guX6vnoaKr5Jmfg5ydbULCssrPXLDRDqWPu6woW2WA0B
         lutaZZHO4uLL5dUtYcDkVoKNSkXc31na+PsAjDfXeaLeEWrWT22Xto/DYAfulF5ds91M
         6Vpvs2081A3MsbtYtweuwhi/O4K+IyjepkPFqLUfpIbiJk2tvIcxxpoUk/fnfUX0/aQJ
         qD9A==
X-Forwarded-Encrypted: i=1; AL+hErE5R34yj6UYuLCGI59BNRMSlcY2wF254GPiknxFsghSx3GE69tuPU55bf1+V6g+UNZlrt+BM4UruaKzZg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+3AKArxN/NgQfBVUn7FmY48KDOc/in9vnvwonn0f2D4xs3AUUj
	yqi182xQvsrjFXSSjXdW9G0SR21ZLTuUaHjd2gyqy11doFLSt3ibDzhW
X-Gm-Gg: AYBFou1jiDBbLb37PG8B7fhdfDo0hZ02SxpUW2GRHGhMb3KVS1Tm7/aaGhi6DQ4gzio
	wGby7L/ZI2SI8QY9iyVl1xm4meTN+RpqOp7XZ5eIr5BO6IiMFvZS02l6LCRiP0G13QNGCxbJkvc
	VjWH7Qufhj/wVsT8OJYrQps0k/8jLufoL9rKRjMUp5LQ7VV690lyc3ypmlJlkelvw/0HB+5TAR3
	RhbGiuh0zE//J5OcfYWpuNJidO8c+URLbtsfaruSYZFVUeo8/YerdIbqz5ZQS+xkg7yCjVyv+9s
	BA3s+02XyzuogYmqvFp065253hVxslJuIW5DGBHM95BdZvFejYPbxqA+4JoW98NLiFyZz+NxwaP
	+qhVdlVfp+YknNAYBdsvqqk6XK/fOhGc1jK09O7zy07LNJeAQS1qFl8lISpv9WXdu/TPv42Nspv
	HnXeyX2oY6mAS/XOpz+S6/gqfgLmqOHimbj5QlFP124+Y3iGu/AdR72Fprk02sHyVYj6ylGbSM3
	m9ZOTA2lpcm/UXyu4TYUoQcEqGrRU7rKp/o2q0UxuJWsua4eCJXot9AJsBNWirJV5U0jwvSrecu
	V3RObDT6WEMF1lY+zDigaYL3qMOaYgpl5jX6G98IGWXEAyGWyFEck16t7yOuz0AyZwgAgns=
X-Received: by 2002:a05:7023:a4b:20b0:149:1feb:6d9d with SMTP id a92af1059eb24-1b5030fb74emr1197809c88.19.1794531546379;
        Thu, 12 Nov 2026 16:59:06 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm2760431c88.8.2026.11.12.16.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:59:05 -0800 (PST)
Date: Thu, 12 Nov 2026 16:59:00 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: muzafferkadir@mainlining.org
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v8 10/11] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
Message-ID: <avZgzxJtnMceNQnJ@google.com>
References: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
 <20261105-msm8952-initial-support-v8-10-311ae8e8f14b@mainlining.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-msm8952-initial-support-v8-10-311ae8e8f14b@mainlining.org>

On Thu, Nov 05, 2026 at 01:54:14PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> GT970 works with GT911 driver, document it to be
> used with GT911 compatible.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied, thank you.

-- 
Dmitry
