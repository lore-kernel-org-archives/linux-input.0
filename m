Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358C15665C
	for <linux-input@vger.kernel.org>; Sun,  1 Feb 2026 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769910560; cv=none; b=pHXQVsNGKw8+ywBINd+cCe3BG1IpsD3qDE9s061Zk+3d9omWzP0EjlvNBJZrC3c3UI9a9hsi0Cpw/pNwJHm54P7DX6NU0oPajmqSFlYGGRQZ05gfdfbLbZKtGcz9jeyGrjD4tev6q9q7bMmnbqTDPDaXL0i6AlsuiZ/kMIeZHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769910560; c=relaxed/simple;
	bh=jIM6ploEHr2xj4xww6y64sZmcRorm+yWkDbVtgVT0r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVnGJOZN8Zjjv2cP+SvESnBqxPR6vbMbWsiBH4kDiAkRZ61jOb8mjOmaX5ctFtZ53XaX83P9FYRv+6qm0JMhDwpICChwS3W5v/Txo5HuE12WR7dwLkmol7aVT+RcweoqgBojKXilr2hkbe0O1kY6rEcO8xvRlpnSLxkUMGW5fho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiDw3CgZ; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiDw3CgZ"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1233bc1117fso2891056c88.0
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 17:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769910559; x=1770515359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDZPiyu35gI7ry6ULQRYnogAcGNCJsm8fgf787oYOkY=;
        b=XiDw3CgZaIuk4hQt1sjqU270Hodr3ZR+4VRyndOiOH7zRyMmMc/9JGUXVr1ltDX/3Q
         DjbELBgpGWZVRas60rFpLuYLrvyIvk1cEKo1Uee7tShQG9FcJoXU+jVGS91/aAYEChGb
         crbvcVXYuZULFVxvtPF0BC6tgzRzB4xray+oy021gTyPcHsf2tIPj8TRwdiatteg0M7p
         3znZANxeEZydI1ifUZKQY5LgSr7n8ES0TZvbP9awbcvPxfqyECfu4mwwYsh4FTkDdiB3
         Q9f0ePw7GmK6uuNpJyaPc57lVmS7o4iWbD8eZZv83nqGUfsuuo7wUshcoad1Wn7wQQ1Y
         G9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769910559; x=1770515359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDZPiyu35gI7ry6ULQRYnogAcGNCJsm8fgf787oYOkY=;
        b=GrU6+TEixNkzwN1HL4nN0cjAcPMCEKd9XAGmoYv1shesgMVA2udc3BzZJUWsPgDLKs
         rIEhX0J0HbfPj+c37wAaHoAfL0zZsWYr3u8S6HRp+bPG1emqViWrhBEBKBytDPD+EGgZ
         xV/Re/6OPa4X4S1Wn3+FwGH+TblONyghO/hW/kzUGWczKZRlwUd39q7po0jzZW/XAqWY
         kZjcNVFAX7CaZPEixRqIhnXL1x48LUSa78JGXdebW31FAte/m4GGI+A47/eq26VzLFjl
         KUi3RZqZVouxNr0UIDxqva6+5q56U0L646EBIW6Zx1VL4AOsCcL5QP4g5FHZ3qKozJoz
         8kHA==
X-Forwarded-Encrypted: i=1; AJvYcCXXo5iH295HjBXt1Uua8UfZ1ooM9F+EdRMmwO2W4LIpldLxBAZH1AbWZL8HIjl3pU8WrFTQutxmniuGUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8dY1ny1o9NQJPKeD/pY86Ntom/4Ja5AtUEEKwzREU/NHa5Zv8
	jjOZUwk6KuVwLgEsR+xsxOWTuY4rEQ34vtDf+C7Pz5vb+/NZpFEuOVZXA25zeg==
X-Gm-Gg: AZuq6aK4mJjI420JlWbDugNfKspM3VkDFQ2OiWxIXfWBbC/c/au0P6lk3/4fuIFtaBZ
	BFbdSI2ksth0Q5AJ8G70ixxDCyHggdc5/GO6ZAddtudS7FC32td7djQSc2tclE0lhemD4ZmEyfW
	E7vMuCnO68c392ehLw5rXpKeb0bLDfvz7MK8Y7kTH/dcd+es+yYpkMOGprdlTAhH1CoE5IgN2HR
	Tvk939HbwZHtfsAfoMoKIGtrVskPvITWPaXNchODLIiO9yQxrWNQJDw2e2bq2Si8Mn0kv5bm/++
	wEY4gExS63u7BHRGsCTuOgEBTpO0YHpMufRwLpG6J10Ic/wc6SbEMYDdQT99CNNPCjtrnxrFpTs
	00wm/kJGvWXZp4c1OhVhIL6SiRm+hvklo+5WMtpFExlps6FpEm0htKVh07bg5+SXzACxf+He0kV
	RQ27hmfhAhLM6nc+u1Y2Y=
X-Received: by 2002:a05:7301:9f0b:b0:2a4:3593:ccbb with SMTP id 5a478bee46e88-2b7c9124abbmr3386218eec.2.1769910558628;
        Sat, 31 Jan 2026 17:49:18 -0800 (PST)
Received: from google.com ([165.225.242.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm16914029eec.17.2026.01.31.17.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 17:49:18 -0800 (PST)
Date: Sun, 1 Feb 2026 01:49:15 +0000
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Input: aw86938 - add driver for Awinic AW86938
Message-ID: <aX6whqw7XyaKMd9m@google.com>
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
 <20260128-aw86938-driver-v2-2-b51ee086aaf5@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-aw86938-driver-v2-2-b51ee086aaf5@fairphone.com>

Hi Griffin,

On Wed, Jan 28, 2026 at 04:51:14PM +0100, Griffin Kroah-Hartman wrote:
> @@ -717,9 +746,19 @@ static int aw86927_detect(struct aw86927_data *haptics)
>  
>  	chip_id = be16_to_cpu(read_buf);
>  
> -	if (chip_id != AW86927_CHIPID) {
> -		dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
> -		return -ENODEV;
> +	switch (haptics->model) {
> +	case AW86927:
> +		if (chip_id != AW86927_CHIPID) {
> +			dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
> +			return -ENODEV;
> +		}

If we are able to query chip ID why do we need to have separate
compatibles? I would define chip data structure with differences between
variants and assign and use it instead of having separate compatible.

Thanks.

-- 
Dmitry
