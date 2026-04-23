Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C791DED49
	for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908190; cv=none; b=QUMTcfZehDXEr72imKi5lwBIYy3gehlCj06QVHHT/YWwF6rAHAiuYXIo5SScQFs+ZaTDk4c0qcOAgXPA7QLhtiRK1kUWj08DBFnA+9EQp8LDWOyHwoSGMawlPtXu6u/xs2Smo+86SV3DJMtktOVmOiRBzml+JwucnEgAr24KyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908190; c=relaxed/simple;
	bh=DNM/Q7BXBRM3geBXRtwNtxkvBloQ2P48yd5lWCONBGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5ogQWSvXvCe54zs3h+PNXSWn/6gyNRSUttt1uWIJDWr6CMURSJvAI4MmuG5hS1dLXcAhCxQZ2L5dxSRGLb9jzVw1oq0QJ6zXqHfrwQqY43RcKo7ZWRpJxvOgmEnBqMY5lK+n+gjFOigqPRLapia8C3yAkESsCezuaK6Rb9Yp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM/o6Gc2; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM/o6Gc2"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2de831d2b20so3385175eec.1
        for <linux-input@vger.kernel.org>; Wed, 22 Apr 2026 18:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776908188; x=1777512988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJqvA3CG/4ClRueOcMsL0HE6ub/+ekGaW8D/MPEOUJw=;
        b=MM/o6Gc2Cv1JvuG0OMRchVVqMJxpG5nCVBgtj92X+XEcHon6ZAov88sACKJL3v2auK
         stHqClJqCP8KOjzsuuTu7FWBuOIKnWv44Lxq1lv8/1UQs3XowVwzCwmAaBVBrmRgsW55
         Ow0cO6ibmChnhPf3xl7/zDjrN8eGke0PqeaAt/flANpx8Wby+86Eo7YK3wgAwThGR3BL
         /UaQT7ICItk3WexzoyqpomXegUFtElUf5Vyo3crGdZsIEIYvoS9XKroutsnkQ8MKUncG
         mlDEy0clqfqmlgm9PsEEglj4RckcX4lchOhMLhwiSoya7xrHLVa0HGF6swOqs9VfFP89
         lqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776908188; x=1777512988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJqvA3CG/4ClRueOcMsL0HE6ub/+ekGaW8D/MPEOUJw=;
        b=mXKV9SwUoiGu+3ZK8Y7T3bcQLP0nlo7HPaqdJe7XZPzD5kmBXzyk/7tdA7lHYP8cHd
         dtHm85v52d/payB+lKXrrFrCybXI8sQq1PGdnG1soyFDao8yXcAk37r+Fr44sqlHCVnQ
         6sWHL5z2v5lfKxGVO5Ir5z4Hpr/dEiD8N/JqazICh1X9ZXxuwdV2kZ0LAkn0OPOGw4cg
         p0ITvKwvf+YRXifftmxr6zgVNn24jHM9eVWiWeB8mxPiRxDdUXXTAqPFOBRE1+uerEnt
         Bh60XYHRnH6NLZDr3nc8U3U8xIf7uZQFzmoeWbx7GRNYhqGAONCa3cdbic3KcbYdMfNe
         GW9w==
X-Gm-Message-State: AOJu0YyU0F+q7DgI4j0iCNb9UMN/hJ7C/7sDaXSqa4HzwwZiWcSPpYMC
	/Zet7vDI65LT0Hrhib/mh3WZdY1RwBPb3hPJYKvLYjUsAV9wYWJBFOzE64HoW+rR
X-Gm-Gg: AeBDiesVwMjhFe83lq2nhd4cArqR7LqC3rZxHkA6GDIonsuL2R4Q2ujnNJw2h8IaKt+
	eveAe35n1ZOQqgG+tKXA6nrszx3HxRTU5Z0M40e+ffH+/9qsW7fInWyTnbx8lrISFdl9eMo7Sbz
	ZqGfUT5cotytUB00byX2clz9alwZI398qNZe2ezmOr1b1ovdKefft2coNxUi88Itwt4k1sclYZQ
	86f+SI1z6nsOwDq7imf3MTaHTSmdA2eiqhHTJzPKUnECMzgGyuplb+9b2wXpND1rPvQoXULLGVf
	/20AABqIqh+DuoqJ1cXLhlzZ4sV41tAoHtQyrZS3REmx99HOQs1XD/jWVczr6NcWAfcZAOx2uFs
	qGslIEfpsKaRCDCeOTH4lVM5fP69vbUZl2KsWlvpl2jEMls+O+vOBnL/zOCwkcjM82f3lFVZF4n
	IRmqXAMROldEIo0PN6R1cSJo0gcHwV2IXMk+ue+FNBopLjkTDL82PuqmYDDMR1JZUOXk3OY8oD2
	j6nxTygeLG6Fw==
X-Received: by 2002:a05:7301:4593:b0:2da:10f0:a8de with SMTP id 5a478bee46e88-2e464db026fmr13762210eec.8.1776908187976;
        Wed, 22 Apr 2026 18:36:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2359:5fa4:9c29:41b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm32568357eec.8.2026.04.22.18.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 18:36:27 -0700 (PDT)
Date: Wed, 22 Apr 2026 18:36:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable <stable@kernel.org>
Subject: Re: [PATCH] Input: ims-pcu - bound frame parser write index against
 read_buf size
Message-ID: <ael3agFzDEV0SgxT@google.com>
References: <2026042030-mobilize-suspense-88f9@gregkh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042030-mobilize-suspense-88f9@gregkh>

Hi Greg,

On Mon, Apr 20, 2026 at 09:05:31PM +0200, Greg Kroah-Hartman wrote:
> ims_pcu_process_data() implements a STX/DLE/ETX byte-stuffing parser
> that accumulates frame payload into pcu->read_buf[] using the running
> index pcu->read_pos.  read_buf is IMS_PCU_BUF_SIZE (128) bytes and
> read_pos is u8 but of course, we don't check the index before actually
> writing the data :(
> 
> Fix this up by properly rejecting the frame at the first attempt to
> write past read_buf and resync on the next STX, mirroring how the parser
> handles short and bad-checksum frames on ETX.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I already have a patch for this, thanks.

-- 
Dmitry
