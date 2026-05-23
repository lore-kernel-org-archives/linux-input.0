Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F07C4204E
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512722; cv=none; b=V6aPDxGFRf8vk5B6pvEqFpdtHEL2QwMw7oLFgCR8LpF1cYgO9FZr+GEdZbVKUuG7Pk+XqXM1m4RCZijzIkcIkcH1Z4+QCHgo0gXqGOvinbpn8HbjyTOxkeIgiL/WaZ6+WwSvIXD5SwZjrq5pB+jKmWonaNwPmLoStgL4ouBPi/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512722; c=relaxed/simple;
	bh=VzI9czm4MrErn/NZb7FoMdZyZZAmawQ07dwthEnYF78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTLJLE/Tq5zkxrZ6v7YkjG0jYO9HE1ApyS4jn8wV3N830EmFTfeoO7rigVsjjB3NK8o5dWuxVHr5HqGVe/2KWL4uc8rAtIttIlWD3dft06GfDjYaQRM2+DNRScodvYm/1/IVfeOSpriX/kb6i8Um9En4Wp6rcoflWp3kL9m/cPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj4xku4B; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj4xku4B"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f7020a928eso11690432eec.1
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 22:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512720; x=1780117520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYCgRM5mzTQ+ytP9QP2RFZeZNSFcBE/P+Xj1TqGJhWM=;
        b=Wj4xku4BzVgvC83+zSmnkVKVEzkMDhXD7KwisQSqRotpqQY9n8W7ydpRQjV3Bf7Pn1
         pIXwk2LLFenctnIPJC2qR+Jhc8/vJa7uzQlUpcfFEZw6wZnHb1pUmZvOAlEWRJdliONk
         3p3aA8TF5t1uKO1bjKLfod1kSWMOq+yhwaB+H4InpmHD5Ejyivq+bqvS5tQuJl2aKMpj
         Swa7tbjFrFsyyh3pzXr4Zf7g7NuyKMci5mzIk79ZKKACuQ8lkkGlxtE7I1a3mCN12L9q
         kEgiSJjDYp5/wBaumYk4EOjoG1d1YjTxreoHm+Goqs1A7mhf5275tmEzKFKo0mmP8noY
         mQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512720; x=1780117520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYCgRM5mzTQ+ytP9QP2RFZeZNSFcBE/P+Xj1TqGJhWM=;
        b=D3YO+6fBLK/2ZK17wJZSdkSnQ1qlY0b1lUc/SVocbaimIURgO6/8l39clctr3sIBd1
         ArffMOF9v2c8fpkcgwdz8rrrKAo/tKyw6JhPqJ0ftr7xFRx6063ddY3P83U8zxPbMiHd
         pnwwY0Yu08S+TH1ANJd81rybTPZdCAVnDB9YS4FO1CbZ3rBDn7YrWHXuPhalL94KV9cB
         ucSM1I/e4W548/Who3QMC6iXkh7RdLeLkq1WpIXl7tzqwm8A/Wv5P7dZs7FJxDF0WutV
         tTHnowvXP+uk89PUEbvZlqfVl4DQ5czzHuh8irKcSZm1/13FsB6kAfWnkF+H6bY7nkUJ
         5dhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BMKiJpsaOSgvHkp0NUOZBDcTpCN0whomQnNgBFqUDK/zBBhGTUhp5TopfiWGiLZ1tfHE76j6zn6Ei1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPes6kwt7UZxmt9LehFVxq6PEbPsHSzK1Z8qx6DiG4heGYu6P
	IScIQygoMJkA0PI8yhUR2TdQCWa1vZgL3GXIfm8IHt9GArA1XLF/49nd
X-Gm-Gg: Acq92OFs7K5SRYqmtJKi4q4wChcmi3IC3CCBKGtlsoC87Rj52I4A0ivC8+KEBCES1Yh
	+p5rhGkmC71fzpF4DtDwrD2vQmzzIUKO7OGYAEpcD7mpEmZ9uP2Xe9ewW7lcwFjz0s7l/+qqbK4
	mdYNI3IV294LD08aep80FZX2qPH2hG+Ohrn1EK+yoLO5hA7L+kt0Q0JaJD/+55tS4DuXUvBoi5S
	kKTm0G0V2LyBqRzEFD5Ne/P+hFU2fSgapLs2YwR8NxeCT8fzGtv0lJ7z9HyYDV3oVPFN9Ywb6gq
	8/zFKNZkLkejml+KaQVO9jr/Qa4rVP6f2/ocrLL0BbWaxjsAs9YP9ON6v+NYwgxNSYV0z47f85g
	jjJ/kIqeVQoJErkAuo0R4nzqnLyZWhZQENIaaUxr7PJCLz7ZKTrBHcongLOWSP9B7mts0CKxn64
	0241APatg0ZuAYA9/0kG7amTMEOqyQjj88vBoEd2QitPxLd4KFg6mtao48jsLaMDQ=
X-Received: by 2002:a05:7301:198f:b0:2c1:7793:7bbb with SMTP id 5a478bee46e88-304491d0c06mr3267768eec.27.1779512719620;
        Fri, 22 May 2026 22:05:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452259de0sm2582124eec.22.2026.05.22.22.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:05:17 -0700 (PDT)
Date: Fri, 22 May 2026 22:05:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Dan Carpenter <error27@gmail.com>, 
	Seungjin Bae <eeodqql09@gmail.com>, Sanghoon Choi <csh0052@gmail.com>, Kees Cook <kees@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ims-pcu - fix usb_free_coherent() size in
 ims_pcu_buffers_alloc()
Message-ID: <ahE1hNQnHWRe3yr9@google.com>
References: <20260522085412.45430-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522085412.45430-2-fourier.thomas@gmail.com>

On Fri, May 22, 2026 at 10:54:04AM +0200, Thomas Fourier wrote:
> The input buffer size is pcu->max_in_size, but pcu->max_out_size is
> passed to usb_free_coherent().
> 
> Change size to match the allocation size.
> 
> Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Applied, thank you.

-- 
Dmitry
