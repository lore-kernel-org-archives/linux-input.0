Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123578;
	b=w6Oq2LTRO2vLqGxX+6MdywRZSeWegunhPNEeKH1SvobS/F7PuADhFQ0sFRBUMGmyvfiM
	 Jdsvng919JC/exnBy+Cj91J8of4QvqQy2C09ikmdEaCTr6ekGmPDBjPaoM7bC5TYP+DnP
	 WVS7kOLRuzdSwIsr8y4wEl8QCjK7TUGSs1bdHaG5oiiHKREOCcyL699I584363o4WnCQV
	 BQPYBMs3yuBI1dhValTeCI7fI0wBegbVxXExhbHa2VwDodlGDao82qLtEJjLWbiOeAyFx
	 cFyne6Z+OvU+xQSMTXRCCKjGa6UOzOq5r+4GamxMzl1I7jJW9pzzwas8hKuq2Vd8fjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123578;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=wxsVbm4lHSm2AHxj2+PuSfU4V4G68ulcR7q/QZ2TFgw=;
	b=oPkA3JDFfykb5fKl/shU3gyTL88c1Ka3XrRakJYfVfwptBLFmBi9VacUCBLvmRgkkAyz
	 R/sut9h3iidsclQosq3dlfR67FrTkJD7Fhyak3rT92DM1E5uwLf+3wjfMGb2tExQxmiUF
	 vCcACOTxtCa3adxD8D7dycyVyrJinnCryrXdSonHYf7jUpMS2o7nE5ANNADq9TfU+X6Rc
	 gFN7wy7fIhqVkbWNW3fSQ77zkwAXevcW9vy+ZH20vUOLLX8sLX8Cj1rS/QT7QQr+D2/mZ
	 2YAFFm1afKFu13Fyejnum37MlwsgY1kf32OiJS3xASuEZ1/R6K9LQv/RWWngNHdNjbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMfoboMU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96E606A320;
	Thu, 19 Nov 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMfoboMU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B819A1F000C0;
	Thu, 19 Nov 2026 21:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795123578;
	bh=wxsVbm4lHSm2AHxj2+PuSfU4V4G68ulcR7q/QZ2TFgw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=dMfoboMUejA+z771JNVM33nQyf6pX6QeHLlBqP6/ybrQwYhCBX/YB0m/5sbudolOu
	 GXCxrquLVOkh4u2r5T87W7X4HaqX+I0tfqoMDp1xMSefhPO2QaqhASjROACpEz07O8
	 s0aezlO+RYiD2AKWzFJjNv0KphD0bV4qHSg0ELbtsgdTDuQQTIKK8pNXcAKsAOdCwN
	 xzyzFEDM/TBIdcH7Nh0QX/x39b+fzE9q2Nk1lUi29gJ8nELhHGDmfKcVfjep7UMsHq
	 7I6wXlW/2s5CR8pgkmtmiDEkgNby/gIC6YZwKw6+jLXoonK09HnG0Zxy/XySBJata5
	 TrU1yIAAomqew==
Date: Thu, 19 Nov 2026 22:26:15 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Muhammed Sariyildiz <asiyee994@gmail.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: multitouch: Preserve class quirks when inverting
 orientation
In-Reply-To: <20261105174252.36714-1-asiyee994@gmail.com>
Message-ID: <3o7p68o8-43s0-6rnr-r8n1-953824or254q@xreary.bet>
References: <20261105174252.36714-1-asiyee994@gmail.com>
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

On Thu, 5 Nov 2026, Muhammed Sariyildiz wrote:

> When exactly one coordinate axis is inverted, mt_probe() replaces the
> device class quirks with MT_QUIRK_ORIENTATION_INVERT. This drops all
> quirks selected for the device class. Applications created later
> inherit the truncated quirk mask, which can break device-specific
> contact handling.
> 
> Add the orientation quirk instead of replacing the existing mask.
> 
> Signed-off-by: Muhammed Sariyildiz <asiyee994@gmail.com>
> ---
>  drivers/hid/hid-multitouch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 4e19a0c..94e83fc 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -2155,7 +2155,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	if (hdev->quirks & (HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT) &&
>  	    !((hdev->quirks & HID_QUIRK_X_INVERT)
>  	      && (hdev->quirks & HID_QUIRK_Y_INVERT)))
> -		td->mtclass.quirks = MT_QUIRK_ORIENTATION_INVERT;
> +		td->mtclass.quirks |= MT_QUIRK_ORIENTATION_INVERT;
>  
>  	/* This allows the driver to correctly support devices
>  	 * that emit events over several HID messages.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

