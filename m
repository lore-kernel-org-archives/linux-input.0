Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEB6331EC3
	for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782538988; cv=none; b=TcV32EkqJcwS1OFoOZCqxVZEocnT/1Aqo+ZZ9C9Gdl8ccILGw0BtNZWzNxv2uxzCOmhYX/M0hv7II8u2fZAiBEkheEObXDLcN+c5pOXd7/gN0IXvG0wfL2vYZ1XHa3K2+Ck0mA8BNIVUJrBPAMP1ptwxXlavWVSXVjwgkunHj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782538988; c=relaxed/simple;
	bh=1AlcacmmfGnLSGC42haB1KmCNL6YGKCWUowghp+cB7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICsB7qwmAo0q0ciwr8aYgV3wmqZhlA4iJ1vSYsdFks4SzwHUakOkz7V6r2X3nexRN+8t1MUrjrKqrhGz1Pzz8CenZptSon+8huoXdY/HXIIab0KGoH/YS9EdiKDmzlvlsk2+gYhoqxrH5oH5FugDG7nAE+B2xMLXKuKZ+9/ards=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA8ZqyQ6; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA8ZqyQ6"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30e18c3e0b8so52968eec.0
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 22:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782538987; x=1783143787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqXoMKna19xGBHDnSKCZr4IKhjs+v6dxb7RGvIkniRE=;
        b=MA8ZqyQ6PSrWjZtMEprM1wH20EjXeNvxAFgNqRNBcapuRta7nxP1lFLjGyWF9qZqAv
         NR0qtZ7HQliE7M6kDc/aGIqbl7cc34kVdWralB6ny11f4nJ1ybp12BwerMX6Sd1Ws7vL
         2gKmoD47O95Jun/dLQdID7u6+QkyzLYriJADS2gpTfF7k8xUUciCXOp/iephx8dls+Np
         io1opYnfT71DmO3idkAYJ8rVUIO5HM5cPWD4wI8FILntjaenznB+XmljNEjVdjdWnkMG
         zrrvNAar38KQqLaO37l5R8pJEsxlEKDdwwuHxIGca5sNm6VCx0tVIBVQ1WxaDuOxIyRk
         eW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782538987; x=1783143787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqXoMKna19xGBHDnSKCZr4IKhjs+v6dxb7RGvIkniRE=;
        b=GU1THgJNx824OT6uXUvMoX7uixb20wlE7EYW6wv08ge6Ef4dPzOWgfv4Tjg3wKHWjb
         ExeQ2YymdzXkI2VZYx80lzyNyFTnF4uu/zIOwzD0cx7kUogQgDrw8TRtMHO/3HIkczIc
         MUYVemO1N4RENqwGy9US+BvstNUu+BUo6lMM965dtfqQnz2SGL7sJefZiQRtFzAwXqfT
         z9ebIIaSdF1heErazhr8xinT2PS8A7ROMynv5MQ/0NKnpFtqJid1EqcErZp/FSQyC0rT
         p38BjEq/u0t3+zFu+RL8x3KPlC1GxNQJmmA5CJYjDe45K5dWQ/3zsOxthSmulPVMTuWj
         u4Kw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3KftAWVEngZRDM6BqK1WI5lB2SAtwQlUSiGxFyMX2NKEmOeH7M6TlOMbBvHQPwN6OjjwjmsylK91l+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YziD0CR1/bYslul+3DvlCgpgksP3+l6t0rAxiftG4KQzrqz0UYH
	EcGb98KNzH0OxqEG+n5oJVQdKyMPm04UeSvdS6mTzPM0ZMv1FSV+YpVc
X-Gm-Gg: AfdE7ck2iLd7Vq0oeRqTH/ozoq9UWF7g/dkBFG5dCoNulJCcE3H65NQHePNAKSGM8nH
	jB9oBLRO+FlR/6nwoNXsFEDMT2Ke5CVonqaJ4Uv9DWP2wYWMJJLmegDvkqsNTNbJ1Z/3sTgEvoq
	39/W85b//jR/1BfgEgkjaNAa3E+Euvden87fUaPesjUjwWKPtOZqZzW/MN1z3xvnvq5rRgXSuoI
	4fHGHSIg5ZQufG9VW88Pq/JVRiTHeHNc++gAOs/LoHquveLOT5SWAYkIGuYicja6A+Ua/9rTcVM
	PnAJMMcweOJpcj7ujQyRU0+pFwOfUTNJmn12ToDJH8eF/s1dX1g5OlqvgOc7xXOyh+OrD0NfM8T
	whD8p2KfHJd2nLGffyoUAmwhR+OJuSZ482/L4etUlJ5nIUgaQxvsJTnMuCEvWqgQiNyfFHofMST
	kBPCBpAg0b01KRq/GuQHgQg3Pk/sHPhZBm14DhPqvUDdhXIOlZ6LMi
X-Received: by 2002:a05:7301:9e44:b0:2f5:5907:3a48 with SMTP id 5a478bee46e88-30c84d14053mr8966083eec.1.1782538986692;
        Fri, 26 Jun 2026 22:43:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e062:ec60:2d87:502])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ca5f15024sm11181432eec.17.2026.06.26.22.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:43:05 -0700 (PDT)
Date: Fri, 26 Jun 2026 22:43:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: raoxu <raoxu@uniontech.com>
Cc: James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	linux-parisc@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: gscps2 - advance receive buffer write index
Message-ID: <aj9i44uye8mHGjR2@google.com>
References: <460B5655BA580C60+20260624094739.850306-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460B5655BA580C60+20260624094739.850306-1-raoxu@uniontech.com>

On Wed, Jun 24, 2026 at 05:47:39PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> Commit 44f920069911 ("Input: gscps2 - use guard notation when
> acquiring spinlock") moved the receive loop into gscps2_read_data()
> and gscps2_report_data().
> 
> While moving the code, it preserved the writes to
> buffer[ps2port->append], but omitted the following producer index
> update from the original loop:
> 
> 	ps2port->append = (ps2port->append + 1) & BUFFER_SIZE;
> 
> As a result, append never advances. Since gscps2_report_data() only
> reports bytes while act != append, the receive buffer always appears
> empty and no keyboard or mouse data reaches the serio core.
> 
> Restore the omitted index update.
> 
> Fixes: 44f920069911 ("Input: gscps2 - use guard notation when acquiring spinlock")
> Cc: stable@vger.kernel.org # 6.13+
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Applied, thank you.

-- 
Dmitry
