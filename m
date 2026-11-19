Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070610;
	b=RdxiRNY0xCd6DX8c6HbzMZq+dhFe/3cxqD2gv98ubrvBau8N+IyWpTBWVQUW3uWPa0Yp
	 h17JuWK0CRiZKTbvASyftHzGPk2IYaj22KHfjBN5zmJVQu9m3riNJjh183FtEQxP4LxzM
	 Ehwu8xfzsjmh3FYMoeSO4w1AV08UmpdZVdrUmYNdGGuF/vXDz+QuakTaYbPTzJuh8DN7e
	 aujTK2G/erS86ax8Ij/5J3uQAmDffj0NFCT71daPeP/s7V871pGNBKjdioZ9UORCNHFjd
	 Tgs2MBz3JYKFhEBOMwvvj8sK70KWUKSNMTgu1E9tJDc/rXCE5b9mAA5kLE/cZucpC3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tlw/MFAgR3dlvJ1uhPp3TNx4s72LXZKJq2RTq8GSaTM=;
	b=WDjnYV7FJB9gshqfveEImj7dUHIZQwhCiJKH1hFY5yLOnGAIronzWNPnqTSQnIg+6gVc
	 HT8Mx/7TXD746FcPBZJiZ0O4SShH1EncDcnQOwhw+6ll73WSoyN4HSj4Tsc1dXdeUD6Dn
	 ncGsNewpsFVJVlE6NJTo23L8s9pwcwd4HrwHX50ik02BEu733bdoHJAd0XG0ToXCSj9b7
	 av0yZN65snF57Jnpv2eCXSDFz6QZN5DpJQdwoUOdGWV199HRjW61uLVwGoClKJ7c7XvFa
	 eCyG1RkFr2g/il+Y/TBfEh9Kp+Vj7Cxk1nF2r4/YYNlRIj+qKiO9ZQ3BVpgQVzNAG3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="M791bM/E";
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFF606A326
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 06:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48CFF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M791bM/E
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b3af93b85cso1045410a91.1
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 22:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795070609; x=1795675409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tlw/MFAgR3dlvJ1uhPp3TNx4s72LXZKJq2RTq8GSaTM=;
        b=M791bM/EJ6YDr7z6lKX8YSF22UffBSA9Fa+DCJFUleFbxsXZiFoAi/xfZ9BehWd6M3
         WEGlD7o0/6flrw6VTWLQkXt321yG8isfrs/CcFfMx0n2hH9Z3F9mRMVUazJ2yfBiCPWS
         hH/FT7nomy0RwanfVtrUClrQHnca6PGaz1ifwKiOmPzFq6oeij7XUORx5LEnN7jw2Rqs
         IoF99aZldktmoceKhLx8wl2r6RWj4L98OcDS79PkOqsLhTjOradqe5FH7rSiQl9tvu+o
         5jQsjGa7plxWJoBYUjldy2c6EKvRuSWUm9jTMCXu+uTinAH+/xOZUFtnIExS0EQWCjAU
         tdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795070609; x=1795675409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tlw/MFAgR3dlvJ1uhPp3TNx4s72LXZKJq2RTq8GSaTM=;
        b=uTTbydIA0Pb9mf5A8VwKpz+uBYQX9RW7DwnwsnQ1X5Xz9hOCffSmr2faENPtHKmoZp
         L8gBUfldlx+7Opovwk1nd+AbGksR+gUq3G0vhHHtH8Dwhz3Hq12/otnayqmEt1Xk8sgc
         MnwHH8/0KaOzUSvQjK6OrPz2LJUyLFakZpZVo7eHHs58VpNLM5sfUBAP+QrCk9wlSUSF
         DkpCdfVFdR3dwsp1UHtMfSRAm5dEiYnEmWlfzE3gx3Te7xoSzhRdUKw+ioxQps5S5C37
         oKccz8mF62qayHdmsn7ugcT0kuYzdVA/74WhoMyZalyANcbsn4ngS5Y2DqtskWWe5Vuu
         wycA==
X-Forwarded-Encrypted: i=1; AL+hErEd2/kouEfL7MyuuH6x1AKb6leD4Wx1XwSjDqAR6Am3yP2Nh0ltuv0sj1PxYXNnhpco3uYB2kZLExeWug==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Sqg2VJ0oyl6YOUXfZYhDZ5K3gcPg4rJ6kOaQCB6+Vtm4/q9pS
	Mj+yBh+G/HTRyfYZ4yZY77JajPNkXVxesnWWP5wpG8pFjqHvJ9fmznpr
X-Gm-Gg: AZFdTZfqQQgvotcPwY1/mTvoNNCaI9kx4GJcH5HfeHiWjCUx+vdUenK3R7YEd3kgAw1
	enafUEYTIy9yrHPKRnMoJEWNk4jKWpAVmJnRaEwykfyRwIe4mvOBxZKiO2oXejjIzKa2ZcG5uy9
	NnPwFrZ8gryFVH/haiaxV4mrVGWNM5q7vBepta6ILx6FK3ZBOaJ4X4N0TlLtJLS+DmLMXe/L+3A
	NyYGVVL+i85HiphKkVIkDh5J2RkKZfUZQXm7I6SUzOyLncd5Hjg0bmsRMlgTFlyFdO9+ZWPK/FI
	A1IGbrIw/s/hfXxFm3YrTbE/fkZkf7QKKXuRGX5je4nVRkMkb49e5JMmz8fNnnlo4ks0sA/jlpz
	+7eaat3bMI5YmqISIjHkK2oE0Zw4EtrFbkuxtyqbnl62Oexp3h/kKypM+vTfk3IScXrx3PS4hky
	rgcVXE6Tec/O6SPSZHICTUTPKdifenTYH4/bVD4l1d748MkbJJGfuXV7VbN0N02pdEaeI+CnUDw
	K75T4lKvw2nvQdbndbzg0hKidSx1deeaDYryhZdMkAPUcQA9IRIyte30tlGdHgmh/Zoo3JyaQbO
	11nuGOf0LGUsjWdjFAhKznC6cdplk3x+m2DJgAXz78zKu1NiOm6S8IbbjtMRgUd4Kdp4SX9gpFU
	TjOtWTGH5hGamsCOJX0u1S3SaPIQJ/PmPt5qgblc=
X-Received: by 2002:a17:90b:390c:b0:3aa:548f:eb77 with SMTP id 98e67ed59e1d1-3b3d07bfff2mr5487494a91.56.1795070609562;
        Wed, 18 Nov 2026 22:43:29 -0800 (PST)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0114fd607sm13890335ad.73.2026.11.18.22.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:43:29 -0800 (PST)
From: Wei Jie Law <98lawweijie@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: andrew.smirnov@gmail.com,
	bentiss@kernel.org,
	e.velds@gmail.com,
	gideonheinz02@gmail.com,
	hadess@hadess.net,
	hansg@kernel.org,
	jikos@kernel.org,
	lains@riseup.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stuart.a.hayhurst@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 22/33] HID: logitech-hidpp: shut down G920 force feedback on input unregister
Date: Thu, 19 Nov 2026 14:43:02 +0800
Message-ID: <20261119064303.274901-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110-hid-logitech-hidpp-v2-22-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-22-30743e91d83b@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 10 Nov 2026 22:48:20 -0800, Dmitry Torokhov wrote:
> Force-feedback teardown currently runs only in the force-feedback
> destroy callback, which is deferred until the last open event handle
> is closed. If userspace holds an open handle across USB disconnect or
> driver unbind, device removal frees driver state and destroys the
> command mutex while queued force-feedback work is still active, causing
> use-after-free errors.


Hi Dmitry,

I was auditing some HID drivers and found this exact same use-after-free.
My analysis agrees with yours, but I am replying as I think there is
a stable-tree gap -- this patch does not have Cc: stable and your cover
letter also only explicitly mentions the "first 14 patches". This UAF is
worse than a crash and can lead to LPE if exploited.

I realised this patch cannot be applied to any released stable tree as-is,
which explains the stable-tree gap. It needs ff->stop, added by
ef166ce08801 ("Input: stop force-feedback timer when unregistering input
devices") in v7.2-rc1, and it also needs context from earlier patches in
this series: g920_input_open() from 03/33, hidpp_dev_groups from 20/33 and
the reshaped hidpp_ff_destroy() from 18/33. So the UAF fix cannot reach
stable as this patch, and each tree would need a hand-written backport.

Every LTS kernel is affected: 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y and
5.10.y. In all of them hidpp_ff_destroy() still destroys the workqueue
while hidpp_remove() never drains it, g920_get_config() still runs from
hidpp_probe() so FF init succeeds and the workqueue exists, and none of
them has ff->stop.

Note that I only mention LTS kernels as 7.2.y is EOL. 7.3.y is a special
case and only needs the driver-side context from 03/33, 18/33 and 20/33
since it has the necessary commits brought over from 7.2-rc1. To resolve
the LTS kernel gap, I would suggest writing a minimal stable-only fix to
resolve the UAF in the remaining LTS kernels.

The alternative is a hand-written backport of 22/33 plus its necessary
context (ef166ce08801, 03/33, 18/33 and 20/33) -- which seems like a mess
to do.

If you'd like, I already have a patch for stable trees that I can
contribute. Let me know your thoughts, thanks!

Cheers,
Wei Jie
