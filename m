Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44F5AEC5E
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070609; cv=none; b=tjowwiwxH1tGcqkIkWBz7OG6yJN0SI++Hj1HZt3Zp2I2T1AICMsIXqRUINbyLGubJ7mqib5Y5FQ10S1S625dqNEcx7uW7DN+TqMGAGa+V8D/zgWsT3W2Ka70c1QzQzuh0zT9DpS0BBJUFG2T2ZBrCOyap33fP8N/jv5c3beZZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070609; c=relaxed/simple;
	bh=lHnxCQX1mCPBdL3Z7XhDIu9MIrWJcC8ujNZYdLI5muM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSjR7kVk+umJmdyrj0BLpUfyezVHPHfqgTfoSsFnQ8p6sC4f8nBFgt6kbYkwlkZXJCe5A2ZtSAijEKVD2VhLyipaX5L8zQZPPk0fse6028Irzo/kKzr6hvnUai/Vi1djoq3HAE4siGDCLWoVP7hQq33aTMQl1vFka+DstP0VMfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF2ZqIfA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF2ZqIfA"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso904255ad.2
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789070607; x=1789675407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yA7AN5SquNgRd6IRwgD8k+yWYneUhO0DRBOSVnhp3mM=;
        b=FF2ZqIfALH0VKUDbRMc3V53wRMATEEKmBrTA1Qxe3g37XhOnzS7OKteneH1o0BTJy0
         +FjaFeAeb/NXajQPhXIQvAzME8gFsHra7bHygvowEmxQbfzJh/JWsXLq8EmLseSHngaj
         u1lGX+o2sBXT76RTtwvf7+z5evgCscp0fYx8eXAbsu2XNFC8y7WIrWWNdb17Huya/Ze7
         9C6iQxbg8/niib98U2KNgKEZXlSepY88igg9U38AilMDS37Z3A1HlKoe4qCC1f9+2ia4
         HaNqI8ebbMZIYmGXGRIKuncOR4bmwTl1Osqj1jqD7Ei0wT8Nbbx+yhLlh8VIC5mCocy7
         3ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789070607; x=1789675407;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yA7AN5SquNgRd6IRwgD8k+yWYneUhO0DRBOSVnhp3mM=;
        b=kw+aiL1LB5HI1pgZM75sYvLcZ2aR4BGeRsFJlonrqtOEQua/vRvGIRiJ23AyQJM2Rh
         IatBucYeEcyue0FWHLvYiBBZSDTCmacvDRpVFkScU6Jj05mVX3l5IogoU0qBSj6Fq/8k
         qQdvXTkaQWX8+I2/350QYV+16NwkGlKtLJL8FDgAE7IlGhek6vNb7dfI9W7c4l7SxF7W
         qMK89mQVsIEfE8aG6BZHh8EyRLEMniH0EipNuW46QZ94mp/rfwDamqLvaygtjaBwKsHo
         Sf6hiXmqWWOUE9XSAQlN4/VCLiL4GRVohC9uobQsy/L3HiNRH7VhaM7qtIksl4v05OFX
         nnlQ==
X-Gm-Message-State: AFuF++mUbgL+VFxWgIicRBUUJe04AjItC84ILVRKkK8AE6hphqt+A8TB
	jwJ4hj4OulNR/JQbYHClWpbASYmnyykSb2cI9AonP4x9j7p21LxeResK
X-Gm-Gg: AYBFou3HjJnmXM3ifXDrVIlXwzEB5xYOGYLqacPNeiPrPM1PGXYkoByVbUPWIzGvsnI
	F9RI3NTmks3lq2RLnocIicKTj3b7I5oLUgtN5w6whXY/Gz0onTDehbZHq7xFB4V/xsW/emWWmom
	IxuoZxifUQKPzNypYSEKvgtySivTl/cL7kMvps1OAmQqCQd9sbBHMoGLx+nXazkVe231NdSX2Ac
	PJFtm85ViEkFKHDTNfmO4DQADCY05jm3/oUxsCXfmF6jQVr30oOJAJM1zjQV88CoBuuWN4b1O54
	hcG6I4mCRf+noLdKXmndLJDwtLgorT49MBx7vjWsNSd7wQi98cskzx+RquX52nkWaWaZOALrnRJ
	vu4atbg6/3Cko0ZWsu3yT/LzBB4/bJAveJ45CZei/bWptcPx98Yp38YAbHFTe5JWwPwL6OjSbBv
	EU8QMgwgJro+Sl9n1YuagbKUfMyYI2HqoCUsSHCmRfN1qjtrbr1qNJbr+1Isem+fKxvugbbgUpf
	P8ocZS/ZBlaSIuN+82txtpH+DHlhx5KgMSf0kb0+SnVnIZARrYVJ8Hz4zDJRdxbyw==
X-Received: by 2002:a17:90b:57c5:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-39d9bc1b0eemr619404a91.5.1789070607042;
        Thu, 10 Sep 2026 13:03:27 -0700 (PDT)
Received: from [192.168.0.158] (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm745536c88.3.2026.09.10.13.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:03:26 -0700 (PDT)
Message-ID: <0c9b2894-c5cb-46b7-abf6-db9ba2c6b691@gmail.com>
Date: Thu, 10 Sep 2026 13:03:25 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] HID: hid-oxp: fix default M1 and M2 key mappings
To: Andrei Aldea <andrei1998@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-2-andrei1998@gmail.com>
Content-Language: en-US
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
In-Reply-To: <20260910032115.28669-2-andrei1998@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/26 20:21, Andrei Aldea wrote:
> The default button map intends to assign F15 and F16 to M1 and M2, but
> the selected mapping table indexes resolve to F16 and F17. Use indexes
> 47 and 48 so the programmed usages match the existing comments.
>
> Assisted-by: LLM
> Fixes: e4c850a6e750 ("HID: hid-oxp: Add Button Mapping Interface")
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
> ---
>   drivers/hid/hid-oxp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index d2ded6b..3f2be80 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -607,9 +607,9 @@ static void oxp_set_defaults_bmap_2(struct oxp_bmap_page_2 *bmap)
>   	bmap->btn_dright.button_idx = BUTTON_DRIGHT;
>   	bmap->btn_dright.mapping_idx = 15;
>   	bmap->btn_m1.button_idx = BUTTON_M1;
> -	bmap->btn_m1.mapping_idx = 48; /* KEY_F15 */
> +	bmap->btn_m1.mapping_idx = 47; /* KEY_F15 */
>   	bmap->btn_m2.button_idx = BUTTON_M2;
> -	bmap->btn_m2.mapping_idx = 49; /* KEY_F16 */
> +	bmap->btn_m2.mapping_idx = 48; /* KEY_F16 */
>   }
>   
>   static void oxp_page_fill_data(char *buf, const struct oxp_button_idx *buttons,

I'm unable to test this patch as my OneXPlayer F1 Pro only has the RGB 
interface.
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
