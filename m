Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC51CAA68
	for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 05:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782537932; cv=none; b=G+XRnRgwlFUApGXfEF6uXOvf+qzCj5CAvRFh/yS9m2kjqmbQv6DAe1mkl/XGPIZ8M9NVvxrsbyoeCtsqsXRDnKO1TrAwTPR6yBon6cIa9UB0n6Aw+pti9mAWGkRaqr83n506uZGnRkcYAaIHv750NxYlW8Ed6SnlIaGPicoLvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782537932; c=relaxed/simple;
	bh=uMZWn35TU6cT7lFUh7QJ7pzaaAe5RKvrKK7AXHsvuVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLSV58VYhwGdlMQHgxaiuun8DoFwqE/jvvYVoLbmaWlznYInDz5MQAtop2hxCG5O08ieYG1a28FSHI025XQRVEu7syPyFvfyWF3sDP5GKNZJTWXdnubaHzyjwjLk8iBXqoXB+7B/5VmL7yp5PUSTPkrSYbA70IYkT+q2yrqnyJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mjtfmfz+; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjtfmfz+"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so3609985eec.0
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 22:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782537929; x=1783142729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtG3amUD5t4Bk8QXwCkGIWpIV9NGLro50H5UE4maCcQ=;
        b=Mjtfmfz+48xqE62KRIITDS5SnnB4WhGqiad/4OvIHGCrcdxzvJJo/mA7mr4S1Dvg24
         BGgoDfo4yVTeffpi33YooDzrRxEbbqYwPUP/gVHQEQMA6UF3uf5E6jaRObJhRZ56Nzen
         VWaypzxGa2iNh7nVcgLkWdjyfPJOwfbrWL0dvUhrihYqtNg1tBmd5EH99uorLtP28u6A
         dq85EJmKr7MIGOhItmjk6B7P8k9ffDSBoTH/rZ0z75oxIrG1I5XP7Yw9Tp/VHEaf/lhe
         +VlVu556csu4Z0ekjLJ2+hfL4hnOWNV4S/vqYj107GTpalZyNk1zX1ohRkCFIBFM+45P
         WvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782537929; x=1783142729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtG3amUD5t4Bk8QXwCkGIWpIV9NGLro50H5UE4maCcQ=;
        b=dVmWjYvfzxImGyj5MSmvgAugTJHDFykKIQXyXjKIHNQl9CQEE12FQjUTNK0KDXGG6F
         gq4ZbMbet0+/CeoBlxMEp61a1bD7+J6VBt5P+bAa4AhdD+C/Qw7vqSQkYSUYs4VSTGgm
         qXI61LB1KCxnhTwgHg3v8QeHIm7pajPTkDSsv/OKg7k4HjgyMVXMqyR4dJPKWDRVfDDX
         8mQccuDlREI/4+aCvP3SaCJ0tbr76XI4o8yrjueN+IavvRmZub7oTdTqckTrvSEF6Xql
         NvI5EvWG/H4guCpnLcsHvwEjZ5rRemehVlRIV0UIWHKVmJb9eoU+0wk0yo3LPGtRiUSw
         kE2w==
X-Forwarded-Encrypted: i=1; AHgh+RrJ+nr6AqVtSOAYzSV+Xg9a4w4bJk3o1kaF5FuG+FRHmVAbrkndIQyfaNrnRquePyS7qmDn28SKia1y6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNDGFcD5gWUA2yDt2zrPSkUH1+OEFTnb6RCJJ+a0bYnDUTMlwf
	JlmtEqeuBG13QwTjW++dVzMLuWR+xw6rifoPKPfyxe9jdXwzZqqk6w80
X-Gm-Gg: AfdE7ckrFHr0pFcN5nyD8sPzCnR6TVY1uYw6KtBP5VwnkeH1KyyNYop1iZnl9zsf3en
	EWnUJmyt8veyfiVCpWsggLPxypKWF7icA54zb5clfPF9I4Fwj1YaH/WW4dzOIN2LqvAHoDDyveP
	4Tf50/gmX31i7Q38mRvJ8c6xlrSfiIzGBfYOilhQiCraJYUVirWCZfPzYxrx3U706PrUrepj1OG
	HESJo7oJ9DG6MAtHRY5/NOQJ88Lnuz53GxuqVx74hQPOMsUZR3EktLySZ6nDiGXWN/HH3tvYVaa
	w/4l4h9PtEzGf1yUr4oMbQ5OW/9zkf/IJtyE2fF0S6VE2vI+qrCm+V4lHLkzEACBQnF+ya9ujKK
	LBq8AOdfI/N+Hy1H0TZlAfgwnobdh5umm2fHAca7SS8t9n5O68dRvfGEDhldjCUhb+JdhFj34Hq
	/EvPYZFf2oDiLoRuq7VnxUUZHgBFxTL2gifXpvTimg7O5BQjfNrUlI
X-Received: by 2002:a05:7301:3c8b:b0:30c:ab97:d7ae with SMTP id 5a478bee46e88-30cab97dc0amr2520378eec.40.1782537929343;
        Fri, 26 Jun 2026 22:25:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e062:ec60:2d87:502])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4c691dsm23022178eec.5.2026.06.26.22.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:25:28 -0700 (PDT)
Date: Fri, 26 Jun 2026 22:25:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Oliver <oliverburns.kernel@gmail.com>
Cc: kees@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: sur40: fix MAX_CONTACTS value based on PixelSense
 specification
Message-ID: <aj9ewPft1xOb-9dL@google.com>
References: <20260614230847.4938-1-oliverburns.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614230847.4938-1-oliverburns.kernel@gmail.com>

On Mon, Jun 15, 2026 at 12:08:47AM +0100, Oliver wrote:
> The Samsung SUR40 with Microsoft PixelSense is offically specified to
> support 52 simultaneuous touch contacts, not 64. The value of 64 was an
> unverified guess as noted by the FIXME comment. Update MAX_CONTACTS to
> match the documented hardware specification and remove the FIXME.
> 
> Signed-off-by: Oliver <oliverburns.kernel@gmail.com>

Applied, thank you.

-- 
Dmitry
