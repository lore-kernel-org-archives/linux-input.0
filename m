Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211642;
	b=as9r2LRDnl91QU7kyRvf+ND0mc5K2fsDtKA8oiMlnEb1ga1j7L7jptU/jVPL3ZDfSWiB
	 2NK/84fX4uqoUsPfx0p/7F6UAqEHaITt/mwmW4OgqfxZFvFvb47m1xnuZYANhoGzvJVHX
	 4ZJPmbEWBDgeVjyMLYBF9fRFls7/jDFNJtBPPQnRw/bA5716WGH5doFo+9Q3UDLAUoACe
	 0XfkaPnQ4Zq8E3kSr2DJiO3FOSqlzRVNRcDHfhKLfqoA3Sx4O7aFYYQ9tn7JVOstDmmU8
	 WtvNjsNWYmO+ihS1RC8lJ6oAOTvc/s5fnHNlw0mpNmSsoUudvDOCGCMxACup/SEEeMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=tSuGt5zJ2pU286bCSrjG244N3zz8YI+MYqo9ROV43xA=;
	b=krgrE85k5Zai/p+GdtdBotVjzgHTuJfR3/ki+dPLF4WNTnbfNFuVj39LXfxoWGMb2epl
	 4sezzRpLHxq9oP36lK85V6CWT9ByhKNkEKERL57Q6WgzQAUkXLM5jHIv001pBylwyIanq
	 UYK8w+B9Mky2T7ZZmbwgxWA9vWUszH4hUYja3IQ9vB8HKx+B/k/OwFWp2LEw8EHnulMgg
	 b81WlXGTuSzYeJVmxtGncmpKGM4eXVsYJmj3ffQmGfIMwo6j0+jX136jk2ZftpY0y3gXX
	 truefK1kOiyR2JhGkh8uvPdg6Y3m4bcxECc4/L8zQqn15MzQeVp0HYMD/2jXEk+TuCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RIbOmdy2;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A5606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 08:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 175A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RIbOmdy2
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15dd124bbe7so1145991c88.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 00:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794211641; x=1794816441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tSuGt5zJ2pU286bCSrjG244N3zz8YI+MYqo9ROV43xA=;
        b=RIbOmdy2ib6vKnkVWcn7VT8GORG++zi3RESLnZOwHMKnhlQzuHv6n1iDPPs0KmvGmC
         IreK21HSKKgVXbd213rMInKk2+ksnzTHAavfooHKKHqF6thg4SmrsFiMEwnVGwP5Q8f7
         wcjYIY1hvsXS38Mp113/lTQPX2mX42r+6zib4GjlOiO0X07eKZSjjWQDjrLmV2IH+0qe
         Hb5rxfCm4BM8MwKgstbByJq72QaOjIG3FkHzbGdALWcnNEY/eB8PFDoUClya1TusHafq
         RgXyVt07EqNCMSZhfIFkBPeJlBdjaWZpOa4Bkyt9RsMZNNbLKDCgP+OgZ3UAJCN62yUu
         8N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794211641; x=1794816441;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSuGt5zJ2pU286bCSrjG244N3zz8YI+MYqo9ROV43xA=;
        b=J+uJ3O6i0m8aKC47LvYL1WIH6ymQ2O0HL4N1bDog2bwYAySSQrr2mN0uW4OD0kN+E4
         sEWaLESD19me4gSEE+niD62VWnix/CODRSyOMf84fs/DGSgFu3AwLGIi9ZQIEhRSsfEh
         pUPyZpplzy2xFrN+2TFcpnikOHJDyxKGs49GlapDIS8aLwGTtNDVPErdHWXwzIpkRQ8V
         Q0V8DvgAmgoUhdXZDDzwkanE+rhnHKEd3EFcPAMY7iOXh8hCbw4MlkHn+8/qO60PIfj7
         cqXDKu9HhDtN+fWYuG/rUosmVCoDZTU6L5FN8LT18Qzc5NcGh5YCMmmnb6HVcrlLQcQz
         ZCIA==
X-Gm-Message-State: APuU4Z82TxN7X9F7eZF7+GMSjhRe4IHaZQoE+zS18CVQ27vqSQ2Hqain
	TkGvVY9DPtby1wsaDg12NdScetURuwUcHOABFPsjv6XmQyEMdekKRlMT
X-Gm-Gg: AYBFou3qOufRJmTqCbTkVy/adsGqThmJema1Hd/hEa+8XZdXg3eW5ZEVSxnrQAzmitP
	Jjv03pU8oSTlpgW7TI1rWZ/bVVxgVtewV4ACeD7GlTDxPhOH5xM5T0fnZlYQVt9u+FP41XNzcvE
	B+PMLG0tBfsAe7ToXbEd4B/LcXzbfY2Xi+vTi6KvdNv7bHvB0x6xMuUPEl11tkeNHqtvdfzLuWp
	8nQUZBacppAUJ7KfdVtnuYaSkzNCY0tHh0JgIL3ZXlzJNgpFK95DO5MdvVjpjhmmeaNCdJ8v4zn
	/ZSHyylBPw9SDR/mHK4BDqR6bg7eolGmTjPf70L0EfAp6kc3cetG5oZAf6tn0zErItsFiAXhBwY
	n916SgESpE82Pv1R28YdVtQWxsyUtr2Vnb3DGRzVOO6FSWhhbYsKB8FCgdAt9FpskvBnqVSxb4s
	5UYbnb8p+WmwaNDZQPtDMMBgGEu5qiOBjY+jSO97DO6B65TFHRiUWjnr1TbY3IurwL9HSceeh1X
	KLSt5ehGqjsWhTz76SsfQDVGP9eW6LCTvCbKBAC2+TeL92xPqAopQ+j18sW9u9GHXYniauohy+u
	w+1aM2oracSygWpVqW1+LV9C13bfru6FBjOVk9X98i80IZFLl3GI0PzjxCOwdyaWQeZ6KsjkviQ
	UkSIvBAtoufYUpw==
X-Received: by 2002:a05:7022:220a:b0:15a:2b63:a0cb with SMTP id a92af1059eb24-1b3a32c135amr6400658c88.13.1794211640937;
        Mon, 09 Nov 2026 00:07:20 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771fa200sm10691247c88.22.2026.11.09.00.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:07:20 -0800 (PST)
Date: Mon, 9 Nov 2026 00:07:17 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] Input: lpc32xx-keys - reject matrices bigger than the
 hardware has
Message-ID: <avF_I_6WkF4B7tPI@google.com>
References: <aurPvymSFACa_kXH@google.com>
 <20261106014928.328020-1-zhugl3@xiaopeng.com>
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
Content-Disposition: inline
In-Reply-To: <20261106014928.328020-1-zhugl3@xiaopeng.com>

On Fri, Nov 06, 2026 at 09:49:28AM +0800, Guanglei Zhu wrote:
> The scanner state array holds the last state of eight matrix
> columns, and the interrupt handler walks the matrix size that the
> device tree declared:
> 
> 	u8 lastkeystates[8];
> 	...
> 	for (i = 0; i < kscandat->matrix_sz; i++)
> 		lpc32xx_mod_states(kscandat, i);
> 
> The probe path only checks that rows and columns match; the
> hardware supports square matrices from 1x1 up to 8x8, but nothing
> stops a device tree from declaring more, which makes the state
> array index run past the field into the rest of the driver data -
> including the keymap pointer the same code dereferences.
> 
> Reject matrices larger than the hardware supports.
> 
> Fixes: 69690bec400e ("Input: add support for key scan interface of the LPC32xx SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Applied, thank you (but dropped stable).

-- 
Dmitry
