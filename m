Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134144;
	b=cEc3nBoG3czNXXjoQOJf/hhznZKy6QfgRUPvPMeSdHOiJG+vxymoqPTh2TTXXarmMLcm
	 QWGFgT01A2D/JHlBa2W2sjXVtMcYnJHm/y1KkS+ZXdiO13Q1ngYzcMmmCSUiz+uDV2l5Y
	 lRRfp4znyYTcxj8Xqrabn4pD5pAZJ9Ys3Hns+pykWn+n56G06sQUFV8m+OFcYynFrky2w
	 KlYK5x9VeMCH4759Um2M8qXWDocSpbBby0Qme/AEb5RLpR3Ukmjh3RC9Za1vqX3YB+N7R
	 kE+XgIV6klcIOC4e3yGXFyLNjQXU0WHkoM+MMoFw/dR7RhUenJk5rPcaXSmenEC+Mcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0hAF57gjoTt/mFElvB0eCyvbssGe7Z9DDBCWZ462jcE=;
	b=ijHl9hfaFGggmmVfxAUB12Uvg14tgP8fyYiD2fZNJCj4PTW5A+hRaeF4B4QT85/JA7DX
	 OWeAC0yx2oYDb8xzbkNKUk/+VpoK2XRQGCNjqBgKg4v1pLTUEFdQUcpLLTC9Hholqa9Uh
	 N5Jzxt4JDWMgB8ktwxcK57VhbHlU6NeVMvJDb0eX45FZgurKMSRAJve02C4Z9nvUioo01
	 +RvtfMXT2Pw0kJz5QcUrrdScvejG3nb655nLHW8kTIQv3UNOA9TN1nI5bx39X6sn6ftIQ
	 qRIUQCd2IVcNw8d9i8J/ezA4RtZMWlVvLicgFc+waITdyG4e/Gkugh5wPztYTXOhtog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e55IsjYh;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC637606A31D
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 20:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC637606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e55IsjYh
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso311611eec.1
        for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793134143; x=1793738943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0hAF57gjoTt/mFElvB0eCyvbssGe7Z9DDBCWZ462jcE=;
        b=e55IsjYhiaImBGZaEfcHNMh1iYy+89zVX4Gb7i/eQxrr1bstQrZpT7NWG28qVP3QMh
         M+/9xzBrp5nhdQAwgEg/OPLEz6m8YNZ2BaSFKGCyUzFsrHTsjrOjrb+fHHvaY+ogpPSk
         6SWergbI2mXHUNZuALNteXmULFbqOWBbdEgJ4LzaWUCqshlf/Foq1MgysQwWE65Nawe1
         Puq8jzGeKgnr7iGkms245khvWVZ4aYfsncoaHoAywSO2TWm6a5oDoZz/OG+BGJGYjv9u
         MXynhrH9Ibj6DKp0ILSEd8tVIv2T1C9285LBP6kw9KeLRu4GpSkLA/UDaVwIaIqtH9hD
         51yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793134143; x=1793738943;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0hAF57gjoTt/mFElvB0eCyvbssGe7Z9DDBCWZ462jcE=;
        b=iuofsfisTsI0Tpw14Ftsqg3qQnDuNgj9Za1O5skVCg+MfFbMEy2irvppN6EDgYQaxP
         2bbXmPkhNHGbLnC1fQ7tAITFwlp3SkkXczyl9bRUeUIDQTeluyrTMg6ihp8KnvfrRZtj
         pUO8RVsFm+uYKtRjedmPWm+U/GY6/iy0fDVTUjbS6nASd0cLeZyr6D5AgK4mtCNVssaW
         dWA/ReoFf1QZeOVdHOAF8bO0+Wqn3hOH5/7ajafgXnM5gbNQTMnbyiDx/KwjZYR6ErRn
         D1RwcWzq7OgvzvZh9hfsfhdXM5WxaYohnONKIQVDOtnoZqDkEz/Q7E9VUtJC7AdnITjT
         8cEQ==
X-Gm-Message-State: AFq9FYIHPcJeoW0MQcP6eDCwQjAEtrR1aT4udXP0c8kykcs8sBZEZkCv
	FekeFNDJ7oDHwWHWXK5jL1Q2a6BJRSvZTkMVab/16gUYJlz7P4JsqVWe
X-Gm-Gg: AYBFou1qlqiS94qavu0rBY0l8vleg8HABdlE4RGDXMbGXult6pjM7RCEmf8Boz0Xuz2
	Heomx9yx9gcMTwwYarG2wB0SjbRhrL8zUB80grZd+ZoD8L5Lqcx1hZQE3u68MVi0EyoYWfO63aQ
	Atc3tm3ljL/y1HFzPxr10ltS+NhCG+/e1nHXBQ47/WmPlzmcajTux0J2U4K3qmycSAA8ZgCpaqT
	7uLqgfDNBNhTDOvjUcLmz13dQGxpKQpz3My2i7OeuN+eQD556ujOKnCnPi1yxMOLTHjBJz0hILA
	UJW/Cj9ODQFHtx0eRwc4eRarvRayfuYll+yI4ZRzA/fj6Q7rn11X7vKc4uP0PEt1Ec96IGJFgvM
	aAwwVmlcPMvLO73Z1I/dK7cawuQSnAYA8EOOcRdFYbYEKQ4IP1B23TaNZgDhxC/ooKg7+Ngm9Sx
	361OWcwyng99yxOu/+1SAmht/0cODNBNCUzxkes8k6kMmcNLHAEhmydJMG/4PT3zLUm3yyvQX2V
	UwcPjNAZCyJT+vCXdI8A5RQm2hf6iVpvpjQpp6R4xkoMlpNGu3DkIpySuQw0nE5Owcs2B/VBSup
	7KZDMMgH4+k6aCyhSvOqZlSH7OYUVDTwB39M3Oa+sSkOm9i3xb015X3OLaLVYcfA7CAwaiI=
X-Received: by 2002:a05:7301:7187:b0:369:fcbb:4d4c with SMTP id 5a478bee46e88-36a2007da4dmr673283eec.7.1793134142800;
        Tue, 27 Oct 2026 13:49:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:9958:9525:7799:82b5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71easm35192972eec.5.2026.10.27.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:49:01 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:48:58 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dmitry Mikushin <dmitry@kernelgen.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Input: synaptics - enable SMBus for ThinkPad P14s
 Gen 2i (LEN2072)
Message-ID: <auEOI-Ay0xGBMd3k@google.com>
References: <20261026142648.2567233-1-dmitry@kernelgen.org>
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
In-Reply-To: <20261026142648.2567233-1-dmitry@kernelgen.org>

On Mon, Oct 26, 2026 at 03:26:45PM +0100, Dmitry Mikushin wrote:
> The ThinkPad P14s Gen 2i touchpad (Synaptics TM3471-030, LEN2072) is
> not on the SMBus passlist and runs in PS/2 mode. Forcing RMI4 alone
> does not help: the F12 attention handler reads the whole 79-byte data
> packet over SMBus on every frame, which caps the report rate at about
> 43 Hz and loses fast swipes.
> 
> Patch 1 fixes the size passed to rmi_f12_process_objects(), which
> counted from the start of the data packet instead of from Data1.
> Patch 2 makes F12 read only the registers up to and including Data1,
> raising the report rate to about 65 Hz on this machine. Patch 3 then
> adds LEN2072 to smbus_pnp_ids and should not be applied without
> patch 2.
> 
> Tested on a ThinkPad P14s Gen 2i (20VX) on 7.2.9, including s2idle
> suspend/resume and the TrackPoint on the RMI4 pass-through port. On
> this device Data1 is the first data register, so patch 1 does not
> change its behavior.
> 
> Changes in v2:
> - New patch 1. Sashiko pointed out that with patch 2 alone, on devices
>   where Data1 is not at offset 0, rmi_f12_process_objects() could parse
>   bytes past the end of what was read. The underlying off-by-
>   data1_offset bound predates this series, so it is fixed separately
>   with a Fixes: tag.
> - No changes to patches 2 and 3.

Applied the lot, thank you.

-- 
Dmitry
