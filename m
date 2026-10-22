Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709512;
	b=WDExMzvNMa1OS1TTAlq0STROTdo77azWUP01/dehUZn9ZP+8Or9YC6GlthxUxV5ZTYsR
	 flRG6kZJRtcIDCZ6jd0hvEOyOMniKgsqRn5A+d+K8fpkVQFGfiOLeAAo341YyoJUarm1W
	 yCIwpgAnTsfkuRtiElsKqavmBWelNoE6rkbByTS8L43VsQJljA2YV/Uh5rvk3l1ovSxnG
	 k9MiWzOAnMuTMxP4Esnu1xHCRNjRRzN4RFa0iwhNBaGtEn+55eZ/rzu3lyrZMt5oDLTRU
	 3HzjwCOBV5uIo5kMe5O9UkaMyOeUmtX1Y64G/djTOSqElVIUvhy+cQoe0E/8RpsFB7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=X6mPg6UiwEtZQv33ZuddKbr9Vgpx/S+VOXpbm0Wczao=;
	b=wbMagbtK2WKJQE8VUC24eWqyMRh6ekMaR3u5dI4LvkY5Z4LcU8m33W96GaLowuHLAiOt
	 T53re8RQaZcdo6MgD/gdAY9M+5dgjuhH5GKJ7xSXuXPy2vxqfu6IR1rwaxgbh2l+75N0k
	 0+VnfU3vIt/f0joXRJ7DhPnbbJ6gllzBZ6NPmhYsJdS8MKI7LDMJNfKHgo0MH4aRz+HLy
	 sDlD79nffL5qIIj/dH+dTp9OlwyioPXtZVCvwh5YwOeeqw1TvVnc7P8Ik+weD7rzsS0UH
	 xLSWNtfdnkZAQNpr8soI5gsPgm/aPnJ4mHJb60rhfVGMmx8es6uvW2xqFfTxow63xFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=acXV3egG;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A8606A31A
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 22:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB4A8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=acXV3egG
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35f1f76ea84so461899eec.1
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792709511; x=1793314311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X6mPg6UiwEtZQv33ZuddKbr9Vgpx/S+VOXpbm0Wczao=;
        b=acXV3egGoTGYDjhdvrmZk497EKmTNRskbF9WlLcG7GYMYMFF1ksn4VI2y7BZGpMJCZ
         SwrJOiYphQOIuAHhJrkM4WmIKjioss1sLDSUBi72gPDta58g5qXAoWl6R8biJdB8dGvU
         A3vg6/M4WwR7KJRZqikZ4deUJnjrt+Ngt87dL6uJ16ObnnY8RGiKI3Aau6b5HcUaAVd8
         JhmSgl3bNjAaODm64JbQTBHDJdY0zDM3obmTalXqc6cYPRs+rc+YE4tBCyltdg42g1X9
         yg+Kmru7yX8g9EF+eGMF56pXr7WfdyPuJxdHgulU6ykalltNNB7ciJ9cRPVlIXkeGkyb
         aqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709511; x=1793314311;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X6mPg6UiwEtZQv33ZuddKbr9Vgpx/S+VOXpbm0Wczao=;
        b=L/UE5dUGB3Odl9ZN0qBY+YWYJBS+rXvnlfb4EZQUvVHwpGttnBz7aWns3lsNdr10K3
         YXcaNbFmo9Waf87cFmWWPfktskoMPL/Ytf5gPPfF1dcH2k1+sJ4GE3L5qGE85BW8NB1+
         enCvG+k3P/gUdboO5h39pMbHKjzdcSrbOevufnWUzonqb84wTHULUSsgEccgcsGfcK1F
         N0i33g0IOeoNH5m1zGa2kelYSpFWvCH+zbazKYmOm4I95Luu8nkG0kg05xAmBteWF0Ac
         bzfjcQvmtHO8L9Dh5K9TcrRkL0Qx5rHy8RGfOdunTjAGRJvvhgxNlvOJMf7b/oHzsqpk
         imgQ==
X-Forwarded-Encrypted: i=1; AKwUvByFE9q3FfAHQM4MXyLQLZ/vbTiqtQjUb0l4XDytdDxBicY9qUpOt0eK/FqBB2thyofpJbVzal4Om8VMwg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKACQi/e0ay8o8XWvLnZO3BFpZuJy3cj+7tZ/jO0qpYaiDbJsE7
	djG1M1mOWo2g0w/z+U6ozhByJIL2QShGsqputk3Q6/bczWTVJJ9ZOlZ6
X-Gm-Gg: AYBFou2Yzqu08p4sLr5K/nAV6PbJizOkFFQf4lmonDbVACDCszlP+/vq8XB8eA6DsxO
	TnDJ/CFpHOYZuYebHbEb65U3xSSCwiaRyuAtu/JK4TAo3vL012PnzHOa1UNqCvEpykKPYfVVDHE
	KYu2YSTdC51zvw7Ii8si1b1rSnLb2DeaLIV3nEqR00e5g0F1/uEGTZjAbR1v9QaRRKTMItqW0V6
	tP7GQEiXOudjB3KjsDYb0L4xZtxbMa9AdXZO+eAmCuGD201JqFbj/PCIMHtC2X7hnUENiC0DPns
	zInB5Sy1/90m4i5EA6Ue8xa6Ms+L6O8308/EtfOZWWy3T4c2OLKvnqlOe7Abfu4umqxfim+OV2f
	bDdAdxCA9L+KUMSnFgSQVyHKXByCPmuVH/rriLgZno/bnPvcN2AfJRZneh/svmfQ1+Jvtkckq1c
	WpXced0Y+oG7MUcJ2BJOd0cCnEHi6DxsoeskMIs76kJUCPvVZMlZpnShoFk3chiSNNd88yrTVhm
	F87UssPaW3+cnXWmy6lRWYvq7794LsR1jaD3pWdsM/46Xd3Vo82cpoFZqmqD4Jsby+BW5/+nu4t
	3lQMXwoNdaSA3hVt8YU9jg==
X-Received: by 2002:a05:7300:ae21:b0:360:ca2f:ce6f with SMTP id 5a478bee46e88-369d90e3646mr708317eec.1.1792709510886;
        Thu, 22 Oct 2026 15:51:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f2d1:b7cb:a745:829f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9db6865sm1071997eec.17.2026.10.22.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:51:50 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:51:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, 
	Miro Kropacek <miro.kropacek@gmail.com>, linux-m68k@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] m68k: Fix atari mouse movement
Message-ID: <atqTLxkEusWSS-wf@google.com>
References: <20261021000338.2160223-1-miro.kropacek@gmail.com>
 <20261021022336.2232886-1-miro.kropacek@gmail.com>
 <c77944ee-f170-ce57-9065-d7d49fcfed6e@gmail.com>
 <CAMuHMdXWHXjbCNojoukGq4OWvLSibk-goJo4quLdbOj01neOew@mail.gmail.com>
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
In-Reply-To: <CAMuHMdXWHXjbCNojoukGq4OWvLSibk-goJo4quLdbOj01neOew@mail.gmail.com>

On Wed, Oct 21, 2026 at 09:32:00AM +0200, Geert Uytterhoeven wrote:
> On Wed, 21 Oct 2026 at 04:51, Michael Schmitz <schmitzmic@gmail.com> wrote:
> > Am 21.10.2026 um 15:23 schrieb Miro Kropacek:
> > > Kernels are built with -funsigned-char since version 6.2, resulting in
> > > the signed 8-bit position deltas reported by the IKBD being
> > > misinterpreted as unsigned.
> > >
> > > The hook is handed a raw IKBD packet, so take it as a byte stream and
> > > apply the sign to the two displacement values alone.
> > >
> > > Fixes: 3bc753c06dd02a35 ("kbuild: treat char as always unsigned")
> > > Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
> > > Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
> > > Cc: linux-input <linux-input@vger.kernel.org>
> > > ---
> > >
> > > Changes in v5:
> > >
> > > - take the packet as u8 * and cast only the two displacement values,
> > >   as suggested; this drops the call-site cast v4 needed, and with it
> > >   the -Wpointer-sign warning
> > > - add the types include atarikb.h now relies on
> > >
> > > The same cast of the two displacement values was tested on an Atari
> > > Falcon030 with CT60 in v1 of this patch; v5 differs from it only in the
> > > type of the hook argument.
> > >
> > > Michael's Reviewed-by from v3 is dropped, as the approach has changed
> > > twice since.
> >
> > Dmitry's reasoning makes sense to me, so we're back on v1 with no change
> > in functionality.
> 
> If it's just a byte stream, one might not bother doing s/char/u8/, as both
> are the same type anyway... and then we're really back at v1.

I'd prefer to have u8 at least in input.

> 
> > Looks good to me, feel free to add my Reviewed-by if it helps get this
> > merged.
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> for the arch/m68k files:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Could you please re-post v1? Can;t seem to find it.

Thanks.

-- 
Dmitry
