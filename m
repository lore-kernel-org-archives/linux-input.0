Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183710;
	b=LbZ+h0B6NHflBgBbKVCzkiOUdHIFpb7U6kZ2kDxxTDHJxwkYoX5p+SkD2jjjYib+Mi4c
	 KaJUq4rg49qFukqEMIlpRoqkR6vOnE6TGWQZMinR5HEPX8jLBH1+HL6x3n1zc1Pa/zcqh
	 XObBuYyJTp63dP9Xr8YmNs0VvdT6RBDV3EKPB6k2gNwrRcV7FpCV6xgGA2H5MVB1F+r6d
	 gSePzDGT5cK43PpB6HAuWfW25ZBbw2+C3AMvtgiQSsc/u5eF2dJM4RTSDgna3jfdKevdB
	 yFoG+8TsznX50T5/cccCdl1VXikPpP/YkgP+4zGgz8QNpLfpn0kt0kX7BdtECCgpPsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183710;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=g/Uw/zfUs+KgJU4czuGuYu2+3Kijzr9VBndrh5VygIk=;
	b=Mh3eTAhSbpqMrFEam51MpB5SmwjTLrEUiMpLpAv6DDbGdXzx9Vq4qBSoBi8BffA+f3PM
	 01pLVkDGxdGqh0vTHIfYTYSSkwzviqb4y8W3dWS714E1vhKA74SIMKhLBoDJBaNL/6QhP
	 l3Dy0EBdBJhn1WX1++tleBxvzObcA1Jp3cqEEJI/ac4V3qm96gHUe/XClnsMucz55USQL
	 B1D2JvrNC45k6Nr3QKI09RG959Vq7P0aSVdtI22OBfW7lve5JRzL90aS6iVc4laYKOhql
	 MedmW0LJoQA4yfqbCDqu3ZQhrCk/v9npeThULbANiPbX0dXAlkfMF+XC9Wh0nE273ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXj94GPw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEB9606A320;
	Fri, 20 Nov 2026 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXj94GPw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3BE1F000D0;
	Fri, 20 Nov 2026 14:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795183710;
	bh=g/Uw/zfUs+KgJU4czuGuYu2+3Kijzr9VBndrh5VygIk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=AXj94GPwXEdiuqLZYsWIzRGFSnyeuJ27XEo6VO+XZmMY2b4jxFsfab/lb6UgJsIvF
	 DKcVaY34FIxDb4PsFvwigtBoYg27174TuJUqONvgnU/bTeVlnO/6VSEKuZQQa8I1+W
	 +Ls6amdYeUBx5XAaDP7IpQcEwy0QeVMops3323mxL4ZmBkRDjWaJyMWVsKi5IGHXbz
	 KEe+7PQQMPwviDyuKukbaX38xVZot7+cWjvwwh4gWgyuKcuOafkfwn9AYAoIBwQ6aX
	 /R2muARrQWSXmVvzr2Bfo3kkJLeGEFGZ6C8OcV76TMLO9pDUD5Dv4RDjnFUvOu6jKv
	 KY3I1hI2fbw2w==
Date: Fri, 20 Nov 2026 15:08:27 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Sasha Levin <sashal@kernel.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, 
    linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sensor: custom: Fix the sensor state allocation
In-Reply-To: <20261120132751.2909204-1-sashal@kernel.org>
Message-ID: <so8sso3n-s31p-7102-08pn-oon59qo77r25@xreary.bet>
References: <20261120132751.2909204-1-sashal@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 20 Nov 2026, Sasha Levin wrote:

> Commit d8dcea5754a2 ("HID: sensor: custom: Fix state lifetime during
> removal") was applied with kzalloc(&pdev->dev, sizeof(*sensor_inst),
> GFP_KERNEL), which does not build:
> 
>   drivers/hid/hid-sensor-custom.c:1023:46: error: macro 'kzalloc' passed 3 arguments, but takes just 2
> 
> The posted patch has kzalloc_obj(*sensor_inst). Use that.
> 
> Fixes: d8dcea5754a2 ("HID: sensor: custom: Fix state lifetime during removal")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thanks Sasha, I've just fixed this a couple minutes ago in hid.git 
already, so the compile failure should be gone.

This was me fat-fingering merge.

-- 
Jiri Kosina
SUSE Labs

