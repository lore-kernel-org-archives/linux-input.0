Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535538;
	b=bgVZbEAdmrg60WSGTrRZTM4hkeGanHo7bq2Oc8QqRENbXnXh9ThqDDqBRlRD/UCdTAZq
	 kuFGrHqtlhI+A1eRtj8Wht1YY1GyPD1/Z3VNshmQ5efTEr0Uq9j43ZENjQ5lTXHjWO45b
	 akecKcaZ4cRebA6F41yp5rbginpg4lYkyljPkFsREZXdlnYdx+LKEB82zLL9Ga1cWAsZz
	 VLMTXrXSxDmJLufPaJpFDePkEXTCV9EZrAzyDPb5d9o477/KM2VeTp0NgcBIBhMTryBGw
	 JA57q9fkgMMADmYGsjaX37cHdhBaC/qVbPEI3xpKJrEhg/D4ZnhlABlgKUdvjB1fQ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=S4imppLOyvDXcuLb3YL+/0kdZASSKJjGPDiIRvfutk8=;
	b=PSw4TsAfd2aw9VSfBStH7vMdkwgo+0xLjTa1jdd6KMEJ0AMGR3hNToNX9yg7Htkg949D
	 fPU45C3MrFpn88bnfp3HgL7uc+dGY0il7ZXMBPLrV4elE1giILoKyk7JUU6WA6/EJSa+q
	 DlPZqcDScP0/Ma+KDTVVbUBjMOg1AvVtxQx1bx23skQOS4rPt46mhfTD8RDhWUmA9MsF4
	 at5MIFF+KwQm7BBI7V5GJTRQPeNo3wSIcrJQl1g7R/6N5iZ7TNPuqe/wXKundp4KFaqyW
	 0VU4KpWKsh11k8r+/MC17/oNZIxnLHM+CX54VXUNpZhlzX0/jRK4hr/o79q8bN2yBDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UWnm0WPf;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DF4606A323
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 02:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22DF4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UWnm0WPf
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37000e7234bso1007232eec.1
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 18:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794535537; x=1795140337; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S4imppLOyvDXcuLb3YL+/0kdZASSKJjGPDiIRvfutk8=;
        b=UWnm0WPfGRw9mYF/UemNGbctgOrYjn3N6rMqRS6w7GWRBITbt48RUqkF3EyLr15NR9
         KrjA20Ej3+31Aw+CtesnYsGy3+zt317COTexb00voSesuKJXUf00ErPdB08gaPIRgAc7
         LR9r3mg4xLKXXdZzACaJgOXeB0A5MKY2vCb2HQwahmS+Xk3FCnGWkNwV+Yon8PEFovXK
         QjjK1SYXeDpsYYAcCkuHTXpfdmBY/rjNzl/vigvsEijkv+/dPrsxQfbg87w7Do6RKTUL
         5VH8JdtEy8/f/K1N+fDuxHWN6Ymhqm4gcgHzVFh4KcyQ1NL0lPJQUmLBGTnD+HQ90LkV
         2S2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794535537; x=1795140337;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S4imppLOyvDXcuLb3YL+/0kdZASSKJjGPDiIRvfutk8=;
        b=2iE/vWXussb/brBuFM9YNqDfyBnuovtEUmKudW1Z5AEziIPCFWwsNYZUSWyDYjvCe0
         FTN5lsN2F1vCA80vObUthvyfcQ7SHtVfEU+0C+pSw7jqNjjXbWHfzz7+UAlWT8t5W1/y
         jIZsJCEq5VppQeKyEt1aWNsNoxma7hPnDqaBaqmUrYHyFj50NGQiYEzpfLiBLY38Face
         mPOKKSJgQ8kj8IOhUuKmx/YyK3ttvvnY/xwoIQLNxNz5HsVqq0z2Q4CG5EdLnWTsiC8E
         zFia6elHOsF3heZqIiMUjrla5MB6+WDtvIu9eNsUAEKLri3H7vzZMcL70OjK4LVGp7pY
         wA8w==
X-Forwarded-Encrypted: i=1; AL+hErHVjaWK3mkV9jYyJk8zxEBnNrGFW9XEFdvasWvcyaXbm76vMnObkdKrRmrNII36hQuB4aYUu/V+XSJJHg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+F0M1h7XAbtaUGZ6qKQXzniLzb8/6q1o6eaA2SDxpBXLFGJ+CP
	9n4MYAE792L1gyJ23XmOxg5aCSf/HtbP+7iOjFNyYMiHu4VFN0Z+Cnbr
X-Gm-Gg: AYBFou0knhqFRXJP7N1lgy2rzk8eiWsbJxcvD44GUdhMiTQ9mSzUWgdRyg+zUVwuHlG
	pwdvrImNe3EG5HfrujFIcdswZbgNN12tJPg6gfTn+TPfcm4Kp6PqRga/Hmv87EEOAQdldn5wIUB
	2i40TaC2w9Yi4hThZDCX8Qwd5TNRDgkUui/3Zv6t6o/iMoYoD//2h/b7vypSy697Icg6Xlb2Ft2
	iv9Gvp8gIOWhwz9qa65Pde28/GfRhF8X8PHpwPb8fPpGFThvfjCtRpgQWKkE6sZwTVaXv8XG5Oc
	DsQ2C5EzXg2vxhTeVa8AgmTecLX1Qgqk/O3koSO41SxtskNj4pRGSwDQKRC1L8kBS2B/dCxcOeh
	o04dYQtfWki/NTbeiB6nu4u7mFFwwlI4pHfwjRSWwW9SgQXZvscp/aB3rOhI5QzvwxcrLiGBfwC
	7pxAiImkON5uM88KVfujxT6aUqkwB2PkY3yRWk/Wqlt82sYw6BdQ1rTczS1Qp1WlT8C8B2CTL0t
	IDW7RT03XrPD4iRfuCukzFULXG1tAifiQnAOR+HPndd182+COcQmAxqqaZgwE8imhI+COTbTbfU
	wRcYn1n+SCSjHjaGQP5Npszgzv9CVeKFgegWltKbxNn9bNGmwfXlTnwg6DOlzrGNMXEMeA==
X-Received: by 2002:a05:693c:88c3:10b0:36e:4aaf:6c7b with SMTP id 5a478bee46e88-3796740c786mr885305eec.39.1794535537128;
        Thu, 12 Nov 2026 18:05:37 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f01d68sm2342174eec.17.2026.11.12.18.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:05:36 -0800 (PST)
Date: Thu, 12 Nov 2026 18:05:35 -0800
Message-ID: <5a9a39b3d7b0e7fe0b1924fe0f97d14b@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Miro Kropacek <miro.kropacek@gmail.com>
Cc: geert@linux-m68k.org,
	schmitzmic@gmail.com,
	linux-m68k@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] m68k: Fix atari mouse movement
In-Reply-To: <20261021022336.2232886-1-miro.kropacek@gmail.com>
References: <20261021000338.2160223-1-miro.kropacek@gmail.com> <20261021022336.2232886-1-miro.kropacek@gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, Oct 21, 2026 at 12:23:36PM +1000, Miro Kropacek wrote:
> Kernels are built with -funsigned-char since version 6.2, resulting in
> the signed 8-bit position deltas reported by the IKBD being
> misinterpreted as unsigned.
>
> The hook is handed a raw IKBD packet, so take it as a byte stream and
> apply the sign to the two displacement values alone.
>
> Fixes: 3bc753c06dd02a35 ("kbuild: treat char as always unsigned")
> Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
> Cc: linux-input <linux-input@vger.kernel.org>

Applied, thank you.

-- 
Dmitry
