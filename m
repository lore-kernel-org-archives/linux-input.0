Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836004;
	b=3VE2r2Fihhrh5LEhMAe4B5LNX5orbY5zQFTmSzj5aE38Cxl5hfXifB/mIwsFGtujfQBd
	 wTZBAbYzxmWLyJIIUKmNp4kbwmZhianWGH8IeMSAnniq3DLCZJEPIoussy0mDthoRaFdT
	 /rBKukHK5L6Ae/ePi2bGKtvSLgN2qRnrJLuv9H53+5qHF6rtq5cg/DlL8yQOnlPsf5myI
	 NpXkssMZLkCcAJKuHYIf9qQjyhm9nKCqzBRbR+1UMTC5bDLvYXLpur62961YQTSBYtekz
	 YcUVIx+7NDWs5k0atFPQv1ydil91leGJraLEQlrHUBJgXPuK8n3nJqVdbaf6YmcNmhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rKToFDzUi6qhaHyBZmmLDL7zVXQz7iwmFV5QQTYo7qQ=;
	b=bPQ0GbYPU0Tam0Lib1Jx3xN6Z1Y3Db1Chj1Pb5z7Wd432aPt7Sz4NiX99nGxLZSBSCEe
	 4pmDZS6JZplEnGiZHJD18xslGzgVgGtQDtMt21/hE8DF91qVNj1kGuEsI1/n68RBiHVxa
	 IvDYwIaz9qG8vcS6hQo8mtQsZxceJ4JaHUIvdvCLTXUThroGcFd5N9XVzWB/l024/p8gl
	 cLsaYXiZUBig+UZxD+r73eleHI3yaUjzBHTu7/U9fuvHGB9v5+klQwh98iMo59336LWU0
	 CsJsosX5KEsSWNFzHSLp8ZNx9CG1YWO9ClamdLJm0oRZJe/D/kFQO5jC71Z1idY9TNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v4qTVCCb;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B6606A328
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 23:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 231B6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v4qTVCCb
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36d6e342f98so1458528eec.0
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 15:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793836003; x=1794440803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rKToFDzUi6qhaHyBZmmLDL7zVXQz7iwmFV5QQTYo7qQ=;
        b=v4qTVCCb7VVhal+oXEIMin9L6U8kT6Yq4/927OR1/wzDyR0v3HuXZSR2FHrMyKaSX/
         ivFqQMctHdPU8OUU9Eu8c1vow2qmhP8IvkXOstT5ait5IWGPdcTK5G+YFV+HRl2/9BKS
         CWTSW7yjW3d/J9mRK4ps5gOToHcdSsfzXBjHHgTS33iOC8jJes4c+rW+6mVpjdhvUuUV
         xysT08LZGEYTQHR6X6wiROX+YZMmlnvq0EV65Irq5uyTRs0B34WY0FKNKPzaHyKkOPOz
         zcLR5TuJ52uS6UxKQW532KJPui7tjFGg3ilYtOkQuDwE4VNcEnOYQ5zfW3YdTNS85Tgo
         dwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836003; x=1794440803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKToFDzUi6qhaHyBZmmLDL7zVXQz7iwmFV5QQTYo7qQ=;
        b=dHA0ZRcflhaLh6svIdDYWLUcuLxHFOfZ1tKUWDMAV3qnq1XkJxbDEwagaKsmx06F1Z
         eeGsaorubsERVcyLfxAugaiY9rYZ3m4lJ6KOafa6GrdT3tT0kJ27MPlI1+CZygvOaWdq
         8868UXmAWKkOrcZrqm6stNInkPSE7S4TwIfVJntkwd2qMNkGHn3is7qXbQrg/HXIYOAM
         0LQ22Azd/FPyWc7qaVbYQVBN5ABDgEPYYFXRRLDGo4z1gDmR1x2PqGMCrdYl22vVPQ1z
         hYF2XEL6WH5KMwrCYMjKAQt+4uHoCTSoqScCewmVYXgyYB1G46RaBPjKMhOH2K8PM/gN
         lrjw==
X-Gm-Message-State: APuU4Z+D2zSEvxxtMa/v+P2ySisNlPpB/coc7LfGiqG4LxKSDl1XSqw6
	DdaUOz9mFsmzxRn4rbbUx/Zr02UkZ4BZ1dDxA1jVbDoAIJoWZ1D8s1ZH
X-Gm-Gg: AYBFou3JgRAitWggjmgaYdwXNWkqZYB7NEJVsrCSIRr00m0+0S8of2v04TEr3QxyxWX
	QCn/QtbiQATeqOHhtIvmiCeVDiLRx65YgLs0XdsL6eAZE0J6zPDvpecnq1m3IxsriN+eiYU9UK+
	rbWEUwu/SN7KgBd15+mNE/oxdPTmF/MvrkQo1I6fLAifqbiiBT4okEXUpIJ5MR0a5EVUXdBPULp
	RDdJH56PWTl5bUAAfrCcLTm7b3pDwN3g1UTxVkUi+9AHJlaO4GSFqPfy1295ilYa8TrG85q5Guz
	fKHvWEgEDuhla6IMV0aETLSAX3+dFlZbNZftkDfATmrAx6Vf079vZTSgfskQhv0x9xLVBooUvPs
	DYEZFpFh8KYqw0UsfrWJTh7g0ijShfqa/HAo1WBif21Hgim7oxgaairvusZHasL/zPGqRWegxgr
	YaP2C3OPtHyPzQy5M8LpJn8Nu+BrFDdq+64j/POO4sxzoV8me0DUC5s9leQ5vtsQD1bTVEvQRLd
	Xob5FjdJ3a2MkBRoTzGb1E7i6Ap1tPCoSSwh3GRD2Smr4eE5Llu2BZfP8izCRvEcPBpRm/FSPgE
	0U3MkM7f/pGBZcOQaIjkRmQBfoftH25mInpiva2/RmOcjjFcavIODrEcjgszd6aBbImrKg==
X-Received: by 2002:a05:7300:7a83:b0:35e:2c6:d46c with SMTP id 5a478bee46e88-36a42362460mr24871452eec.10.1793836003085;
        Wed, 04 Nov 2026 15:46:43 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm9855784eec.9.2026.11.04.15.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:46:42 -0800 (PST)
Date: Wed, 4 Nov 2026 15:46:39 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH] Input: db9 - enlarge the Saturn multitap packet buffer
Message-ID: <auvD3ISOJKoQv0cZ@google.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
 <20261103084135.426629-4-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261103084135.426629-4-zhugl3@xiaopeng.com>

On Tue, Nov 03, 2026 at 04:41:31PM +0800, Guanglei Zhu wrote:
> The Saturn multitap path fills the packet buffer block by block:
> 
> 	for (i = 0; i < 60; i += 10) {
> 		data[i] = db9_saturn_read_analog(port, type, powered);
> 		if (data[i] != 0xff)
> 			/* read each pad */
> 			for (j = 0; j < (data[i] & 0x0f); j++)
> 				data[i + j + 1] = db9_saturn_read_analog(port, type, powered);
> 	}
> 
> Each block is ten bytes apart, and the low nibble of the block
> header - taken from the device - allows up to fifteen more bytes,
> so the last block can write up to data[65]. The buffer, however,
> is sixty bytes, and the six bytes past it belong to the rest of
> the stack frame.
> 
> Give the buffer the size the protocol layout actually requires.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Applied, thank you.

-- 
Dmitry
