Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359DC310645
	for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776952996; cv=none; b=K/WYpmh3UEbLAbLuvQYj3euLKIzdwx8eYUQEDVz7x821OgO9MuAQA4oug4SAHnt7MezhK8r0APxIHKZknJddpj2YZ6htVVgysWq+PqHOctDNtEMM9csR1MdlDmZ2VtTsvEDF1pMsxuon0xwc5y8ZZOf9K6xEV2as5XwIUvn5HBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776952996; c=relaxed/simple;
	bh=Q8SOwjA3n8AyY9yu3gQA97C6u632wXoMoaCNqx1RbBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMRMmXT0pfh9s2tsWS48YAmPgqcT2j8UFRoliYYeTW1Vg+12RQJziMHESgH63zZRWt3tyIB34NBsqRyWNjYS3pTA/WlarotxMNHiCJo+Jf8Irtshh6pZYaUl61PjbsYATvNI2mxvtCTPTOSxfvZYlC/8ydHCcOwIuuHzzLqHlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=nBEuW8fq; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="nBEuW8fq"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-479e7e88fb5so2342120b6e.3
        for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1776952994; x=1777557794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMzADB9T1+5NaZTwqzMz03wrHfVcsLKJ39eezIOEENQ=;
        b=nBEuW8fqquQEGxBF8+3//wlqvBXk/jexWlJ9UKvJF+HlBljYOEY0knm5CZ0RMt9uqz
         Jxsel7Q3DS5hjOyve32MLbUhYhLd/F5rl1sF8wPd3xc9X0wJUpKubMVora9rmtwRXTAv
         nItHpELImTJ5OSqH222zngzzTpn0tHil+4OFk5QVsbl8iisHwHfE4rsaAYpAERx7jXtE
         3Nwe1pV/3IxwU9EHEywygnjVB4kQTfrRjwIJ3GU6tW6MDaNOLOXfrt1f10BzfCZepFkZ
         +lj5+yvpc4wKkpgE8C6mfdYvlvD2/v5h1UFwx99Urp8g+X/U0RV8/2uIU23Abdr6ONkC
         Bj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776952994; x=1777557794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMzADB9T1+5NaZTwqzMz03wrHfVcsLKJ39eezIOEENQ=;
        b=qxK/AFvBFg05yxr+a1VnE2740RObFnggmlDh571lQKMVX3DYpAifDWwdKvPTRcdXp2
         X4rhhk+lYC2XBObpo6PojXcILiBt7HCdTO8vaKOVsp76o2EgYda2fA2kcbkT44ka+com
         L943PMeYjmaBiCoBXCxasQF9CvPg1IlFnk0dliNEwValAzQ7ZBX3plIFGE89yISxT5oC
         c4LzeoX4J0FbELwMMfDjCHt9pWryAxys4CLkOugjlB9km8LWyo1xXDbu5K483D7n3yH+
         VIX/Igs9yV4nPYJxjNC/qFVid7XofOh7Ax03LO9xjyqp229j3ko6bPPMx1TLRxJOjENd
         QLoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VRWFQxadrlFApiuVx7wk0WDfS2V65NjuRO3Bjc8U3cWBKdnwY9I8oJGOjRh/iW0Bx9oyODIOoZ9IxsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0P2cS0VmilUSyuB/Tw22HlHVWjJ7QTrpr+iYnDtTEnUXuAB0l
	skDXzdHNIkn9CbCeRo2DcsWCiyS856UkPUCYOdd5silZWVGGc1lWxrZBqBAMYeq1Pw==
X-Gm-Gg: AeBDiet/EQis5Nv6gTQQwAp+1r/+AIOE6iBw3/b6wiWeUML4BcuzgdhIcQgKFlX5INf
	RTBaCPmAAutyjoevMZppRS0FbkKKBuNRUlCnHTnMX9ZtFhHOWQq2ru8Tjz5I9jWpAdAdQi7iDYx
	ki1upitR6kw8fA16Q1LEQL+s2BZX4xH5MLinkfZsxJGZenW6u90kaMsixaYtCLLuhOZsS+RQ2zM
	2Pmagehp3yKiymjjjJ68/5vizvB8pO0whoWaEJ4t0jtEPCpCidm8DCEXiuhMIpadVdQmtWjUzWf
	6uXyPy0DSeoEIgr7fxOpxMXIGXbU2b0PDN39gJnhv3faCYQlF0t6iMhA4QiK2yU0uCOPmlbuTqU
	VCmpAJoLMFpvVZXh9SYM0JwI2jkadMi3+06FIM2mhf1KfmgX5dd63aToR3ttwUW+B8bvwp5N3uc
	qun0M+yfy6BtRjSiNUINry8RfMHE8HOUtsE/jHcVnMi+ZIFANswJ4z
X-Received: by 2002:a05:6808:e68f:b0:47b:c703:4231 with SMTP id 5614622812f47-47bc7034dc7mr558199b6e.16.1776952993794;
        Thu, 23 Apr 2026 07:03:13 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae7df88sm166304046d6.35.2026.04.23.07.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:03:12 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:03:11 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg KH <greg@kroah.com>, Eric Naim <dnaim@cachyos.org>,
	Taylor Hewetson <taylor@exponent.digital>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: usbhid: sanitize hid->uniq against non-printable
 bytes
Message-ID: <75a740e6-89af-4a2e-b3d9-9e0533c39ff3@rowland.harvard.edu>
References: <20260418025823.21767-1-taylor@exponent.digital>
 <2026041845-approve-pelvis-9845@gregkh>
 <81ef5ca0-b070-4afc-bda7-3e5a49677115@cachyos.org>
 <2026042330-underarm-reusable-effa@gregkh>
 <7312e4df-9eab-4678-bd40-ae7187a53827@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7312e4df-9eab-4678-bd40-ae7187a53827@suse.com>

On Thu, Apr 23, 2026 at 11:49:02AM +0200, Oliver Neukum wrote:
> 
> 
> On 23.04.26 11:29, Greg KH wrote:
> > On Thu, Apr 23, 2026 at 05:55:00AM +0000, Eric Naim wrote:
> > > On 4/18/26 3:14 PM, Greg KH wrote:
> 
> > > [1] https://github.com/systemd/systemd/issues/41339#issuecomment-4266429563
> > 
> > It's either up to the kernel, or every single userspace program that
> > reads the strings from a device.  Might as well do it in one place,
> > right?
> 
> No, because that puts the assumption that user space is not interested
> in what the device actually returns and uses these strings just
> for printing.
> Eg. you can no longer use this in a udev rule.

Also, the USB spec doesn't say anything about what characters are or 
aren't allowed in a string descriptor.  Anything, even a control 
character, is valid.  The kernel should not rule them and certainly 
shouldn't truncate a string descriptor.

Alan Stern
