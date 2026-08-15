Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E78632B
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786828107; cv=none; b=ZlxcBqbCzp8/2d63ysT2H4XASpR/u3G+GDFHZ96X0zlSULk0BChrpkqo0nUsYho5/v/RAsaabcqJgMI5aSRSDliBuOi8IZe29HUqvsQl+Tbi3o207PRKsJW4RmBCH4U/G4atwxwJqixKWuBMQCh+1m0A36q5s34DizZU2hnyM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786828107; c=relaxed/simple;
	bh=XKOEVoyTfwUoCmcAmKQ1YP13jKBU61CswwSJSCo7nqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zt30xJ9r0FCx1vzRrxlYSe8/ejSnr4UdHPmuNa8dPUTV5/CBLjbtiDe/mjJNDMaTn53r/RNAelxSYEqEmzSWMB8It7aERbf4v1H0UqG4nbKgze6kuLfohlE21kbBB22AtqXN1boQW5howHqCDb6XhqyY/GdLdXUrZK+75qcHaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rsV4UEuA; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsV4UEuA"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39db07589caso16270081fa.2
        for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786828104; x=1787432904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKOEVoyTfwUoCmcAmKQ1YP13jKBU61CswwSJSCo7nqs=;
        b=rsV4UEuAC7b+UFmjkXc8X63Idg0oIQ5cpKow1SXn49JM2BsStk99Y5t9+L68G9eol+
         n8xQ9NVQ+FfbBD9/GJlyV3QK5b6OF5GfvzPV1LlcHAWQaP6oX5A3o9CNwGXSBbiaYjis
         n3uo59GcgVYfhOC/F0YMNip+Ct5Ep0yQhEJcg6nt4BVEmmMr28ugCOFKpH5B5U1gkikT
         dcOtaeLtKbwI5AKkXhf7j94TXMSwOFMgZTjB8m9Y/dg6k93B/rt139r7fkyieXBeI8bY
         EPuT/EWbqyOiAvMRL0AJRwRfhfH7UNU7YRXYMZ6A5DUTIMJ/W5n5B6FZqmhUmLFnvGkf
         PzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786828104; x=1787432904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XKOEVoyTfwUoCmcAmKQ1YP13jKBU61CswwSJSCo7nqs=;
        b=PneK7WorXSxALaM2o0xVc3TkTR2yvz0YwxqkEqKtBL/BXq0Bs6ypfLdqh2msY1FVX1
         ZOoznQlqbvPbhN5mB4pHW/7C0ilNqbJhlHH9PN5fXDT4xzuEMz8eO6ic7RYgSJD7JNev
         683Q5we1drToWE1kTqCDz3+55JV0f2/nMzB5+NCqorDn3vdR6maxt2RUWrkc5Xxxf+TH
         ohYJOctlxyIIXiMZLT4RVH7ch/9ixamoThFeUH6D1Tug7vJ6hVhP9tUF8mueuWShstc4
         1TQdXdPcNxP8DVmozFPijS4bt6OYjAn+jnqZP4JjcTYGemWnkN82HRYYgRPIDA1dRN0i
         LWWg==
X-Forwarded-Encrypted: i=1; AHgh+RozyjmYS+2iWNVxV4wgPEY3dfYk+i6mBcL9fQ1iUAICkOcttEvAc+Z1KXdsvufXtsGuMPU5Ft5lM46JCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuNq9/ZknhIB/K65r7+JJ+gM6R0vZYJvyJjgJ27XNqtX7lwZEO
	YYcfUIULbna9O5PuBF8mz0HUP8PgoxP156AuODyKW7CQpZKdhWUR9vcD
X-Gm-Gg: AR+sD12gDBnwCKrCjQLwc3x2M4UWwpb1wRDEB/cd0vg7B+C4eXFoGHLrBHcSRiU3Gl3
	PBj4fHIA1+uhVo52MppBIgnhuLbI2bM9GkkV25O+avlYKfg3vBqezpaC//VKZQqwAFawXazoeJq
	zek9ARnJ/F9fd5ZAon2a7RyfD+IwYE3hO5rdKWAqitKS6pflgqoT5FWzvaxGC7hEHq9ZZneufS/
	Yo4yLgZbYyhvR6rvcVUatreM6e+VhC9Yg2HvEmnzyT3CfLm6xkeQYt47jjOhfpcn4vEJC8pKnPY
	dfx55MAfr2UheTZ4kKTCmtIyTBe8pP6bAF7N/Yg4BvwYyQGq41dDyYGIcet43v1eWsR3Tbh2IS0
	/RUW59jTh8tKy+YRGZbbzi7n+GDaoUXCG2x1+StBunGMswqWxnKPpUTWpOzJhSeu+Y6J4tJAgW3
	4+os9kkjpi67cr9JyOcK0apB9B4L1ZwVwQu1mmf88F5SCw4N34yRejZZMhIGbw1bOnK8+ES3qWh
	7up95VP2mQn+Cmku9NwbCG6ApODhildcBsM5QWTLvk04y0RL59coAvuvhhbJf6In1BqIfpT8WWr
	IiIsez47eVI=
X-Received: by 2002:a05:651c:2227:b0:39d:b5b9:f0f4 with SMTP id 38308e7fff4ca-3a14a041594mr5940271fa.10.1786828104142;
        Sat, 15 Aug 2026 14:08:24 -0700 (PDT)
Received: from localhost.localdomain ([46.205.206.103])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a130872f84sm12958501fa.1.2026.08.15.14.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 14:08:22 -0700 (PDT)
From: Oleh Kuzhylnyi <kuzhylol@gmail.com>
To: m13940358460@163.com
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: touch screen - cst816x: fix gesture handling
Date: Sat, 15 Aug 2026 23:08:20 +0200
Message-ID: <20260815210820.585452-1-kuzhylol@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815021821.2896-1-m13940358460@163.com>
References: <20260815021821.2896-1-m13940358460@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 15 Aug 2026 02:18:21 +0800, Jianing Li wrote:

> The controller reports 0x05 for single click and 0x0b for double
> click, while the binding only defines keycode mappings for the four
> swipe gestures and long press. cst816x_gest_idx() currently maps every
> other nonzero gesture to the long-press slot, so unsupported gesture
> IDs can be reported using the long-press keycode.

Officially, the driver and DT bindings do not configure or support the
Double Click (0x0b) gesture. While the hardware may support it, the driver
does not enable or map it.

We shouldn't handle gestures outside of those documented in the DT
bindings, unless the goal is specifically to ignore noise on the I2C bus.

I re-tested the original driver on physical hardware (Raspberry Pi 4b with a
CST816S display module) with debug logs enabled, and I confirmed that no
gesture codes outside of those defined in the DT bindings are emitted.

Best Regards,
Oleh
