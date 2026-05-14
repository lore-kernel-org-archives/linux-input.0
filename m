Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB013C0A15
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778791458; cv=none; b=HhpTysXDzu77HFQLtBynImNft0zbGRu9uWMAFW93MxYO6eLHoLLgNJHszh8ej/ngElfWpZNH66gV2PKYqqT/+E0V1uWkZooadU3BmPInnI+vcBszJB2FuljDGXmIlGKLNQ0GdUPkJEThuLjnY3egkmtlOjEQRVMoucQVwVuy47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778791458; c=relaxed/simple;
	bh=c2MxMkMCSQaI62ScLqlw0pb93BIEdwSXBPYFrcu7Xio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqQouXYJXY7EaWfZ9jWTh65r4s/uJ+ur7jD8FqmBwPcXVmt3z4x3MmxuFgRUPFmSaRmKLe+w3Ft4XTUmS99khv/TjDgSfaWSqZSmLZ37+8qFa+GPSQ1Lq/cbBeIWm1bYh3gzALcXKtZ6lWfd1ZFemPqMSU277Rd4gm39bfVz2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEDMfqhR; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEDMfqhR"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7df05fc49e5so7975096a34.3
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 13:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778791457; x=1779396257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2MxMkMCSQaI62ScLqlw0pb93BIEdwSXBPYFrcu7Xio=;
        b=OEDMfqhRPDRJjvvLsQrXFWrrE4lm/ZnWoKW//ezh8/g6XKmWBGTHHVaaazBs8tKSGq
         FdaPOB7uCIuXqYMt+EpG1ygZfCY3hHlFwTh/I9749ttfh6hX+EqPYXJd1ZGrIYUPq/Mr
         JS02hEMETUxrV//KKMxO/KUEqf6ywVfy6CiBZ1s+DIT4tALH+/qpVmJCwwNRxhYiy9Ew
         I4SdcENrM+iTw1KFmaHfIa0RTM/CkUFMJixYDliZXTV1ygArli5TUS5JzWBdkg0pMtFh
         Pj093Ej0X+wr2XBa5OOpnewe9gbRVxMI1VPRhAF3Khl+7j8JrLbbETxs7MyeKToWhugd
         DNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778791457; x=1779396257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2MxMkMCSQaI62ScLqlw0pb93BIEdwSXBPYFrcu7Xio=;
        b=bttEpljV8/EmaILW0A1zKqHaXsGYIhXoghIF466RhY2EWpWtFKynilptC4DKz90hIa
         hv1C579H5b3cLsxdOy0e14QFMJJnXcICgm74YJ4KSWrQv0v0e19cIWjs+bcVe+hSSb43
         dF/EcHxzP67MXnJ9laBv+0plwrSiF9WJXG+3/hauHQ2IdfJ2uwvk0tHPqs7mIbf1KnQJ
         Lnw1mpkvFQtxaoY6FdS/1wOvXYADmoJH8v1bzrTtau4CneyKdxjUKyM0kgSRoJjhOl3J
         f9ywZ1GrUTA8jvf3zZHbCl9K0wEQqVnGNz2AP9fBHx5xi9A6P9/GzNRRLJUza1lvGsog
         wHig==
X-Forwarded-Encrypted: i=1; AFNElJ9vbmEpJCbn4uYJJdma387NOqj/sXv7k2VeOAOEmhiSm+0SKv6TQD4Jhn/gNPeYhv4OWlxrNyYzv5GoRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywka98GLPVLYvNlHsWbAgm35p7tb+jODqMgC3Qg8uuPFV3BpGMk
	5PqpqJZOx2DjDMPrc64PmTMuRZToRDFtDYx3RMdS1rUoLOu9wDlSkCGGOSao1Md7
X-Gm-Gg: Acq92OH2wl3CMAcva9bZ6CZoPhzOyzDWfHOYNm0ups7kpy3L9fVUWwBfb2mN/+k9YIS
	kQQ45yn0ckWO9eAYewr9PZk5XBrkN9DeFzWztRTr+cTXi3bB4RNrU7ymejgErp89FbYZeq4UQJS
	X46wQCyTL0udHe9UnQzN7b6M52mFUvnrZfD4JSPfdloOsv5vlr6JmaK+vCO/J0RAXuf8LQfCE7R
	hIFSLGFAApIBpsszDfcwITXrtPbVpBE60UV2Yzg5MVFo4SAPdcNQlDlPdKYVf9qaAOtbT1/SiQ1
	wXM4LrXI1Zv6sjrv1ZqgCNXVSAinhC9biy28qWkXJ/Yrn2hWrpzdNbnUeVaaPLsK6JpXy8gkUDV
	muytn+DkY5cmDOSe7EqjxRTw7Sx0iYYj2ANIDv/I0os7T33AiF8c6Tla8B40VznUvs83kRSQdHU
	2yPXsSCdFf2dAqnLyizq+qgwMDq1XKyuuDkCQIhQI=
X-Received: by 2002:a05:6830:82f7:b0:7dc:de0f:b640 with SMTP id 46e09a7af769-7e4ea19d54dmr623284a34.6.1778791456681;
        Thu, 14 May 2026 13:44:16 -0700 (PDT)
Received: from Dell.attlocal.net ([108.243.219.47])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e558c504f6sm20644a34.23.2026.05.14.13.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 13:44:16 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: david.laight.linux@gmail.com
Cc: akash.sukhavasi@gmail.com,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: analog: replace deprecated simple_strtoul() with kstrtouint()
Date: Thu, 14 May 2026 15:44:02 -0500
Message-ID: <20260514204415.58914-1-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509105520.61f823a5@pumpkin>
References: <20260509105520.61f823a5@pumpkin>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, May 9, 2026 at 4:55 AM David Laight <david.laight.linux@gmail.com> wrote:

> However that might break existing systems.
> So I'm not at all sure it should be done.

Hi David,

You're right. It could introduce regressions for users of analog
joysticks passing module parameters via scripts or boot configs.

Additionally, digging through list history: Dmitry reviewed this
same call in 2011 [1] and chose to leave it, noting the complex
parsing semantics were intentional for this context.

Withdrawing the patch. Thanks for the review.

[1] https://lore.kernel.org/all/20111108034805.GA21927@core.coreip.homeip.net/

Thanks,
Akash
