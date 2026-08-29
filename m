Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E61EB19B
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787999607; cv=none; b=qyGobSYgdql/0sMf+jwkYRzfGtmxC3ASrZc5T22CQRRiVRbHS5iGjtxcw0cuJUAAnd7XO0TpnhHsRnzAQWwvTYheGn9ezHkISvaCS1mLOvGbqC39R54LU7I8GXCjZgRvuv+oyctWHXlLkfrIpzmb4QQlq/k2UxZ2Nk2xK9ZvdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787999607; c=relaxed/simple;
	bh=rEsFU4Rhp0vY5xwnpOA5fzc7vDZCbVS7WUbVx5Pl3eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic/babzZWnl3fhmYrIZnGaBKv59FIVUz8CiVIWNVFciKuz16uAcrQ1If34gyq5tHYDXs8hlABBuWfLq+HKYgmQsKHIiR1T6WCOsN03q+25JR2M6ZhEGhJrL+QN0f3yAZ5cA8gnysqUVxImSbN3NIvKwmP+H4j0FbiE3XvyQUnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiuha5RO; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiuha5RO"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so1494890a12.0
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787999605; x=1788604405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cVHjzO5N9iwp5UaMNJvBuljJ4pYLi7BFATm0HZhB/jk=;
        b=eiuha5ROzuPj4lyEFD1MmwMisbYkMiNWQDLy5oUN0Br1G8jTUTnnWZXlrcCg7y0sAs
         SI7W0GvCryoY3ZREcmfehtX8ZOiR59hShmgngKoBpBnAvHwu4q6LOTEThj8eh2NrDyE0
         SWL+sPLzXqn03w57rsu5VMvH+HRbasQVnPnjUGbWE1HemEYEUmgmrRXZ+yFicrA5YJGF
         jL+CBMQw1VdYTqxpfa8q1xheJ1lhgoyClcT6pqEYdFOKy74Ou5+r+mBh4lFqNdR1eA5S
         poCMSBu4R0PPd/IaUzdQBvNvqlvwHPck6aJKnLM1MGznqQyWWgtmyxNdHXfAuCMWJDDy
         h+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787999605; x=1788604405;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cVHjzO5N9iwp5UaMNJvBuljJ4pYLi7BFATm0HZhB/jk=;
        b=d4n1Zcdc0MaQ6BJzFSukP0y97n5g82uKSZYUFsBtyaMmZQapzzpCCeewTBD5c99Ztm
         7IcpkQLrBU2MFapr6/TjLr4wcXmZZ0Y2R3ucjSvoJaxRLUouEhQ05k+b30HK6kk0VTbG
         DR94b0kvM1dZ9i3DMqODWDix+ZaksHca55QATLul42nRxx8TdBzqT+iZvTpdvkEtcal4
         UVGNCXTP98lX63EUrwhkPLdSl14LmlvsE7c5UFxdZhQeJV2fJEtHLm4UEKIuTd0OOnWO
         U8NlPaBCRAia0a7Ff50EG0JZgb1BQGgCmvJYLPXQjJyqy5gMwOqe/3cnLRzVxwRp1feq
         FPqg==
X-Gm-Message-State: AFuF++kHmSbkW9fKkKvMrkdcTCBgvBU18PoGDQXcM94OJFl3Lcu1c6Yr
	qUA/uQvbC48+JmeEO0ev54mGuGoUjew1g3x6sDgudqHUbSeHaJl6hFvD
X-Gm-Gg: AR+sD13VvLqsOVfhXtvdMgV/aOSFvYEg8Pws3Rib3RiVSyNHoefNGvaN7bFo+ho7HUn
	eDNC2kPWIpztTMLyor1lF6f+WjwdLXBEkESb9emlec1x9OT7OgAIB1uy8LPFiSJcDrh42NFrRLd
	TRMj5bCU5P0PuHNncf6AlB3r8Fydpz9Jm3cbBHPN2jUtcKediUHBgbQCb7sEtXXcXlufJXqJfwy
	BSpr1jdArvF3X2wLG1aBWAaVofrSlJ650laFqwSPzMHGCpEOnSXELipLbAfYkq3lvSAcP8NpjwT
	vmM7i0GMxVqMeWGgsc7HgHQzmGJxKFGnioTVxr7B5fkc2YIe4SXRv3PuRYwCBjvoBl8jYzVAgA4
	F63P+dM4dEysyRjoZUQFfwqm5eGqy7OpV8ZcqlITizGvqq8m5809r9vn+vKNLO+d7ltnVGE8Yy9
	JL+7O1gJRm79kgPuRPfSBZo1RSiLZJoJyeam+D25oHRqkkDs6mPcaPqIp7JeK7T0Jh3w+t3ZDIc
	AdaOdJwULNpj8pswTyZxfyQrvKYFA==
X-Received: by 2002:a05:6a21:38e:b0:3ce:d411:8120 with SMTP id adf61e73a8af0-3d2681a9f7bmr24611034637.15.1787999605178;
        Sat, 29 Aug 2026 03:33:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:54de:b26f:8c97:cc89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e3cf8sm15322640eec.24.2026.08.29.03.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 03:33:24 -0700 (PDT)
Date: Sat, 29 Aug 2026 03:33:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] Input: atkbd - fix uaf in atkbd_set_repeat_rate
Message-ID: <apK03L7Li2TkOMOu@google.com>
References: <20260828162211.149899-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828162211.149899-1-jeffinphilip14@gmail.com>

Hi Jeffin,

On Fri, Aug 28, 2026 at 09:52:11PM +0530, Jeffin Philip wrote:
> atkbd_disable() marks atkbd as disabled to prevent any work
> event to be executed, however this can race with atkbd_event_work().
> If a pending work passes the atkbd->enabled check and atkbd_disable()
> runs after in disconnect, it could dereference dev which is freed in
> disconnect following atkbd being marked disabled. Fix this by adding
> disable_delayed_work_sync() which drops all work events preventing
> any rescheduling after atkbd is marked disabled.
> 
> Reported-by: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1e2ef9bcb29af666b2e6
> Fixes: 0ef7a26af127 ("Input: atkbd - fix canceling event_work in disconnect")
> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
> ---
> Changelog:
>  - Changes in v3:
>      Rewrote the patch to include disable_delayed_work_sync() as per
>    Dmitry's suggestion.
>  
>  - Changes in v2:
>      Added a check for atkbd->enabled so userspace cannot queue events after
>    atkbd_disable.
> ---
>  drivers/input/keyboard/atkbd.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index 5736f4bc5a50..a92a04c005aa 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -963,15 +963,12 @@ static void atkbd_disconnect(struct serio *serio)
>  
>  	atkbd_disable(atkbd);
>  
> -	input_unregister_device(atkbd->dev);
> -
>  	/*
> -	 * Make sure we don't have a command in flight.
> -	 * Note that since atkbd->enabled is false event work will keep
> -	 * rescheduling itself until it gets canceled and will not try
> -	 * accessing freed input device or serio port.
> +	 * Prevent work from being rescheduled after atkbd is marked disabled
>  	 */
> -	cancel_delayed_work_sync(&atkbd->event_work);
> +	disable_delayed_work_sync(&atkbd->event_work);
> +
> +	input_unregister_device(atkbd->dev);

There is no need to move the call to input_unregister_device(). When
atkbd->disabled is true the work handler will not attempt to access
input device or serio structures. The only change that is needed is
replacing cancel_delayed_work_sync with disable_delayed_work_sync.

Thanks.

-- 
Dmitry
