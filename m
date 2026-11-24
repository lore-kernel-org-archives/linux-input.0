Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495196;
	b=IVP2x/JvNxjK2D4qeZN1SrD4kgdjk2yTLXUoKJ578ZfvXzf8XldCvo3KPGcKf54/wcTB
	 yLIF05JkJLo89R9oo573912p4FLDthwt545P1JNOJunUNZVRZZZ6HTkQECX3Hh1+/L/k6
	 oz3ezq1h8D3K6CbSgNO+5mdvbD0y2EjTr8o65fH5KsKxxc/6lliiCZwflT1S7GW63oaBd
	 BZZzk6PhQs0fcT6cFDESpkOhcc8ZxgdLS1gOhv3VxB5TAqb2pqL3Gozj08KPLDnqtc3EM
	 TS2jfE+2R3q6ZAQ/E0bknmOmCWxV5fE5veM38dWBHqH4+pwOShupULhfIT9GxAVX/Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=e8hU1KwP7KOcNpt1N+F1VtaFHoAealByJyBT1mkquWA=;
	b=QOp9Bhu8G2MNIL7BQEyOp7d23Thhf2bzPQA0pvUOdeDsgg/R2NKdeEgz9ZFtOSma2BTT
	 G9UJ0O5mj389/tZEV34qLyDcLB6v4QvQ9RkfHzlW4sxGF/PrsV0p43XN+qkvIMrXaZ4S1
	 GiIeW5KJMyzLX3PSNZhM1IwRAYYFhGer75laUEP8W3PHQurUiHHKAu2XMeGadPyzI1Jbu
	 W9wA4wdvtD9Kr9HCZ36/VFnwOeF26eWjgEJxnZveotH7/eVH11ZKnSuOr+Id2OuVeT2hK
	 x0ebMpRc4FPVLZik16oVdiCIzWYBixeTCUEH0Bhi4F7FX9tU7IEsPBrXk+tpTY9fR3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZNSafUon;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB558606A321
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 04:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB558606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZNSafUon
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-386ab9ab619so3823308eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 20:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795495195; x=1796099995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e8hU1KwP7KOcNpt1N+F1VtaFHoAealByJyBT1mkquWA=;
        b=ZNSafUonYPg9CR0WBoVpuOFRKDVjdqJxBy7Np4xVHLU6KbfVFy2IcQKTQP4x4ahlf3
         gn2XHC5I7y/1z0ijw+UAk1opNdVHeRBld75RlyGjFCryuQDrsn9PCvNhub+MHUKWwTZ5
         L5Gdw2ydTqT7IdicOBXLAbj5aYQ3FphxhLUn20Kx2WagUpr6w1wQ93rWZBd2sxO2LZ6A
         Jik3VEcYeXJMiOYPFVuOt3HEYFiL5SNDZozzYsKPvS/ArZR6NYu/G7CHNC1S2eloB5+P
         VLLxcld9G4pcqGOI8lNGUSzKBKWewTUYDRdo21VFbH3IosTSShbDqG/HwrFrEd4i2ZG1
         pB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795495195; x=1796099995;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e8hU1KwP7KOcNpt1N+F1VtaFHoAealByJyBT1mkquWA=;
        b=htXjHVweQMSAdv5bwY1Ramcd1c/ilUUxIGza8eie8av6It/tPHvOvjcmCOjZ2MA3tX
         d2g7wkXiie0pDshPEcQSi4gR98mQLx+5nt4U56eLmLauqIB3X1hQmHpJDsGknoE00wZ7
         vXMsbmV5do1AEpSGm5PWdEjHtpeiL7/9VsrNmV3HxWB6Inaf3RXrhoD9GhKyRzLSAscf
         xRuzzHgUhgRSeL4i+naAxvxHI+JK0BoWon2mYQJnB7Y+9Hg1HKiQZP2GvNzN9LhMOsvj
         95voiC42tvU1Ph/U/BHQyyBEh5umeM9HjF/rjV2dSnKZMaL2jhq35p4kJTS/3UWr5/s3
         GEgA==
X-Gm-Message-State: APuU4Z8rH29q4SZMoIHNNOIugc2v84/YsdS9NQ5+Wj/y+0rOEM6ip+7u
	TcgQ6dc7CDnhP4q5x1tmQ4MpJAn93j/MpknzEbY78vl7N5WXhG2Ny2M2
X-Gm-Gg: AZFdTZeE6OP9jqaw6xgtjixJXlvbKMMtMMziVRKAdyKccB1HRstu6e5P9fNsC7NQdZu
	rYDbPQ00RHF4gPdbsQ9xONTAivLdybOZUUKJ23tj9PHFt0oi4S1SP5yVX1IPnhBhqSOJzOqWyP2
	Ktu76Un1jL1RTmbxJYlA0jnM/JdfnbBYzJxMVIdtLAGspGGW8iKOFfAJh7imTSYPuMJdoFhYfUB
	Njem93SLa7OrVbbyo66LAI+p5jqeDLzZYV5C0IRM5XYOG5C1SKa7Bw1ER0moKeP2I8B/qly3qB5
	U8M2rOlDHqn+NEKQdJ4H09fk0yJfiLRTFA+aPF0FrxUaVmAzwuZ7cLJ3aR5gxqmjfgtJHx6+h2o
	LMiF5mG+pgBSz9zQoXwRn8VXrRGwJ2krpkO6MwouYftojEvKFmf5OqbTsPEDdBmYInMnmREG4bH
	y7JI45RGa1o66sSVWu8Y2HmlKjmSE4xqCV6eqC+bY+TB1Fbx/XkoW5xePc2VIpnkAmpR49hQoLv
	zRkN+pD6l6CHmwTq/VtgtmZR5kQx10AwMTbPe/pl249qyzsWfA/Jc/+MSrFfgHIO6eEDVdLlpak
	flVHBbFmDUkiRuGETfQBa8xSL0Vy3nHZrP5Swmm/pXAYr1411lcLMaJfg0oiJKzQ2sp38cs=
X-Received: by 2002:a05:7301:6405:b0:381:a3bb:f945 with SMTP id 5a478bee46e88-38570254ec3mr16446848eec.22.1795495194672;
        Mon, 23 Nov 2026 20:39:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c349csm43149340eec.22.2026.11.23.20.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 20:39:53 -0800 (PST)
Date: Mon, 23 Nov 2026 20:39:51 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: filipp.dunsky@gmail.com
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: sx8654 - fix SX8650 reset and status handling
Message-ID: <awUVCt-TC6HaC-UK@google.com>
References: <20261123-b4-sx8650-fixes-v1-0-b82a881b971d@gmail.com>
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
In-Reply-To: <20261123-b4-sx8650-fixes-v1-0-b82a881b971d@gmail.com>

On Mon, Nov 23, 2026 at 09:41:44PM +0300, Fil Dunsky via B4 Relay wrote:
> Fix two independent issues introduced with SX8650 support. Its soft-reset
> register is 0x1f, unlike the other supported variants. Also retain the
> signed SMBus status return so an I2C error cannot be interpreted as a
> conversion interrupt.
> 
> On Almond+, writing the old reset address acknowledged but left CTRL2
> unchanged; using 0x1f restored the documented reset value. An isolated
> harness using the actual driver helpers exercised 39167 cases under
> ASan/UBSan, including negative status reads and both reset paths. ARM
> built-in and module compilation passed on Linux v7.4-rc4.
> 
> These fixes are independent of the Cortina platform series. Local
> OpenWrt conversion-rate and recovery policy changes are not included.
> 
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
> ---
> Fil Dunsky (2):
>       Input: sx8654 - use the SX8650 soft-reset register
>       Input: sx8654 - check SX8650 status read errors

Applied the lot, thank you.

-- 
Dmitry
