Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453632ED24
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328754; cv=none; b=uzW1UeRYeIacjUilgKbCU1jgh76Cqt4IPSBGcEYQmCxSVg+EpNJyVEBjFqStbZIvTG9B85sN27bKmQfKVwRADM96oclAxAvc+VxD4TV/viiT7Hbf7yHFWD37Wa15dvtZf3XH7+KiDaJXjN8lzGQmPbWwYGiuZ1AZ89QpC6mJ8Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328754; c=relaxed/simple;
	bh=O9Vuz2eLj2Lzv8nRQmMXuHWfSi1FpI8CO72I+mTjxQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHq7sEIOiVlPutAPVzUWiZnXF51I7MzQ93/2Kp2o9jg2W0b3215lH/hsjDSIYD4UOUXixT7UnnvLF6ho6aMFG1Gw/j0kGO3NZp4Krc6JbvDrcxHDUDWSu0zgypHXWbKPC0SZDYCXvDVT9nET1lTYgu6MNmAryvX9fzYsySFkAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/kosQVw; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/kosQVw"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4864a8e80bbso849377b6e.0
        for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782328751; x=1782933551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9Vuz2eLj2Lzv8nRQmMXuHWfSi1FpI8CO72I+mTjxQg=;
        b=F/kosQVwN+00tqzL6lhD7Wd8oFX0DfEzKy6SfUzGSbWZnnwbno8eQ2uUGJCp+tL3Bo
         T/3KIFBDxmkipqVnr6jlplwOiYIW265kXaN6QZLWp5VSJUNf/fxuQHFuNzrpF8seJZuL
         xyw+C6GXtcajZAOQWqQDSpMV0/2MMosfSGOBse26j6fOvVyOMKosQ9shoMNlWb2JLvsy
         xukZjmmMLnfJV/XpBFzOZgv/zHls32Lwyq2cehXkZIF8fNs21W9cVulz1nCstM+hbotX
         xmLVCXk3EuGT6AJ21dfmRRnSlTzR/EY5EW6E9TBg1NfK8BqgUZoYMuHTL9inT9n/9pl7
         tjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782328751; x=1782933551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O9Vuz2eLj2Lzv8nRQmMXuHWfSi1FpI8CO72I+mTjxQg=;
        b=b0tGpbIIJF0ONk9cb9pSCjwRvJbUp32Ym8QtloLjEmTT5ZJqQjlgFhSoVswSxHUF+x
         8xyEhy6FKTAWYF5H2Xdw/j9QNTDIJKDUQ/yF6WRwe6ZJh8UiBC4f6/v7sfFUd5437Qjn
         NaUJ4K6AizYw78I8W4H9PtoP+UTyNfQ5UYQXooZtWKgfdoyn/TRKbfRIf2Sj1SQHNhcA
         zIelrWMogz2VWe7HKBTCMCs2icDobI7tsxAdr8eFm1Z+sRM2DS+Qvqx21FMeff787bia
         0ZHI+lMALKh3zJ91tbUGnXn9RzYlEaqyHcD0jZZcejOId0Zr351JhyxS9xczbqcxTn9f
         jPqQ==
X-Gm-Message-State: AOJu0Yy9v93gobdcFOH95s706n543Cmty9x76WrJVkL7091Id7gQVv5Y
	3VcWmAroqcHmD8U2X6lW7YNxSoQZ/1iPdTvk11cUkjz70WcynL9uiz28YSP/W97i
X-Gm-Gg: AfdE7clPaeUKARl+5Wx7t/rkkO/KhQSKELzdrxiuI6UZt+xLWcsM2eUwRnr1eAxgdCW
	ubj5a0efeIMUhFf/ZBFlEcYOsX5QfBK0hdYD+zwaSSCwf3CBeOcosFXxsntjvRGqyIcuOPlSPij
	bY6UY5YA4UWjvSzeq52MzPA7j0j6J0FEyC5/kusyEuLpyfZJrxlOd0r4vmwwpcZ5gl5nhzBnZ+m
	QuQ9KQY0wyWvC5un9PnSuJ4B5by+fsS82huvOgVi6Ov4otAPzAwDIzhSIZTPfauzuTjFe+BH0ca
	Upr+gH5KjjxO9WkSaTiyGrtmWy9TKuW7M3T74LooovQVFbCwTQqmEs2Y4BA8OwVQX4s8MNsMXg8
	hZAa8H198SdBDYEDflsHg4h1odG6ZMn2Q56+E0hF8skTQwMoVBl1o7tQ6Fo7MtM+2S+XMrdblne
	XH6g7UwdoXVvk=
X-Received: by 2002:a05:6808:6a96:b0:479:477f:559c with SMTP id 5614622812f47-49077a9a66bmr3671905b6e.14.1782328750975;
        Wed, 24 Jun 2026 12:19:10 -0700 (PDT)
Received: from fedora ([2600:382:992a:fe78:e8a7:4b87:ea8f:f30d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aebb9f1d7sm9591186b6e.4.2026.06.24.12.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:19:10 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	Dave Carey <carvsdriver@gmail.com>
Subject: Re: [PATCH v2] HID: multitouch: Fix stale MT slots when contact count drops to zero
Date: Wed, 24 Jun 2026 15:19:00 -0400
Message-ID: <20260624-ping-stale-slots-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522111527.69428-1-carvsdriver@gmail.com>
References: <20260522111527.69428-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Gentle ping on this one — it's been about five weeks since the v2
submission with no feedback.

For context: the INPUT_PROP_BUTTONPAD misclassification fix for the same
device (hid-multitouch) was merged to mainline 2026-05-28, and the ghost
contacts fix (MT_QUIRK_CONTACT_CNT_ACCURATE) was applied to hid/for-next
2026-06-10 by Jiri. This stale-slots fix is the remaining hid-multitouch
patch for the Yoga Book 9 14IAH10.

Happy to rebase, respin, or address any concerns.

Thanks,
Dave
