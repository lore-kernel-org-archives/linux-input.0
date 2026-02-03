Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236A7260F
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770089262; cv=none; b=PrvmDWvy6qLy5zC14zIm1Jb5FGWCAb56JHqWnzoeEUGvsJinQ/Gg3icAy+FyL956s1yqx6I3s6qsyLQCT4B5L8Am9kfEon4xgL8GHPSKF1mQOnZVCD5HJ5GSTZcIkCUaT6SNNAqZWzGbV3IjmfQxb/ZFTmrqR+4RNjGJwDlt66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770089262; c=relaxed/simple;
	bh=ZObqSp7rL64AZA8RD2bM18vm6vg9yJ5FjnhTfS8Q/Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IsOZf55UMJ+wUJJI0Ivu8wXpz5CAaIeplcv3ryVIESqb3y5tkmOrvrjhLIwrZQhVd15EPHTaf2PFSiTevuaNEgNVxG2OJjS3M+XpBLfgwXboxPzLXHbdz07eTdJuhzn5kIB8VwGZ7oL6B0Q0gqRpXaImu0rUMCe4pdjYbEKtgV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=o+rqobo3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="o+rqobo3"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c7146b0854so583081685a.2
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2026 19:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1770089258; x=1770694058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ud4Nf4fUHoNxgJu4FeQWF07qKkJEjuctBAxcThVHh5M=;
        b=o+rqobo3ZBwX2eBEYjZnvY4EcsIXhxiX9ks3nzGypiwZMBbqdX4R/0k1TkQGz2UJOs
         wJQjldyoJyMK1hqCEPcJDOmKzd7QLm3qpzesJCwxXOVQ9nnfhzs4ZoC3S6cTdgHXKCWF
         LI0kOMcm/xFQxTuFI96HKmbHVTy2p+bvQUbTNQgcIRk/5mJ7VSGNCqdrpUoc05VXWlFT
         N5OFmdQQUind/30IGMlqa8EtCz1tr66Cn4ucbaIg2P7Ka/eUc48b3ioshfG7bqXl46GD
         LyVxhBJokCvbbBKY5XTXcVliFelJhECYX54M+GJUKzHPRrUpV+UqwGW6Ah1wY7gPZpm9
         MBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770089258; x=1770694058;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud4Nf4fUHoNxgJu4FeQWF07qKkJEjuctBAxcThVHh5M=;
        b=rTmJitr9NnH2gmhCLMLsfT0hrQ/D+jpg/s7Fmqw/E3ZihiUTqqaDioVmAshLfawF1E
         VKCPZm0O7ABX1SVbCiRRaOKAOEyap4tRqLIDEpkcBJJaGsEbcwXksLFwd1kON62BwEPw
         blA08+rzXV7g2Bo6nP7KPxWe4+plNzBE+QMhMMFLHHRoE/yX0CWCGPczSPV1uZAuoCq2
         DzrZ//CjhMmMWY4poVTN3pX5ECTjP1kN7hsaCVoGN0YJdyO8hBRFlB5KWeZUMkIq7myy
         7ZX45pljZ1d90If64SvvmA3zFwkDizoyRCRvdp0qBzwZo3R16CsRf5rcXsyWcy9aI8wb
         MkNw==
X-Forwarded-Encrypted: i=1; AJvYcCWZN/PQYsvsyv5/YQ2phe6VcgCdc2fXQVwwiTZ1/fedplHuix2LO4gKwsNWyaI625VTD+J3waVxzy3CbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpzPbpvzwKjraVe3/mVEILm5F/u2dfLsYQCHmP8kRApHO5BCIH
	MchNxKkoE0OAKduVy5pWDnWUeQT9tvyHBO5e59x7mF7NysN4tUriLVJwlng421qCIA==
X-Gm-Gg: AZuq6aIQbkYew2eUr2p6t1/uMPUCvCscQ/VhhP2oH4IzQQRSUyoYENlCQPpn6VeT1ZD
	2W8V+fE8z/QVgzgKs0+NLXiu3w/mCzC9p1+KWGR+lNFumlHDrlyGh2shdIekOP3v3IBNLmhPH2C
	RI/OjN8A6sBPHDUPbbR5ShXZBYjCXsC0wfLkZZ03dqTAwsZrKvO0a4gDBrNxd39h5mpEqQ7CCAu
	qDtEHUxYHSAuaINJa1JJECWc1tMtgAWocHs0eBwXia9VAj5N630Ookul3skjVGez1Lih8HUnC5X
	r0apQ+W25Ev0pP0tbDUwTqLGcO5BAmtLFpCfE7QAz4JWx0kr/38cEETqqBy2OEsnaVxVr8PP8cW
	8Ri7YAlZ4Y1rjuKEdsvlzO7ftxOAx8qsQhE/lNSxrGIsHCtGqXK2S2qzbJlYwEFKNRHyeJy8P7N
	LZ/BM/wbWH1WcH
X-Received: by 2002:a05:620a:2550:b0:8c6:770c:40f9 with SMTP id af79cd13be357-8c9eb2e10a0mr1677635385a.54.1770089258242;
        Mon, 02 Feb 2026 19:27:38 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::7a0a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d61c6fsm1368352685a.47.2026.02.02.19.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 19:27:37 -0800 (PST)
Date: Mon, 2 Feb 2026 22:27:33 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Sahil Chandna <chandna.sahil@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: bentiss@kernel.org, connorbelli2003@gmail.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: asus: Add check for cancelling fn_lock_sync_work
Message-ID: <273d8509-3d2e-4686-b56f-a12c5c203291@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130155204.96831-1-chandna.sahil@gmail.com>

I just noticed this because of a related message in a different thread.

On Fri, Jan 26, 2026 at 09:22:04PM +0530, Sahil Chandna wrote:

> syzbot reported a workqueue warning where fn_lock_sync_work is cancelled
> during device removal before the work has been initialized. This can
> happen when the device is disconnected while initialization is still
> in progress.
> Fix this by initializing fn_lock_sync_work before marking fn_lock as
> enabled, and by using fn_lock as a flag in the remove path. This
> ensures cancel_work_sync() is only called for initialized work.
> 
> Fixes: f631011e36b8 ("HID: hid-asus: Implement fn lock for Asus ProArt P16")
> Reported-by: syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com
> Signed-off-by: Sahil Chandna <chandna.sahil@gmail.com>
> ---
>  drivers/hid/hid-asus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 1b9793f7c07e..bb85a36de14f 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -960,8 +960,8 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  	}
>  
>  	if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
> -		drvdata->fn_lock = true;
>  		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
> +		drvdata->fn_lock = true;
>  		asus_kbd_set_fn_lock(hdev, true);
>  	}
>  
> @@ -1343,7 +1343,7 @@ static void asus_remove(struct hid_device *hdev)
>  		cancel_work_sync(&drvdata->kbd_backlight->work);
>  	}
>  
> -	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
> +	if ((drvdata->quirks & QUIRK_HID_FN_LOCK) && drvdata->fn_lock)
>  		cancel_work_sync(&drvdata->fn_lock_sync_work);
>  
>  	hid_hw_stop(hdev);

With no synchronization between the two routines, this patch cannot 
possibly be correct.  There's nothing to prevent the CPU running 
asus_input_configured() from executing the assignment to 
drvdata->fn_lock before doing the INIT_WORK() (unless the INIT_WORK() 
call itself contains some synchronization -- but obviously the code 
shouldn't depend on that).

At the very least there should be a pair of memory barriers.  A more 
palatable substitute would be to protect both regions of code with a 
mutex.

Alan Stern
