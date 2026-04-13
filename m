Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962E1D61A3
	for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 03:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776052691; cv=none; b=kMd0bwe0EGMae5X7e3RaWaRDlfgAJKSXLJ5RwSLowYj4VQEGhEvzmYjmZJOxBEV/pPox8agvot+9RpZBjPPWiitJJVDhFd0ScqM0xEi9HihGPrXJ6nZq2iAr0XFTyx7hlPD0QQ+VizmrYzgg8pr58mziCrUifeq/KBqo15LhwqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776052691; c=relaxed/simple;
	bh=5rMjmz8480hGwZh+4bVWEVENJe1raTrv2aqtbrGkErw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXqEPNxjcNNvVPQ/99nZ7KS8H7Jp8Z3SB6+2A+ZkVVAi+8tp5M5kwE2pUiOfIC8xSIDeKWV5ILYaqBxve+hW5Q0SyiJ4eOU+9nmw1eUed7zoBfX8OGus3R/n5m9T7tVC3iFiI80Ag6X5YSoUYuJR6OmEwja/ptu7+bCbM6sYWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyp94RCP; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyp94RCP"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1273349c56bso5033858c88.0
        for <linux-input@vger.kernel.org>; Sun, 12 Apr 2026 20:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776052689; x=1776657489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7mo96xdM6m+XuDbVypNs2al/ajl4Rwtt5VNKc5GRBzU=;
        b=iyp94RCPu0og4/5KFurQVz3UjM4eosI4VdOGBQT2AFsBWaL+m93FsYONjF5pH7Ew1K
         7Uw6iZBwJneXx3oP1kGavITEy/750vrJtV1LLxvjlHVnuknw/gDUF3hv9wWZAZj9CsCL
         ZDJsYTmeZgy9+2KX1dBBiEDcc8ABCR08Hz2A6KBXMgoAJ2NXY75L2uCRRVc8yH6t2R1u
         mfeyVdWEJoH0wjkFRhRtsSjmKyHHoVlX/JpnMKlilSEmdVSKVv7f40dNB+lgpgFxBU9y
         9Ga2vOUJ9tdE1WQxy4JCKqJ9Y458lkYZzKAWYajvuhU4D/VIHV+lwmPuE9xdjdiECWdG
         RPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776052689; x=1776657489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mo96xdM6m+XuDbVypNs2al/ajl4Rwtt5VNKc5GRBzU=;
        b=TeL8ueIMKI+gLTsBYWkWCElFVSxV2mkBhgl48fsihGL6SA4mSKOwbmA43Og5e4tEo0
         5Z5uiFXPkU1RtFPaBUeyP8yP5FD5XMMZ4mKift+CAqJWKIfh1dPoXwkq9kNlaam1sItY
         DrjiRWXYpKa3wnEMNkzSb4Dmf/vvnBG4k+oK2bQYjmdO17wYRwqdtAGXzENkRIE1nwKw
         JbnJ37mDFV5IFA0V5qA8kK1B5rGLPdtR0QLk1e0VuFTteaEnN8rL2lAlFh3o8J4RUpN/
         hjdIr2eQec9TWLC5Otyv1vH6FU1s1Xki3bsaDhbp/ckOr/686WEyko49NYGn7o9v0F/h
         U/ug==
X-Gm-Message-State: AOJu0YxOWHQDYut7jzhHfj4FFW2mPu+2qR3ZRvL9kgSxnGtlEciLlFs3
	6s9vDhMsu/Kp1ldXBczjx16kwc3IpjvUZNhZo23fAxZ+/pHA8fNTJ9tk
X-Gm-Gg: AeBDiet4bUSTMRzIKwXfCt4BD/Xeq6WIlGfyO6RqS+tB7pGIZ857SuA2GReO/I6r8m7
	WEZwh+mLMrN/lL702L2mLHf8w5J4e0GCI4cg9tb6jOkEXc0ZHx+RSfhkJz1XfZpfux/B5gdrYFS
	Qtz+SKPiQregs6G9tFvzcU6q5dER74h+9edIyy3VtMse+MKBSAsjamgd5DEkxlQA5rGDFXmz1kX
	NuDzJECuWqPidLjGgj/aRRO2AfWq9qB/KTQUp7uTzRGREnWIHYS6S+o/sSnlUIcC1on05i73AvA
	ekzvN6ob/a01ofd778iRLKeNyHCQzDavYwXpgr2CBp03HBQYepugn161IoMJZDmTwRDT+KkpkyE
	4HHS3+DPoL8HinTVgBngJIGDr4LSZeiTnS6ylwrp1FbdAFIml3CMXxmDvYSUzwy0LiXTGCM3SJQ
	1AGqPSLsAiWxeFctTGhgo2dFJrM942BbUGuNt85e0S0nPg7FeaRBWCsPzVf9vczHwpqaHfGIR6B
	pg=
X-Received: by 2002:a05:7022:389:b0:12b:f8f0:80c7 with SMTP id a92af1059eb24-12c34eed8d6mr5747791c88.21.1776052689334;
        Sun, 12 Apr 2026 20:58:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:fd17:4617:989a:1816])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c4acc7d6fsm4787583c88.5.2026.04.12.20.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 20:58:08 -0700 (PDT)
Date: Sun, 12 Apr 2026 20:58:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: webgeek1234@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: edt-ft5x06 - Support label device property for
 input name
Message-ID: <adxpdaSXYAa9dLPD@google.com>
References: <20260409-ft5x06-label-v1-1-21e8a9ae9a60@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-ft5x06-label-v1-1-21e8a9ae9a60@gmail.com>

Hi Aaron,

On Thu, Apr 09, 2026 at 06:16:08PM -0500, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> The AYN Thor uses a ft5426 and a ft5452 for each screen respectively and
> these currently get the same input name, making them indistinguishable
> from userspace. Support setting a label in kernel dt to make these
> report uniquely.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index ba8ff65f7ea671..c36497571b1aa1 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1285,7 +1285,9 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
>  		"Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
>  		tsdata->name, tsdata->fw_version, tsdata->num_x, tsdata->num_y);
>  
> -	input->name = tsdata->name;
> +	if (device_property_read_string(&client->dev, "label", &input->name))
> +		input->name = tsdata->name;
> +

You should be able to differentiate them by their sysfs path.

Thanks.

-- 
Dmitry
