Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A129D294
	for <linux-input@vger.kernel.org>; Fri,  1 May 2026 04:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777611515; cv=none; b=fnb92q5WwW0cGQcmXQ88r27DRVNmxpBXrlNsMWJ0GstCNv53KAzCkw5kyq91iD4jQ4Ud5HXG28TPWT/AE81lev62M8KonIJmLWTzkoC3Yxphgr7cYYXgbv0QEkxcr0USpKniBPQ5wJCED72uNQAiRWL1Ac5zOuyeQRhoqmEFGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777611515; c=relaxed/simple;
	bh=tdU8YY96P8aS4onFWRXSJvfYotvS45VlIad9aLpAvDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ht4hL2SwreDvVlHdSaO6oc+y6Slh1IYQCbLUuIUDh75PzIMcgfriqCwCjMWeOHQ/Ka3NT+FvnsXQnOfUJEgDY6+O7a4LJm3EUqqIjmhlnaMtzXAICGDbmitIUhOfBe9U0XeVsMObay/tKHGm0iRsrsSlfES1Dv2Glf/hIlERsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbIP4dAF; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbIP4dAF"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c19d23b19so2453371c88.0
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 21:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777611514; x=1778216314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EZVXvV64KApiaOjGiC5GXYBkmQwWs+olbrbOlrpU7rc=;
        b=GbIP4dAFA2TD9TqLc2Eqsq+UDnVzDSqwt/wPU/tejIVA4ax/kfjJg50AZY8mq41OdW
         GCrtkwJPPj6lgRV6hXQQBy9nXA38aN3ioTOVPQPYmLhF1c2cx/6JDQHQ5suGh3jhAH9G
         MrPdG0TK86637zn0V/ou1cwIJWMeHHqJWK43BjQoeRw/QjEVIHVyP6FYVZakS5uaRNN3
         AcdYBQBjJAceJLQjN1yfqujgWOmKX3Q0sWY3hdpnNdt+Xt9xPu8ASbfYVtwrzLmwRqLu
         Ex4tGnO27WgQwk3SAd+SAA9qwh9akOS8nPxO/2xqWGAzJALFepxp70t1dfoUGyxMmYaq
         YXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777611514; x=1778216314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZVXvV64KApiaOjGiC5GXYBkmQwWs+olbrbOlrpU7rc=;
        b=Kewb20c3TNUSiM0MHvs7q9o4+f2CPg2Awe1fCxFB15tQIdYtu64Kw24zDh7SeXuqYt
         raESn0+YJS7odp5zhI12oAgjf7f/0sWqxll52Hh4r0EkLUH69k6ErvsZ7b9Bpy5Sg8FR
         CHVShaytWEA4Gpj9MkL5UQs7w0gvFcpuxChk9NnfeHWoiB3KvbcI/zcf7qogNeVtdBl4
         n8pwficmlTv0873J8P7/08ndnSsmEuTPmHVZg/S8F/qc/+jus4oXXv9ChEfg7IeUUSWg
         ork4+0+qoHXMrUSgQ/2LkJz+CaZy0GEgoB+xQNxnseeRLhg4Gh+ujEZX7OzWkIBd8Yzu
         f8JA==
X-Gm-Message-State: AOJu0YzUY7QrX9xV+0Uksp3GHaohYRXoaCC1qETbmpv4qvOMiULL2Ufc
	d4iYleWyn+XQfPiTT/cRgQTxWbqF6cT5mTQO3PoXBIct4mPnLIlyNEit9jZnGg==
X-Gm-Gg: AeBDietCyzB2+c1JKZZ/5tALX6xLWnpzVOqn89PjWYNyJBqLWeEqU6hv/gOob/5Fuua
	QzPxiYVsNASXTHTx8ekPMRXR7lN2Yjc25WGu2YbtppBob+kYaDzhRVMyWpRkHy7L4K17p9cJRNO
	9Epw2l2RpUxU305tPCPLdAf+EKsZB3LBBntnYR1mmgnED3bZqAtYKan5YPYHrt96Ra0C7o1M/k9
	GriL/K+wA7nVc5SObqWg7fiYyDCQyX6fv7Ar6LMWog5avbdKVeQxnHmte4xHRrmilKzCpbvyO9s
	fmI4Isy+fHLCCMTlazsahcOchzYtbv+ShvkESXu0mJQmckuPETggkSU9GGBXHzSi/Pj4rc02hCv
	vq1k90k2DOAFfSAGMjUXm5QD0koy7AJAsFg4E6dPTXn3bl9H3CXkAR6gbagV1tRuh+fDfHTHIay
	WrMW0cqmhn8ivSWVlUVbxgRxTGp7Pd48b9dIZW28AMZ2d7kuwwvJYIvgPMnZQo1LlDiKeFHHRRK
	f0=
X-Received: by 2002:a05:7022:1702:b0:12d:ccf5:271c with SMTP id a92af1059eb24-12deace0f72mr1179952c88.22.1777611513565;
        Thu, 30 Apr 2026 21:58:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4372:f619:5d87:d4e4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df843f04esm1421359c88.13.2026.04.30.21.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 21:58:32 -0700 (PDT)
Date: Thu, 30 Apr 2026 21:58:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Qbeliw Tanaka <q.tanaka@gmx.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH resend] xpad: Add "Nova 2 Lite" from GameSir
Message-ID: <afQy7-nP_0UApV2H@google.com>
References: <20260211.101707.2126959894059795107.q.tanaka@gmx.com>
 <20260429.162040.930225048583399359.q.tanaka@gmx.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429.162040.930225048583399359.q.tanaka@gmx.com>

On Wed, Apr 29, 2026 at 04:20:40PM +0900, Qbeliw Tanaka wrote:
> Add support for the gamepad "Nova 2 Lite" from GameSir, compatible with the Xbox 360 gamepad.
> 
> Signed-off-by: Qbeliw Tanaka <q.tanaka@gmx.com>

Applied, thank you.

-- 
Dmitry
