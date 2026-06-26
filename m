Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15625B087
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 00:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434831; cv=none; b=oBQaD39DjZJlY0g2O7+EhNX2+7XC/aOFPbrtOTp4FQbmLcJbUh9C3lYFXs2gbOOz4PyRAG4KzECDz97vTb2KM4jz2P1voCzs37sMjS8cqnSeqfeHlt1y/YTUS3HCpvu8x+dmsdRIvJ7VAuyXNEUKxbqDbUkcc8CRrCkwtrql4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434831; c=relaxed/simple;
	bh=6yrkd+f6Od2f0s6kOTu9gBsVj1K7M8+rMQ/nmU9kYuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDs7c9Hl4gCwX7n2K5KjGKGJ1CU1bKTnSnR0QUHkuSsYDLFYFRzlM0Jv1MgKKUaFVAyf9qJvvTpwHGTvcmUvQQ8pm+pjvu/Fw0ai2AnA6V/Wx9juBcFwHTzpKg7qmVghtXQRPn+bgmTxGa33229gId9m0GBTr1LbGZnl1PQOEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6YYhv4K; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6YYhv4K"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1384ebe7a10so1081174c88.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 17:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782434829; x=1783039629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAkgYZFIckmLQ72JHdZDQUywabEfED+EFNSDTArDkJw=;
        b=l6YYhv4Kzq+C7LajfngWTQAcU3HeDExKpEhE9OdhtG4BJXAWyW0hBl0t1dSTLJGhZr
         ZAe+BkohaSw1psy21Dhq0btblOFnbDA5to0XuN1uXID3VDYPuBaHWBAPM4wtBw9S+6/m
         c4pjH5+q49qcfYTetnHpZ3pLFVJs4AsNQ2ZljDxXLu2UH2f1Tb+xI6X7M7MqsUwERADF
         qULPrWLaEQsH9rqoy3Jv1OefkmryQnRVpdOxRCgCbbJ/OlnSOxnaa18iJedzqASZyEyt
         aq00OrF6Fapk6GmYkG/leAI8At6Om6D8GsHakjp4Mcgyz6bjwyUIYZck0W4zHlGyIxYI
         TYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782434829; x=1783039629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAkgYZFIckmLQ72JHdZDQUywabEfED+EFNSDTArDkJw=;
        b=NlH2N9JukUYID7IclKvu7eb83eq3wTfy6MdQkmWKLheFCLAbPAT7yL7/d/Y1XaTRvf
         jeDgk8CM8Shoi2aE4fVBK+slUg4E5NrJQwFLi8NUw/0WZ+6akm7jTxjoaiUYO1/Gqf6s
         dO4IxUCR1UwEXit2WNQ07zigLppGIu9pu6rJKluYUItxnanYVh79tc1oDlnEGQmQ58BO
         Ton1hd680n5pQNF0EwIPmrPYldBzUS/O2VS5j6kRsEya7tWx5TSAIQQZkktn5G7blJvJ
         7UPMSLfWEuUNLvRcN9qTxY7IeSPnc5kB4gzkMMSuusXb/w2yuQmU8M/41F6mktI1lnf/
         0M5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Kxf08xTC2QLH6sJqwSObWhOVjZWveeL0r/qBYhi9W0A2MnggF1tZ/YzNYJ0VO/2Qlt3e5pCm1Zs7VhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeA9YihrUNcX9RqGfX1kxYveeFh9mG2102bJFqZD8QX8cgi48z
	o4mwWnih53JXNf4BdsCgtnKLdT9dGFHjyqPxb1JQS/AJGH94CsxFiC/U
X-Gm-Gg: AfdE7ckOZ0HneOu2iRyk3mQGV7ebTjPSFbuCiEq84LAeKGX3S+Jsk7sGUqNqBL0Kw6N
	jmk9koIPEk98OoEOL5sLcl+Bl/sJYADiwBcX8NvREkVQSjc2KVrEnY90R4GnbW5j78ytHi3LdsG
	Ntr5uWp4bHUnalsV+z1vyhE7TUMEjhDmcjca36yOQxz8I2znIEHmSC+5ZSzNmXNKW1IuYwE36FW
	LBNkGtpTmG5AIztpDHnhd2C9mHhDRubw0/7iU+jbMe1U8cTajKBPKQqbepbFcKPES1refZ8cMVm
	NTFmtZvLKmlN6y868qPRsqFMebIHq+vX0eGLmZ+g8yIUensplZhbGXLCHH+nJT8cBFf2uCsl/ag
	h55hK/IkKBLuuEfetjnqchMCbDHHNqNNQ7XGmO17HHb31ziwFa86B2eiiBNiAuzuA66o4rUO/3X
	xLcwShSm0Uk4H4cuRWgdwjm2iTpFsoEJljjEzWOvs5JvNDCAVlNfr6fw==
X-Received: by 2002:a05:7023:a4b:10b0:139:dd81:70bb with SMTP id a92af1059eb24-139dd8195efmr2446115c88.30.1782434829133;
        Thu, 25 Jun 2026 17:47:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d912197bsm19501767c88.15.2026.06.25.17.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 17:47:08 -0700 (PDT)
Date: Thu, 25 Jun 2026 17:47:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: hexlabsecurity@proton.me
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
	Vincent Huang <vincent.huang@tw.synaptics.com>, linux-input@vger.kernel.org, 
	Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 0/2] (no cover subject)
Message-ID: <aj3L98m2MI9fzy8Q@google.com>
References: <20260614-b4-disp-818d6bda-v1-0-cf39a3615085@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614-b4-disp-818d6bda-v1-0-cf39a3615085@proton.me>

On Sun, Jun 14, 2026 at 12:36:10AM -0500, Bryam Vargas via B4 Relay wrote:
> From be2c4843f6145374f28edd25cef43c9373542874 Mon Sep 17 00:00:00 2001
> Message-ID: <cover.1781415009.git.hexlabsecurity@proton.me>
> From: Bryam Vargas <hexlabsecurity@proton.me>
> Date: Sun, 14 Jun 2026 00:30:09 -0500
> Subject: [PATCH 0/2] Input: synaptics-rmi4 - fix out-of-bounds keymap access on large GPIO counts
> 
> The RMI4 F3A and F30 function handlers size their GPIO/LED key map to
> min(device_gpio_count, TRACKSTICK_RANGE_END) == at most 6 entries, but
> then consume that map with the full, unclamped device-reported count in
> two places: the attention-interrupt report loop, and input->keycodemax
> (while input->keycode points at the small allocation).
> 
> A device that reports a GPIO/LED count greater than 6 therefore yields a
> key map of at most 12 bytes that is indexed up to count-1:
> 
>   - rmi_f3a_attention() / rmi_f30_attention() read gpio[led]_key_map[i]
>     out of bounds on every attention interrupt (device-triggered), and
> 
>   - the input core's default keymap ioctls bound the index only against
>     keycodemax, so EVIOCGKEYCODE reads adjacent slab memory back to user
>     space and EVIOCSKEYCODE writes a caller-controlled u16 past the
>     allocation -- a controlled out-of-bounds heap write reachable by any
>     process that can open the evdev node.
> 
> Both handlers have the same shape; F3A was copied from F30. Patch 1 fixes
> F3A, patch 2 fixes F30. The one-line fix in each sizes the key map to the
> full device count; the mapping loop is unchanged (it still populates only
> the first min(count, 6) entries, the rest stay KEY_RESERVED and are
> skipped on report), and keycodemax now matches the allocation, closing
> the interrupt and both ioctl paths.
> 
> Reproduced with KASAN on a faithful in-kernel model of each handler
> (kmalloc-16 bucket, 12-byte request, reported count = 127):
> 
>   # without the patch -- attention read path
>   BUG: KASAN: slab-out-of-bounds in rmi_f3a_attention
>   Read of size 2 ... 0 bytes to the right of allocated 12-byte region
>     ... cache kmalloc-16
> 
>   # without the patch -- EVIOCSKEYCODE write path
>   BUG: KASAN: slab-out-of-bounds ...
>   Write of size 2 ... 0 bytes to the right of allocated 12-byte region
> 
>   # with the patch (key map sized to the full count): clean
>   # benign device (reported count <= 6): clean
> 
> The full read and write splats and a 32/64-bit ASan model of the same
> geometry are available on request.

Applied the lot, thank you.

-- 
Dmitry
