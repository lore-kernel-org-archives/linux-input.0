Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573927;
	b=lWvBe2OdlkC2kCBiA8s6MuYsDuasiXdxjhCOsMpI/lN9wh0wJ2CEut1dYX57TFk5knJl
	 aIxyOkXjeYK+BbD0zEeobcxUFcsg61plexir7FliAfw4cbAujK70Q8bLYnAxSGN4OohL6
	 rOko/kuBnjMqZvE/asNtHqDEUGS9MJIlzq1HhLLZ8MixgfEa3S9wfbcevPfEHyG8FyU0W
	 OlMwdyx/33mxJ2C56HOp8xOT1apjDjFrs0dQuaksnLuoQpe+IWf71CcGd9JcRF/vaB9DN
	 +s9sRI2PtSim31rHJD5jwjlSP0/iYaY7aSD0B77qpRCwW21jOAQeiurLLx3ZBApl/EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZkakucMXa/GLA6c3NEIv0nalbNEBO6xsvd9bftKJ/G0=;
	b=0Ox9RZ74nK+/eBIi/dW3yW1nqrDRbdgcXnMluc3/RJxkfeBGRl1qExGPN1DtZ+12tCuv
	 JLaa7E0tGvY1XE2PoWRwtL2HSwWcqsdl+D2EO1auAuLIegm8ayJFB5WeMjQN6yxI7Z22w
	 fYA+X69VH+7DA9CDr/yip6/SiEjkkWmRKN9HpwXKJVsSDbu6NUvTrmquJPo7W5JwjBfD/
	 g/cVFr8/NW/JuDLHxWQ58Hy1jDnHH9WqIM+lIMhCs4b9X4WAJFkp0n2ZI6JTHQo8kaJpU
	 iEw650MUnsNQsxBQKh8CitLGnm41lqhZkwXMZJc5oAejdLb/UKazu14HSbCd4IRH25Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fYJ1MbM7;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26A606A321
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 02:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D26A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fYJ1MbM7
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38190551625so10520723eec.1
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 18:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795573926; x=1796178726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZkakucMXa/GLA6c3NEIv0nalbNEBO6xsvd9bftKJ/G0=;
        b=fYJ1MbM7KOuGMRCQcWCIqbfMFOr2CUQf/B4ldHnewSb4cE9+E0UiaaU/soSCEPq5Dv
         QHXY0aDlp0D/RDykZzPagQjfF3Bb1TR9D2HLkw5cJJa/RI7l0DS8rmtLSYn372k7W9pe
         FmNcn1v4CFhzOVrhoyW5ihXGylpn8ajH+Gi68rsERfTmgWWfxZocFIqUdK/cpfHZx5RR
         Qd/9xyIg7bE3k5+roqXV1QtL0v8zpAJgszjD3SAefDRhLZsZhhB+FF8UaakaZ0t5dFaj
         FKHLBCZNs1EevVE0mbRaQ/4QDMVCoI1rlucSesLMTKQ638Z5qjL+UwbZ5fZF42mLQeNG
         jbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795573926; x=1796178726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZkakucMXa/GLA6c3NEIv0nalbNEBO6xsvd9bftKJ/G0=;
        b=J9aHunC5ZUcKyrwewxlRc2bWYbUcDcmPgm55HEWvAP75Briy/+5PC8J+9Oyq9WzrGu
         4JD9/0oewWmWq9HUvHySv70j/sEDvv8hZm2d0KvQG8DADyLQdrOoFG8EubLU48dsqq36
         iIXnMaYVzVwy3e3O5fSUwPr4vB3Wgn3yrG04pLe7s5TepZqRfETT89TO8ZSDPZSVUFxb
         vuPiqOfViBeaBXyXWzxiv2X6BkLei9FKSzoV3FBUooCaIVIvMl1dODvUR6ePXhMwy0X0
         EKrr5hVLTJsUbB4tPQ9XYOZM/xwy+5mv0U5HNXYpj6am0zeXN6dEZ7CvJBAZBMoJWnzz
         pMiA==
X-Forwarded-Encrypted: i=1; AL+hErH8E1d63SLXuCWpGcjpyHqzZtOgGhuNBfKssV309XRIDyRhMwz3UT/G64MXpA73atR+1cJ+9/R90n/MNQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HDQgJYEuIXyxrV8W9CDFsHCS0l90pGD8Ug3EKAwaGbDWJVyqq
	W0o7cyKFKmN6OMnKT3SsAuvGInn5VjHs33mQ2WhhyEhP+EXldCIWQVjIKO4aYw==
X-Gm-Gg: AZFdTZd1QVbqOxraEEtVDPvPCI9y9cYxX5Xga0BwtPgUi+BM8fYeCgKSGJH0ZD51RIp
	G92Vt3pd6LE87CPTxqGfSEPpAUAnLRu907Fc2SYHNPF7oRoYHI8gDalBdArc7U5J/HuN3TSh4p+
	aFRDRZfdiznTWTdE5y9SUmVgs8aXPn68KhLikP0GE47OX/WZafiB6rMWF4q0R9kB5u0teqTQWxg
	NhsMpM+SngypcP9xD/mrKKPBQZm3rECGAsctDbpbP8xQ6+rnkRSa7jWpxBMeTBkCmfbWJGHrq89
	3ihTV/0UGrzuH8fugCh2pNGT1r/ALmN9X38GYBkcB508jdcsTdjbALmCVmEfWi8qkD2QSTEcCCP
	03KfiezT4XzyWT735nCE9gbGwxVQ625lF8ORCHsiwdIgcgAdwAB8piTHujiPF4dvvpwAHYGYxgS
	Pt46PC6/hK9cv9REXeUgc+5p6MJM1YAf2TJQxvkRo+lCY2nch1QyGD3q0t2rYeA9fTpDYc3JKOS
	4Xm3w9yONHvJZgXAgmnt4FvPIkUEYk1N43nPB9q3C4KPZcNfe9oRGLjNzyyl58vRCpCmHqIdySt
	c8+An9RvzoOFr7DB/nyZhX1I8W799BcDmJzzO6kYsVL19IDN42QZQB9Y+HTTLFrPxpqoNh4=
X-Received: by 2002:a05:7301:182d:b0:386:b801:cd06 with SMTP id 5a478bee46e88-386b801cd3bmr6055021eec.40.1795573925600;
        Tue, 24 Nov 2026 18:32:05 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ee3b:b892:771b:3bc7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd4efesm50729285eec.12.2026.11.24.18.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 18:32:05 -0800 (PST)
Date: Tue, 24 Nov 2026 18:32:02 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hefei <3066883572@qq.com>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org
Subject: Re: [PATCH v3 5/6] Input: add Jadard JD9365TX in-cell touchscreen
 driver
Message-ID: <awZIEjbpVfVNoc05@google.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_03FEA6A02E8E137CCC5AC97E6F118A3CC10A@qq.com>
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
In-Reply-To: <tencent_03FEA6A02E8E137CCC5AC97E6F118A3CC10A@qq.com>

On Wed, Nov 25, 2026 at 10:11:26AM +0800, Hefei wrote:
> Signed-off-by: Hefei <3066883572@qq.com>

Spare a few words (or maybe even a paragraph) for patch description.

Thanks.

-- 
Dmitry
