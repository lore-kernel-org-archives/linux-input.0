Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D745385530
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126002; cv=none; b=GvpbZRmGbBJZH7HT9w5StI9rJwV3L9/GMFEkVloEl8Nytv1cfZg+sTAM5rnsiYGFe4E+ggyk7Qngm9++a1i5y29t5L2mtO7bQAOUG0yVbqEOUFqREdKpdhB48DOubU9SgwpV5dSH7VRyX6YIXbgYgoBS9PbU6pIv5E4ICMadLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126002; c=relaxed/simple;
	bh=bao+9wfVc4AaxkH2SVBMf+BEqpRCBmpTjgPp3EEiuso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmqBPmRSoNQbxJhv+0bd734Km++32GIWS6GCPKGY6UY9PLOlXrnoLn+tw+d55intIOxZiaDk7Btbp7mH163bq/A+OPqJAx5088UfYUwTSqEj32tNuMOpPQdWKji46XoO+U9S3F73CS4PNLN711RHZzFcQu4faNIckYH34lpRj3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAAyv5RZ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAAyv5RZ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso2029665a34.1
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784126000; x=1784730800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6Unhl6R6oMV8GrpjwS1Licw7UsYPqJhVRljHMZNY+0=;
        b=EAAyv5RZd7L1FqHylDOKL5yeZA/CMdaDuMGuaKXZBClE3tNMqwcPpBcUuoVUZbzweh
         jlS4YUQf+wnyi58DHpZ9QA/4DncC4ZWfkgELDVdfCWmMG0CBR2ok7G2ZVhJi99oEiABz
         X4q3kkwIVzVEHvPluolAQJGOKPo2BSR8nIiPWAmotGbkiGs9N5abqYoDKmJ2bV3vWGDs
         0m+38N5qRJDLZ99EI8kx0jgaCOpQsiyLY8jKg+v1Ro2BFuZ10LBBsPfxN7xZfbSK9F4W
         CywAPN5OtKTCWfD469O3ipLbaJ0p7GqrbpPshIlRsqGGHCdmQarFKD7lmZ+FNPTl/TQb
         adgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126000; x=1784730800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N6Unhl6R6oMV8GrpjwS1Licw7UsYPqJhVRljHMZNY+0=;
        b=CYNwQ0nVWJi6+qlFtE4240d5fukD+Sk2cX+sg9UnL6m8SWxMUl7w98tnxn4m0xRv+n
         oCp59YIEPfRvaiC/W5E3CsvzCRV4FSuYEhpmct0zxx+DN6rBgxoNNTI9JGr1tmccM6WI
         ocvRHj8YlQtgztONvcrJpjnt4bjUAx2fbjighqaCBZFYfC9GHWoM6uU04uibm4TqmstY
         z/tcYsJL457YCI2Cddl1fAj+1t0l+67kxPA81ROOSol0LiOYeAaAOVymfyIQtRfXuY6u
         Vql/dGcdSkqN/eexZquDgdcn6eq2DjORQG5IpIVKMVgp0db43rC2LzEIG0WPFsYipLtx
         NzFQ==
X-Forwarded-Encrypted: i=1; AHgh+RrA1UzwggcWxQjYqmtDArpIHfFCfxpGTs2C1CN4JB/b5E7+f+Tbagm2SBeqNlPw2BD7pqiJZJP57uoBrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqYMkmWqGf7KAX3kZCh4Y+1vpJd5fi/+yhQmA31MA6HP0remlZ
	S35JtD7ZYUklekqERkxI6mj9QFig7uEAll+ZZ+aXKD3ncU61q1V69MKp
X-Gm-Gg: AfdE7ckaoM/fl5hDFkBRR1kzqcymflehph9ZQDmpFE40kZ+blh+O1G6KbBp008X465E
	UhShC8gVIrg5qLsHen5pnkOxpJYyzDMfV5vThMv5PELxwvTSdC7Ez73Hw/rWrsWh9XCZsxGMObC
	I/9OgrPzysYv5+wRqQ8zptqQT4UY/7ENcsH+lsWLzB+zwJL390kSz3iyapoUeO6gDHFZCZBF9vD
	UoPtonRk7D0W2CIv/8KOhLOMpX/b5RpVPnNE4GSr0yHiuImITZBGPKm6maw6B9mtFdvFO9ZhU9J
	gieccZ/4J5sw6sKM7u6tcATRZC4d4fJMbyodEZjifC+IY3/EDUsJqUZHwtk8U29e3Hc75lCR62g
	K90LH6QLnFgLOjPITMJJl/wy7r8ZEzrur00arppRnSZlW75gxU11Fcpc7a6/7DCR93XFfzHetSi
	G0QoiAW2RmGw==
X-Received: by 2002:a05:6830:6d4c:b0:7e9:db7b:6d5e with SMTP id 46e09a7af769-7ec59aae78emr1616121a34.5.1784125999743;
        Wed, 15 Jul 2026 07:33:19 -0700 (PDT)
Received: from fedora ([2600:381:ca0e:289c:9a0c:2711:542f:e3c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm17584114a34.8.2026.07.15.07.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:33:19 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dave Carey <carvsdriver@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 2/5] HID: multitouch: Fix stale MT slots when contact count drops to zero
Date: Wed, 15 Jul 2026 10:33:12 -0400
Message-ID: <20260715143312.32408-1-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260522111527.69428-1-carvsdriver@gmail.com>
References: <20260522111527.69428-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiri,

Gentle second ping on this patch, now about eight weeks since submission
with no feedback.

For context, the other hid-multitouch patches for the same device are
already in tree: the INPUT_PROP_BUTTONPAD misclassification fix merged
to mainline 2026-05-28, and the ghost contacts fix (MT_QUIRK_CONTACT_CNT_ACCURATE)
was applied to hid/for-next by Benjamin on 2026-06-10.  This stale-slots
fix is the last remaining hid-multitouch patch for the Yoga Book 9 14IAH10.

Happy to rebase, respin, or address any concerns.

Thanks,
Dave
