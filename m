Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793568616;
	b=DLXIFFlB7tMtXPVpvw2PuXWolmEtSLfMg1FPBoX4oB3aZXIxj2TkdAtClwmrnHs3g8qY
	 QODF/eHJ6DJEffC9nmz1iCGzH034JTwRbgoyN8qXkRJP51jIK5luEKhRSv0+MqLGhqzor
	 2zVzFeas6v4NAH4X9f7p+K68Eu2Zm/uFzlbGtulJdBhckxl1FnXk+eCNmi1/y2U3Sv8Ln
	 TnCMByYXK74ULt/TsT+QJ29BhiZwXr+E9QEecxDBMXfm4ykwcJNxWJkfHdGqe8wE1APDv
	 8j9h3C4iFUC0Zj4lbn0nNdiJ+xV+YeIfTMnmyXGYsetPJvIDCBFWN/iQRoQXXfa190Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793568616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=B7MrTrIHlVbro4LWjqK7zsTFe5H1wNzdgcP08X0fb2s=;
	b=KX0VXhGQq49vkfTqSZIl0WtoFCkJ8efNMYT2M8Xouq7bVHtoWCyfiGlAVPisrCB9gQJB
	 uaBWe1MXubekT1p1qzcXwjVOTNI47oemYRlGBi9AFWK7CGzevzGhSiB965Ra4/c5A4D5q
	 aXMX5dTJwJ1Iplt250StxU4JF/lvV54YUKu7MfccsZ2uqtKowaOV3rK3ji+GQBEFFo5Ob
	 J/Sw6CVwCgO4711N+fKbB1c2S/5ZPEYu65jnBYfy9SGXBpqfvvVgfvvFHHRItSNZjo0wG
	 GwOaXUueVmhNC0iX23Cxt4cq2Pe30754xa14zVhWIsMW5TrSU1XJFUR3SnmQqlOa9uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSBkjruA;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30C606A324
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 21:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB30C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSBkjruA
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-353804b591eso4212068eec.0
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2026 13:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793568615; x=1794173415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B7MrTrIHlVbro4LWjqK7zsTFe5H1wNzdgcP08X0fb2s=;
        b=jSBkjruAfzObyoPAY+wamOtyIvKEia4R1ks1KmR3wiUgOe6UgX2likEyCuID2MUGdn
         tQPTVr2DwYcnVfdkWsGPIK1JaX624wxBYFwfgAmdJUrAoDz0o0NOhIZ//H6ir1N8FFvV
         x/Lx0F/Jv0qwXy3RifxEq3iP14GHVRVp0V4GIaJk0RaEqJDV2+Y36mLtOZdUY+Z1ZP97
         9d8q7/fkUxTUzHuOHADWFvsQD9bd+TLAqQkQA/Lo7cnRSI8leJWoxnIxwNH5vv95ezGS
         VLAbDUgmq6jeqGdnbUueLy5P9FgsBvc3LpBFNoLFqdctXA0m35KpEn/xGaiqTA1yA0QP
         OrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793568615; x=1794173415;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7MrTrIHlVbro4LWjqK7zsTFe5H1wNzdgcP08X0fb2s=;
        b=sFDFQ5pc0uaaZmRg6R88e8EagWz7jpjoLUDstU0QYbLN5ZO0AfKN5y4IrTxbhQ8TOj
         lIc3NZsqoTqGTdzC1Brt75rwQLnWRjxXDSSELAS/rxQHTItCq2czeEklaziBLzZmmh51
         56XPY+H5Xkt1xzHX0IiwjyB16bmI7rPOpXBRPHt1qxih2KSgGk6Q22HmFs53OxFya65P
         5hHYPhUUWHOYXtSxBl7UmvbXSvgexABoSgIIkpw9pWkkzg+2Jh7M+88dF/OTC2avgDa3
         xm1wr+lOLZYqyNIdlkWA4kBHjRKBVq/FcBy5Lalsum1PxKA3XVh36AO3IJ61rZGTUAUk
         MAyQ==
X-Gm-Message-State: AFq9FYK/xtoTk9qYOXXbSa5560Q18ghKKDjuqtOzjb6sqOR5xmpGgOvm
	0287X22dLmClil4RR5TNsd8Br/yqUVDxk6MPlMlbDpM1orFkdUWk3V6+
X-Gm-Gg: AYBFou0WDcvSZ6hAQxR54LY4lO2ZEoxegQc2PWqQx5eA6G6stMUHp/GPbvXi0VSZSuT
	R4lk2q7+gLbwoLCmbUj7pmsB428nMo8b4mI6sIJNCCvys+vonBPU2xUV1THYHAVr1QqIF3VWU7d
	wwOOl9KO7Tv/Pum+DXGkGMtwtOvDWOcF83OGr07zhTtNHiRaE/XChJiaIbC1bka6ecd0aj+ytmU
	APDnx4fI+285VGFIUscvN38OwXRF4T6yZ/8xKg0vm/5pujgliy2bmZGKaGmlKGjbXIp0Zt7lr5N
	nzR343xLJMGZSG7QK64fCKzpH2hLPCX/4ipcIdsu/DzMGogk3sGR8SUFUTccd7R9vXs183hPtac
	qx8GMTwgh0nXYUJmc66+HAYxs5cIFQnRPync2SbprtQbom8zB4AtQW25U3V7yfYmrE3/on05tVB
	CN5BGadIW8qMIqFmVKFrtWxmAic8iW94rugWQ4GnjMn/WmWBKW5qgGifSmmf6esVxkOELHC1DQP
	EeJ2oi4HmlqtbOLh5C/zN4HF2Jp/FCv7U0OXSshpfl64bn6AXZ9Tuh/yJE8Aa1cSmVt1JPUvdPQ
	LRT9y4f0P6lx2j9MSJG0C0cEpU2FR/Cq4tYLVb6z16QjmglhU+DtG58ff0pDWqC7hTdXQw==
X-Received: by 2002:a05:7022:b0c4:b0:144:fb87:5b91 with SMTP id a92af1059eb24-1ac5e32099dmr11277954c88.44.1793568614892;
        Sun, 01 Nov 2026 13:30:14 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d75c:a9d8:6c00:c5c6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1d4dsm25555112c88.3.2026.11.01.13.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 13:30:13 -0800 (PST)
Date: Sun, 1 Nov 2026 13:30:10 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sergei Kuznetsov <kernel@phnx47.net>
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - add GameSir G7 Pro support
Message-ID: <auevXv-b2jcKZGmc@google.com>
References: <20261023121314.8024-1-kernel@phnx47.net>
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
In-Reply-To: <20261023121314.8024-1-kernel@phnx47.net>

On Fri, Oct 23, 2026 at 07:13:14PM +0700, Sergei Kuznetsov wrote:
> Add the GameSir G7 Pro (0x3537:0x109c) in Xbox mode, connected through
> its 2.4G dongle. The controller uses the GIP protocol and was already
> bound through the GameSir vendor match, but showed up as "Generic X-Box
> pad" and its Share button was not reported.
> 
> Set MAP_SHARE_BUTTON so the Share button is reported as KEY_RECORD.
> 
> Signed-off-by: Sergei Kuznetsov <kernel@phnx47.net>

Applied, thank you.

-- 
Dmitry
