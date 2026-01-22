Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510ED3A89B4
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096038; cv=none; b=UaQmcCuGeKzyvAG16JfthznuSFLWTJbMovjvCVcpgd10s5mJhbsb4jG+Xx+gQ0+zo3zquhUij+/wj+PUSKgtoBt+03qFZhlR/vm0EjGWrL/BRdXVghDdDP71CqX8C5vgl07N5h1kq1Z5J1oOf2idgarBlXxkIDe6cUoniC8qars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096038; c=relaxed/simple;
	bh=osQBJ6S1vmYBt4uZOQAUcNLTVxIhvNUqsppbYafr1fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+Mwb4fyexwKRzVYVecXhBIHCHnzzp/SN6N7ZaDd2DPjzEv3QXiT57Y3ZltAKOEMhYoFhv4HtnhQTUCmoUpuFUuvDj3t7i2N1U9ZdCnQk7QDQc7CWQQdH+8clh/2BIEjog09aiw6MqCCuSQtB1xpR7R32ZAjRYTi3DJXo+IHeEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuPBd8NU; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuPBd8NU"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12332910300so1066376c88.0
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 07:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769096031; x=1769700831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHLX3yOLEYGr8uT/cpmE2KzYH63xwNriAPK2e86lc3o=;
        b=OuPBd8NUUt3uwalSB3SXAbuvbG6KJsnEiJnwmc9iLiMB1cpwtm98ubcSjrsxYEU2d6
         uemCBTX2uI6KzkjT73eNsOZPNRdt6PQJSQEWa9IDB7935eaXt0JKvlvKftoLECUPLvN4
         4+pqe/AcmUj4kjGoX9MEU9PoMiA7HWzmnEpKM2Iyp58AtQyKHIbd0QNZQ2rGsKJxya2W
         p1eEsE36FcvDurYxH6IZZTfZ/YSNZ9XIVSy8+8XGOPMygN/1UtRky8x/tCRK81d89SK6
         Cyxaco6C6QpWkS4/dMknAuNlygP4OGsesFEaYgrM/qeTjYGeX5zjIO5i+jU9Dkb+TIPy
         phrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769096031; x=1769700831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHLX3yOLEYGr8uT/cpmE2KzYH63xwNriAPK2e86lc3o=;
        b=T7LMrWo2W+5ECbIfBxErlzxjIkiBAue8+/VQBGY+gGSPVNTxQyXESfDNSbkH1wSvrh
         a95mKd2H33NxJ5FPpFnV6U+OdNAsxzpz1hJtMPYakdL4TLP1HfMU77Wh4RkBCfp+H0+J
         tU3l4Iar0qFs3ndW/CH33Nmi4T+pwpEL9kwErMcMgxk3vTcqcCCV7uHg06lYwYTNODtH
         yCufeAHGmrVyoyvZHTBus9fucjN0+Iv4ObzRJ2rc1lYMcWKS4hPXhhpqTAXEsq6Ik3FQ
         pUFyuIekU4PHk8e0NPtKb1s9ukp9OcgUVYWV3GvL/kETQk/FVdbGsGiXonkBQzGyg/WB
         AxMg==
X-Gm-Message-State: AOJu0YwMDVMwuGI8LJC3Wxs1YUAbKST9scK5EnylU6yHCfWxuvwslyP0
	CsB2Ng1aos0U5IviBqne1g1Iy0fGuuNWFEg4zVlSYk6DQwdoDo1095lGtNOtsQ==
X-Gm-Gg: AZuq6aKuBlWsFWA7owF+rfQQ0Uq1DKdZquCTs10JTSo/y/2YiiYVPMB/yqv+LlBPHxA
	nZOhwv6PwCo5GNOjUz95ekW29VKZJJLczLY/rNcSV0H7vdFqO1PZJDxUxom+68O1IwUN+rcofYK
	sVX8oioNimE0XJIj5MwIrk1Ul0NZp2YhjCsiBv7tvPr3SK1AmMYhjwSl5YzcCwrhWGVSrSdH4oM
	0pVSzNq3Cnxu69mnkuXP3gc0adfRAHx5cexCUBXLDzdyCF1hd8STXTu0TIXUmWFxbOVKneX8Utx
	eoM4vaWrVT86l+Pm9GJEfI/oboZR0ko/BjL+y0D88QqkM7ybvNCRoM1OKPXe7HL3S9Zo7HCnoQ8
	BJ62OaJpgWDLcuc81babHry6uCE112JlJoICUVwmIrCBZbxIEz/umt0tVOyDuBq5XzpB9a9qiek
	IbgFJc4TMjxP9ezf6e8O70RKf5ZdpiBmw37jl0Yu8tnp8vhPxXd1A=
X-Received: by 2002:a05:7022:4586:b0:122:9d:bd43 with SMTP id a92af1059eb24-1244a70cd2bmr18079970c88.19.1769096031023;
        Thu, 22 Jan 2026 07:33:51 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:777f:716:9c18:5588])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefab3fsm27545901c88.12.2026.01.22.07.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:33:50 -0800 (PST)
Date: Thu, 22 Jan 2026 07:33:47 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: gongqi <550230171hxy@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gongqi <550230171@qq.com>
Subject: Re: [PATCH 2/4] Input: i8042: Add quirks for MECHREVO Wujie 15X Pro
Message-ID: <nqkgxfmjlkwf2j3dy4bse4ixcuxzxodutesednv5pvophqwqhd@6oa64xyuk5y4>
References: <20260122120640.3471876-1-550230171hxy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122120640.3471876-1-550230171hxy@gmail.com>

Hi,

On Thu, Jan 22, 2026 at 08:06:40PM +0800, gongqi wrote:
> From: gongqi <550230171@qq.com>
> 
> The MECHREVO Wujie 15X Pro requires several i8042 quirks to function correctly. Specifically, NOMUX, RESET_ALWAYS, NOLOOP, and NOPNP are needed to ensure the keyboard and touchpad work reliably.

Please wrap commit messages at ~70-75 column. I will also need your
"Signed-off-by: " to be able to apply the patch.

By the way, where are the patches 1, 3, and 4?

> ---
>  drivers/input/serio/i8042-acpipnpio.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
> index 654771275ce87..4cd09560c5bfb 100644
> --- a/drivers/input/serio/i8042-acpipnpio.h
> +++ b/drivers/input/serio/i8042-acpipnpio.h
> @@ -1176,6 +1176,13 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>  					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "WUJIE Series-X5SP4NAG"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
>  	/*
>  	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
>  	 * after suspend fixable with the forcenorestore quirk.

Thanks.

-- 
Dmitry
