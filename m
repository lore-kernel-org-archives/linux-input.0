Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204644;
	b=ge2KWpTZJe40Tduc/KCTHR9DpsFC9uPOG8mKhJWaBL2d9W18NS4/Fw0hjfuaVa4oelDe
	 yRgjLtUd97xg9Gdc2f1SkPFoV/vOnZJA1aeY820xqzKVvaO6nOQbwxhjzSyd7T70wHF8h
	 qGXyAWGSeBCdHnZUfRuM7z5kx956JPx2ApsO3QDQVNIi2qL05NtDsuQJh83Xl0Ib0J7ld
	 obaTnnD0Hig5N6aocjb+J5OhrpgFxnqvpPY6NozfT/JR7WN8wxu2HohmUfVS0/isCMsWQ
	 NsFB4snsTJRWOJU9/NJUt4eM/OS2MXVDMVPhS1uWAQneAn2MJqyCfFG6ygU91DD8K4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=mI+HbT4aq71EtzDrUXMdQBEGrhtn+iFI5nQKU1FqNt0=;
	b=esB2dwfIb/X2YU19YCFmTnxwnC3nqPOlp3EjAH4uxwbkMo3BQO938QEpmWw6KHS+n88F
	 7PCZCh2gNNl/odbRCXBLX1+MH93PlOX7+kM6+2XB/PWukyjHE2N4jTPYMPPJKVIdqCiFh
	 Wzl+d4rNH3F1LZfT03i+OrgBV5rWcJa8vDVvhbNi+cFU8ktP80c+K3JRU4JKGkhHU3oIE
	 3FWuksvwP1c4wxkMBlW2HnAxixRCmFIvBs911EwMPOXoiwNtHEP1CVi/cpN42RLqoCdcn
	 HE2lHySGq8+GS0xXfZX2G+6OuzqUTxafVP6lkKjM5N1KanJtb+CIk/PYk37OIsrg6tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kk4aT2Zd;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE5606A321
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8EE5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kk4aT2Zd
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a3c08d6928so895040c88.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204643; x=1794809443; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mI+HbT4aq71EtzDrUXMdQBEGrhtn+iFI5nQKU1FqNt0=;
        b=Kk4aT2ZdV0Y35Prc3Njr3my+xSXrsRGYS8jPHlQd21CT0ittst5Y4TBjF4zX0NBi/9
         fveCLgMKvA2FTZ8Tz1J5e4ijpIRiEIYsnNjENdxjsVj7ugFB56BF0loKV9D7plHYZgrh
         m16FZhhexjkWE1E9n/RCvCLOqwp2HD3dLjEi8mmurzkmJsnxcbRIEtFXLYxaw+jetdjB
         busNwCPHXhFMAscBDILM2P45reFSrDtyBuCFVPtfbrAsQXFtBhWgLGYuxS0mB9RcRo7n
         dbD8Tdojy98qKhMIAFb4eT2U9bqkHNJoPSeo/bgrepkVZf7+i+Z9CA+eW8GEZFZMW1mz
         XQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204643; x=1794809443;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mI+HbT4aq71EtzDrUXMdQBEGrhtn+iFI5nQKU1FqNt0=;
        b=M/048tL7TTMz0BmHRaoJkGfs4Mm+ySrSy67aPwJnl1tTtXHcH9UwO45Nsl0LD4WIFy
         BL71PMg2YgK6ddSh71l6tDffihNs7tIUtbwEcBnEAvxpPltvVOQbueqJhgCUADf8FtzD
         mibsEDvl3cgDEhqNfww4Q51LjLRBM3EyPWZYyY4BblSFiXNy7Jl0OIeURPmGuCsbZjhm
         h1imYCMAxGoGyWjuye6O0Tb3sTG2Mx2nkmiVmFR2j73iGsiUYVk2PbJ6jzB4t6P9aEUB
         SheDzPf8eSGJC3nsYs/m+KSO9fAg/cyAWW4THVZlRdRWUFY/0Kk2qMGYfW9LQqXG9G8n
         j1WQ==
X-Gm-Message-State: APuU4Z/M6EaW9Jiyl13W5ePJYI8ILKMA/FlFeiMDFyQkfJJB/L4+AE3X
	Ug0V8CE4+A4vXdnvMpH3sQ9E43Myy3JSirmH2Jagpkqt3THKNdpDYXQs
X-Gm-Gg: AYBFou122W1k153HEIc5IPsEzKAkROhIw0XS0MWIW1KutuqbIP2BZxBrF9g8gehySMQ
	9CWhyU/H9d9dtrH/FhLMS9aDsKs4k3mYQUmujJr+ePhTtvOI008xQis5IDQ42Mod2wig9NjJmdx
	cfWfH/q4Ohe8sYlDwlR4WNZ0cT7nVvb6/jP6Mbzljs/gBV+eYsks8vsmbdZVM2baEWpCbmUYrq2
	s1+Q5i7Vjd3wFQT+Zj1sSWb8D2MSK0v+8F3lSo0FjbzzN2vuDDc/fk/2z8q9XCbkppvQ7Z+r1iv
	rholC6W+SHxNu4lz9S1Ww0/xBNe+IJvQFtBUFKXYEAoeo1hggybso1vlp5wXgrLSYl6WdTiwJDe
	d7gxT+CdTboIiPhNICiRzriXkjhvP+fArFmW+3IQZnrTzqRJrrNVGng1ph9ubLQmu7nWYyJVw3M
	r0yC5yRQAxRKIWPETqnLxkb9pK5+UEkYJhcrtKCwuA/pQY5ZUC1ovZlgkPq8hKaLhUz3kShKBzH
	jq6M6fJ+a62CqlU/JgWm23JCgJc6dlbIHGfAcaYmVFgNllvxfWqQC9Sw7w1lkFqY6UsEiIhTUEh
	yZ8uHWqCTM3YN1uvKhqsq4KTiLUhVyE7CQcNPbDXvbSIH2FAs4aCv4PkoArLQyra5FKAoSZD+tB
	tqo1sfwhNHc2Yhg==
X-Received: by 2002:a05:701b:240e:b0:1a0:f970:4f5d with SMTP id a92af1059eb24-1b39fed8a01mr4887790c88.17.1794204641868;
        Sun, 08 Nov 2026 22:10:41 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e936bsm12574635c88.6.2026.11.08.22.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:10:41 -0800 (PST)
Date: Sun, 08 Nov 2026 22:10:40 -0800
Message-ID: <c0f01b2823565b5ecf0cd86a175650e1@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Gideon Heinz <gideonheinz02@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.com, bentiss@kernel.org
Subject: Re: HID: logitech-hidpp: G920 FF init fails with -110 since "move FF initialization to .input_configured()"
In-Reply-To: <CAPb1+K3ca9HdcNxF+sckhL7-Ud11k5E+1vxmzsVK=h4srC3A4A@mail.gmail.com>
References: <CAPb1+K1-pirdLGZ1wTUw26G6pvhg7rGP3QZ172ys5DB7rNCf5w@mail.gmail.com> <f37327374f65a93439c6cf0c6287a820@gmail.com> <CAPb1+K0aFMox4-FTjODmOSN7iHDXfFGq-2jGfQyXcp+X_rNioA@mail.gmail.com> <44267fc27bb527b5ea390ac53553dd7a@gmail.com> <CAPb1+K3ca9HdcNxF+sckhL7-Ud11k5E+1vxmzsVK=h4srC3A4A@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gideon,

On Fri, Nov 06, 2026 at 07:24:03AM +0100, Gideon Heinz wrote:
> Short version: your patch
> fixes the 7.3.1 init failure, and the runtime errors I saw afterwards are
> unrelated to it.
>
> To your question: the constant effect did produce force, a slow pull to
> the left for several seconds, then it stopped.
[...]
> So this is your first case (commands queued after the input device was
> closed), not the init order. Everything while fftest held the device open
> was answered normally. The init order is inverted as you expected (the
> ping comes after FF init), but it caused no problem here.
>
> I then repeated the same fftest run (play constant, exit) on stock Arch
> 7.2.11-arch1-1 with the unpatched driver, with usbmon this time (capture
> attached, wheel is dev 7 on bus 3). The same thing happens.
[...]
> So the exit-time behaviour predates
> 7.3 and isn't caused by your patch. The init order on 7.2.11 is the old
> one (ping before FF init), so the capture pair also shows the inversion.
>
> Tested-by: Gideon Heinz <gideonheinz02@gmail.com>

Thank you very much for collecting both captures and comparing against
7.2.11! That confirms both that querying G920 FF ahead of the protocol
ping during probe works cleanly on the wheel, and that the exit-time
errors are the pre-existing race where closing the evdev descriptor
stops the USB interrupt IN URB while the async FF workqueue is still
draining stop/erase commands (with each command retrying 3 x 5 seconds
while nobody is listening for replies).

While looking through hid-logitech-hidpp I ran into a handful of other
bugs and lifetime issues around G920 force feedback and device teardown,
so I am about to send out an 18-patch series with you on the To: list.
It starts with fixes marked for 7.3 and stable (including the minimal
init fix carrying your Tested-by, draining the FF workqueue before
closing the HID transport on normal input close, switching FF work item
allocation to GFP_ATOMIC, and fixing an off-by-one on hardware slot 64),
followed by the probe-time G920 FF initialization rework,
disconnect/unbind teardown fixes, and general driver cleanups.

Not everything is fixed in this first batch yet - normal fftest exit
should drain cleanly now before the IN URB is stopped, but stalls on
close or teardown can still happen when device I/O is already inactive
(for instance on driver unbind with loaded effects, or writing the range
sysfs attribute while the input device is closed) because the 3 x 5s
retry loop on timeouts and synchronous FF upload/erase handling still
need follow-up work.

When you have a chance, could you please give the series a spin on your
G920, and if anything misbehaves or regresses, ideally bisect within the
series to pinpoint which patch broke it?

Thanks.

-- 
Dmitry
