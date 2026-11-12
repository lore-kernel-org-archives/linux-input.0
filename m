Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461589;
	b=0lsP7XFBORARfse9BMOxAdri+nVHCnqG022rSQIPspxHwNNPv8g4MFsQVRZUKM/gQTSf
	 nXaV7E6wpIXXhnTpcVTSJtaurcFrZg05Bx8LROtuY+SX87d2OfUtSSjs/QKY076WDjCk+
	 n48G6Uje6IWh5B52CHBVQTTy6qPtXZhifd+t0ZghktjRHrpQqvma+rKK4iOuNQZr3LSB7
	 DGFmNKPiyppE1G5P+WHiKShwWMLD1eSBmLSlUBK3byM+pM9M6mZQPACQaFPNu9CLkhS34
	 31UgUdOngVd3O6QJ9MUaltwF09knk+gomKqe9MQio2S8OGUMhEMj9A3dkU44H8ijOBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=njCUlLoyOIDOncaH4+djS31c7ySEziXPtaELXRIFSNM=;
	b=yHqGxVdBk75F3lvq42w86gcsGxnjcDnFqxGlgpRyR4MMq7NrM224pNtP+yPjlfzNV0pe
	 VrKTbKN6Dr0rK9RyVNSodg99J4nAQDRNoktDczRQQUnstMuwUNQNqddoUBQI4bOa2N3OG
	 UYEKw3MqetR+eCRZIKRBsqO36cN1Rd5ZWSccp8+0wm6pGieuQWILd5zPWQdA9HlmZ7tLn
	 JKgFJgt35QzxfBaEK7DdpMkqVHPrd8HN87/XTfduJ7JCEhbBMV6gcxC/UGTBpx5lhbRNy
	 8RelK8s1OJ96Mbi8nw5IxbjQSCp9M+WPiE57cV9xh7JhY71hj/f+YMverUGIh/ZXxwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mLgDaxY2;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA2606A323
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 05:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10EA2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mLgDaxY2
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b197cd42b0so406568a91.2
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 21:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461588; x=1795066388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=njCUlLoyOIDOncaH4+djS31c7ySEziXPtaELXRIFSNM=;
        b=mLgDaxY2YkILLtiwHGCnVHR2Gio060ale45ThqnikVOJ43bYrTPZNQ44scY+S5ZjGQ
         zTuJMjQBVOW2Xhk8z63WL/5dni8dOtpyVasqUms6VHHdonV5l6CHJrvdBDIbFmB1UwEC
         i5rX19Y6KuycB7iBaL4LvN77wK/7qOBJBw3qmTb7Xl6hKEZ57GqKXTtscBT72Nl+PT6N
         ko1X5qSp018CP3AfQ811dSji0RD6pX/i0ej8tDrVBzsAf4xhiCGRDrQ37MRoTI9Xv+0n
         7gA4QRaOWJlphYFzLFk3s54Jr1eNUbv8RMQxY72QX+Ce4wSZR1CpoDVbyJCJbQqw7lHZ
         zMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461588; x=1795066388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=njCUlLoyOIDOncaH4+djS31c7ySEziXPtaELXRIFSNM=;
        b=kJUKoYNw31GwGOrapON3MlA72vI6Ay18YCrwkcROiOPPQdtLwR/5pO8JgJ4151vg5e
         nsYZYFBL9xsb3uq4ztdke2+IbqtlAYAyacG5Hsg9rnh8egH7Nquw1m2Vq5QvypN6UXFO
         E81QWugzie357QvrHMIwqcoV1YP54QyAAn9hqEn1Q8BE6mYe0tml2/Axi0J3F98bXPgP
         tMSKfhxeBMRzzREUmJzS8CVLlSOLr51J2BizSu7nVjbiX9gRxgjv5w3k81QVd5wo9VBa
         SiOdkqmzJdeLXzmVSPz3aykEbHmwUTS0jvsjGiCpnu+oSKV5s7CUMvFvPALZXLQM9BD3
         j1lQ==
X-Forwarded-Encrypted: i=1; AL+hErEaOGtegBS9x37dafKGHcEolzcPD1Eu6KrdbzeWSMKZtNcuxpf9wtmikWa467Yv/9K/NrxM2agPcJ6V4Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/IlpVIN8+RAU1FxO7rhg487p8ozKd8mJBpRIjJCE1XdaA0Ef5D
	6osqc34Bqi4/Vz+i8vyBtwOM626c+2wDnSElQmdmMTJ7cpY16PxvDyLP
X-Gm-Gg: AYBFou1/h4DgMgRCQQZNqgeR4zZYHgr5lx2NnCgdVncyXnR82ebcHF7EjSxRs78wdQz
	Xob6M77dsJpwHzV72qolk/26t7PDt283DbH8eY3JqWa9oyILy1ov8G//B6oE97GO4LNiCrTFt/2
	eviBe8s1c4V89Xl1EIzLyMtrzqAmiIcCRV8lleZPQ3bXJ2Qvg2ZkL6rQUbw0+sSLx2kXqahfq7W
	nglI1N5iXq01/zqx7H7EnMOScHhH0iN7/tGPEAcBC83tELt2QjfGFsMnlQxA3lc55apimT5b8NC
	Wi/cY2pnIXQxUcHFPTl3CKbki+EVKQynjtRbgtA0xZMfbM166G7lITIgrhqS6lxg9nIpcowl+Cx
	wBSEuy1vkWK3SzRn5pqlQHuzBd27Jmpidx7DVHL6zdu5ptiCF6OAkiiC24sgIMjCddL6I56DFZl
	dWoYfxN/jdeENaHQAQflE60XTZXcIw+22j8ggT0/gHIh4M09VtAQUt71wQLCLYrqEIHeb9ZS3uU
	pRN5Kqann5ycg1exW7j8dm+k+qhalNm5y8eMvEDKTSLBeGV4Nf7fVHajlo7pKyxzKjlkSQou0V8
	x9wIRI0wbfMBtg+2i+LoADmM9K+GsQRbTsb27+JwEnA+bPkA5RmPzXTYk4maUjWWc45bSt2KcJM
	ekLCJYqNqg2h7+XM=
X-Received: by 2002:a17:90b:4d91:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3b182efdd48mr3779419a91.40.1794461588456;
        Wed, 11 Nov 2026 21:33:08 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c42c11sm2678324a91.2.2026.11.11.21.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:33:07 -0800 (PST)
Date: Wed, 11 Nov 2026 21:33:05 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jingle Wu =?utf-8?B?5ZCz6YeR5ZyL?= <jingle.wu@emc.com.tw>
Cc: Yao Yuan <yaoyuan0329os@gmail.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vishnu Sankar <vishnuocv@gmail.com>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Phoenix Huang =?utf-8?B?6buD5LiW6bWs?= <phoenix@emc.com.tw>, Stanley Chen =?utf-8?B?6Zmz5bu657at?= <stanley.chen@emc.com.tw>
Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Message-ID: <avVPRySmoH_KKHa6@google.com>
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
 <20261102130836.11863-2-yaoyuan0329os@gmail.com>
 <avKBsi-E7IeUgsSY@google.com>
 <TY0PR0101MB4786C8CF42ED66617BD9DA1EDC722@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
 <avMcB0q7wF9oP5X8@sapienza>
 <PUZPR01MB477458CD012208A31DE60068DC712@PUZPR01MB4774.apcprd01.prod.exchangelabs.com>
 <avRttU9N0EZeq8nY@sapienza>
 <TY0PR0101MB47865DFC765932B9E6C3E1C0DC702@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY0PR0101MB47865DFC765932B9E6C3E1C0DC702@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>

Hi Jingle,

On Thu, Nov 12, 2026 at 05:26:46AM +0000, Jingle Wu 吳金國 wrote:
> Hi Yao:
> 
> Upon inquiry, it was confirmed that a black TrackPoint stick (0x07)
> underneath the red TrackPoint cap corresponds to a vendor that is
> compatible with the Windows ELAN driver.

Are you at liberty to share the vendor name? Or should we mark it as
"Elan" or "Elan-compatible"?

Thanks.

-- 
Dmitry
