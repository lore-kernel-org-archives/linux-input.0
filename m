Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35183264C4
	for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776225790; cv=none; b=lTwT+EtMsf4VNoo4kWHoJI1HmEs34tJs+b1wNMcwF7ZCEQWbUEu/c9O1O0FO44L7KCMkyZHr5UI7VB8Te0d9+HY/hlwpfJqOZSn4qn3rNWS5oE80k8n7ne5rd3UNTiCeJPE5ZONZLxc7L9pU/xYZCUgCC8qnCXmd+ChTIxnhhLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776225790; c=relaxed/simple;
	bh=hrC3Z65p5cZ0prw8RHnFQu86gAoL2FGBUwxvL+MSbww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLKz2Q8PAg8bXgsKxSAucx+xp7VCmx8QCFQ8LNj5gcqsfHhL7SgXmd+WNoZeWhTXg94f1oBhtweSUki+HGOpm/tRpo+3pgjyhcH2wnB58MoLdMzLyOGvePmYoDq/eW2eTX2ee6Ck6wl++YUJC9vjD6Sl5AAeYO59ag321V/XSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tD9K3TjV; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tD9K3TjV"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c287eb77fso9871404c88.1
        for <linux-input@vger.kernel.org>; Tue, 14 Apr 2026 21:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776225787; x=1776830587; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qqr8Av6w2w+zaihiQp380a2uqCjd4dhbly0XvRyprjc=;
        b=tD9K3TjVE7yZdyhw/DyRn0+wxhWWwIFjjGwnBgMuEeATwm+qd18j8+1Sbrs/e5C8BA
         RUx5r8ImUPyCS6+1QddhTRaW6l6ESWBLFU8yI0KYEPQLv8kWNP0lItVjLWQAuBdghtUS
         gMYlIrWeoACgOal//mFN99L18ZZdHBn4qUYzePQD67Eo0htB4AdWWnGmDoq9nzUQKV38
         dcnggddGrQaiYZ02pKOlNuDEzVgZGQoKlTGyVE2ZMv8zcJVvIKlNQoFsQU+mScSXqqcF
         xKL3BH8SLQJxk32cQIuTllu1fEpHrKH9tl3xOn1Tki9VB+pE1L3QtDLxe1ndTKYTkhKB
         jCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776225787; x=1776830587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qqr8Av6w2w+zaihiQp380a2uqCjd4dhbly0XvRyprjc=;
        b=kwMvhSZ1w1aRKVmplPbAo+wsLMzUpST9dBz8xFY8te9FQe+KIOewZhw0NUN3LtKvV5
         aPWsY3P1UnGBNyVpe4Ogg0q9p3VzyreisbnXT8/jFGwQbkJFNjZjvPO2VftbfvwdW6F4
         MV5KfnF18nP6rPFlNyhoEbCqeHOH8g8K4P0ppin/HtrvXECb/LNcHLG2kcJlH7dOsQxG
         LlbcajcUcewkPeBWRnfh4MRpE+yuZ/KI2ZjHJ/QoJ9fXjuggwffsjydWOh8Chd3EfEea
         dCsN/XLe0I35nSPaVksC90nJWnLfzXDgAzr7X+Z7EN73Ygznlvid5IOUdDrVeDOJMix7
         7DEA==
X-Gm-Message-State: AOJu0Yy5RIzfMLTNxsI102gPHjLu114HX39O3tbX45c2noxztD7oKCpy
	zRxOf/QU7xJJkTWeZxMZfZrFvv540t+UTUjB7frA6Dc1H5Dovto9dHmE
X-Gm-Gg: AeBDieuy5a/ehjrsymdsA8KPqHw2n599xHD3SRNSzZGsBupnewisrY1PS8wiNytqCMi
	xNilOjiwqY36CqEpEySP3zGa7NMACo4a1MH0laIASJKntaHnWErylFh+zSEhdfURH2iOVqLGzgZ
	UF5xu8LHa+ApkQ6A5UOfPowtld7pbvJS27Ai0l700+oX894n7XqmU/zqEhsDq9Yvquv5JA0R85x
	EcdGOdk1TnNG48WKhXpPtGLPdlrzegUs/2uVQzMaUF1dfVNZ2fBFg2rCRjLb4cLaTgKDv1kUu5i
	XMSY68/1uukUYDYUMZ8XcYhdmGvEihs2s+d2zZihNeKj96XgGftRF0lgd+N5m3HbKTq/BB7wSdQ
	FGxBUMfRDUwXTQjp5yOc8zgnrzE0q7PiQV05EqEb4/epsyTGO458eT2/fkbP18tSnWTiM1JOGsZ
	XkRPh4A7JL96mn9HeTud18+Hv66vm8DCu5dC0y4lK9rfwR7wxJmaLMfqe5wU0v2Gb7
X-Received: by 2002:a05:7022:6088:b0:11b:f056:a19b with SMTP id a92af1059eb24-12c34eedbbamr12410589c88.18.1776225786604;
        Tue, 14 Apr 2026 21:03:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ed3a:7da9:709b:b01c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e62b9d1sm548605c88.5.2026.04.14.21.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 21:03:05 -0700 (PDT)
Date: Tue, 14 Apr 2026 21:03:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?B?6K645Lic5rSB?= <xudongjie25@mails.ucas.ac.cn>
Cc: linux-input@vger.kernel.org, zhaoruilin22@mails.ucas.ac.cn
Subject: Re: [BUG] list_add double add in cm109_input_open
Message-ID: <ad8M-FjZie-QVJNB@google.com>
References: <1fdc2218.4cc75.19d8f37b6dd.Coremail.xudongjie25@mails.ucas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fdc2218.4cc75.19d8f37b6dd.Coremail.xudongjie25@mails.ucas.ac.cn>

On Wed, Apr 15, 2026 at 11:38:06AM +0800, 许东洁 wrote:
> Hi,
> 
> While running fuzzing tests on 6.19.0-rc5, we hit a "list_add double add" bug triggered by the cm109 driver.
> 
> The root cause lies in how the driver handles multiple input devices. During probe, the driver registers two separate input devices (idev and keypad). Both devices share the same cm109_input_open() and cm109_input_close() callbacks. If both input devices are opened by user space, cm109_input_open() is called twice.

Your LLM hallucinated a bunch of stuff. Please refrain from reporting
any more "bugs" to us.

Thanks.

-- 
Dmitry
