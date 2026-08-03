Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003D312837
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774210; cv=none; b=BXYBzCgaHq45hULW+wNuF0ibvFj4dj3oa0IzvmsB62Y5LP2dp8wNPQ80ihZweqc3xSMG1N8/6iq3F2Hm75TowSO+MKEZC3rSCZcQF2hxjvirtYtWOGTEofBAcUsMOPN2nmBBkjlbGnFaVTnI0xKjAIg33VbwTYg0T3saty8ZYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774210; c=relaxed/simple;
	bh=+E+dovH20Z3BzIx6gDwowX8vcV9ujxhqvh6i4kCrDSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRzekJhXo5BXlA95IAAVZi7HL4U66xtv6Fev4PpyyA9tr5nUE9CqcwsWUpCbamCVNMD/DegFCpoBCKb8n2h4pNj46EKOTw3vRnSbfKdVK2X3rg/z3icmWe+UFSSFojkQyUEO9edZmB8uUiC3aQXBxdLLo7IH8ztCIXjiJSxs2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crWDDFtA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crWDDFtA"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8486672f03cso4040843b3a.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 09:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785774208; x=1786379008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/MCvJOFJV8ipMWE62yWISNasmONj7SWa3jUTj8zprYQ=;
        b=crWDDFtAQ2L2+KZIMLsl4mUE36nQqJBF+nI1XKUzvBo3fnqwFW3HJEeGkbKq+j1Eo9
         MVRgGpKG6QdeQLpGuleniQu+GNG76uZGSU0aPAr98qBcYjX6EIMGN15XUbJ8z6uuKl8z
         QKt3vUZ7j64gTJXfhr5pP8IKlJMILd75N1f8DAW0kIQ4FyHPxoQEZ7utnyiAmhatRizr
         7oHrhq2JvEnfWfZzEUJxzU/OPz1vjUJnCgPGHfdhA2dZK2CNq3xJc3ArjC4o9SZnO45g
         fQDggfQSvNDgJSALfCf/i6zjlUY/F9pJLpiLg1sxWkVhkeUBfuFnLOmcf2Phzo6FzBtc
         gdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774208; x=1786379008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MCvJOFJV8ipMWE62yWISNasmONj7SWa3jUTj8zprYQ=;
        b=OILclzAFn0firqoWqkuV8GdYlN+Rf8KGvwx7ioaBpRotm/3v0vPkqF4hbudxy/Yfza
         xK74w9SRNk0iBVOXxOBXkD+vu788T0thP4oz5QqizMF56C3ciDag+eG5a8jWkHrjyW5W
         RWAOZufyCCdBngaPrLHiHg99hgIH2qvWhj32chvfgLwbIBrs1bDLxzRey6eem8KwY1TF
         JzAwz2Qxq8W9ZK7wn/svTxgMB2f85CUxR9SmCwtIGmMDIZy9qYdgmEUKgvPcXdYKzcOr
         wyXwkHfnBuv9SRrT9RVzx8YSJ4CmrqOhXK5XslJYdVrMdqeH5ge5zs2lWWcJZy/Btj/5
         q9QQ==
X-Gm-Message-State: AOJu0YzFVG/sF8420vhJIWk6DGuhDwIC73uLPr/g3VHd//XbLrk8bEeW
	nNhYc2KRb5SM8Bi0CFBM1+9hKut51BIzSsCOZqmYLcJwD1xd0e+Re6o0
X-Gm-Gg: AR+sD11m+UOwFM3GzQbqGMGLQ1C/sGiJLC1mtnrXYQjQjbfvkNRBxql03N28I5zrx/p
	NMvDRQXmew1PnaKN9KGq/Q9ABN9pmSm1n6BzVLyxOIXwTYu/FLXI2ekkm5uBZX/mvJiq6O6Pxsi
	gNeSIcZFOJXSSR337uLXWxFdMUwFEuoaDeI5yX61Wv05FdAQN9QHphLIb/uPgqqYW88JMfqvHRj
	6bbIBbQ7NxeZ86tSG2V3UU2WfACT+zpeKGJZucuytXNXlBXvueynL6MxtC0uekbgLI0FFa5rLme
	9kBjn+oCIduPURyZ+LRrSg36STevWGj5iVMo7C7QHIySPC3Vz9RefdkBCSVvE+RMnYdmiixz78a
	sDVR2lqgcK1dvjBbLAi9qJoaCjwBvru/LuhHyNefTVfhyWcvRk4rOBJW37duq5PuwfvDR800X3H
	NDoCnguxSjK30FUTOfKEWWJBgh5MddkeSbKiFvaD2OYFS/l+rjgKMfX+rFu8/DK3ZbkIKNzXD53
	Z3rHwsq4iOfAUSiY+vGOzaHNEddzR4=
X-Received: by 2002:a05:6a20:6a06:b0:3c6:61b9:917c with SMTP id adf61e73a8af0-3c92a518b1emr9469376637.11.1785774208484;
        Mon, 03 Aug 2026 09:23:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e47dsm58242974eec.3.2026.08.03.09.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:23:27 -0700 (PDT)
Date: Mon, 3 Aug 2026 09:23:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Griffin Kroah-Hartman <griffin@kroah.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] Input: xpad - add safer data access framework
Message-ID: <anDAK28M7wBWtzSf@google.com>
References: <20260803-xpadone_packet_fix-v1-0-280da203f15c@kroah.com>
 <20260803-xpadone_packet_fix-v1-1-280da203f15c@kroah.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803-xpadone_packet_fix-v1-1-280da203f15c@kroah.com>

Hi Griffin,

On Mon, Aug 03, 2026 at 05:07:24PM +0200, Griffin Kroah-Hartman wrote:
> USB xpad devices could send short messages which would cause reads and
> writes outside of the data buffer.
> 
> Fix this by adding the safe_data struct and the sdata_check() function when
> accessing packet data for input events, and add the usage of this to
> xpadone_process_packet(), which was vulnerable to OOB reads/writes.
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
> ---
>  drivers/input/joystick/xpad.c | 115 ++++++++++++++++++++++++++----------------
>  1 file changed, 71 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834..c516860711a8 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -780,6 +780,24 @@ struct usb_xpad {
>  	bool delayed_init_done;
>  };
>  
> +struct safe_data {
> +	unsigned char *data;
> +	u32 len;
> +};
> +
> +/*
> + * Safe Data Check
> + *
> + * Returns the correct data when inside the array's bounds,
> + * returns 0 when accessing an out-of-bounds index.
> + */
> +static u8 sdata_check(struct safe_data *sdata, int idx)
> +{
> +	if (idx >= sdata->len)
> +		return 0;
> +	return sdata->data[idx];
> +}

I'd rather we had explicit length checks for various packets and skipped
the processing if the packet is short instead of making large number of
what can be considered repeated checks.

Thanks.

-- 
Dmitry
