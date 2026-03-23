Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720B15665C
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244077; cv=none; b=BlnEzXXVFelsLzreagrMUMIJ7/1HlW4UN+/dKLKO4CVlfyFVVCHHDyXo3PwMiwU1i3A4ToorBeTT0EAyFAU00zkF2DceF7NY9/guUucANHF3GD8lCFvgLhPnhEiAsxWXJ7yJYME4sYI0cJiV0QxncbBhhw3bnvKeM+AMV4091Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244077; c=relaxed/simple;
	bh=2td1MELRMbYbIkXzkJG0JV53kcFOiamIu5/lW/KHguI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoG0OsJcMNMNSmF30E3IDkONbJllqY3VMGfS0RUm7OxF5MlpC66xnBCQU6HLMqcdVH8/Nw5AsGR1k0fTI5bhBYo1mS2E/MEwV7SnBt0/Qnck4csMB7W3pf3vPwR2hmmDn+OqYAzgxcS+b+QH+MQGeUiy3zUlUKQm9XrkDQe4nGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b96zcARf; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b96zcARf"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-127380532eeso2499359c88.1
        for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 22:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774244075; x=1774848875; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nj4kb/KM1ZkoBXilSmy+DrriwxK8CUQVlwY29+Zz/hs=;
        b=b96zcARfGYOHjop52LokIVNF6Ia25BxbMkDFKkVrxSZww7g5wU6b0Rvo9vGU2sFL66
         7i8P5ze96GANANhvHnCwW0TE34hVgYE3IHHEWqtbWjAaSBAxw+petYj0rTvAwGD++7lk
         pSvYlBiNHKW+ojgNeLNShyrEjClJULZ7AkfM4znhZsUFDB9CTuwzd+hqgUriqOQOT+xo
         e2fEZ5s8BomXgkoqQ2JX5PbYLC507lZzursQ3hhqua1FZ1nKjXo0frIkK2qtNtwVM5M3
         3DUwEKJ41t9XmxHdLnhhla4jgjVU1oJptFAS3BsqJrAC5X/8U/iNPwvuM6FB9IgDJ/bF
         1dXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774244076; x=1774848876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj4kb/KM1ZkoBXilSmy+DrriwxK8CUQVlwY29+Zz/hs=;
        b=n84UI7bG2EbEdeTL+FINGGJJOGFxA91WRF1NsBKl6SLkVwbeVto40rSo74eu7HXN2k
         JvhmIJo2EquZL5zRYUB3GxBbdqAcdYf6SRVltHDSVeYOq1aiQaYZm6sfJU0ZVpOCFl/8
         8uQ+YOHRtiRoL2RJOmSXwED6rbERc8en6dfZSNASdILLuaVqKR6GVAP1GTyoharOz70Q
         FTxXUg+nQTQkxzZNiBr3Qv85t8rnPud65z0zs59jYirEkydpNH6ihVmfrH55HFaT3lry
         ngD1xI0Tt82YJmwCGqJkWIhqS4JWTlxrKFr//8THhLeiiXfP/Ge+sqCvvunOtcNqcb2i
         pndg==
X-Gm-Message-State: AOJu0Yzcz9SX1z1TxhCeJdXF8rSWtUHXjnNtp1TdqtY59mjzifDQyf03
	eg+iFIxuHW2h7BzY6TtijcbgJMtxZZMLwhdEWKOzQrTOCejPI/nTcORE
X-Gm-Gg: ATEYQzw69v8J2ZMxGUFwTzDiTw9B/ChmCuRDAS0KRpckZrUqta4hwzPv6p9BnRcpGJO
	16KL9rl+2NFfCWQJ4mM3lbYWEJ/U1QJb6RegVMKC5o31r4bwqpxM5wr4WUOisNZPk3BdcEB4Uu6
	4RDydSFum2aRONdx/naq5X/Xjso4oBJtmzj1GHLmnBvYc+6qL2UddzJUA3EPogGyrwiUNO3MTev
	kyEFJgAlizs79TOQECYC1Q3Ru4Lmlwb4jhjeyufzquOpsCERfCoz20frCawWHL5tkQtM1b+pJtk
	TM0kgqmUjWtzOo/rM+U8Th2au+mgoJ2gwMDXXJSgCkFzP8845jVdf3YBUj7B7pHBA1x7TeEguAS
	6J3vJRJKWU2tMP3j7gQg1O8+H8ph4/h17qRThELwQrxLHDqgxLexFor3ReIJEBhuUW+IsCPsPru
	VCuKnSnkExQozRdfvEBoLvj48bVy3OhVwekuLR+jQd07m3liBWWCbLBX9d2frEf1sQ
X-Received: by 2002:a05:7022:6728:b0:123:34e8:aec2 with SMTP id a92af1059eb24-12a726570a2mr4609387c88.1.1774244075483;
        Sun, 22 Mar 2026 22:34:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733b4a99sm8570423c88.1.2026.03.22.22.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 22:34:33 -0700 (PDT)
Date: Sun, 22 Mar 2026 22:34:30 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput - fix circular locking dependency with
 ff-core
Message-ID: <acDPeFpxX57Uu0Mm@google.com>
References: <20260228223628.472208-1-mikhail.v.gavrilov@gmail.com>
 <acCpW6McaPOE0Jq5@google.com>
 <CABXGCsOwJu2dw67bR38MJb5DFvGon=MUCxKcGEQYfT6qrPZU1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsOwJu2dw67bR38MJb5DFvGon=MUCxKcGEQYfT6qrPZU1w@mail.gmail.com>

On Mon, Mar 23, 2026 at 10:17:01AM +0500, Mikhail Gavrilov wrote:
> On Mon, Mar 23, 2026 at 7:47 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Thank you for the patch, it looks solid, however I wonder if creating a
> > separate "state_lock" spinlock would not be better than reusing
> > requests_lock?
> 
> Hi Dmitry,
> 
> Thank you for the review.
> 
> A separate spinlock would certainly be cleaner from a naming
> perspective. One thing I'd like to note though: the current
> approach of reusing requests_lock has the benefit of atomically
> checking state and queueing the event in uinput_request_send(),
> and atomically changing state and flushing requests in
> uinput_destroy_device(). With a separate state_lock these become
> two independent locks, so the ordering between them would need to
> be defined.

Hmm, I am not sure I see the issue. We are not going to change state
back to UIST_CREATED until after uinput_destroy_device() returns so we
will not submit more requests...

What am I missing?

Thanks.

-- 
Dmitry
