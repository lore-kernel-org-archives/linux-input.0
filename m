Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814764;
	b=cQDL/+F7UV3XJdBaeoECvVSzZNdOmLyG0E1I09InBtDD6PqxdfLls59kIz9pcI8nUPtl
	 /8mt323JchZgZEhdu72OCGSwURZiP4GaHDzIjQD6yx8EC2yvT7c5v2qzyiShI69znpOPu
	 tk2J0nE2m1OGHGuIA5g+DeTC/Rcb5c0cr94lHi6Yl1avHERyAWbQL80TOANsAwhn5sy+3
	 +O0/DVY68uv05iw2IRf48kYvgdGv6+d/cH/wU4IbqlHDkDn4b3Y6RD7suTnOo35VGHAtx
	 Ko6UgSjYXoMm/tCAZygMHIs445oXZqdK9BVJyLK8um/nsTb/CTQxh0l1rgTNUwaKE7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=UeZc8ScP5phq/mylPhGfZEPbU2/5SkeiQIEf4wyfYM0=;
	b=yteoWvE450SlKPGB2IrFf7466VyHUVOeQ5eMuOBmM/kdqILP7aSjqiyUHskMSTHPHabN
	 zh5zrFWdOupV1vM4QkuNCMg2GsIsZrsC/CjyFmmXDMP4IYLk0lcxpQLD4bLLxruHKxm/L
	 JwgVGTYujBEvzMGwshmiwA+DobBGAKecOF9PaZin1xuFRPoGP0ZcD7DOmEAfgfWa4dsF7
	 A+NoRMujVQMMlXjCnbTubJV88ImI6Us61iVpCT0qZjSPcv6ByU/DOpK6SlQxfus1AyYg3
	 VT3dVHrV7G721bi60qNfugdVGWN7JO6b0s9/wAa7GG8KemYb9B5QP9YLFGENVafgmRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e8QGPVGc;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA8606A8A4
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 07:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43DA8606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e8QGPVGc
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-170135e43c7so4961734c88.0
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 23:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794814763; x=1795419563; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UeZc8ScP5phq/mylPhGfZEPbU2/5SkeiQIEf4wyfYM0=;
        b=e8QGPVGcIJk/acexgXCbZBKNJeoKTJHpMuSwfSvBT/KOSejyR+U62mYzuQWaSPBTBa
         iIDEPKn7VTw6QtMDRHsmsU8v0MrG7Fra5bWFrvZAg7uSJcnhJKd2LypSeyFZ1Cl4g3cM
         wJOyBPFZclGXxIz6U3vw75FTJgfkZlYV54hNfzN+93CquaRDkAwWJjbMB9E1lrD1PWqH
         x0v7jfDrPPWEy/jgzDzoOMTtWpqeRh8RfOHXDJZ3ksAYSmWiOkuffs//aQefF6Ydh5/m
         2mmEZNA8saFLtaimpJxc28yeWaf7EhDQ0SMDCPoA9T2KMP3ujHXh4XvZ8UmywiM8yHJs
         ZfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794814763; x=1795419563;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UeZc8ScP5phq/mylPhGfZEPbU2/5SkeiQIEf4wyfYM0=;
        b=Aj/TmDQ8/CjYAYVzHubC5ub0a0ljnqSpz8GfGTpMqFik1H9fXPtq3ZNIuXLFAfcRfw
         ciH7njrkjC3AMOi2/Ho3B/jojJ532zICIUyxA+WWgcVBzm5bj25srtUG3AXV0ZS9XWAn
         l8fK+VO6m4nyhJjffTM9Q9v8a+1fyGAgNRLFx8a0nURdEUE444pcjMjXrk/NFcswGSoL
         1PBLTty9UjtzYZdnVUEkv20WjN/4tpW72xTdR+zbIr925tJTdOS7QX8BqP1mllQO5K0X
         Ov/L1B8V6APxzkcqYvIJj2MLFrEp8RR2p0BD/wywgPTqnrH1N6+2yPqG1xNnalm75fZb
         6A2g==
X-Forwarded-Encrypted: i=1; AL+hErF8z2ajz2h+OgDsomlUz1WtZgnvRVAviOgVGnv3SWC/WVOKkvoiS6eFrUmjsZxFlBaU6HVhK+Ug8R0GKg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/lS5jRLbDq+3fLX5lcVvHgBhorq0nPVnfJYLfSeqilQz3vKyYx
	4nkVWWD+HuEft+6bqLz3CTyteYl2O/wzRAjF184YSEY4PwDe8dxdmJPa
X-Gm-Gg: AYBFou3AX5h+RBQ0OZMvrsQ/p/dSN+Pwld6oR4jTSPgzqycn3FhKDfKEgBqGNh9/np4
	1HHG7sckDUYZhVbiGALcV9+yWduAkRV9IgbZDXCIy0QMuWTfSVLTT44cmbsGc/HNsGGO0oI72o8
	WyJyMTZcCBbjFnF+PG2DzsUqCuPuBNmYV6CKj+1abBwU2tBcd6Xz91LCkjD5FxKIJtQoAX3EUiX
	4G6gJQlqURD9Pg6PqrZJGYDCRVhu+LZ8xfTOXQkfKNCiiYLsQ6b/w4NMnam2YngLTfpfHGnvGqm
	w9hcS0I8RgmF1lEd2J4y7ozc9GKn7S7+xkHF4uug3QQwl1ahkWNcux5si5zEiV3m+4VRD6UBoLb
	9kPVCoWl0MnTd2SJ6r31fbZJhS2IYFmayGIklzR40qCEDrcqCUyA2dQtF97RhYrmPdZO5ix4HmN
	7AVP0LtkgERLSpqtRAdEn0JnwaDMT5pB5JvpDylHjNiRcT3vYMZR5sHAAfTbAWSUv9hUyaZhfK/
	1tNQDI1i0s65zHzVfieoBVAW4z61Z+AKgmJLuYedFuWmNnUQ1vXtjyCGvEPdN/JAFBhZKBuD8Mk
	so83fFjitPReen4CnQslPJtX5s6EsSNtTxxyY6SIz63YVpD/cHGUsk7Car1Nu9bdCzYTCTWXXAp
	qdGMoVIRzSgPGB8/h
X-Received: by 2002:a05:7022:f4c:b0:1b2:6cba:7f48 with SMTP id a92af1059eb24-1b50315622fmr8755891c88.31.1794814763158;
        Sun, 15 Nov 2026 23:39:23 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:f133:af41:7614:f46c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm26795070c88.13.2026.11.15.23.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:39:22 -0800 (PST)
Date: Sun, 15 Nov 2026 23:39:21 -0800
Message-ID: <9639a3578bf1cae847b4b0cdddd1a0e0@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: axp20x-pek - support the AXP313A power key
In-Reply-To: <20261115150903.16855-1-jernej.skrabec@gmail.com>
References: <20261115150903.16855-1-jernej.skrabec@gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jernej,

On Sun, Nov 15, 2026 at 04:09:03PM +0100, Jernej Skrabec wrote:
> The AXP313A MFD cell is registered as "axp313a-pek", which this driver
> doesn't match, so the power key doesn't work on boards with this PMIC.
...
> +/* The AXP313A has no AXP20X_PEK_KEY register, so no timing controls. */
> +static const struct axp20x_info axp313a_info = { };
> +
>  static ssize_t axp20x_show_attr(struct device *dev,
>  				const struct axp20x_time *time,
>  				unsigned int mask, char *buf)
> @@ -193,7 +196,26 @@ static struct attribute *axp20x_attrs[] = {
>  	&dev_attr_shutdown.attr,
>  	NULL,
>  };
> -ATTRIBUTE_GROUPS(axp20x);
> +
> +static umode_t axp20x_attr_is_visible(struct kobject *kobj,
> +				      struct attribute *attr, int n)
> +{
> +	struct axp20x_pek *axp20x_pek = dev_get_drvdata(kobj_to_dev(kobj));
> +
> +	if (attr == &dev_attr_startup.attr && !axp20x_pek->info->startup_time)
> +		return 0;
> +
> +	if (attr == &dev_attr_shutdown.attr && !axp20x_pek->info->shutdown_time)
> +		return 0;
> +
> +	return attr->mode;
> +}

axp20x_pek->info is only used by the startup and shutdown sysfs
attributes, and we do not have variants that support only one of them.
Can we drop the empty axp313a_info structure (leaving driver_data as 0
for "axp313a-pek") and simplify this to:

	return axp20x_pek->info ? attr->mode : 0;

?

Thanks.

-- 
Dmitry
