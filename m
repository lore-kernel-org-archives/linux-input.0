Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85984245005
	for <linux-input@vger.kernel.org>; Sun,  8 Mar 2026 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772977735; cv=pass; b=sLBfaaCdyTBvGKHW6RgpyJkuibDwMuIy9Ar7fVo++TUV+89MpT/7h7lbufE/6vF+x9CtdrfglFBtRrK6wu/PJMbptY7T5ajzI9CHcU0U+PTUBUGo328U8uMpBkI1OB7MTsKtXpiyHnzxmM8nhijbZdh8xH/zVzO0oJiZskMxebo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772977735; c=relaxed/simple;
	bh=mirjZLK0sGiBRb+DxEIl2A8YjWv8pb1n1yoDr2Kl2mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXJZAcFqCpOoJdC7SMk0NAlJ8QvB3ipp0PisNKXJIAFs1NsHpogixmHzoeS4iwsXNY+DwBWjijj2wFyTMIHHZLnfSqSXkcAVHa5lDTodQHt50VjuNv6z11viJB6URzcDLNaoHDNQukzB8NMc+5bD3zZxm+V6FFhgbejzh1vCzIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH9Iqnck; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH9Iqnck"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12713e56abdso6301318c88.1
        for <linux-input@vger.kernel.org>; Sun, 08 Mar 2026 06:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772977734; cv=none;
        d=google.com; s=arc-20240605;
        b=cD49MWlZQW6yVxQv/54K8grWVFiYVLW3FqWHr1UyKmW5iNBztMCLtUshz4+1+6KrOk
         P+9j2O+0xGMs7fwBRh4q6NBgsnS/DFTTem4X+S6t+UYTWVeNnLeolQzIS5tjEigkTJpm
         iHwTdiaFhCDvZ54Uy3/LBt5qemJytSz7OzI4Xo6FdSi81/GyAE1SuOWU5jq1kNjFoNBR
         BuCcyB6IkNmrJe1Bs7tq1r/sWkXpXkK9LrE5far9Rsu+SqxoISkcbCPZ768XAJY5/8OU
         wZmXD+f0imxSv/AIXLwHHqk8iQ9EspFP67aTVwfPC4RFi9C8p3doqvH7zlj1pHgs2SQX
         p3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QDne/1iGZ6vINMaPqsRWiT5WAHOwNwL2T3qbRCbs1Aw=;
        fh=Sk4BY09Oqj6UB/q8IXvS4a9Dt8kXtKZw/Ur0pKEk600=;
        b=HLF/mTgFZHdMeXH+rTZ51IoyIQCMsNKDmsOgxl0xC/tVz/SjnxlY/q8+xKScq2M2Ja
         6XKGGlHEcslXmz9DM4o7cnpZfcsX1jdKojwbztIgf4+DOY642VqALObD6o5PHKsuCdy4
         B3YKjrQ4+vS0rkCMIUGwZP5iGWZC3M1QYPvOKtpDf5Ny/Phv44YIh6b+a4iV++FiBNnd
         7O9iM7qERkaw3TWcAttk/+u9kjMnGyfgXusZo/ED8Eei+nZrvIrRb5wDGteyZ2c+zW8l
         SN5/N6/5Uzw/gzusNkqnBvaP6F/YGxyStoQK9ggm5aSvc4eoRhFH+5JIQqdmIAZOyZvQ
         M8IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772977734; x=1773582534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QDne/1iGZ6vINMaPqsRWiT5WAHOwNwL2T3qbRCbs1Aw=;
        b=lH9Iqnck2vord1qqyvemPgVmErPHPOSlN8LHsgbXNz5FsqR2YZVsmen7ctTTiO9Icr
         faiz1D+t5jeXnVKEZd5Xr2fqrmITT/Wqmn/pOldxdoanF1ah7Acqq48nYw3rlO8/4tYY
         hWwKONkLX8tmY6pbeQoVOv5jlHmvV2D7222hkjj08d31jz8H+eyFnLDFb+CgezjauhdC
         tlGfR2z7fXY7vVKZRFRbNJz4l2xgqIaapOk0ICtMvmwUl6PGy7XpuHuw/m153IOlSLih
         Pfp3INzgt3LTpPg01MibShSGknQx0pN8FKhIOehxt4BlUeiIxIftlV5zyAIr4OhxeAJM
         Q99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772977734; x=1773582534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDne/1iGZ6vINMaPqsRWiT5WAHOwNwL2T3qbRCbs1Aw=;
        b=KUoBK1Ljwj+StHS8pSN12vKtW4DcKIffd60qOqAvr/nOpXNEqNeJnYQAWn/x6GyI0K
         WC2f6inrwJjzp4bjnp/lx76EDWfqEqHcpRzqDpfR486C3L1oF83aqhnQYjx7odqYJdMT
         gfTFoM1hP9bUXnleDM7tWTpLQywTCCPFDwdgq1m3LX5i//rp3u+ON7EyhqjD/tNs/Tdb
         8AEUaOsI8pVzjnW0sGjcsj9E5eUok4A7wds4A0E8bGZTk1WpyG2+PPWpj5orvGebs71A
         TzoQ2JP00vSWiwYeLhfpcXiiVYW9Y4h8AEbsuupbgbqrxhBmaITN6ZZ2FvuLzc4mOzYa
         LUmw==
X-Forwarded-Encrypted: i=1; AJvYcCW6wFPc+yspjB8ciSIc5nT6M1pP+7qm+Mzue243r1f+HyJOX0/E+x7AJChB9gz/4vDyOdeTNsoIM20CDw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22RV79ti9yIidqhTCG6IyicVaulDE4uyNTOpGUjRrw2zZtzOU
	b6gL38m01dNbr2RAaaCI9VPDuUFuJHxhCG4P0UlDf6uGD9mqCBLmZait9w48xXx0f3lpttTxsGJ
	y4INuj/d5DLRrbXgC1DQ7zTJjPamLzZS/9+ra
X-Gm-Gg: ATEYQzxGWZN5oToiCGxkU/56lzjGRgm3H2IzgPe03rQJ3OR0uNSh+pHUZt3GCyEf0rN
	osSxyG74pegBPI9I46Ge7Fc3CqOPo5+js7U8PAQ6MlKqmaqo0o+Xwix6GFqVZw40DR9OZz4SK8G
	cXiYZ1GeSjwkPRs9bYZpbIA53oyffQAmePcNYy7eC8f3KDw57ohRlqSguhk3BrpV0n1mPh8Hu/T
	UnO/B4HZL6cbR6hDppGx/1MgQoUJVCstojozekBp5PvR1vR6BddSgJZQihl1cpTN1+Y7FhgV9bT
	0D/XaHvCsK0yziHGRYmcD/ipkSRUBq7sJ3Bb+Hvk
X-Received: by 2002:a05:7022:60a9:b0:11e:3e9:3e92 with SMTP id
 a92af1059eb24-128bc01df9fmr4628415c88.23.1772977733480; Sun, 08 Mar 2026
 06:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307-usbhid-eproto-v2-1-e5a8abce4652@gmail.com> <6cbc6c70-8252-43d0-8701-e1613ddc769f@rowland.harvard.edu>
In-Reply-To: <6cbc6c70-8252-43d0-8701-e1613ddc769f@rowland.harvard.edu>
From: Liam Mitchell <mitchell.liam@gmail.com>
Date: Sun, 8 Mar 2026 14:48:42 +0100
X-Gm-Features: AaiRm51MocJnGriPRluzCDqmFOcXhMhT8vtS9I05YZDwfu2QUrfFVChD0B78ArQ
Message-ID: <CAOQ1CL6GcPUDw+wriKtqq05ywkuhjyi-ujp7WwFpSWgY1fV1zg@mail.gmail.com>
Subject: Re: [PATCH v2] usbhid: tolerate intermittent errors
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Mar 2026 at 23:53, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, Mar 07, 2026 at 07:57:09PM +0100, Liam Mitchell wrote:
> > Modifies usbhid error handling to tolerate intermittent protocol
> > errors, avoiding URB resubmission delay and device reset.
> >
> > ---
> > Protocol errors like EPROTO can occur randomly, sometimes frequently and are often not fixed by a device reset.
> >
> > The current error handling will only resubmit the URB after at least 13ms delay and may reset the USB device if another error occurs 1-1.5s later, regardless of error type or count.
> >
> > These delays and device resets increase the chance that input events will be missed and that users see symptoms like missed or sticky keyboard keys.
> >
> > This patch allows one protocol error per 500ms to be tolerated and have the URB re-submitted immediately.
> >
> > 500ms was chosen to be well above the error rate of a malfunctioning
> > device but low enough to be useful for users with devices noisier than
> > mine.
> >
> > Signed-off-by: Liam Mitchell <mitchell.liam@gmail.com>
> > Link: https://lore.kernel.org/linux-input/CAOQ1CL6Q+4GNy=kgisLzs0UBXFT3b02PG8t-0rPuW-Wf6NhQ6g@mail.gmail.com/
> > ---
>
> Liam, take a look at
>
>         https://bugzilla.kernel.org/show_bug.cgi?id=221184
>
> On Roman's system, these protocol errors occur fairly regularly,
> apparently caused by high system load.

Thanks Alan, I commented there.

> Do you think a better approach might be to reduce the 13-ms delay to
> just 1 or 2 ms, and perform a reset only there has been no successful
> communication for about one second?  This might perhaps be _too_ lenient
> sometimes, but I don't think such situations will arise in practice.

I would prefer to have at least the first error resubmit immediately.
I want to reduce device downtime and missed events. From that
perspective, I want to assume the error is intermittent unless we see
evidence otherwise.

The current reset logic "reset only if there has been no successful
communication for one second" is problematic because there is no sign
of successful communication if the user isn't pressing keys or moving
the mouse. Two EPROTO errors 1.4 seconds apart will trigger device
reset and 100-200ms of downtime when ideally URBs would be immediately
resubmitted with only a few ms of downtime.

Can we infer from not receiving errors that we have successful
communication? That might change the equation. If we don't receive
errors for say 10x the polling interval, can we assume it is working?

Ideally the reset is only triggered when we are very sure the device
is not working and needs it.

> The reason for having at least a small delay is to avoid getting into a
> tight resubmit/error loop in cases where the device has been unplugged.
>
> Alan Stern

This patch would only allow one immediate resubmission per window
(500ms). How costly is a URB submission? I was assuming they are
relatively cheap and even one per 100ms wouldn't cause problems.

Liam
