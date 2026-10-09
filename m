Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519CE33B6D6
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566655; cv=none; b=PPFtPE2nt36siV/e7Br6N1tccG6pdqX5Fx1sG8kI7UdzlIWFTYgve04hTQlGTplKZzOW4a+Hzx8jstHtrGCA1pEioIU/8K7+hF5M/hFTCPrI0cPaVeDyUKEcG99RPjfNtOZ6zIefSrgLVP29tE2NtR/8fXprH/7Pe+bUljPiTBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566655; c=relaxed/simple;
	bh=VFysVpEzuY8YIJW9d/0IzEmfKNAQdee0KKSzflKaTuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoniKPbK6wpEzJsZvYN1KfP/cIJg2epdp2INWao5CPiIWYVC5PfL9AMWb4I+bbTZ6v1u/8jkJf/RIe3yRQSqypkivSPUPAXsTMd8iVcRGItAVqMUtBct7WS3UNc+oao0aYF1Fap7aH1Ztun06QQ8Fgjn4DfZix8dW1i5mKXptuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZ5YjG7d; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZ5YjG7d"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e60f9af6e6so27711755ad.3
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791566653; x=1792171453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0MgP/Yvmg9WREY6HrimkIjIQqXOyMedJLEXkISSPgT0=;
        b=qZ5YjG7d7fSw7o0DMAmePRu7hcS2xZz3zqcw6tR1loygGKORjVgg7hxAlglm0alg1z
         jT5YzPV/dDEozPTHqdr2DDUwqukSxEDBiSD2dxCPZ5MoacAI1YBwAI4mCfcXzGHW/oKl
         ih2MqoAT9KZXs8+TVLSHGuNtz5ZkHVHsVRTFJRhhUI+ONXrpMHeUyQyE1mjiLl+wAOKY
         HoXee5WbjdUuauPnXNgeqMRc9Sl/6csXrsu1M8VYldmfb13B0cQdMY8GdEPd9UC+W8lS
         7pHD8fKtZ1Rin9v/6Uf4HaFpUwSjBZ4Xzx2K6iyweAtBVh4gKu1jpzi2KawGAmz0uR0B
         CAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791566653; x=1792171453;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MgP/Yvmg9WREY6HrimkIjIQqXOyMedJLEXkISSPgT0=;
        b=MuoZfb9BX9Xa3kfCYn1VVMa1Qm8tkWSyy/378vine7XaX3m4xtt4s9ZgHLEiJBFy/W
         5bt9iO2uS7iF10mud8VuzZDtM6uayuWmxst8akcI5wNzCsREtDXbZN0Eei+UJwedIbQ/
         58i7SKrD3vkotbn6VO7yM1gRrumcPc6m2LZFtn0/O/jH66D+zJ4jzr5fEbhPGaBefGqb
         Xwe5Gtax+KEoABMmFHO7TLhLQSEmK3OVAqKyVNYvIh9wjVhGwco1rD8MP2jhDX3JtZYf
         DuShNNVAWVXitqP0n7zAwYUieSqD6wXTjp1/4OC7hOH+BCaIxLUShzFhSN38VLU8xqaX
         Q7MQ==
X-Forwarded-Encrypted: i=1; AKwUvBwz1r7/c0JloQHL2nkVjA0ga4f2Yr1XIjOej77r1ktxvtot7V/P+9NMgu5X+wMGcCV3V5LMR8BiOKRdHA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLAsWEtvAxu2FnihAu5d3v1J4fLsqkOi/aPUT3DNlLR5SlsStoO
	kBZ0HMr1SH3RtXrZOyS52hpmCsxoUWNBS+iydu1ahmypPLnRFDlrvYlMI3HQZdzy
X-Gm-Gg: AYBFou3+Bjho8YWcHG787T5TcA9hW1q4vGEhT1r7tc7YXw/7YL0ADqzIG7G8K/m962o
	QpOMcBDhQ3wlUKy3BhNAkcuA14yAAtQe2QmWfTKXF+ymiCTc6wJPnIJ14RJCj85QAurQ5iOF1HE
	LVqG+ZMswA0k1A4lBcvRsESxaqqmObRp0dWCgNYQbr8hl+4h5VfnDzWySRJOZMBELvDleorYdsj
	SGyPVi2NSEaPNXtA5HxH5AQGFqK8/OvqOIoQhCfC+rT9fdXPYKnWL9H3t0K7cM7VLSP1i6GIsSE
	tltWlPkz3dqMKMJLKXaQj7cwlGipQNy3q1Lz0GaGIgKBXNMyMiNjt3aej3rlcrbLrgHx8Y3v3s/
	oLYkiRAOzXyEXmUNkgzDgkxOgqRjJQGnoR9t0qupmHV0Uc2nK90iOV4Vs6RulPshNY0dQrIKLdr
	BCTT8eS5q4yiwb1Wdd8nCSFtNaRea45Jdi3oVK/q4JF2iE3lTh9AYqprdIWR1/ujS9KFBv9Ac7y
	EFUn+u8MOIfXU2N2BbR5qMVYB4dtIpFVRVN9fR6
X-Received: by 2002:a17:902:d58f:b0:2e5:d33a:88da with SMTP id d9443c01a7336-2e842cd4632mr20971865ad.16.1791566652480;
        Fri, 09 Oct 2026 10:24:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:8725:99de:769c:1fe])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e1643sm14442125ad.70.2026.10.09.10.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:24:11 -0700 (PDT)
Date: Fri, 9 Oct 2026 10:24:08 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Haotian Zhang <vulab@iscas.ac.cn>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ville Syrjala <syrjala@sci.fi>
Subject: Re: [PATCH] Input: ati_remote2 - fix type confusion in device
 attribute handlers
Message-ID: <askiJMSDiLRTeJyX@google.com>
References: <20261009040302.3087205-1-vulab@iscas.ac.cn>
 <20261009-shapeless-silky-deer-acd3bc@quoll>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-shapeless-silky-deer-acd3bc@quoll>

On Fri, Oct 09, 2026 at 08:10:08AM +0200, Krzysztof Kozlowski wrote:
> 
> On Fri, 09 Oct 2026 12:03:02 +0800, Haotian Zhang wrote:
> > The channel_mask and mode_mask attributes are instantiated by the driver
> > core through struct usb_driver::dev_groups, so they are attached to the
> > usb_interface bound to the driver, not to the usb_device.  The four
> > show/store handlers still call to_usb_device(dev), which applies the
> > struct usb_device container_of() to a struct usb_interface::dev and thus
> > produces a bogus usb_device pointer.  usb_ifnum_to_if() reads that
> > pointer as udev->actconfig and dereferences it, and its result is passed
> > to usb_get_intfdata() without any NULL check, so reading or writing the
> > world-readable attributes can crash the kernel.
> > 
> > Use to_usb_interface(dev) so the handlers recover the interface that the
> > attributes belong to, matching the other drivers converted to dev_groups.
> > 
> > Fixes: b20d6bf8014b ("Input: ati-remote2 - use driver core to instantiate device attributes")
> > Assisted-by: DeepSeek-V4.1-Flash
> > Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> > ---
> >  drivers/input/misc/ati_remote2.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> 
> 
> 
> Multiple things here:
> 1. Your team ignored completely previous feedback.
> 
> 2. You use multiple identities with this email, thus I actually doubt we speak
>    with actual person.
> 
> 3. Finally, same feedback:
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
> 
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
> 
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.

Not sure what was wrong with previous submissions, this is first time I
see it. This fixes a valid regression that I introduced when moved
attribute registration into dev_groups and inadvertently attached it to
the wrong device instance. We could consider reverting the original
patch, but since nobody complained in 2 years I think I'll simply take
this one.

Thanks.

-- 
Dmitry
