Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB2729AB02
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771358946; cv=none; b=bO2kLdoQnyWGv+XNBZy7BrA9zjgaJLoLy/nRtbl+x97wGN5jRldEJErrXDfs3HUj88n3JWkPUALpqA0oJjnTgUzDAga05T0ga9vUokGgDVNPNjVjbNj89/MhK4vF4gHSQdOUBNlWRXSXdhJXKcwnro4u/p68aEpS3dJgHEMBUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771358946; c=relaxed/simple;
	bh=o0vbhrwEPUW5Jv+ySCaUz0Lh9SolmQw6jDSes2hfZz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1k8i9X50LoE4gFxibKxZF8Ny+PcqTaAWv7LP6bgadfmdS9q1rk5yQ0KgOMJgiMT2yJqSfZ8gTy50+ycQ3zOxaokq5uzpAX8xBNgW2fzf5y/OF1LtfdY10Z3kkD6WIKDoc6ChOmqk6a71h+00+3XAp6MSwt3b9YIVqHmM+G5tJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JjMJE5kG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjMJE5kG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso1157125e9.0
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 12:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771358944; x=1771963744; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pbY7O8xAwkUDKQr6iB+JZ3Qx3bRNJ6Xv4CAEj2PrjMA=;
        b=JjMJE5kG3UKDLfyDb9aJyO+OBY1yx9ROCj4j4IRJm9ghvu+K09q3LSE+U2RjwRaQM3
         0Cq3G8Dri9dxsILtbAYXT0SntZNHizvE+uBlAbZQJuP8NNDBrxSOpQ+NbV4uXTsqxVxO
         lEdd5pFRJ00mnnesNVzQiCpQ+MD3+DOHH8NBAMSrZITaYoTQwbYFJF922lIhMNVlnBqq
         w1CVIq95cJkWr+9iQGxGxUuHpW3MR8UxI7a1owq/5H4CqaTq+ffczd70W9HWRXu3Mdw6
         N3fhkQDyF4CTkj8KRAioYowQ1/kEiznDtysefQBYseGNN2KCvHd2HTin3Xh9PGkZZqP0
         48MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771358944; x=1771963744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbY7O8xAwkUDKQr6iB+JZ3Qx3bRNJ6Xv4CAEj2PrjMA=;
        b=hzpXIIDo0AXxQA56Qxwis8TL49QqHpG1Af10PD8jqwF6z539Hwcg4ERMZ28uusH4IU
         43n/qbRryOf1nSldgyGQ1CNPaBFR1yy9GXgqcoupOFNDbXUm4/h0X+JVK8N/tcDB0Wrb
         Qyw+gLHiKc3mBGJUO7/aDhmtxEOrRrUKu+0cq7fTosqh9fzaFPWkNquMXG6pCq5GgCRF
         MPxyk9PSSt5MP4d4veTV3Fg9AJfIyXOXQcmjDwFix/9NJ8m4BNhzW/xvO2bKgH6JzPSD
         nWc+g5GzqTc2Co/QxVn5e1orpmhfHZHlZam/anSTgu5BZxt4Hqnw2nxH7Rpz4KxtYrHC
         zi5g==
X-Forwarded-Encrypted: i=1; AJvYcCUVgt+QjQ9CIXe3VsWGVPbHm+TaywWsORZnvvxHzr9ZkmRgKg2sJKnrXNvHIXnsdE7IEVte1aui6NUq+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrjEsMaq50TXwaZ/jLArsqC2I0OwmXVgWsSRGOT81tTXH4zQEP
	X0nh9qFC7vLWl1MtAoQju2falDFUKFoy4DsAN1zWHkxPfEuTvYbwqS5gGKO+pQEA0wkVvVFw5KS
	IVWsPag==
X-Gm-Gg: AZuq6aLu0q1D5hsO9zi1N5goSW3S45Kb8myocmiFrLAHJOYEfK6aXkSz05Qc7BOMaaX
	8imRSBJPJGo8dI20UmxGYwSC6q5wR+ySGbmgP+EXav60ax+ud/BTGwoo1S5Pjj2n4cfy+6eBFeH
	c0UhKrQU34QlTWfRQuRUC+zJM+vsnCqTAJzS9jLr+S2scz66VS2OJ8gMQesAAT6TPNjGBSPioHR
	ejGedCymIdd/oLTLqWsO0H0kVeGGAJF9BHFnVa2tTqaGb94FzPF61Kj5GtGrohndWU6MlUJm9Ji
	OknHm1B+vg5+nZzekpSE+cHL5X1kLNJ5xpVnM0ofJh979S0d1XqsQY24MqxdDCMMmlzEmM/X9h6
	hMwlL48PFdX+PQGQc9hQrZXQs7VTCOlWj39FBpca4lRWsGXwgERVLP1TikMNYK1Me4bFEN3BaNa
	t0lwh6EXmeGN6furFHE3U9iACify8L306r7YNFQGgBogRUa7uz5x7ltg==
X-Received: by 2002:a05:600c:3e05:b0:480:4a90:1afd with SMTP id 5b1f17b1804b1-4838dbae89emr77350015e9.0.1771358943406;
        Tue, 17 Feb 2026 12:09:03 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:8d29:f905:4a47:1dbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm587397615e9.3.2026.02.17.12.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 12:09:02 -0800 (PST)
Date: Tue, 17 Feb 2026 21:08:57 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] HID: Fix some memory leaks in drivers/hid
Message-ID: <aZTK2ZLjmoUMy9of@google.com>
References: <20260217160125.1097578-1-gnoack@google.com>
 <aZS0OAaSPhX2pJ6l@plouf>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZS0OAaSPhX2pJ6l@plouf>

Hello!

On Tue, Feb 17, 2026 at 07:36:46PM +0100, Benjamin Tissoires wrote:
> On Feb 17 2026, Günther Noack wrote:
> > These patches fix a few memory leaks in HID report descriptor fixups.
> > 
> > FWIW, a good ad-hoc way to look for usages of allocation functions in
> > these is:
> > 
> >   awk '/static.*report_fixup.*/,/^}/ { print FILENAME, $0 }' drivers/hid/hid-*.c \
> >     | grep -E '(malloc|kzalloc|kcalloc|kmemdup)'
> > 
> > The devm_* variants are safe in this context, because they tie the
> > allocated memory to the lifetime of the driver.
> 
> No. Look at hid_close_report() in drivers/hid/hid-core.c.
> 
> HID still hasn't fully migrated to devm, so as a rule of thumb, if you
> change a kzalloc into a devm_kzalloc, you are getting into troubles
> unless you fix the all the kfree path.

OK, I have not verified where the devm-allocated objects get freed up.
If devm_*() is not possible here, then the drivers hid-asus.c and
hid-gembird.c have two additional memory leaks, because they do that.

$ awk '/static.*report_fixup.*/,/^}/ { print FILENAME, $0 }' drivers/hid/hid-*.c | grep -E 'alloc'
drivers/hid/hid-asus.c          new_rdesc = devm_kzalloc(&hdev->dev, new_size, GFP_KERNEL);
drivers/hid/hid-gembird.c               new_rdesc = devm_kzalloc(&hdev->dev, new_size, GFP_KERNEL);

(That is without my threee patches)


> > For transparency, I generated these commits with Gemini-CLI,
> > starting with this prompt:
> > 
> >     We are working in the Linux kernel. In the HID drivers in
> >     `drivers/hid/hid-*.c`, the `report_fixup` driver hook is a function
> >     that gets a byte buffer (with size) as input and that may modify that
> >     byte buffer, and optionally return a pointer to a new byte buffer and
> >     update the size.  The returned value is *not* memory-managed by the
> >     caller though and will not be freed subsequently.  When the
> 
> If the memory is *not* managed, why would gemini converts kzalloc into
> devm variants without changing the kfree paths????

I'm not sure I understand the question, it's not clear to me what you
mean by the "kfree paths".

I have seen usages of devm in other HID drivers and I was under the
impression that devm_* allocations would work in the HID subsystem to
allocate objects which are then freed automatically at a later point
when the device gets removed.  Is that inaccurate?


> >     `report_fixup` implementation allocates a new buffer and returns that,
> >     that will not get freed by the caller.  
> 
> This is wrong. See hid_close_report(): if the new rdesc (after fixup)
> differs from the one initially set, there is an explicit call to
> kfree().
> 
> -> there is no memleak AFAICT, and your prompt is wrong.

See my discussion in [1].  The pointer returned by report_fixup() is
immediately discarded in the position marked with (4).  This is still
in the hid_open_report() function where the leak happens.

Let me know whether this makes sense.  I'm happy to be corrected, but
so far, I still have the feeling that my reasoning is sound.

—Günther

[1] https://lore.kernel.org/all/aZTEnPEHcWEkoTJR@google.com/
