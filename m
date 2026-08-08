Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B53321A1
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786216703; cv=none; b=tn499Iiyrw9WZcHJcNCT0OivP4VFVJiMcd62dqk+XdDQkb+vVH4rWMAC2HHHt3C5oUT9HnozLF9h89n9Dq771UFQHZbQTpesYtmX7EG701XP347N6xWmLUHyZ6MSjENBIGd5hKxzL1LBV8/iv9OrLGNk77bS+YwFBoTcZXVmsYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786216703; c=relaxed/simple;
	bh=kItp9Z1e8JBemDwqeOPjo5Xxl2mgPRr4PDK1h4h3tHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsE98Rh2Qt7ssO7rrPRtD7y7AI43zeu5tk2MoXRbqYFDmmIhv5pbJOy3zavgw8EuNLne/MjM+DWbeNb3cn+q1t1Ku9Yg700EbcFsi6XDxt68cTQXxwogzgMbJhIXLMBlz7SSIZAAiHYpBH18Kpou/NPdbPYKhXdSSO4VgUtxWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=p9WD2jz9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="p9WD2jz9"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c05dcdf49so6626551cf.0
        for <linux-input@vger.kernel.org>; Sat, 08 Aug 2026 12:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1786216701; x=1786821501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rLFxNt6cekVDYhRViYWogX3gp+Zn05f4HEhIaap8PSo=;
        b=p9WD2jz9Y8XSjF7q7b/0c5kuLXcOW9eHQhDt1iLfmuNZNHhtUYaeoA2SrzYShUAeCR
         GlnRUQGhWm+E/tICw3dGlo7Hd0A7SXU52JveFTAUk+sNppm0M/9bo9g6TFubOl5p0Dhl
         D+HSShuGr/kxUKMy6HwWabnZwbWhS6s0PgerapzzDfWPGQaNBQdNeIuus3iVUO4tNKo5
         rCZFC5uGXDqEQwvpbWRRaY69gk3zws1dpyUcjB4mMsIs1jWSonoszV3ysPjtOhTeLiz8
         Hft60D2o0YfcyFKvtBdRL7Be1Qb28OiDgp3HYKvZr6xeoeQmHitkUGfBGutwksNG7mDA
         acjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786216701; x=1786821501;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rLFxNt6cekVDYhRViYWogX3gp+Zn05f4HEhIaap8PSo=;
        b=p+C36JIkck5BO578KesPrgeDj3wNQLDeEoFzOhzRxQszx89E5Glmx1TJzr2MihWR5R
         tHRkeoItTp/ng9Kf7UfVBkEmWhqC2KFgxeioPWhuC0e8LfvNY66Tzg+95eyO3cPsaYfu
         zxx7F61QoFlOSbz2wIQ3PGWGwR736Wddfj1uIVQXF8F+5kv7QD1g5g6UUyCDjXFsFWkx
         GZMmtQPcggvzkcoKvAf0PfuZRlZp64z6ALf18ho2NT6QayPueytqJohy/mw75FLrfAEN
         Cn/Gl0uQ1PCsy3mv+c1YuJ3R3gh1BEHJEWpxF1GbUocF7tSEjfaXK/kEL+Bs7oY0heSo
         ZUuA==
X-Forwarded-Encrypted: i=1; AHgh+RpXpLPBchPjlM5FfeUROLL5HjZsZaJA/i/C6tkP6qa+nhpfILwdaQkvfZfBvmGDIoacsfgPga3v98O+ug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2spneVeBW370P8VoNkCkX2Sadg9JmIpQV6slmTkeguV4McPqg
	fMHSB5kHQi+8YMuhuJWXDscB2mZXuHk59AgOOObYAikKaPDImq3kl4nNGy2p/ndShQ==
X-Gm-Gg: AR+sD12KSDgY0jFHGfTe+FhzO/O8MaEUkMG6Ht8k9fZGahsFp6wf3TDD/ADYD0AjUex
	jJYdl8bI3ievRzRXEEzxVWorYvSqTPMYT3GgTueJgZt1wvv2PV4Cn1r31d5JtiPZFZeSVP/JDo8
	8/btHpYGMoHLNPihX+gHnLdGPPQRNiWJqWRLHQHMicTxV1Koe4Aczo4SdXk3inaZW8+fT7TOw8Z
	7d9MkVfGXfbnb7dEQzZP/zmQHv25jENl6PpGFcbgxdRS4Co6uXofc9D94cl2UYZp1vFTfmZQfq8
	el3SyyUUFNzUL7WsZbtHspcQx3EBUotzo4+p3DvufWLDKL2XxUJ1eYkrU6eq77SY00QE0VosP4T
	qn+rzZcCAmqgGGZC/x2mBA3r3NDTCs2ukja89elNEvBjr6AvWA12atzDFRk+FNBvp6nRx5Tgo0l
	xJTs29r2GPMdAnjqkqCNYy7b3ieORh0Tn/xGYg0X5EdbiroYq9iDJDmYqHml4O9w==
X-Received: by 2002:a05:622a:609:b0:51c:1a11:75cf with SMTP id d75a77b69052e-52ce5f7ed9emr323594671cf.7.1786216700651;
        Sat, 08 Aug 2026 12:18:20 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::dfd8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a92ff8d1sm36588246d6.25.2026.08.08.12.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 12:18:19 -0700 (PDT)
Date: Sat, 8 Aug 2026 15:18:17 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jamie Stephens <jamie.stephens@gmail.com>
Cc: Lovekesh Solanki <lovekeshsolanki00@gmail.com>, jikos@kernel.org,
	bentiss@kernel.org, regressions@lists.linux.dev,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [REGRESSION] CyberPower LE1000DG (0764:0501) USB HID regression
 on x86
Message-ID: <be3775ba-3e7f-4548-aa1b-4710711f8aed@rowland.harvard.edu>
References: <CABWMpWQiSEKMkROgKZJ6nV8GXYgr7E=-SmsatQie4eK8b3F9Xw@mail.gmail.com>
 <CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com>
 <anIhyHL4Kl-DX2G_@eggarch>
 <CABWMpWQEfycicrctrW3RD1yNf0rv1ZrioY9FcjoZZGEz4GAm_Q@mail.gmail.com>
 <CABWMpWTn3H7UKqYzr7JP9tkQCEJHsXX-F103nyyey_srn7mvHA@mail.gmail.com>
 <CABWMpWSkJgmoZACA4LYEbmsbEGJMYLyixwv2V3tZbneeKBxpWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWMpWSkJgmoZACA4LYEbmsbEGJMYLyixwv2V3tZbneeKBxpWg@mail.gmail.com>

On Sat, Aug 08, 2026 at 03:14:38PM -0400, Jamie Stephens wrote:
> I also completed the test with a separate PCIe USB controller based on
> the ASMedia ASM1042.
> 
> The UPS enumerates normally on the ASMedia controller and the kernel
> identifies it correctly as the CyberPower LE1000DG (0764:0501).
> However, on this controller the failure mode is different.
> 
> The device and HID descriptors are readable, but the 504-byte HID
> report descriptor is consistently unavailable. Ten consecutive runs
> of:
> 
>     lsusb -v -d 0764:0501
> 
> all showed:
> 
>     Report Descriptors:
>         ** UNAVAILABLE **
> 
> NUT behaves consistently with that result. usbhid-ups successfully
> opens the device and claims interface 0, but then fails while
> attempting to retrieve the HID report descriptor:
> 
>     Unable to get HID descriptor (Pipe error)
>     HID descriptor length 504
>     Unable to get Report descriptor: Resource temporarily unavailable
>     No matching HID UPS found
> 
> There are no USB disconnects or xHCI errors in dmesg. The device
> remains present and enumerated on the ASMedia controller.

What shows up in usbmon (or equivalently, Wireshark)?

Alan Stern
