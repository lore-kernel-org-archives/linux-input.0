Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B02F8EAC
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.203
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599514; cv=pass; b=rLnxWy7qh2yW5JhJZkZEj03duFxWMRNhHIofWYKV1n8SdTMzzVKS1g06kO245ZIepP2KAsb11LDXY7NUYkAuBEeOvGexo2MDxD+HLQm4wxPn9LOCiuM1pJKbB9veb1QTgjBL/eYEFulJss2T5h7jcr3mjlGULlxk8+VpT7B3y5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599514; c=relaxed/simple;
	bh=uml54LJdPXLb9Lj9vOwlme7Ptb7ND54ckXVmhxSLoVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJPTZB7/obUidwLfgP4ZqeTm9veTML2GpB6GUNEPsTuZM8sljg91SHfh+TxVgMCVhvrONCvpSvl8FQRFIuNlRMvgpPkhKACN2K+xDLEXLuM1HXWh1CqCa+2W9qk7zxUYL4BZ1xIcXqE6lAKUEreELdQ1wqXipbC8USPEZuGKhyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCCMf4u2; arc=pass smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCCMf4u2"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4c1e3be1093so1250823b6e.0
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 05:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790599511; cv=none;
        d=google.com; s=arc-20260327;
        b=IFySolILDKBS1RSo0yzwrJ0hTXLT/1SxxPLPvz+NElZQTq0at3AN/zhl1px2gmrQpi
         WfhHiY6bziWUHDFmLxJxRBNPM6vkMqPxgr0nEzwFC489Pjypv6G6xKh0FxDB9p221M96
         BFANJYKTV47ciyrp8W9HEv7XaV4Ubv7vj5BLNxwPatvVWZHRFspDhGDVQ34xZV/QzPZ3
         zslRMRI3BPis98GLU5JGfoMSukd2vF+HEYGF3cgq+XBR4gxHUK9D2QUIaUUVl/xDHGnl
         oqpB51Njd4Lcw5rCtlBmBMg1C3EVBZ30oF9gF5FdON/hlFncpt4YZ6gVGIan9EE7HZFi
         60sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uml54LJdPXLb9Lj9vOwlme7Ptb7ND54ckXVmhxSLoVg=;
        fh=775flLIK9KD2KJ6YjhubTNWqwS0Vz3SJmSe4jvuJC9E=;
        b=QTLD6apNjuAKS+6+C15yydgGFSvp9W7PMnn3z0ZC3OSWP9Icecp9oDTyBIsVW8vvpR
         e9mVSCuVTZCoceACLNY8llUHDnrcqe0JM14AylpfUtVCjmNJ0GMYLlsFb0wNbLnwry6m
         32fVFYLJsF9MaDKOfWZFQpfFpjUqNmy0Q0RxUQ7XkM2+DMv47tSzvAE1MO7UVx57swRf
         NZjGh8gmTd7RkFYLwymzGi3NaZ6399nradjVNU6TAhsDhmP9l37NA1/YeGg+8X8Q/CJ1
         u+yucOvgcxlsudjPPmEWNgkUEmDgZCFHFHb/HRqjk7HSbkT9t2jUXq2CTulIN7ORfRdP
         DRyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790599511; x=1791204311; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uml54LJdPXLb9Lj9vOwlme7Ptb7ND54ckXVmhxSLoVg=;
        b=WCCMf4u2AjHud1qCNQ0sC5XzY75zPL+xRzdxVkKDRUooLOnn/6Fi59ETIN+zeXyXK4
         0Uej8Q+ZarRRRnTVJoBUY4TRiDBFGkFvvXOrzCIdPG4c2MHYlpMYsrcOhZofI40Rt8qj
         2gs0KQY6ycDs1pH8vy96JlRoAO8nSl++eOpJUojuIrlJyj668PCdaZ+bwuMw/gElBT4q
         tUuKVEVhNvDWZDOuaYeoYKui09K2oKxKLxLtHe6vY/HMtKnQaE+QkW9e/IYjCjccN2rL
         SDIExMwB7ajK6iSCjdPdw/aNyDErSpvwFMt4P8szLZiv4fioYzoFIRtWJqfUNXK2oVNs
         cLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790599511; x=1791204311;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uml54LJdPXLb9Lj9vOwlme7Ptb7ND54ckXVmhxSLoVg=;
        b=gGWsyXN3Evle3l0GsqbRs4GkhErYnUcDYCLo5iyD+fDkAR7gM7pddmeJqB/iIiZA1U
         QfYJH7Nvw36sL586JlxO5YVcsn7HZYqQ4o3nLTfcivBpYpB/1QqTUtI7n9BTUcGcp0xE
         mzXNKetsIm/zWDkCrbTXlbtMXNJhcqIS4X2Sxh3oOj1Tr3l0CKJmGXqRucbHPBw44CjW
         fiqhoriXnkwBxHWVcg16jgPuoxVC4WMDcF22L1X2VgFXHYL2sjxUnrDsFaKSdgOgXZVz
         iyu3sl/Xzr8BTPzmooyFJX1GrtKmEjG7gPSwrNy0qZkNz8F0cHSpro7/bqx5qO67Zfkl
         fJkg==
X-Forwarded-Encrypted: i=1; AKwUvBw/jRrZF8kDqlJJYhA47ZEbdpyr4kY5KrvvzS23o3Hjb2GWK0macDee8MVfa5mYAoCxKALhpplz/dvnkA==@vger.kernel.org
X-Gm-Message-State: AFuF++mEnAzIgRpp8kBdkR4xesXVZVw7+A8ePi7uKGD3yo5bPTYDq/kN
	kL5nV05DSr9Yj6S3beUInb5P+ISccjv5V/BqoexcxBJiQ+lq33BR0rWu/06oG20/BB9T2PuPf4f
	/X1NS6lZYhpQp4onpfltIa/9OCKGu/kY=
X-Gm-Gg: AYBFou3pGf99UUZikdfXShCBUnQtEgfMahVIwCDvaTb7yIw5VlXRi4JQLQZblWu2cL0
	9YRr9aauaP1jc10UPt3CC/4Hyp0l6QVRadomiFB6B4d+eMi7CVel2Usw2vXiu5X2oVG1qEwis8n
	sO5RgWoFdvGE9iJalu7s2nTktVMMFMLL+3QJuDbWrHHVhd9vFjHy82mdPGxKKi+mR4KeAZlSJ9w
	GkD77WP57DEfpRUVFj+6ghxtx4eBpj2Z2udWMiqqZMI4uL5d3wzHQQCAx+lbLee1Mcdw8CDQdSj
	aRPcHIph4AtASR2wXKOd5rXM//FxZae812zeqZjYiHsK5KdgV9gGzTHzxIa+YxkLcMsvzXvYr37
	DD9bUMkR6r19L8WD+KW+z
X-Received: by 2002:a05:6808:4f2a:b0:4e8:92e5:db3b with SMTP id
 5614622812f47-4e8930466c9mr5061632b6e.35.1790599511413; Mon, 28 Sep 2026
 05:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANOyQmEg5abcMc-Xk6=2hQQWu9vq9wevGR3spe352QLyxsZNEw@mail.gmail.com>
 <CANOyQmGkGwSkwUj-NOKzhQ_mgapoqqoOLaqXaGAjWK8jiknarQ@mail.gmail.com> <20260928122822.JdtAHH3g@linutronix.de>
In-Reply-To: <20260928122822.JdtAHH3g@linutronix.de>
From: Jason Mike <jm5905938@gmail.com>
Date: Mon, 28 Sep 2026 20:44:59 +0800
X-Gm-Features: AclHuK85xEilyaFEaA6Ff-fETSVKq3q1FX0B6TRO8Aa1XTtbukC6Oiy0wX_0q1I
Message-ID: <CANOyQmGkfZs8z2fcDa0fN508MV2aahvq4Gg41BCxUOeMqCLONg@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: picolcd: Move output requests out of spinlocked sections
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On 2026-09-28 14:28:22 +0200, Sebastian Andrzej Siewior wrote:

> This is not limited to PREEMPT_RT.

Right, thanks for the correction. PREEMPT_RT was only the configuration
where I reproduced and tested the issue; the bug itself is not
PREEMPT_RT-specific.

> picolcd_data::lock. The important part is that the lock is a spinlock_t.
> Non-PREEMPT_RT builds should complain here, too.

Agreed. I'll update the commit message in v2 to make that explicit.
Thanks,
Aveline
