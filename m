Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A33AAF5A
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 05:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155424; cv=none; b=gWUfM3TctIXCC92FLRJnr9jZ0YFHbFjDDay4a9LIWFOWRWkjRvnkC/B32Qi/Y+k/sUa2zQXTYHsZWmVwGDqB9yraKtIKR62amlDRRUjjJqPydZrJDnjuB9vSH5r84ErW6Y1RyIi4atEF9Mw6P9RHHKpoe7VQ2X1DiqUIse+4XVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155424; c=relaxed/simple;
	bh=WPzDy6QI0Cdle48zbtI72awG3e8e4k1qnYGpIZr5jR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odKEA98ygWZnYR0oqd8Ug6Y35v8NfABFtH0UPlnD2xbperLJ3bDYqQ+pObhHAUkcrnA4JMVOjRyHTPjgHdADnOxWV3evlka+EXu2ZU4k3n1tkSMH3XjIYIEf9gsIjs0YhftZXoXOyH4R+OGD6zuNb2vg0LFCicQRKAtZutnnUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieU09dJK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieU09dJK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d7195706f1so29722895ad.0
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 22:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788155423; x=1788760223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4fY8flvk1Rf5VPFbST/ZHdyH507l/1gO7fTOQXgpBc=;
        b=ieU09dJKGlWOpFhdni3p+RBojCEQJ26948+sYplhqXv41B3ONyyHexnzlNsZwUD9Eb
         TWbJJDr73RPno7BY+u+Judpn7+qTJRBISiTEbZfBhnh/hN/csp8hrViE8rdBC5c9HGmz
         Jt9DohUytzz5knWCMxH4dT7BGMO2MJ96G2mo53xlZ0c3KEcz9j3ruI0d7J1jbCvdXPVb
         clgeZszopNOO0z0zNL0mbvNmk6gGt8DCsqcDQZPf/VE/q/K9l6dJPYSlZfk/Z2NKO7xY
         EYcM+cH2gkpm+AiPCnzTgmnfSH8N/x/CMJYHhthnIbP9obiF+Y5GB7/43dJvQb6eOyhQ
         kI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788155423; x=1788760223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/4fY8flvk1Rf5VPFbST/ZHdyH507l/1gO7fTOQXgpBc=;
        b=gJPEJEdFMj/HNZObRkGOH6OmXwEq2EVgcyrK0GZNjMEsf2LpJ6H3z9EpGCqIx2awbO
         +feFXwNhmBK6CX3Tb7fS19HQGbldEozo0zaFRdPETEJD0CdRr1Hcf1dirQYMd3JK4A3F
         Pv1kd0MWtuu6PgUiwmha2I6JUzUk7APihjBtEq69XDoCKSx4z43wEbJGedlgSXvSVcJy
         0+XyWkmLZIWKYgc1Q2cgY1roFWSHVUvMf03AfdRCvF0iAD7jNdSy5snORm8iewnoXd+w
         C2t8Y3wHZW8TiJPJXNg54Nxmj13g7yD+ohRnCw5DRfQPjnt5r/tt+ICCN/z04B5Zt76+
         eOgQ==
X-Forwarded-Encrypted: i=1; AKwUvByF0v52B3+elVguZ4lFI4zLUQ4MDZZFqveGt7cf4ahqpWinZJhK9XVueDXoQCTde0R9mZNtjBPcldu+rw==@vger.kernel.org
X-Gm-Message-State: AFuF++mmCUioa+aUoQziarya96NUjc13vdKyjoI/6WIL2T0lB+dXDc8P
	NNjyUb5YndL1/qkuUmDa56T0nmaOcdxYxeLRti9BZK09RPRZHQVnVXIK
X-Gm-Gg: AYBFou2XCmNq0zWrdwUb0pyTsk2NAk0+lhNgG3BJ/KVzToLNTjcVfxB8aR4BHQpNm/S
	mTn4O+iyJ2+cjiGYrY+HrNfTDd+fhNcc1qzEzARmfxsoKQ6TcZJS7yfq50s4S5Dhs+7tJ/pDS1R
	4nieitqluN12DI4TkA1voxkx6nLX7EI7M248grtW/UkZw+lYW1lB2EEdL5bcbj86NtAXxS+BJsW
	m9wLVe5eOC6Wfk10fz89PCzBsB5Sues3D3yeEJp04x9l0r80ylCiAckQI6YiBSbCJs5Nrj8oPkf
	EFNGxc5heULSOZpQto2Ma132JBI7KUFHfidyFT1rwFLTP7OiqzuJkexBYiwUT7AqRV1ptEMuq70
	OMFzh5pAuLJHlEAoa8syQY38TRty+dWCu8Alt0YYndIbi2DqGFbp57Tqix9MaoR8DT8D5CSoFSE
	ccKqppHS5JjybUOxa61Q2ISWdGB/3sEbv4BwogDYOVtl8gUre2+XmR//84/B9reR57rOs=
X-Received: by 2002:a17:903:38cf:b0:2d8:d4cc:be68 with SMTP id d9443c01a7336-2d93fa55ab8mr14713175ad.21.1788155422558;
        Sun, 30 Aug 2026 22:50:22 -0700 (PDT)
Received: from Default ([2409:40f4:1012:165f:9722:a5d1:aa46:da42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b49c867f5sm12967862eec.2.2026.08.30.22.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:50:22 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: ccc194101@163.com
Cc: bentiss@kernel.org,
	chenchangcheng@kylinos.cn,
	jeffinphilip14@gmail.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com
Subject: [PATCH] HID: corsair: do not re-schedule LED worker after it has been cancelled
Date: Mon, 31 Aug 2026 11:20:05 +0530
Message-ID: <20260831055005.18420-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817072831.139954-1-ccc194101@163.com>
References: <20260817072831.139954-1-ccc194101@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Aug 2026 15:28:31 +0800, Chen Changcheng wrote:
>Commit eb51c9f8cb4f0 ("HID: corsair: cancel worker before unregistering
>LED to fix use-after-free") moved cancel_work_sync() ahead of
>led_classdev_unregister() in k90_cleanup_backlight() and
>k90_cleanup_macro_functions().  led_classdev_unregister() internally
>calls led_set_brightness(LED_OFF), which reaches the driver's
>k90_brightness_set() callback.  Since that callback schedules the worker
>unconditionally, the worker was re-queued after cancel_work_sync() had
>drained it, and the subsequent kfree() freed a still-active work_struct:
>
>    ODEBUG: free active (active state 0) object type: work_struct
>            hint: k90_record_led_work
>
>The removed flag check inside the worker itself only stops it from
>dereferencing freed memory once it runs; it cannot prevent the re-queue.
>
>Fix this by making k90_brightness_set() a no-op once removed is set, so
>the LED_OFF update issued from led_classdev_unregister() can no longer
>re-schedule the worker after it has been cancelled.  Also apply the
>cancel-before-unregister ordering to the probe error path
>(k90_init_macro_functions() fail_sysfs) for consistency.

This UAF[1] can be prevented by your patch, would you consider adding that too
in your patch?

[1]: https://lore.kernel.org/all/6a937393.1d9ded08.62e62.0113.GAE@google.com/#R

Thanks,
Jeffin.
