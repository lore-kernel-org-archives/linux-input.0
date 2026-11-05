Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912005;
	b=AY4rxOOO7I4s6PBvMeiSOwsV2gCcNXbNNbVDBF5qG/xQN6IBJMpmRy2Z9yKAzHSXXcM2
	 js5HnQP6R0nZJeDe3D3/QPgxnL4VK0po1vbNYuHrQeGGj4nmUrjUTDWpu5+92GxhcXoYO
	 eK6SMCCzvXyvaJPoYMVgVtmiekoR3FZUFe38wFSxWdzs2R7O5q9A+OImfmzaj1KZU0AOR
	 OkO0XBsKsLH6gu9tmDql55Rn7QpQAdn2qDE4nMm2NCq7jzujyJ2UhGpqDi8DcPxh7do2U
	 YtchC4JvChTdDLoOZncZwOMF28LUmBHF5u0LoUCQ1dVq8ILfv/+y62hU4B1fagNpNOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vyz8X2IVMnrruurpCtF0gJRtd7l1YmKPgdLWxJdXL4A=;
	b=mlzW/tv5clB2hu08C9/89UAIxovT1otIZh/KAigqeJnWXbGpReEue7rToR4cpueNi71P
	 tXvw175I//gRSdu0KIjrYhhA4jhspOfVkhklJhH2ZLcDBpHXrTD6ZHcDiBeHafF7rUDKr
	 4zRFeoBKCwzLhdw9n9BQFWBll2hymGtJiTYrr9ONlidWBDfkcd+XiAh0/wRNKy1lMmRJc
	 b5lHsKBV/TUNC9PJuAYAOYEXZ8SlLwx660HLfeCKq1D/Lw8CY3g7ZLL2fiR42oV+k+eQI
	 6mQXAW29wvzGboGyIE8wuNWNCRV9hdYd0tPix02XaOjAz4u9BZZp7T5DtXUZAWPuRcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ik3I7FnN;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9458606A328
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 20:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9458606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ik3I7FnN
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso18012085e9.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 12:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793912003; x=1794516803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vyz8X2IVMnrruurpCtF0gJRtd7l1YmKPgdLWxJdXL4A=;
        b=ik3I7FnNvyvNyXzPAbpplQApSSJoH/llqQRkI3xGINTremiplDSXi6YBQer6lGZu8c
         gX1breYwuVaY3YKYJlIy3/HHkA3zXXWuXnBz0OTL6e3kbaXi39z4hU2SfgLI7HgKmsck
         5Yrr8iY0JHBD+sTrCp4j5+Ks541puJOaiG1gymXQEuXgPq/u6pFsBJhLI7v6Mb9QhdwQ
         XXQXzpUt88RNiK28jAo7OjbW+hTwUsHMxFHE1doSx26mRvXzGTGI/8aoGVDyJ5KZb43M
         vFRyjtvfpH0BakxJyCw/diLAh94YtNoAEuOIeuT/sqk1VsIQhbx4N807HdNrm2n0/u+N
         KpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912003; x=1794516803;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vyz8X2IVMnrruurpCtF0gJRtd7l1YmKPgdLWxJdXL4A=;
        b=TJbzuV16w9z/N6S7kl8z9Y8xr4JDNce/cuvDuH7kOZZIw0AGx69+iv/yTYefQlpJ8Z
         kGxO+2yATYpx2UzUYmPU/TbGAAvKhkwSOABOhH7obMVQkinPGGA5Svbfe3i1G3XkUBop
         tWDklENQKf6Xtfwzbgq+FY74r+wSbWQTcYJT6AALRDm3++yk9UjqkZIl1XwR+lA3nJQ+
         lZtlHPDc76rWpZOY+d//64fSU98CsDYz3MHcn2X5+AMdEiCauFQjqqopcYTQ34UTttwL
         iPIl0PNHsciE7JBVhu2HM/rLTwdGTlH1I6spfnqhnunLd6sO3JfmvA9A0DIYXsOgKPKb
         c4pQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxDWLyBGPuq3pzXSKOQektsnjGkpl4fhPMNjgRplCE33O/vYcboPVkmeaED/H+vJuMNfcEqwt5WBd3+g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/+eYadOG1GEOp39x8scvpEFDN8QV0mOh+x8xfJuQKsAMPuHENI
	WanYMUZhPT6ZPOBU/z850x8cKi5WP+dkkeBC/Sg0Lr63MBwDCVcD9J9p
X-Gm-Gg: AYBFou1RdvB6Xbbnd1ijzMwAQeklo100nRtJ8N+W943QcDa8lsB67vjqbzp1zDrH5/j
	myvLNesZxUByi01wexHTbiNrnGvxVpGO73cOdge/OmpPM8eHvqqK0SeE8raVINjebgjQ4eIdSwQ
	1Mzc4xeYB0KU3ESWpwRbJmJqFkNsSY4AsUHCeATFezLIsHn63L+IJX3WecGDBHY4mqF9hVtkF4a
	Xry15NjCcxRXWaJOedIApibBK9wbvfQQnksJpO2lMfVpN4ypRCBmQFrbGtV9pJyiL9ujvhCdEGi
	Ko1eoPMzVfY07+X2Yb9GgJIbLHSbH6iuyO3uSFQR+/tqwr9oTy1WezR2sFsWIXutlvETQqjgPgm
	UPa9KOnXjbNlReiXKt9dNJHdSaenMT1s+SOgXjNIGz3gKEOIOtDP3GOzyvL/c5H7T4Q9jIYbKJG
	0oSqTRF3noME8aWhoiFgp6JrE4oTpTDHMltM521FcD/nI8jkV4idJxK6xoEQLKONBPJE2Z1rzeS
	qH6zvZ4UcKuKfgGH/jVW4gfgPls6IHuNwJ/Vj2cX0E2l73dmw/ZY+qVuvqkfh7gvVRM9c+FD06S
	2hh6Ti2L0lacMGFeKy9hu6Gkzp358cgQ0OQLU2eOE6mecEerwwN9SqVnPX00kjh7Nsax98m9gBC
	HGcx0i+hHzg==
X-Received: by 2002:a05:600c:4f81:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-4b6de69168emr4225715e9.20.1793912002832;
        Thu, 05 Nov 2026 12:53:22 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4532916f2sm167407535e9.5.2026.11.05.12.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:53:22 -0800 (PST)
Date: Thu, 5 Nov 2026 20:53:21 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com,
 morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <20261105205321.7b303231@pumpkin>
In-Reply-To: <auxrRmyg50gvP1HE@devuan>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
	<20261105112813.13210334@pumpkin>
	<auxrRmyg50gvP1HE@devuan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Nov 2026 12:49:59 +0100
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> > Personally I think that while there are issues with strlcat()
> > (mostly to do with its return value), and that there are often
> > much better (and faster - so sprintf is out) ways of getting
> > the same result, the deprecation really needs to propose a
> > sensible alternative (not inlined strlen() + strscpy()).  
> 
> One alternative would be to add strscat(), with the obvious internal
> strlen(3).  This would be a drop-in replacement, and wouldn't have the
> issues of strlcat(3) --mainly, the DoS vulnerability which is
> consequence of the return value, and also the more difficult error
> handling of doing '>=sizeof(...)' than '<0'--.

I've had thoughts of a more general function - but I've not tried to
write it.

int str_append(char *dest, size_t dest_sz, size_t dest_off, const char *src, size_t src_max_len);

Where dest_sz is usually sizeof(*dest) and the header can substitute that for
  a constant zero.
dest_off would similarly default to strlen(dest), if -ve the function would
  return that value immediately.
src_max_len would be used for an effective strnlen(src, src_max_len).

The idea would be that calls like:
	char tgt[100];
	len = str_append(tgt, 0, strscpy(tgt, src_1), src_2, 0);
would append src_1 and src_2 in tgt returning -ve on overflow.
(Further chaining would then work.)

But, as I said, I've not tried to write it or see what it would look like in use.

David
