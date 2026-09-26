Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954C02E762C
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 03:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790394536; cv=none; b=msf3b3EnXF6jBh//iIEj2S0MSFEUXap8HRwK6SOTzyraAKzhq5piRaBrbF9gpdjyxzvV26F4DuoP2C1I5UEDLYW+IwZNAvu0zEflQwXJSYzICUeG5sStaSVKIid29K/ahZVoCDNNVIvgn2oQKc4ewGic1/louIna3m2BlS+m77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790394536; c=relaxed/simple;
	bh=CLrM2wPA9wxnXi7IhEgR7GfVZFShh2FdnM2mC8plLbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p38zJ3w6MbxxBtsdGarmU6YC0Fff19FIz8ivZpLhYesSZE+MzK9LI9DTApPiUlvod07t11hxSxotas3ipSn3SYjusDFOMYyneIb/oLPtFe3wDtMxBUSxzGBeUAxRXmPHoNIHesB3MYS29nz3o5Snm13DEaHH5zDv72F40PUk/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZOt4gGv; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZOt4gGv"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-34182b58c7eso1128183eec.0
        for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 20:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790394534; x=1790999334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s/TFdpTxMiYwHrmjouP2VwdkJofSRV30LB9rRr0t5Pc=;
        b=aZOt4gGvvEzchDBFSC9yD++v637Ri/q83vubCPw9DRvXUDMvTQorzc2JQ/+Qo9mW0L
         DMgTlQzLuLjzDd0Li77YnoObe9Et/pI42EUl/6mmQYxza+jx7++zJQr+CzWE+2hntHkb
         YQAFtK3hU8UQVAdSZAn40qRR5iFbNZodlSKqI9lLQeLfed2wQnr4XxMpulUqIA+fxxFk
         iBjxqnVqzcoSsI4Ls+n+s51pr974feV4KxP6HVLz7MWN2pXxcqv3K/JRS8mb0U6REyaM
         JkJ3GnH5TlM+3cQaYrc1bYaY+yoELUsq86M7VfNKeRlBqV2QZapMcsU2989dYOBtIrOT
         4eGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790394534; x=1790999334;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/TFdpTxMiYwHrmjouP2VwdkJofSRV30LB9rRr0t5Pc=;
        b=IQTEvKN1Y/BGgTg197qGcA6i+nWrXCs7dvDNQMSaEbx6MOpJ8EvOtt5SGS9Awh4S0n
         dZawE/7bvOepqHYthwSb1q6GLvgLGE/ut8U89SPWi9moSrkp8jAu9eDdt3mENUNizvtC
         mnww2yCcSao3vRXwyM5imoG+7B6Bh0c23l1cexH4iXSyXd67Og3Yt4gfE5lxIVo/YL7o
         qhWoN6GuACYRcuruteIskIJ4fMc6weCaBvBatXtDpGEzSOwam2eFuFbM9mukkdXO3GpN
         BIJBaftNPD6uj8qhJBK5lhfk524lf2T7gDK4vN77ezZU98Hz9W+IiQ+EmHB4xlONo6lY
         dPMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTYm2ehLd36T/5fKYSpPEES+RM9eS1CnKhBT2wtXQ2CxZnA1HB+0s5e8Uz16ZSqiCdPpROHoL1LwzZYA==@vger.kernel.org
X-Gm-Message-State: AFuF++nBYlM7RtWPXJNgP/8SO4wByIxRR1o9xntQic3b8ZLp2JHO1F0x
	UKTGEbNM8NrNHcdZqqKWCZRJ+wzT7EwVjUSw65Bdf+SDGTUXBfIfWxIoQ7MSKYSc
X-Gm-Gg: AYBFou0MPh1fm3WpzOBBYrfyk3ZRBlGWSxNljkOm3tcpbtDJ7JuLc8x75LVk9jx1iQt
	Kn8j2PyECSrXWwaHihKykFbXNpS3U58ib8ssdDNTyzIX4vOVrd7jBxG2VmVRCgzvWDFJSmY/i6T
	bW4KWh863txwAkTxV7fklChwuNHah6TpmfINes1/h5VGiXTXALi+bE04NnEPiC4TcFGwLP1Zvym
	tgI9cVJAWIRRt7J8R1IqWhXH25KVqUN/6Q6zR8UMySBUhebP/PU3MJlzCdSROoOMGhrtdMGVdY5
	mOsb6dX6XSvolmdBk2cmxjt/rw4liKM8s7ZVMkOg5o5d8YQASJUGilh16q6y0nxXE7M0HYsANfg
	qCngSm4+yFgYi4souuAR7xOyM7M20YUcduTZhnlh62bENR8ImsGE6Ppdsi1wUO0AcVNAZ7+1GDV
	xAukq7/DjWDTelkuFJGAY0fMkBEpVS2V43gnAJ6f5l3FEb4vNJYavZ7LZa7mAECZ9M1NmUtIz4k
	E1Ld9VgmFSSYn+PjNJditlavmDCb43ibR1EUmVsv3pxOc5v1g==
X-Received: by 2002:a05:7301:7e04:b0:33b:c122:6bd4 with SMTP id 5a478bee46e88-342701bed7amr1482746eec.6.1790394532963;
        Fri, 25 Sep 2026 20:48:52 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:375:19cf:5fee:be32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3434958c3adsm902665eec.22.2026.09.25.20.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 20:48:52 -0700 (PDT)
Date: Fri, 25 Sep 2026 20:48:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Vladimir <anykey196@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] Input: axp20x-pek - add AXP313a support
Message-ID: <arc-Q9D1xcFn8I1q@google.com>
References: <20260923110741.1880-1-anykey196@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923110741.1880-1-anykey196@gmail.com>

On Wed, Sep 23, 2026 at 04:07:41PM +0500, Vladimir wrote:
> The AXP313a MFD driver registers its power button cell as "axp313a-pek",
> but the axp20x-pek platform id table only matches "axp20x-pek" and
> "axp221-pek".  The power button therefore never probes on boards using the
> AXP313a PMIC (e.g. the OrangePi Zero 2W).
> 
> Add the missing id table entry.  Unlike the other variants the AXP313a has
> no PEK key/startup/shutdown registers - AXP20X_PEK_KEY (0x36) lies beyond
> its register map (max_register = AXP313A_IRQ_STATE, 0x21) - so give it its
> own axp20x_info without start-up/shutdown times and hide the corresponding
> sysfs attributes, instead of exposing files that always fail with -EIO.
> 
> Tested on: OrangePi Zero 2W (Allwinner H618 + AXP313a), kernel 7.1.13.
> 
> Signed-off-by: Vladimir <anykey196@gmail.com>

While we no longer require legal names on sign-offs we do need a "known
identity" and just the first name does not cut.

> ---
>  drivers/input/misc/axp20x-pek.c | 39 ++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
> index 24f9e9d893d..b912f13b607 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -85,6 +85,16 @@ static const struct axp20x_info axp221_info = {
>  	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
>  };
>  
> +static const struct axp20x_info axp313a_info = {
> +	/*
> +	 * The AXP313a has no PEK key/startup/shutdown registers: AXP20X_PEK_KEY
> +	 * (0x36) lies beyond the end of its register map (max_register =
> +	 * AXP313A_IRQ_STATE, 0x21).  Leaving startup_time/shutdown_time unset
> +	 * keeps the matching sysfs attributes from being created, so they
> +	 * cannot fail with -EIO.
> +	 */

Maybe just say:

	.startup_time = NULL, /* not supported */
	.shutdown_time = NULL, /* not supported */
> +};
> +

Thanks.

-- 
Dmitry
