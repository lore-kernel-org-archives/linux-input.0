Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794796615;
	b=kVhePhWEW416JN56jpjMJ00me7z3EeNCBOE4Nd/V4h92B3i0NRK8KcGkH4vkvy+w2YZi
	 +Wy0Z4513utBsoZVNtHJw8VakXOaguB1wZHaGo6rB33nI7anBMur6MR5/D+0DAHQxtBWZ
	 +L3TqFGrdI7IVZF24SLGCme+1m7q4/SKgeBL9nJzitks62zjrikBtzjM4LMMr0XYWhFky
	 eirdHF1D3jPUCgzBTRPvio5Ff8qbI4h1er+CXNi7viNvw6b2TF4rh9R5qoFl5EX+dQxdE
	 cUBII4MWY3iwDgsbkGp2xyGJYBqWaTuVbqsxbeMoJ6U1few5Ws6EonhkKdQnZiaP8lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794796615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xX6CkA6Wx5SU/AcLVgEPrjNCEuQtMzhCBWWoMNoHGPg=;
	b=w/Hiv6ya4Suw2PvFes5npTEMooR8yaSpDB4f5UqgiCkyO0S0ndG73LXoBlcxH3NqFUoB
	 EGLPZGsD7QzAUQdp6MY8Ol8jLfLiTG6RwkfARcK9Hgk2opATb7QT1KtQfBCB6dmKPY0B7
	 qULx3TFU7XLzYO55LdbudGyPZ8ci0hVbNOg3EkQXpR9QItk0qBgctk9ONdVrmCmOsgfVx
	 8f8VVtg4FEo6vvjpdGDb7w7eEcwnx8iOb0Ew/K7QPZP3H7vwX3dLTk0FYYIsXa7IcUmpV
	 txmIyGMdh9DwDKxOKP5WfNSRb04/dengTm57o8sZylkQKAuQVf7i1fIjRw0re77+z+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l4Rist4w;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC4606A31F
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 02:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66EC4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l4Rist4w
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so3446070c88.1
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 18:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794796614; x=1795401414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xX6CkA6Wx5SU/AcLVgEPrjNCEuQtMzhCBWWoMNoHGPg=;
        b=l4Rist4wafGh61eo+v58em7wU81hSwBFHNcD+KdFFPB/2ZsmziQbgN4UCq0bUSgPOQ
         OCnFSgfdhP+BhEcshU/sZAqDpIZRdp9InRNM+i2epJBSi4G0CPQWPtDfiVWXskF8xqkG
         Y6yMCfVibIRJi394ZetkeDRrTjcYYJj46Uks2VMnki52NNBd39hKR6e6lyrxmurii+lp
         idoVVpPPh/o/p738Ayfw0jixFgwvI0Pjbmf66JxDM+vYaU/bMx0f+nJgQPOExfLDSkpQ
         cOEXtDa+lTuLBBbV9a2Zotb/5yq8vDyi4VjZ4oKoPTw6s5Pkfa51AqqbyXCMauvFdOwk
         EN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794796614; x=1795401414;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xX6CkA6Wx5SU/AcLVgEPrjNCEuQtMzhCBWWoMNoHGPg=;
        b=MIw0e6odKIHWSF6OLf3D3DdtXVbzQ8ADkr4mpxQNvqWp4gebtW1SkG6Sh7mo9H9cLL
         wNoQOhDS8BAxC+tUWLMPThTtAdMiE5r1gLmGhXETxOzYQQGRduVCZj9S8iN/ShYlCRoQ
         dz4RBL43BSxBPD4bIfUwsutuhokzum5FkKfGS4HcHIV5jqWB07irbMmVkjKfa/+tF+56
         Uo5yMxFqPnrdeJY1QW6IPvEfgmaryNcN2ihURlhTJ1Na3oe1IFk1T2lmayhhETLD9oB0
         xMh2yD1SfygtFXf01JOyb2ANgKZLICQ9Pa0ryfuGeQz89XsNLgjLNNcR0Zs7CbbJ5ZY0
         Y4Tw==
X-Gm-Message-State: APuU4Z+nylmAuIg70mMq8LOW7bzmklDtWiSVWdA7Byh5wVEW+tv/mhzo
	h/+BXktxkfbtNwLFMbseb85GtHVy0Htx4VyMjKrBL4DSnOXD4xEDLF4B
X-Gm-Gg: AYBFou3SCaVRR8F1dEzTNhcPA2GMkddNjkW8Snr/2HyXf+6eCjqXq/zY+jGGOhjzBCr
	/H7v/HDrUoxLUmWSQ0joo95/eqg6QKDIUJbP/Y6x4mG7VGezFCPtwSYOKcFf9zhYWw+4Ft05Kps
	uHpaoOKxyIPP2U0xRu6+QUM9/WfiUbTVM4mxkVJEonAg/AGKuOMSz0aWDuwlEN3Q2G0AIiTrGyz
	zD5sKSrfTfe27ibgZ3eSffKDH8SN5aZcpIoBo5fOSGuemUOyDv8CzQv5UHSm24nSDqIC5xCSppT
	vibhwBZmdxnSCG7/eWMb9khRlC/jNtDhiiP404Qo2KM34nTmFbeqruqbzXVX7r1hXMJ8WKwDY7X
	ozENOSQzvun6iSUAruB+yRc4Ky/Dd2WOjRxojOxDJpxaq8KJXAPIZL0uVDxE/VNktQ/17Ld5bCj
	bQqnM1lZkQast6rrqzK0drMZU+1kmXM+yQeKBBoRAPInE192UGfkNqY1tKg+WZrVs/lZlf6YCkt
	KShQv1cN2oHBiEm7vNz8C4Gd0dTkgeMpiIN1I3AQQzA80Jb9qJkryVPqAVHq8DM4l9auS40PWtn
	kT3LX9i8Z0Z0IFDCpzRiI2x2gyERtD8rnuJ6Xcyh+twluTYE/iURWUnyhI6ghM05K6NGPQ==
X-Received: by 2002:a05:7022:f109:b0:1ad:4ef5:ffed with SMTP id a92af1059eb24-1b50313d936mr8152988c88.38.1794796614479;
        Sun, 15 Nov 2026 18:36:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:203f:d9b9:dda8:24e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm37357720c88.9.2026.11.15.18.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 18:36:53 -0800 (PST)
Date: Sun, 15 Nov 2026 18:36:50 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: lm8323 - drain PWM work and finish with
 outputs disabled
Message-ID: <avpr6qngp8rfJ9Fe@google.com>
References: <179474329214.103840.17616107855531843241@seu.edu.cn>
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
In-Reply-To: <179474329214.103840.17616107855531843241@seu.edu.cn>

Hi Hongyan,

On Sun, Nov 15, 2026 at 07:48:12PM +0800, Hongyan Xu wrote:
> A PWM brightness callback can leave private work pending when the
> managed LED and chip state are released. Merely cancelling that
> work also discards the final LED_OFF requested by LED unregister.
> Flushing alone is insufficient if an earlier fade is still
> running: the worker waits for an IRQ to requeue it, and the
> managed IRQ is released before the LEDs during teardown.
> 
> Install cleanup before registering each LED. Once LED unregister
> and IRQ teardown have stopped the producers, cancel its work and
> use the documented single-END shutdown sequence: put END with
> RESET set in unused script slot 59, stop the channel and restart
> at that slot. Do not overwrite a running brightness script. The
> engine then disables its output autonomously without another IRQ
> or a worker accessing freed driver data. A current long RAMP can
> delay completion, as documented by the device specification.
> 
> Found by the author's in-house static analysis tool.
> 
> Fixes: a48b2d4a0091 ("Input: introduce lm8323 keypad driver")

This driver is being removed, no need to patch it. 

Thanks.

-- 
Dmitry
