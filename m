Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F835B137;
	Sat,  8 Aug 2026 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786196360; cv=none; b=GZZAYL1xal8YKS8yokZ4Ga0700Gz6ap8UuEXdgJW8eDIBWJXdYd2Na28Pmf+SCBIXPmhWfYHpLxF1O1fFnqDsisTfxAEj0iL1sQ0TEb7fM8KRpbknAoPBWwjg//u+J5+PCWhqwTcUc8f9YtHXdaobAV0XKdjTQDZL19r+/djJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786196360; c=relaxed/simple;
	bh=Qvx/YdpWxrdeHSIfbb5Z3+M5OXb0fS/yQRzlCnHa0HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGrzNoJf2ce5bh48YLFwmQcwexTiJnQoW/vUdV+Bh3yPyzMUJRAPWzZzF+PCIg2yHrrTklmIMpWEhyxgCbJzPo5Xm1kQXxPDL6LCrAIosRhzowBIFLgsgfszUcNVA2E0mDy2v1rGINJTVperMew9a2eitMd47ysZnxk5fwZtNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpzYFApS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpzYFApS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD9F1F000E9;
	Sat,  8 Aug 2026 13:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786196359;
	bh=FpARLT0ntytvRaBnHmVX6doAJF6A046KyxMWuRGLl/Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EpzYFApSpqdneSBM5AD3yxJbSyo/PnvM2KPXuoW3v27RMBLqGMb9g1aY9b7RALw33
	 CSAttEY+pwp5iqiS5n5F2y3Dj/omQJbfIrynsba9DsQK335A0TbweUm+T0+BElLpq/
	 BqV849GIn/QUbn0jV8xwikpQP+QX7CKBJjaRXLETsszhPhpRM8+YcVT11RCoR5s7zd
	 jlRD5LIYvGfQkOb9SuHe+MTpUxBf6ewom3QbjcObTQ7gye4LA51N0z8YVSGQIOhbrG
	 dX87jdbDDnQknUhAbj/pztO6FXLC5gAuM55Lezys1Zjrv8+LiJwxqwgNkFTpZ6WznK
	 RsGkknX4rwiYg==
Message-ID: <704af23d-32a7-48b6-bd3c-f7f471e18073@kernel.org>
Date: Sat, 8 Aug 2026 15:39:16 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: focaltech - use signed coordinates to prevent
 underflow
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Richard Davies <richard@arachsys.com>,
 Mathias Gottschlag <mgottschlag@gmail.com>, linux-kernel@vger.kernel.org
References: <am_tH_F938rK6ask@google.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <am_tH_F938rK6ask@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Aug-26 03:22, Dmitry Torokhov wrote:
> focaltech_finger_state stores finger coordinates x and y as unsigned
> int. When processing relative packets, negative deltas can cause
> unsigned integer underflow if the finger moves past the left or bottom
> boundary of the touchpad, wrapping the coordinates to values near
> UINT_MAX.
> 
> When clamping the coordinates in focaltech_report_state(), these
> underflowed values are clamped against priv->x_max / priv->y_max instead
> of 0, causing the cursor to jump erratically to the opposite edge of the
> touchpad.
> 
> Change the coordinate variables and limits to signed int so that
> negative values resulting from relative movements clamp correctly to 0.
> 
> Fixes: 05be1d079ec0 ("Input: psmouse - support for the FocalTech PS/2 protocol extensions")
> Reported-by: sashiko-bot@kernel.org
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans


> ---
>  drivers/input/mouse/focaltech.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
> index d3ad4af5aa09..c6f6540e3e29 100644
> --- a/drivers/input/mouse/focaltech.c
> +++ b/drivers/input/mouse/focaltech.c
> @@ -78,8 +78,8 @@ struct focaltech_finger_state {
>  	 * Absolute position (from the bottom left corner) of the
>  	 * finger.
>  	 */
> -	unsigned int x;
> -	unsigned int y;
> +	int x;
> +	int y;
>  };
>  
>  /*
> @@ -108,7 +108,7 @@ struct focaltech_hw_state {
>  };
>  
>  struct focaltech_data {
> -	unsigned int x_max, y_max;
> +	int x_max, y_max;
>  	struct focaltech_hw_state state;
>  };
>  
> @@ -126,14 +126,14 @@ static void focaltech_report_state(struct psmouse *psmouse)
>  		input_mt_slot(dev, i);
>  		input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
>  		if (active) {
> -			unsigned int clamped_x, clamped_y;
> +			int clamped_x, clamped_y;
>  			/*
>  			 * The touchpad might report invalid data, so we clamp
>  			 * the resulting values so that we do not confuse
>  			 * userspace.
>  			 */
> -			clamped_x = clamp(finger->x, 0U, priv->x_max);
> -			clamped_y = clamp(finger->y, 0U, priv->y_max);
> +			clamped_x = clamp(finger->x, 0, priv->x_max);
> +			clamped_y = clamp(finger->y, 0, priv->y_max);
>  			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
>  			input_report_abs(dev, ABS_MT_POSITION_Y,
>  					 priv->y_max - clamped_y);

