Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3175415F1F
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788021294; cv=none; b=Uuf0sMzIwzGIFyTGe0xlTOjhOUnvRQ4q9v3NoHjZfQbZy5TJDN5tXCRTxQMhVVev2LqoTt39OlhQeXm2HcmvN3EIDEM+thpaI4Ei1vIiEpBlnK9n1gDxbXXcCRXGpYU3oec0rvbWk2nQHw6i3WgDxmCwwKqi7XG6wBbzqbKIGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788021294; c=relaxed/simple;
	bh=4D9nZXAm9tLvW+Sewbt+Au+wdgNuOS3iH1O3wBuX5Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jslEZp0mfoVRcf+ZnFSCmNdNj0HMczg9WPWQ6Ud9y6AAFRM2CyPG5esRSvI8a4boRZHuwym27qN6ACxIED+aWfY3dnaQY8EJ0gnhQoBGYpk5CN2Ve7ynHd5rhqMW3tVFG7o7UPL/U8PwaQx+MK/yfL6/8miB8yJq9niihojMvSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/Qg9D+t; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/Qg9D+t"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d71ae3455aso31054775ad.1
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788021292; x=1788626092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=US8cD6b1qOpH/CBv47csfwQnjWV034hIbN8Yzufaviw=;
        b=B/Qg9D+tutMmvP1FdGyoGoGjLEOxobUVgQRnmZ7oovgWuTSa4wd1TwU+xQIIX0jUOf
         PmKCi8+zG/dofh9j8XFUfpxO49y4hodFNBBgJ7wYNlYEC1P3lrQJQ4AHDXQ+ujK0w6jD
         kC+l56fRrjE3jCPQe4aFl6HeJ25hI0Zllfc36v3mSTmw5QfdbLjd5c2aCp0HL6wJ1x5i
         +roEBNi80g+SHjcbkbksh6y3eAF/PEQ0o7A4ScOFB2ZYswz6HGb1HQgxOKxRnYOxyDm5
         XVJFXzzzwg21ChISyHe/AnUXhC0paTQGyUmybDqqEKw58lcUJFvxiv14Mbvgt0hFzD0H
         itdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788021292; x=1788626092;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=US8cD6b1qOpH/CBv47csfwQnjWV034hIbN8Yzufaviw=;
        b=JPnSlDBs3oxObrV3tVlmdI2icWs10auEF5u21sYTuYDM8yYOllYwc3z36TG0rnBVbz
         8NNiTWX8v7YRGNXe4UBXjL/PQ01y6xlAl05XhxwlxLJW5g+Yg6Hmt33jWkLNSw0uaC6Y
         +iBq5m4muH8E45B5AFFzG6cb/LIGmM/TSBYNXwfSDEDftLPF9CLbmLzH64TLjYvUxUGw
         yctLx2OftQHTaOT1K1sr3QV/Qt6ZAGyQp+xY+u6vssFUgJWqzGJPHL70GaszyLh5J2GN
         MYn87V0Ua/MbD9VwouFIq1qn02JS9XjmR4O9u3mMY395nAggN5tUlkXc2r041d6g+EFr
         LTdg==
X-Gm-Message-State: AFuF++l5LfLKSP6tgzG9ipfWl4mdtSrsgddAuEsqc76Pf4iMf/bk6A8Z
	VBz39BboP5pVbdrZwtUP41iNjqucJVQEUVKwajEa70JwZbkH4Zq/onuQ
X-Gm-Gg: AYBFou01JVz9+UNPrQPyp3qi663umX9juvGn7TDm4LQroGEz91dQCtR68D9LzRXKkTT
	PY9JSGd4RvSHlYUSvn3swWzFsOwLTrfYYTKEaaf9xuWmOaZP7LSUv7DNQNJ35hIcOKO5KuTYxdH
	QP4mF8/yjRYcE1wJntV4CUutTLVS4guH/9ITwOp8ZuOosrrx8sux8i/xbpIKuRJ+oKJ/VVzvPtj
	oIaZ4zSctWTt5rw0DC+6DK5R2sTUzBZwoi8wY/aZ1lY9+0BXLlLZ9d3uqG33YZ2zvgB5fW+S/v6
	0kJES6v8FAmkD0XnRbGF8tscz2WohNal6RH5OY7Uk/xKoBihqldHOgI3Wa/l5D6dvN0gZGQw6Ul
	M2jSjPBtkhYxcjHrrN31CAPFgbM0DL1WW52G5Qv1y1K248tagaRuC6vTvtpgH0//Hpenv+cfAyV
	JMcxaiynBqnf4He+CdkleNH2MLlH6EvJX/6gBjaBQDM+ssOII0H2zM+roGiBMYucqGt9MRJV5ii
	XvAmXy2ji7T5fVJ4LEmUkTRlsJUOg==
X-Received: by 2002:a17:902:fc4d:b0:2d8:d4cc:5bb0 with SMTP id d9443c01a7336-2d8d4cc5d79mr129510945ad.16.1788021292182;
        Sat, 29 Aug 2026 09:34:52 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:54de:b26f:8c97:cc89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f8094dasm17925741eec.13.2026.08.29.09.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:34:50 -0700 (PDT)
Date: Sat, 29 Aug 2026 09:34:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] Input: atkbd - fix uaf in atkbd_set_repeat_rate
Message-ID: <apMJ1qoPOffbB0t-@google.com>
References: <20260829135959.14882-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829135959.14882-1-jeffinphilip14@gmail.com>

On Sat, Aug 29, 2026 at 07:29:59PM +0530, Jeffin Philip wrote:
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
>  - Changed in v4:
>      Changed location of disable_pending_work_sync() after input_unregister_device()
>    as per Dmitry's suggestion.

Actually I think I was wrong and Sashiko was right. I will probably pick
your v3 but I do not like that we do not clean up/reset LEDs properly
on disconnect. I will have to think about it some more...

Thanks.

-- 
Dmitry
