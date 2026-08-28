Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198246C836
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927544; cv=none; b=pX0I7/mr0aCYUAENutL4ZZBJEbjgnCdmGcytwJiq0zwWnHs3kjL/47fAzDYdy6EjmwRhMY8JRWlJ/VgS57LyrxDxN2GZTv7lcjPP8924qN0noXDuFk+zGP38wBDhrPrlVHum4DdWpDzDsmlVeJfJSB4VIXj20HSTYOm67O7zWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927544; c=relaxed/simple;
	bh=tVAN3QworqS0BnYjxRFY90si3ZSQdAxuEt8sP6MPaCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFWAJD9qyon6+vGqBnEs3S9TYb8at0Cm4qGccwEi3/wmXENHGLnsseajF7w5vj5ZCJsitNfGW95z78nxe1i9Q9JklMFMUhc3liiFcu3OPC64vc/JHMqq7f8GYxhaSvaTAPCM8/VeCZKXlJ/gnwQbWLAoOXzxKkBnnGl9BSUZeb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qyXFBUAr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyXFBUAr"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1200656a91.2
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787927540; x=1788532340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V7sf7plh19GCC7RhUSvKdPjyBhHsntHmx3sRykLziyc=;
        b=qyXFBUArHAsFbqfPXIkr4MY57tTjgPUrgA9kfFN0jL4vrxcIremVGYUowc4emskERR
         Em86rgnXi10LYKBfI9PLE4lSvjZC9ocv6AMUswp+aa7iiW5BtjkBlFsTB06h+VCRNWDp
         9Htstvpbjz8c3h13+oItHqIwWaZs8NZYtNnhhOJpm1Aq1QUBCk9duo4HrLHrWAHARbl6
         VFHA/TTmWIJQ9zuQIu8MDAeS4FeMonvNytVqj7qTA3cHcWkJNxvh7cByND2AN/5HkfdS
         l/LmoIlLXgG1xn/gBaY8DWTzptHjI/fDjpnkYDOV0SGUEkywqUYSb+1/uwjk46oV49Bk
         QNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787927540; x=1788532340;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V7sf7plh19GCC7RhUSvKdPjyBhHsntHmx3sRykLziyc=;
        b=UzyZ3ouvq+vhr3HcmWHqFX8giB2EdvNC0aOM/yerE/yLbOjPK6b9dugAvd6xzhWRv0
         S1OtRxxnchZvy1sUtXruThNajCdPE9FCiPlIdLkR1tlfA7ZgS+Uu0CBroHfsIM8ZA6yP
         n4Uq4ZWnQVxmiKwty3U+WBJSl2z4u0FZpTpJSZ5E5Eyh7UQebdNtWPZx4q3QedHQcxMM
         QYNRPGTp11XkdkcBGfSqDLigBNg1wzs0P/CjwYq25THXAn4s+qSbkJVmVOlu4RE3puVv
         UOopJdy22Nu2sVEVNr4byHvYC5jcVN/NFKNVta9ECoTJcZL1wvRHSDfEFRB5frmsUt+W
         1WLg==
X-Gm-Message-State: AFuF++kYgAlI2Bt0ghyAJuobatirpCfva2FsvwJVnLpRbfXOcF3Pk5tc
	k/6Bu9YvrYhqB3PTSLso8YXQn+HtQabcxl104sv/c3ufIiqTWBv4456n
X-Gm-Gg: AR+sD128uMdcfYxbkwhDvkuMQGEAk5h/FfpxcQH5eovMgF6msjBwiWo2kgRHIhtYgez
	fkP41V/gOUiwEp7E65Pjzc4BWiZRtryygWrmN1jyEsUwjSpUHb3rOmJiml4GbIWr+SBhSPVcfin
	sFFBYZVG8RhEtX/jsb9oqJPWnvVNnMSwTDMyrEKh8z9UuAVEDJcxP7MDVp6PljSN9WMRpP639TX
	+HYzII5sVbCxVYRAmnxNDfII3oaCfGEI9jgl5FHIJ7/mkLT1pOFMgHjze5WcGLeMnLu+jCmk7/g
	tjJLfOje7dQfacPsozgXNg4hhE+1ubHLQW0SzwFJ82BVYQucD34yongBly+2EVF/VCkJU7lZyEX
	ZrnuJwcjFsDad4pUcWNAvhjK1Kq++YL74k4XNdFFZlzuoz3X7kY1EXsgbHfu2/b4oR94agO4lym
	ADUkuUdEB2pNRxAy8DGpbR14IHAq1DrayUNSm64caPKZngmNY+Rk+qVmxbGgGNZPE+s7chvHVof
	J4eVp1VBjzvAOKCg5m7SgsECJkZtp+DVGIJm8sa
X-Received: by 2002:a17:90b:2d82:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-396d0f2f709mr16353248a91.11.1787927540236;
        Fri, 28 Aug 2026 07:32:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:590d:7e37:c87d:136d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d38207sm6514014c88.5.2026.08.28.07.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:32:18 -0700 (PDT)
Date: Fri, 28 Aug 2026 07:32:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Input: atkbd - fix UAF in atkbd_set_repeat_rate() on
 disconnect
Message-ID: <apGbjnQWWbqCLEVQ@google.com>
References: <20260828100547.120553-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828100547.120553-1-jeffinphilip14@gmail.com>

Hi Jeffin,

On Fri, Aug 28, 2026 at 03:35:47PM +0530, Jeffin Philip wrote:
> Commit 0ef7a26af127 ("Input: atkbd - fix canceling event_work in disconnect")
> moved cancel_delayed_work_sync() after input_unregister_device() on
> the premise that events may arrive until input_unregister_device returns.
> 
> However, this created a UAF as work that may have passed the
> atkbd->enabled check in atkbd_event_work() may attempt to dereference dev
> which is freed in input_unregister_device(). Reverting the commit also
> does not solve the issue as events may still come through and pass the
> enabled check as atkbd_disable() and event_work() guard with different
> locks. Fix this by closing the hardware first using serio_close()
> and then unregistering to prevent work from executing after
> input_unregister_device(). serio_close() closes the device preventing
> work from arriving. Additionally add a check for atkbd->enabled in
> atkbd_event() to prevent userspace from queuing new events after
> atkbd_disable() sets atkbd->enabled to false.

I believe the proper fix is to replace cancel_delayed_work_sync() with
disable_delayed_work_sync() to prevent rescheduling due to atkbd being
marked as disabled.

Thanks.

-- 
Dmitry
