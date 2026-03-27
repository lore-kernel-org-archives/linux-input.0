Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99834A789
	for <linux-input@vger.kernel.org>; Fri, 27 Mar 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628283; cv=none; b=Lpzk88e6c+Ynea/2JDOBvwd2p8Cu8WKr8nBBgYG5q6ESOd6mOSuLNiivZK4ZvTExclOYBwS199wvxEgu4FeAfyrrAYXRWeU8ax1MOV2xGMvnOmBr2nsJ5kH1sehqHQaEBF2Mxed8OozftJUpHeQj3HAQ4YkuE7Pnn4H0ry9s2ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628283; c=relaxed/simple;
	bh=D+n4XyuGm532YgpEI6QRVOxvm8vdS0iG4qzNK/+2sYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLmdGJGPZe0CXH6HYnHvxU3iMtiV+jnqJzealIVMgAicm5T2K2yjvOjCx2PQwHp/JNWD5nomLZJS9vdny+yT2E8j2mzORehoOItazPrQMSwR15wl7b/DEpaKkPf7HL6XLjovwRTqrZI43VWDYUuPxPKCuTSMr9QQ7lB/1E3QHdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEosQeqA; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEosQeqA"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c1092cc08cso779218eec.1
        for <linux-input@vger.kernel.org>; Fri, 27 Mar 2026 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774628281; x=1775233081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHQQPVThq4mOhV4TGIDKWbB6lIErqzzDNiG+cxWJT80=;
        b=bEosQeqAKK3ucOx84BbgMfWbM0NqfnipcXnqCDZOr1xm5AAmBquS6X2VQEQp0guNyM
         kSjPcrezW9gqADXZZCf5Xd8NAaBBhRuPK/6yKgj0SA/AuCzy6HCH1K+Dr+p+tRylhSlU
         8ClHCwIIhUt3+4miorVlBS5Y+H9xcU7YkaGKXG6SKxrQgnMCOQh8NJBBDH8x1etCMe1t
         Z2ke0mGuS8oMlQZpVk3D2bP/L4xq66c5yFqXUoDxh4wSMsRU1X0Nz4ChATjRTcg3GE64
         UZUBEpeMQ7lMBri7brR29IkGCFGj8cxW0tZeMCHWJ6m1y6u4w1bWeCIBIAXp2XimHktR
         h4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774628281; x=1775233081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHQQPVThq4mOhV4TGIDKWbB6lIErqzzDNiG+cxWJT80=;
        b=PEY6DyM0cnxt9UQD2h6t9vockfEEW5YVtEr9+08TDFqiSk98skGWKkpI0FzWRzp836
         qkChjzIGXmTyCjZgBX/y38NVtOgpLc5TmGUrZrVMeoFAx3CGGwcvEP3Z3e78rrZ9yN7O
         1THypuqIWlemtBm0ozcn35XtKl6Hozluzz5yhMTnZiKl26F9UxEoTQ7AgOo8EcAWwbhi
         7b9btJ/QS0/3NoAXJCZ3Wrb3k9QpAEJXcLSShIwHIvXIEsXuIgR3eYHtN2kWXHBQbH7T
         VzdqShvLgUTCjknD7AEry+h2ER0FaqG20a2IXE8gzyf1Xrz62pQ6QIRpxBTSBVBBZbCc
         9kuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWWsPOd6QLDdUPA4c2T4bNzVd+4VNlmhsmIvcSj5kMipF1o0VH5jzUEtQ7HnululPTpmXHRyw0W60MeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxuqMN7/J4i7zZ8oqP2sLd3GBnio1BdvcsEoA+zqLE0X2/42e
	l3wNOlyhM3FDYb1PjTRVjPGJtCCfoLaUuSKolDdWuPMWxn/k/BKta1KF
X-Gm-Gg: ATEYQzwSf4jB8C4E19td+Dz5NJJGhMPRWOtExLtYaG40gNBtcyuQ1qLu49/8hJUttLS
	UN59mx5dZDUEJfueZvFEvjnhESPpcg5NxzP/rRwUXdv3gOh3bCPSnbeudu7hgg2EpngWgK66JJJ
	UZavz+vqy+mbuiJ784JvNypq4wO4Yk/zQwO6sqi63Ir0yGQCQDdAg72KYqWIlkJLX6ofG9APKRZ
	PWqSm97RX+H83YYYprwWNcn2c2nbb5CdXsBDFyRaP/df78UqjH/opPJm+jN/WDM3SLQnloS/a1j
	GE6DlliUm11FU7zzmFAOF/967GyIGznWTcCmK0iIhfCKGvTInd/YmLWjuC0GQsleNcZaIKOrNlL
	Hj1vU9KZlmV5jfDAw4Qf4lrUoXoyIluNSNJkZtjz5JLLriATi5PoXaw0PnQR+LBZOUXXJ+TWtBj
	hRCFK7shjlzDA5VQYiggE5C2GI/28fUHHYb/9KE6h6+CSZupyuivz073k1wk83dDLGAmqczZu1W
	O4=
X-Received: by 2002:a05:7300:3254:b0:2bd:c285:2f3 with SMTP id 5a478bee46e88-2c185c91172mr1676865eec.6.1774628281102;
        Fri, 27 Mar 2026 09:18:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:85b0:37ea:7fa8:4717])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16edc047esm5308046eec.23.2026.03.27.09.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:18:00 -0700 (PDT)
Date: Fri, 27 Mar 2026 09:17:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Akshai Murari <akshaim@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: add keycodes for contextual AI usages (HUTRR119)
Message-ID: <acatScfJMhlD2uOj@google.com>
References: <20260327065446.3467352-1-akshaim@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327065446.3467352-1-akshaim@google.com>

On Fri, Mar 27, 2026 at 06:54:45AM +0000, Akshai Murari wrote:
> HUTRR119 introduces new usages for keys intended to invoke AI agents
> based on the current context. These are useful with the increasing
> number of operating systems with integrated Large Language Models
> 
> Add new key definitions for KEY_ACTION_ON_SELECTION,
> KEY_CONTEXTUAL_INSERT and KEY_CONTEXTUAL_QUERY
> 
> Signed-off-by: Akshai Murari <akshaim@google.com>

Jiri, Benjamin, how do you want to merge this?

Just in case:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
