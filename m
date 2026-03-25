Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAD35DA46
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455020; cv=none; b=Mje04AZk48OqM2RlmyCSxROJMVLIxyoGMyKXSktRV3pAxv+Pb8ENkh52cz5dI5vtenbqA6qaIrJHHuu4Fg7CDF83U33bEjPnhtGpXRhWAG9gb/SUm5WGd/KqFKUqvL5hoyaQyqBm71NSLqBWn2z/UM2dD/gaqGCkVRM3UMuDhwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455020; c=relaxed/simple;
	bh=dvFi8SJREKcTnv11d71GI3s1iMiLPZh8VYrtAvSd/ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV2EmSgXBxr1d5dn8SdAsj2haWVmoMBuX+c0Kle5VUFIv7fye6LrVzeDmtJv4syX2Jt8kVvvZ82CrDFQ8ZsgPgfcoepfbmffSsT3EJSQBkKZgmhlitKmyrnZZ33FvLKWgkbSLyRdE6onn98lCewUshNXQs9CRJt5XOqTuLAyHOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXLiNN6y; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXLiNN6y"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so44113eec.0
        for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774455018; x=1775059818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aF/yB3MA6FfUyxHiRxkYKaKFeNHb6nR5Wo6UMsmYEL8=;
        b=dXLiNN6yhRIjpu/qu4Zs2xr0LetHJsLAytFz6gXdLQ9aO3aJUR9/p1qH2k8W3ceOd2
         qjge37VrJJuGwcxytBqQbiyX/irl47Bk/+/lxW1cQ+dBbC4JOcq48mvyNbAvlRgeKoRq
         M4IoScYHROUJPNNBNUme9vo9dGVQPzZPHRrC0xmPycvWYzZ2o0Fkth7MbzJN5Sqdx2mY
         wq/Afvl4789qcvCpTDK2zO5nIiRCGH4OXTQv5MCkVqQrWS7CvC38vT5MRs+5t1+GbxNl
         t8G+rkTIt0qtm59l3DPQ9TWQkR8XJBjjJtC/FNNrAsbmzK2syYLj7f8ywr3PEKgFd9Op
         85gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774455018; x=1775059818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aF/yB3MA6FfUyxHiRxkYKaKFeNHb6nR5Wo6UMsmYEL8=;
        b=rpUu51wrlji/4/Gkl290ueUTi22NtnUoIU8NERetrL0XX6BHcGBuRYoja7rug6zQw3
         v6n4SSVvR1CqyOymr5Wm4PHRorypv/mr34KdAd0sXTHEv4BkQv41XN1amV2RGwYRXQ85
         sBS1qatOUephhVi+vKppGgvXmFrLy7LuGf78kXnL0bOSudeLWT4cnig0j+JJSZsA3t5V
         olZbJEqspEdwhgRby/TstqK9TYHw3UojralDOWWy+m7Ubgw8lyBsSTBbWZw6hb+GHQBX
         vDO2VBO4XCk1oexRTaqfwTuLePrQYdGPWu3qtWKOlwuIQRryZ9Nv6smOWFX4r2Hd7ZqV
         i4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNBEDUKNEqYOnDtXko20E4dFiYvoGjkXn+0ji+BuST/H7FhiLoX8T9M9pJWvW7R3SKz4lcCBSqHMe/8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeyr5pZw1qBreQ1Hr8SyWQoH9sECIs58GT3F8bWVqwqWSUC2fS
	loKeuS6fT1ihq9+rs72B+8JYX2Sb9qfjyv7pR9tjO9Wk6oi9liptG56M
X-Gm-Gg: ATEYQzw/6qu4btOu4TMd/7JW9j8D/nuiFe/njwu+11+JHzXd965C5ho9IIncLdmz3fE
	n0PYh49gGmYPS85z9Y2OtF02AnViAklUlTXX3H1/hxgDt44FKLOEectu5+nrDdGG/CPPS2vml9a
	TcLci0/cOZomj79pXrLm6iIVnGkmrKoOayrMUtge3QklzTvD68BOkhC+NKxF6GJden5XySlz0bb
	wR322OEnPQoG9wXFLabCzDlZAr54T0YY6+KxrgI/0RbjqRn369cx83qObtNMPIE+B/fFFVytRgQ
	OHDu4zUi9ewfHD+EgBgNYAnUTP50zqjJSgZ08uJHXwUzqDoMLwhxW4C1wFHVxcvh9RUCDz+lNZb
	4hu2qUtdpuXfbmZIC4iC6UM+E2fU/9ti8KmoELB0/DRyTz+begi+bPsUWUaHMZtcGEG5ywKNWL1
	VbjvxtmvkVwdhGcbZXRiLCe2n9CTQt545V+N2z6b6X9z/qp2+hBIz8KEki4Shc0uqJ6XglkenCa
	K8=
X-Received: by 2002:a05:7301:5f14:b0:2c1:2706:b412 with SMTP id 5a478bee46e88-2c15d28bd1cmr2464011eec.5.1774455018266;
        Wed, 25 Mar 2026 09:10:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b7b4:352d:eb23:66e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16edc0436sm39305eec.22.2026.03.25.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:10:17 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:10:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: kees@kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] input: pegasus_notetaker: use HID defines
Message-ID: <acQI5JFR-aUiBeW8@google.com>
References: <20260325143256.371854-1-oneukum@suse.com>
 <20260325143256.371854-2-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325143256.371854-2-oneukum@suse.com>

On Wed, Mar 25, 2026 at 03:32:47PM +0100, Oliver Neukum wrote:
> The driver uses its own definitions for HID requests.
> This leads to duplication and obfuscation. Use HID's
> definitions.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Applied, thank you.

-- 
Dmitry
