Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C169368D4D
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789342090; cv=none; b=PI5ckzY97hs1k8VFb6q7Um7MgipJgglyrTD/x2lXWXSRlsJI1/KInc1643Mwvj7W4+/qMT/fksCu14APW0GXENVMxYoWHYszplS0A9Ws0xr+l+V5CnpEffDg8OhEFiADbvxXv5d36IGPcWlT/T2aZmHwKPnuykgYvQy90d01Jwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789342090; c=relaxed/simple;
	bh=B5wmYvgAumOgkvL+j3miHf8Yd6fnFpMGVGSUtvMSkrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN6VPzjO97BqXCqQr7O3F8aSetl0l3+bM0aFojxUmoTn80bvDyGcNPVcBE6h7xaLt3jwJR+Nr/vAei9s9KITFQIilE8tpE+3DF6cOqHwZ9hqU16m6mAZYRWyCjSd2CFmTHnwdFmTyv2tociMxrDSysNVLkLDwchdu2d4o1IAy8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Saf5WQM8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Saf5WQM8"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d942c7cc2fso25381745ad.3
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 16:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789342088; x=1789946888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R7s+G6iKjm40YpfgASlG1A6+cEJNeaXA4iyKbV5zAO4=;
        b=Saf5WQM8vef8YCeLDc9hPtZT4h9JT+xN7+fcCvGfS1WXryNCvWXtor+FnteyX9eQq7
         cH9ZRFYv2r9N4gDFQDdUIJGBpGHByOzCGOCsiCrGXXmig7dqgcuFJc+pqpgsnQbavwnB
         WZ4hiJT6YjQDOuNoaJmpm9TbzMnFzdMz05YGWpJK6ij48XUtEYMLvczmb5KdSqSRC6O2
         nOJzssr5aNh52ziIGXIH+euxQli4VfEfVjmyojCWImuWBstaiQCmdxc53/mKQmIQuq3n
         rPmvuzW3XZMD2lKF5tadr+8WxGIq5SyTWRQIFjeJO4bCidMFrXH0Y6xj/olI3g/JMHn9
         Pidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789342088; x=1789946888;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R7s+G6iKjm40YpfgASlG1A6+cEJNeaXA4iyKbV5zAO4=;
        b=kw+fYhoU4wJTClJNLrU43gRahLIHtb94uGoCiiANdqd4u139NPqz+h6eF6Q/EzC7xJ
         LMWhnQ8NezsDZ76jJcOnaXMiFvPERQz12eFVitJ7Vj8r/7xpFfMXC25wd8e+d4HfJTxh
         oWSSru1xWKUGDw/LymM7j+DwAhBSHdsDjYHjjPoKwuz9pY3W4emBSMIRtK6I4NIK5Klo
         /CtoF3cD/wSPa8J/4rElnJogj6UzVS9Byo1ED7xuBqHWTAt+4W/tnj8NkYVmkQnI3dzP
         eonMmeao7gP/cmLa0ZXRTwgWJKcoASmDKSWPxgfxi6lfVlPv6rLnBqQvFx2eiIaY2hZY
         +3LQ==
X-Gm-Message-State: AFuF++lyMI9QcImcul9OEXygQhd83KpukQnTWfV2jSB3e18b/jsK/kqp
	0zSPJei+QYYiQvNPr3w57j5ZzRWxDBsi9d+tWLOOnxFOyyZ9GDcd1yk/
X-Gm-Gg: AYBFou3j/XqERX/ncbvIRnmaNZcer0Zx0tlZ2UypE8JksKY5YzK8lYFjZiu9ym5nhJI
	xTcj72UaWRtTrxxHeHDvPPRWKpFgxPH87u/k4QASUe4FTz44x6zKyHLi0jxLuWd0v46NwbCxfAQ
	/pX8OiGyhapVN0zoUkJxCrBYbjnyXUuc/hTaeU9i2hX3m5Ye28XORVF0k8xfovd37lT1SsAF5k2
	pRTURKWBWwewiak+mQXvuZjUhZJ3e+eFCMcCmzevwm3AkKQ8QasWP0Nf9F3B8yhi0P94ZXJQfGw
	mdJQrdjHW2QTC356Plg9DagcmO3MVzeUHWto0+7fJ1qiIQEisbdV36k3csBpDl/Wj27XNIHxO7q
	EdJ+xa//43/1M2lse2ASpUk56pkZ87waqdNP5DsX4+LxXIZHEqQ129Z8OtD05RvbajBVHauy5XU
	RfivRkhTPnJlMNYmUeehQIqO/FG1IJrb3L+c3ARNDeAiPtxUq77NOHmPZJl4DwunqRkX+O2RRSf
	eBifKZhs8AR6YVO5/7vtjA2wSyPxvM7NI/WetPi
X-Received: by 2002:a17:903:2310:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2dd6c6d75demr2017215ad.10.1789342088253;
        Sun, 13 Sep 2026 16:28:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm23728160eec.31.2026.09.13.16.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 16:28:07 -0700 (PDT)
Date: Sun, 13 Sep 2026 16:28:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Chris Sommers <chris.sommers@icloud.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add quirk for Acer Aspire Go 15 AG15-42P
Message-ID: <aqcxe2U81KD2uPYi@google.com>
References: <20260907182723.2709981-1-chris.sommers@icloud.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907182723.2709981-1-chris.sommers@icloud.com>

On Mon, Sep 07, 2026 at 11:27:23AM -0700, Chris Sommers wrote:
> On the Acer Aspire Go 15 (AG15-42P), the internal keyboard drops out
> ~5 seconds after boot on both Linux and Linux-LTS kernels. Keystrokes on
> the built-in keyboard stop registering while the trackpad and external
> keyboards remain functional.
> 
> Testing confirms that booting with the i8042.reset kernel parameter
> resolves the issue and keeps the internal keyboard responsive.
> 
> Add SERIO_QUIRK_RESET_ALWAYS to i8042_dmi_quirk_table for the Acer
> Aspire AG15-42P to automatically apply this quirk on boot.
> 
> Signed-off-by: Chris Sommers <chris.sommers@icloud.com>

Applied, thank you.

-- 
Dmitry
