Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CC736F437
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357873; cv=none; b=YBbeA+4GCXYq272tNsc6h7hXKJfXhYn031OjIZqZ6jynMC2tfm2AVMbjIe1004BJK3JZalCqWi3sMVSd3BVujdRxWIFiwxB7G/nAUjIjuQhsJkLF9Ke20wix/+dN9U5TvR0LTFp2VI9tWQYHun5IyDaPSza776zV8uGEHZSNq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357873; c=relaxed/simple;
	bh=0ylqJ8dbg3vKa9h1x1fhdHgq5lHNwWxKQIXM7jtdBYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYjq2g1HeeXPdMpxKf4NnZrsdi/DJ2qj3OMgchFXOJrcJuJ3hUhkt/4yzUfqXMcGULr5zeRTZ/jtnkLDZ1Qy8xlbEdhWd1swVGAydpFjM3/uG+3/qkTjVKLvbQO9vfze7zOxIwDZnSib/pfpwSbr72qhlkRX7wcl0bBBet3YrD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0a9tXVdA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0a9tXVdA"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65c5a778923so1306800a12.2
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 11:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771357870; x=1771962670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8NMx17lfk0z1vTpalGUqUAQiCsJfCCjhwGFwiUMogkg=;
        b=0a9tXVdAkxZ1E2TWZAZik0/15y69vUezzJ71GN0+DJQGKyfBYFdfVWiq/uZ4K+XqOP
         ejV26aj645l53i6XknF4fr47i6QtggLkoGdY7wgGiSfb/IPkEdIStH59fDfOTnfaHxOT
         G/cqXaz4airkcD5d3vAOtTN2Y9ds4AUKisQav3w0YtIjTV4PdpaZ+npDKO4en9HuNOF4
         ByKhuzvioh7HLfpiuHZi2T68iM7NPu5cTMEcOiA+oUqVcRTgMfQYb7uw78zA2PkgOuKZ
         FUe1FCvl+qfnQSrK/gjMPtjEuPQGfmNWKLpXwWJ8X+eXVJ6OwWwWQvYAZSLZu9pQ4edv
         CHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771357870; x=1771962670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NMx17lfk0z1vTpalGUqUAQiCsJfCCjhwGFwiUMogkg=;
        b=jGI/hiH7xRG0ggNC4RtMuHkrObQwJNUO1aO+NS+zGQtMrdwALJqNaEtWFlzcDbV0bA
         TT07pOCHtSMJJ/6YekkyGEFRcyXYtnhejIn+z0OWbsF3FnOqk8w0ryih4lmqYMdc+9nL
         QBawRSht1qbnAxp8yM1JGCd9dbSmln/kjIMHOTmQfU2Kf/sjpl9ldk28ucLZr84RC2nI
         Y4p4GkyixgsOyrtO5MG0Q2cYLygD9+ngQC9g4YOYumo7Ya4BIlao/Im4uXGelFEkG9//
         PpBuKXQjFq66qpyeinQKHjHQkDSOSQkbO33x7xXMLra1ciKNg0Mnm0iWQ3xo1rP2vkYd
         fDAw==
X-Forwarded-Encrypted: i=1; AJvYcCVSmsElPRimX0PCYHuQ5n+kmiQh/AFO5mxnRPD15ZJM9w2VOBrPK51k5tHlLseeEEYhqSoRBJaoPPtzpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjSabmMAH+pWsEbbpoMfwjbf9IwdyeI2stNyDw/V2TYgMQg8o
	KmdNk3JNEahluHfuKewI4Glsncbd9/slgCIoiCoaGNTojpC/+hKhX11SasVRsjkGwbt7aM3F+jB
	JsFAPUg==
X-Gm-Gg: AZuq6aKWrJ6Ru/KtlXai7bbjWPb3NIfOGx5doqyF4MbumtKHjD6c6sIGM8oe6l5V1Yo
	5807SaIAnfDRXv1rgwOJjFhV77hhlV9/cFbwruyMt2rzyEQVfxv/jT1YcVvM+SWkrPsLxDRnpOv
	gRcmUX0DxkQTCxc/BUbfLFGDwFlicZVY7J+4uYVnmYq8moG9BuHsu/JiyL5+B9Rh7nMlrnuLTyg
	OtBJhB5sYHBVDpH/+yKsYK9JNuwyJUP68hTQynG3vgwwkGcM9D3r2gDS9G/tdVD0kb7J0+YUBSU
	D8C5MAnlCq1E585G0deLUieVHwQIDqHmSNyoj7301+CrhPg6h6OhIMT7GNYA07U9N6vBwTuayvR
	fPgZiOmXW0dFaBlWmbcTV7s7j2QvtwlysmaKIiQ2rq4HWO+/nLX1Y/iWIqPMfbKEsBwtnaVn1V+
	VbxUyZl6FeEWlDU6FnZPNdgQHrOnpnLh/K/CYzHnHOgWlVuMXlp45AHQ==
X-Received: by 2002:a05:6402:5213:b0:64b:58c0:a393 with SMTP id 4fb4d7f45d1cf-65bc7a7f68dmr6607873a12.30.1771357870145;
        Tue, 17 Feb 2026 11:51:10 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:8d29:f905:4a47:1dbf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29d471sm2705392a12.9.2026.02.17.11.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 11:51:09 -0800 (PST)
Date: Tue, 17 Feb 2026 20:51:04 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] HID: asus: avoid memory leak in asus_report_fixup()
Message-ID: <aZTGqC1xHLBwpjUS@google.com>
References: <20260217160125.1097578-1-gnoack@google.com>
 <20260217160125.1097578-4-gnoack@google.com>
 <aZSzASB_TC2RyQsR@plouf>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZSzASB_TC2RyQsR@plouf>

Hello!

On Tue, Feb 17, 2026 at 07:31:23PM +0100, Benjamin Tissoires wrote:
> On Feb 17 2026, Günther Noack wrote:
> > The asus_report_fixup() function was allocating a new buffer with kmemdup()
> > when growing the report descriptor but never freeing it.  Switch to
> > devm_kzalloc() to ensure the memory is managed and freed automatically when
> > the device is removed.
> 
> Actually this one is even worse: you can't use devm_kzalloc because
> hid-core.c will later call kfree(dev->rdesc) if dev->rdesc is different
> from the one provided by the low level driver. So we are going to have
> a double free.

The buffer returned by report_fixup() is duplicated first before
hid-core stores it in dev->rdesc.  The pointer that report_fixup()
returns is not managed by the caller.

I elaborated in the response to the other patch in [1].  You can see
it in the source code in the position marked with (4).

[1] https://lore.kernel.org/all/aZTEnPEHcWEkoTJR@google.com/


> I really wonder if this was ever tested.

I only convinced myself by staring at the code, because I do not
happen to have the matching USB devices here.  What it your usual
approach to verifying such changes?  raw-gadget?

—Günther
