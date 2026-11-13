Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531891;
	b=sXSZm/FF0NKtskoLPfIJ6Jwg7R80YcjXf7XmwOXgjZV5VVmofY8WxEk5VMpKcOiegzkz
	 wmh4n+yHgJ6qsnhzwWirZFo5cX4T0ggv9EyW/DhUWC/AJPi6FDE0KwjAewOJDlY1D1gtk
	 Go62u9W1gK+gKsqHqxlLTBO0UvHx9L4+MKsvXuit92B2eUpMJWEbaQKRlIPGydRgecAZU
	 A8dxf9ZR02PTXofdbgiFCBgWUhxIHp4OG7QMFVlAZGuQBnOL40UGEDK0YtE8yzzFI8zoq
	 gSqANjR+7WlWwOkjmLi7nPw8x9fihLG4MXeu6PRR2MLsiU7gIZkI7wkM8f18uRn0WNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=t2MxTc2Fv1MEa7Y8XQgZN4nrlh0LEBvUVZK4U5Q5+68=;
	b=RR33a1oXaCZpQeXRP/Yy1h559FOyT7RE7Wkg03mR7n6qyKQZWFopDT7lVYVzuetL0eoP
	 LJW23+jjEeUZfghMN3pHsLYapou/iHB12mUAuqFMex1YTuAgCl2myCSig+ahbg2biGgZV
	 y1nQ/f7s5oCMaWZWiCmUj3Q9svoGZZVpQj3PRFAVNXABca2fWtBdsnpDfKChCW4KdVj0q
	 wI0KD9Ah7Ep4t9XtDRwIpqc3haQMKxYa9d+g/WBRbtvCV2ZUeeGQAfqynGlyW+2QeFbNk
	 g9L56OT6HVtKoRVpomx086JqWlgM3e0KQ3DA3tnoOzPCoswkMwg68zFojcSnw165VDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bc0iTdFP;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD064606A335
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 01:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD064606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bc0iTdFP
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15dd124bbe7so876749c88.1
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 17:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794531890; x=1795136690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t2MxTc2Fv1MEa7Y8XQgZN4nrlh0LEBvUVZK4U5Q5+68=;
        b=bc0iTdFPriAHSfuJXyG6sWma8K96Nqbdgne4jcE3xSOqEA88q4Q+WzuX//6yMt6zsu
         j2JfO5Z7wB6nRAJdhZ/FKHN16lpb8Ki/wDvw7srrdSs4atwrKjmaZr4bX/o5V3eXxMIa
         io6D8CPBQ3kTT2y68/b/wrKb9fMhAiN/t3er5CNrX6vg4g96gKDGVlMlbUgn7S+Y7IHX
         sPL2usxLi4pQg6zM6Ib9doz5/njOVCcDOautj2AIpPvNZkFcCSrebjo8ftwajx9dors9
         A9x5HtFW0K5n7tRVlE4oJZtQZ97yQBO2JJf8qvf+3vhnX6bQZ9us1GUuY3lMyeB9jP1/
         KcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794531890; x=1795136690;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t2MxTc2Fv1MEa7Y8XQgZN4nrlh0LEBvUVZK4U5Q5+68=;
        b=RrwMACj3U9qn34Edcr7b6xC95aG1qQgIB2kV+6TzjwofDjE/XBoMxf1YR1Gbd0fzyr
         IISVDGXeNUdQMJp4Z3EpU9Kb71Ggps669hE7F+w3ESsE3L96sNN1DeGLYleQYXeMNY+M
         N48jwYAxZYrL0B+Y44drQkQjW7H/fKjjHFkfAxZtCgjf05JxeUo8jN7LbEz22isOJo8B
         TLFzddwYAbSPSNU+2lelgco7eDyBFxt1I6D1stF8i1LThh17Zg3Q0UlJGUEFdCIsdHLv
         6Ku4LqejUwJ5UTHsbLSTXJnucCLQiUfoUVSFftF1SxiUu0uldnWVL/6OOWYgpIfYALNo
         Z/Fw==
X-Forwarded-Encrypted: i=1; AL+hErHhRRiSEDuk7V8XDfYfBLWRaiYmnYstnqMlA8nH20jTDaTCJTeISXopGe/xNGcdTEuzG5nwTrK0bPOncg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9pj2n+DIMGdWBupZcxRNrui43QiJJfiv9SFQa9OSbpzyvsBW+w
	t1JtMTtTStP1XfixROQPjHDBMq8Qj9ocf6OiUtgRepqct6Df4ziNAhq5
X-Gm-Gg: AYBFou3DU+OF3vwXcCap9Y82O8xaSgsQIUDtAlxJgJ+ilIgbRjhuxEsNgwlyygZSo3I
	xWKoEymujfCgsqkv9K/w8xEOZnb4fUD8NtcmXOKFqWntyDbr07xeYyLNhoNLp0lJX91zmVyMQRf
	doQUlNdzYgOW11kw1DalQwzf5scp82oNVVAUBQKUgNrZxe5cSiD8kcXu8Cu4S4uGF7MLGReyWjf
	5BeXDNoc3Mv3D2hNLNuM5hD7cpXDXFAPZeI6OStH9d12yWxQuEou2QDDKJA2DLWhFrZyWSFz43M
	en30v6loSz02+dcld7Am8GNlJFNm8QjYOOr0uKxgR0E/N21eT+0D4PITIlPCs2qbquO/mmqGLi2
	3lOsdFCidTcjb5hLluViLFY/02Udpb8cAraI/wCK+1uAbJzyx/Ksv5fy6W8Ec+6+y9l/swGn1Ca
	a+NwphRUPw0gaG+IyDq21dsBJFZmhNfgUZ5p9/GXhB136T0aaL/OG1E5WoywR8NJDFIYimVTu/g
	pLno+PfYpSq/mydxmPtRDGc2fnvK4NaZASHBdFgI0b8EJ2hmYbXNyRne6cF+H/S3uftT0r/oX6o
	1O1DU3D0gm4MNt5s9j6mvrhnm6tG427yr439uL4BWZvMpd7QdnRUuTnmetmm4qFwpa/Mhp4=
X-Received: by 2002:a05:701b:45d8:20b0:14d:baf5:c419 with SMTP id a92af1059eb24-1b50308b54amr1088369c88.6.1794531889873;
        Thu, 12 Nov 2026 17:04:49 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e008sm2344725c88.6.2026.11.12.17.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:04:49 -0800 (PST)
Date: Thu, 12 Nov 2026 17:04:46 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhang Jiaxi <Z1529105815@outlook.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] Input: goodix-berlin - validate the complete IC info
 misc block
Message-ID: <avZh230CD-_-tlXG@google.com>
References: <SY5PR01MB106009B0C8D0A657BA9CC5D92A1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
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
Content-Disposition: inline
In-Reply-To: <SY5PR01MB106009B0C8D0A657BA9CC5D92A1932@SY5PR01MB10600.ausprd01.prod.outlook.com>

Hi Zhang,

On Thu, Oct 08, 2026 at 10:34:45PM +0000, Zhang Jiaxi wrote:
> From: Jiaxi Zhang <z1529105815@outlook.com>
> 
> The variable-length parameter arrays are checked while advancing the
> offset, but the final misc structure is dereferenced without checking that
> the complete structure fits in the reported IC info length. Reject a
> truncated misc block before reading its register addresses.
> 
> Extracted from the v165 source; no firmware-mode change is included.

What does this mean? What is v165 source?

> 
> Signed-off-by: Jiaxi Zhang <z1529105815@outlook.com>
> 
> ---
> The bounds payload is unchanged and reuses its successful exact-target
> object compilation. No coordinate-mode or reset/resume change is included.

I am not sure what you are trying to say here.

> 
> diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
> --- a/drivers/input/touchscreen/goodix_berlin_core.c
> +++ b/drivers/input/touchscreen/goodix_berlin_core.c
> @@ -347,6 +347,9 @@
>  	ADVANCE_LE16_PARAMS(); /* stylus_freq_num */
>  #undef ADVANCE_LE16_PARAMS
>  
> +	if (offset + sizeof(*misc) > length)
> +		goto invalid_offset;
> +
>  	misc = (struct goodix_berlin_ic_info_misc *)&data[offset];
>  	cd->touch_data_addr = le32_to_cpu(misc->touch_data_addr);
>  

-- 
Dmitry
