Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC23271450
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539151; cv=none; b=PQyOmbMORxwduTUjWnJFAAjOzQGpxQQpG2/JgSey41RU/Fd9aeBnEgwlNnzdF9/RXEBy/95p25WaW1Mz9G2u+6MrmZSxFXQhE/OYj+ZaAfcpnMqFCZVdIxwoUntGl3InLdteNrpXUQp2AsoqiZeVNux6fU8nx/eNoIkS8PKyYKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539151; c=relaxed/simple;
	bh=BIleVtqMchT8Tl8GbjBxQORlC1W+9SAKfnuSUEn7qaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSxNbY6EI97z2LQZrOTWi7sWs1I8lEL6XpDtH2FkzxN0v7mPMvx5A0x3HyvAEA/IuUjMhf8c25Fn7SfdF/nWsl7Ac37yXz6RL8aS64bale3Wf9kDPfd119LyvwOzV6/6SayrnsFdw/ukzoLP+v4slGkV/V15jEjxZi1mwXOw6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnCe4h8A; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnCe4h8A"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ce22328930so3846753eec.0
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 22:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775539149; x=1776143949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aJPRef6pu2ylG0bboh+7Z2QxwB192DESyzZ2pn62zC0=;
        b=FnCe4h8AxfC0PsPdZnwVmKxQrpAti8vZ0oKMph8Ziu9GULaBexYT8JgnrgdfPbZKBA
         RyePj0UkvJgiw7Tmys6liHWQG+zBkIPPXHieDacxcChkHkaJXj2SckuPfuHGlonu022H
         TUA9eNY6ZUnif4zcShj89jz8aAhmYn/+/mM1YDdZWxLWtlAmAwc8peDYTP3L7mJUn6VZ
         TIE6irgBOv+CtoB87A+TYAU0A+3p4wHbOc+nXYlOiwlyhWoIHmSQtjGwhnRwH/mGlEuu
         1f0yYcQFbf8oBGxnDm4HvgDwp1UpvwQnUall6tmzasUkQ9YF+o5JsgPpnRR8GdZ1hnPZ
         dBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775539149; x=1776143949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJPRef6pu2ylG0bboh+7Z2QxwB192DESyzZ2pn62zC0=;
        b=AHKPiRwDSBSIlp91tmSd9JqX1UZNYFVrW79TcIbxevAww7Y/9MnhEYAAhM4So+kZG+
         TCOONB5KcjAgs8FkhysvwSks2rqmDO/+QE+ZhERcD76V2BXKQlQypwaZhd83ewqXl5yE
         +g/Vu/EnIZDsZVAq6OYLoN44VGMsCaRb7wHo3JYvFDRFOYiFcB9N1by16XuSEn4RA1Cf
         3fpWQuh91m3/O2PA8jb4Hr65L1RdDtUh2ap7zyDMiBNC2M3vSwRCpK4TV5Sl3iYtzAPF
         gcIkUAXn/SFXO9b5Ogi3ycDVLp46cA3iiwBE/1eS6tcdri8dN0RfMsniSWdXtBZ/9f9I
         H/iA==
X-Gm-Message-State: AOJu0YyvDCWUs+Z+y+HnPdEjZVth8zQroVAC3srH30B/cpjGpkWzNIJ2
	IW0QJZ24wMPzV/2gcQrasIpYR67ucB/jiMHBVZoBgxKbGxK9+HGK9C5c
X-Gm-Gg: AeBDies/o2iiVwKtr5CbP/OSsnOyXbBRGpaUZYjfLDZ6xzbdH+g4SHWad9eX2f9hleK
	HyymTHmwElFqhNjrccOV2q+YbDbr/w7LlbPIWU9CB2hS3EZYHiCNkumFTjzKT/uOhcBpyoMom4T
	JBUAAjiIZ2O1Xujb7+WMk2Eam5GQXlgVeMa8Ezt3f5sr/0l/mCVXotJ9NVBwa0uXMl2lWjU1KiU
	GMrr3nJqPLp7mBHAcXw17fYtO5vQ3HAi9rddBKoqxHkZ04hyr8V/mNp+db7vkNQvdDZ3lDtB6m+
	aO1VT9JdGPO5vsB8iBBHFC5qY54+htCJ1QkRfegdN3RJaCaP/uW4tXKwq9exxaphUBUFf19Lp39
	NvQO9PlGJb6zXkA+IhYE7hKlYONFhdvg+x/Bbo9JtLtUzgZLCix5d7fIyg+Gq1DQw6if65vFKdV
	b5ovi5FkJApXfDpKu2hq8JRKyItcxpduIYOgnsewON13ryp6kwRqW1dfSmKPfJSszB
X-Received: by 2002:a05:693c:3005:b0:2c5:60d0:7031 with SMTP id 5a478bee46e88-2cbf97f57d8mr8312335eec.4.1775539148835;
        Mon, 06 Apr 2026 22:19:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:dd71:7176:b4e4:a7a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d16d115c00sm1766354eec.12.2026.04.06.22.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:19:08 -0700 (PDT)
Date: Mon, 6 Apr 2026 22:19:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput - fix circular locking dependency with
 ff-core
Message-ID: <adSSoVZBLs8b6I0J@google.com>
References: <20260228223628.472208-1-mikhail.v.gavrilov@gmail.com>
 <acCpW6McaPOE0Jq5@google.com>
 <CABXGCsOwJu2dw67bR38MJb5DFvGon=MUCxKcGEQYfT6qrPZU1w@mail.gmail.com>
 <acDPeFpxX57Uu0Mm@google.com>
 <CABXGCsNwLTAKFdRDHnGBdF-h3fnKY0_ysQJevMTv-N7+MNwS1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsNwLTAKFdRDHnGBdF-h3fnKY0_ysQJevMTv-N7+MNwS1A@mail.gmail.com>

Sorry for disappearing again...

On Mon, Mar 23, 2026 at 10:39:29AM +0500, Mikhail Gavrilov wrote:
> On Mon, Mar 23, 2026 at 10:34 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hmm, I am not sure I see the issue. We are not going to change state
> > back to UIST_CREATED until after uinput_destroy_device() returns so we
> > will not submit more requests...
> >
> > What am I missing?
> 
> You are right, there is no lock ordering issue since the state
> transition is one-way.
> 
> The reason I reused requests_lock is that uinput_request_send()
> needs to atomically check state and access udev->dev. If we use a
> separate state_lock and release it before calling
> uinput_dev_event(), uinput_destroy_device() could run in between,
> unregister the device, and we'd hit a use-after-free on udev->dev.
> 
> A separate lock would need to be held across the same scope,
> making it functionally equivalent to reusing requests_lock.

I was talking about taking this new lock in both uinput_request_send()
as well as in uinput_destroy_device() when updating the state. With that
requests_lock will be taken only in uinput_request_alloc_id(),
uinput_request_release_slot(), and uinput_flush_requests().

Thanks.

-- 
Dmitry
