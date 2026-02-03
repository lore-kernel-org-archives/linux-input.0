Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8A15ECCC
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120486; cv=none; b=AIUDgaSL0JgtwG7TEwV0unL+44agmTxFLaQxyAVih9y8qWfwq5YGqDCERXAD9bOgcPoOJtri0cpU9PbtJK/BeCVXbDrhPV+ONL33ux44eOuCUuyyFRLkkI5VQABGESKcmrb4L2GWodMO3O+SNShi7uUVOca99SaTlczb39jvzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120486; c=relaxed/simple;
	bh=hXd5NeN27SE1v3662vuiVByEBigqrt5CE6IzXDzaphQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecx2/xb0x2lT3xu3HDfiDfWRxZxBjtZADQ+/6pSuaHws5/jlceHHlpuLj3S5jpYmiVo10T1LZuCDAhdVRunjU+TMy3rbKzEZtFOcSv+koxnK0UiHedevjro5jmF6snFGTjK3rtS5N50GaZu7eVz+JguZmUhQIekR4SKkJ3QqDkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlYup+B/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlYup+B/"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3532aa9a77eso2596593a91.0
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 04:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770120484; x=1770725284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/4hPHfTdQWA0JGvjcKOgOEvKsRXcQ/wn/yvOWmyEsU=;
        b=HlYup+B/HgF4NMJuQiSVYT/1ivQB9jp+jlO6az9OXG/4e2DRqXQ9CUZ/uwkHod4WaN
         9UM8O4DEgLG9IzcyiTWZJxbyzc3HTA0ytJLlogR8Ber1so+EPyyknLqiVgGUT5V6GRDW
         r0MKgtXWIru5Qg+PJTyKn0dvg5X3BE1bESkYpRf/lU/NG4140cj7eY0qYO7p/1jY9i19
         Wh/OVZF76HokNJ4CNAzSP6uFjIojst+C62YInOkuSfqVQNBWdrth4LuLmFn1fiUER+wW
         TakJ/0+blW0ho/f1cIFQxqEYyOpDtEmCuZKSnAyCIiNVdhOcBOOLP4oNenNKIccx8NoZ
         xH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770120484; x=1770725284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/4hPHfTdQWA0JGvjcKOgOEvKsRXcQ/wn/yvOWmyEsU=;
        b=b2Vd+v78M874nxbzLEFTzhQF+sO8C43PUx2czLvirKzAzOHWebxijkQ3iwuG/8ZoQi
         DDzGO7kXvJItotsZ9AC0pJ2Zu8I5XGWfAJfdvcMdGTuOsmNMJBcW0juxWM18dPKiLKU/
         F/y1PYueN7nBVHAs1ErWbRT68auJmKTAnR0G4+xN3s67t16Vsu70QoC5PqYu3p6TREEr
         rx9h4Z/vTWhOWHn60Xw1yO7FftA0ztFkIN55TVVIh6FVIYw6cODVK/SxfVSDQojqnQ3J
         IZXoXEYGharLRcWuYa4BhEFhx7YdzpZcSGaPvELphhXL2aUeoDnPdC9mSmQAYJB7yuUe
         UjsA==
X-Forwarded-Encrypted: i=1; AJvYcCXsgOlKxehK7Bg9ZWgx4U0n1RXmhxYsiGKNhMIINbyp+sV+CHTn2yaeBcStmzNTq/hieQk80zWsPOXNMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyioOdxvzRApckE0OStaBEWik+hyvqnWxV/8ciIRg08kjMhMSl5
	VQety3kzue6yIJsxJN2Z3IRoUK+qPTpaJPx7h7emFVBjx6S1RXAhkOEL
X-Gm-Gg: AZuq6aLDhJqahTtGUHgPkE8JErG5cWv7JPet8lqdwrhldb6G7D6N41U63PcVLAD5esS
	pSoyYlWDFHbQgxvnuq9J9UwyZj4xWRMis94UxT7lQDAfDWmoohv8PKri4atpD65u5BPQBged1yh
	bf5Gn/ZnqGJNuABI81F4XzNJlGGDrUUbq9E5eqnVAOI5YiZefqXF67ZMBGuv2SSxkj3a9VhAUBB
	bqgd5tQ7ahMpJc1tbBvh41e7vK9RA1zWzpz60bV6R8hu4G3bWtL/IfF2xSPfuOpiqVCKzRzlcXj
	Br7Zpqi1UbejZIIDQGqoGu2X1jI43b54b7LhQnfFjDUl7pFFfCT5r4oUGvcKPG6DPvNJj1mR/cY
	fhkgrxIKVo04trZh4SprTQyITZq1i2+W8JwtxVxj4m7lKeWKB+3CbNF5FTkgRDmAR2uGZjPV9Z7
	xX88uB5sJBxTEIovToINrSx9Zd5w==
X-Received: by 2002:a17:90b:3d4d:b0:34c:9cec:dd83 with SMTP id 98e67ed59e1d1-3543b3d6641mr14334780a91.27.1770120483713;
        Tue, 03 Feb 2026 04:08:03 -0800 (PST)
Received: from chandna.localdomain ([106.222.233.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543be52017sm6826350a91.2.2026.02.03.04.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:08:03 -0800 (PST)
Date: Tue, 3 Feb 2026 17:37:47 +0530
From: Sahil Chandna <chandna.sahil@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jikos@kernel.org>, bentiss@kernel.org,
	connorbelli2003@gmail.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: asus: Add check for cancelling fn_lock_sync_work
Message-ID: <aYHlEwK19HzADcOv@chandna.localdomain>
References: <20260130155204.96831-1-chandna.sahil@gmail.com>
 <273d8509-3d2e-4686-b56f-a12c5c203291@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <273d8509-3d2e-4686-b56f-a12c5c203291@rowland.harvard.edu>

On Mon, Feb 02, 2026 at 10:27:33PM -0500, Alan Stern wrote:
>I just noticed this because of a related message in a different thread.
>
>On Fri, Jan 26, 2026 at 09:22:04PM +0530, Sahil Chandna wrote:
>
>> syzbot reported a workqueue warning where fn_lock_sync_work is cancelled
>> during device removal before the work has been initialized. This can
>> happen when the device is disconnected while initialization is still
>> in progress.
>> Fix this by initializing fn_lock_sync_work before marking fn_lock as
>> enabled, and by using fn_lock as a flag in the remove path. This
>> ensures cancel_work_sync() is only called for initialized work.
>>
>> Fixes: f631011e36b8 ("HID: hid-asus: Implement fn lock for Asus ProArt P16")
>> Reported-by: syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com
>> Signed-off-by: Sahil Chandna <chandna.sahil@gmail.com>
>> ---
>>  drivers/hid/hid-asus.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index 1b9793f7c07e..bb85a36de14f 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -960,8 +960,8 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>>  	}
>>
>>  	if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
>> -		drvdata->fn_lock = true;
>>  		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
>> +		drvdata->fn_lock = true;
>>  		asus_kbd_set_fn_lock(hdev, true);
>>  	}
>>
>> @@ -1343,7 +1343,7 @@ static void asus_remove(struct hid_device *hdev)
>>  		cancel_work_sync(&drvdata->kbd_backlight->work);
>>  	}
>>
>> -	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
>> +	if ((drvdata->quirks & QUIRK_HID_FN_LOCK) && drvdata->fn_lock)
>>  		cancel_work_sync(&drvdata->fn_lock_sync_work);
>>
>>  	hid_hw_stop(hdev);
>
>With no synchronization between the two routines, this patch cannot
>possibly be correct.  There's nothing to prevent the CPU running
>asus_input_configured() from executing the assignment to
>drvdata->fn_lock before doing the INIT_WORK() (unless the INIT_WORK()
>call itself contains some synchronization -- but obviously the code
>shouldn't depend on that).
>
>At the very least there should be a pair of memory barriers.  A more
>palatable substitute would be to protect both regions of code with a
>mutex.
>
>Alan Stern
Thanks, I will test with mutex between INIT_WORK and cancel_work
and share v2.
Regards,
Sahil
