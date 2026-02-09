Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6EC36827A
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770634186; cv=pass; b=GUP6zXWt5nQUh1WEB7wZSrl8cSbCYUds2p/gF8SA+k097kyr5PR+pju9jSITBQ2bO1ydqGYW2+z/uJZ6NkP/mzoSpkOmmg+aU+PdJes5eERg6nM5yJGQAbC+YYCj6j3ZOZvZZg9u1L6G1hCy5E3xMGqZS4zlUVoNzOVVOHBAehU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770634186; c=relaxed/simple;
	bh=08/7/xGSuxMbBDwIG1erXdK27DO2BwHmY91O7UVKmPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvV2aIBp/6hZmB9X2Mm+/hhko75GTTa8fbXePYpYQ7shxYOd+5yo/rM2vfcuYweWZgPmrgVIy2FnwJ6uTAxG9s5XIa9aaLG5aJ9/SfjhLiMTKP3j3GOJmJ8V5BNns8+mUtIW8jSohTL8oYgowqkQoQYGi0v16Uf3BArQJLVprTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kalN0D0P; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kalN0D0P"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-124a95e592fso1905450c88.0
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 02:49:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770634185; cv=none;
        d=google.com; s=arc-20240605;
        b=e2EHX2H7CSk3zKGrvYa3kjLfmYfZSFL3+BMY641QrB4B4s1qDeownkaMg+Xkjq6W8K
         pUi+zTagfxXMiZGutYxspVMMnVv1VFbzMG167PUJ3TYFox2eqnLKk9fH5BZm5tQf6p8Y
         JaEU1R2V8AV5nw8TRoqg2erbfyhd+JvghEAtg2f66AgnMtDMzG8ygylIGiA0skyIlF0E
         PcwN2No2YXY6b1W5O8PlwNk9eLqF7EpDqHgsnbeSi9s7PMhhLrBAEkX12SE0znr+sKAq
         IPRt1fQpbtZ0ed3B0+2XrR1qEciUTVUgD7uy8xuK/KkhI1WWCfuGzLKt44JS9Q0C0f+g
         hD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=08/7/xGSuxMbBDwIG1erXdK27DO2BwHmY91O7UVKmPA=;
        fh=+Qs9SkiSxy9GzsC2LIjIqAp63DeeGB1264Zca6bYnsw=;
        b=A5PtsqLUONGXsXMu0eUbS8aQVMR243us4+r+Vp98LRCxbXjuto9mKKtqas/U1h8dE1
         2e81Al1uPDZSnK32jKg284gv3lka487EUbA87tpkGeALDMBUm69g5bLSRQJAuQ24V6FA
         v+v5xhvd1Uie2st5ModJvwcYRqqf26IHU0Hym7yp+rZ8XGwwKdEDGa2EKQwz3PW2wMYV
         iIPYNNdyndxm8PiurdFHVMmgtXVtAIA3AZtuvkeycnrBWSHKwfJix2Z1o1pOoF4Xp3/h
         k6MJCIK+zsYzUNJKMPkfZfTAfiVbGJ7sCigAiOQ2lawKj/0xwsgRJFp3g6Ucw9nFItrJ
         LNqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770634185; x=1771238985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=08/7/xGSuxMbBDwIG1erXdK27DO2BwHmY91O7UVKmPA=;
        b=kalN0D0PkHCgsniYYvAl5fjXUT0m9MakKD1WBRMnl8t6rntLM0hDTxypm4bmaOSc/e
         56/g9S89yXUMWRDeZuyGAkJXljTsyjt/+trh0a0BkmEqTG1KPqD3VmyVtQXXTlZlCGyr
         4OLtZNW/YsvHyAZSjF0DWrEEJIdeE/6tcMqGNW7qolpgC646wXBd0CjTvhmxhFf/rhty
         plah9wcSgqiCuRS9mH6rMyntiZrS9msYn99YvjBnEJK5GyT0NSHPRNN4d/dys470fHJC
         dbkgn8TqqzA/Xd2ZMvm/UOVMWhxnPTtgZR6XEVSQDs6IZHf2Cp93giQ0rvDnSSDbO1QA
         42tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770634185; x=1771238985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08/7/xGSuxMbBDwIG1erXdK27DO2BwHmY91O7UVKmPA=;
        b=EAwf9013saX984rEiVtRrk/KjjdbgCkaVqDUfuGeN89tfRhcIl0emfcDGV++TZKdW6
         bPf/q5jnH6Tbaudg29x2D/Q73ExhzUgF1vZHfq/aXwaYerHOpU8J/o+uCVGiqzN8E/H+
         sQNXON7naArkcx9Zk75L6cG9MkobCp42tu79YF+qX6IcqUFfVUlIXtJwIGS1TqPxNikF
         rk2KFubC1aeOvo6idgIkPnS7ttQ1w8nccwU/74u2mPhBO8EF0M4bletjNxrrhLe7Fsni
         xRo6IhSo8mTcxN/kXrh0lgOof8q04WQH2oAIlv7HWcvFr7NqF6gPsiHOhXlWp9aZ8eWq
         mjJw==
X-Forwarded-Encrypted: i=1; AJvYcCUrBohfHhPtLY8gIpfbpk/jXPgstt6hZSPJj+Z50plWMn6xrKoqKQy4bkC5UQmZmI8gWBglXyTg7s36Lw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+gqNQAuijJ6V9q2RjG0iX08w8rdprN6ubNN2VSSjhq2K38nhM
	faBFizdjSF8PKgQ67rp7eXTP8b26zNC5D6T06WBSX3y8K+g5jhCmYKy95OAoa7yBS1skhLJ24V2
	F1vc+AVyRwQPWbc80ZxHqJ04zbYN07/w=
X-Gm-Gg: AZuq6aLLVYACzyzYJyzvJBAkDp41L7/hNcj9Q3zoDB6v+Tm9o+lP216O/X7h7VQTAu4
	BMbfSp7EXuWEDHvjmx8NVqt7HIkoIsWWoSjrubYIDnCJhI6K5mJ+V7JRhcn8FPlV2ztI/FvfG2R
	Nb6gasIrmwawspUKgX/LaFalcqQcr6Q2EEnRg02LzoWEXQObT31bR2OIGu7PaWjuFrWzMe9DC22
	aaxkuMn1rh1OwOWxiWVeGmtQdkVG8c16CTy5Zgf8N4vp4DfLmqaBbUSva3/vVBKcKrrx1hhfZjP
	pojlPGeYSda9RglYwQY7m9b1ynco
X-Received: by 2002:a05:7022:a9e:b0:119:e569:fbb4 with SMTP id
 a92af1059eb24-12704178c7dmr5839940c88.35.1770634185215; Mon, 09 Feb 2026
 02:49:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-usbhid-eproto-v1-1-5872c10d90bb@gmail.com> <a31763aa-77af-4e13-8708-b007ed53277c@suse.com>
In-Reply-To: <a31763aa-77af-4e13-8708-b007ed53277c@suse.com>
From: Liam Mitchell <mitchell.liam@gmail.com>
Date: Mon, 9 Feb 2026 11:49:34 +0100
X-Gm-Features: AZwV_Qg6Rf0O8QeUVCTGL44qcDTkjiWWGRpFRw6zv4HPFAeia2dGGKf9ZacJZKo
Message-ID: <CAOQ1CL5Ea7twCdqLb2YfpOCpwrydakMnhf=K-puc-SBQYOnn5g@mail.gmail.com>
Subject: Re: [PATCH] usbhid: tolerate intermittent errors
To: Oliver Neukum <oneukum@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Feb 2026 at 11:06, Oliver Neukum <oneukum@suse.com> wrote:
> On 08.02.26 18:10, Liam Mitchell wrote:
> > Modifies the usbhid error handling logic to better handle intermittent
> > errors like EPROTO, which should only need resubmission of URBs and not
> > full device reset.
> >
> > Reduces initial retry delay from 13ms to 1ms. The faster the URB is
> > resubmitted, the lower the chance that user events will be missed.
>
> in this case I have to ask the obvious question: Why wait at all?
> It would seem to me that if you have spurious or intermittent errors
> the right time to retry is immediately.

Agreed.

This patch is intentionally small because I wasn't sure if a more
comprehensive fix is wanted.

Regards,
Liam
