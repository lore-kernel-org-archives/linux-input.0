Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B5438945A
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785298039; cv=none; b=LP5bq2LU1cP6i48gyWgeO7lqK9g6wrvs2EXz5UEOOczx/Y0RN1zadeiG6cEK+sQqVgvSn5uvz4iNNEN8rfcEduY9lIbtX5p/N5rD2mmd+is/IK4N5lXgnOhXNvOET7kbAQZqfk9bxbBQoEPecokerFpfFIrWIujGtmk0aDYHVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785298039; c=relaxed/simple;
	bh=5u6ghBrhXGyP/MEBZFNvKYDEydau+rYuPskh4t7NgyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7bTxtLK4oNHf4mqKjdJSROstPpLqGyOS+wrodcqlSmzTxCjG7iSsdqv8FDjY5zlnZv8AYIMGKunRgOWyITMk49WzAJNuFSgqiJsVfyOl3NgGLMVxGy52wzgRRmDGRQ6knYQWwweS3GQpG0oXBR0Ru02HIUBCyeoHI9yFLPqhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWGRGJ6G; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWGRGJ6G"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6b554044fso530659a34.0
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 21:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785298036; x=1785902836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nv0Upv1Vj3F4AGa3oq5CtafeDcw6cWVGiKmt6d8J7/4=;
        b=pWGRGJ6GPsnhVx3AxJOPSwRS/i4aF/j35IEIXcEBgqAc5il2qU8/KQkT/89abaJ3oj
         2tE4PihxwcpYIolA2Q4r4H5AIKFtIxeC9l1k8QTUW6BbfiHFnWpX9Di/t0KWBs15oez0
         9Mqm0d5tKKB1BR/W0ekTjXZ8lyp1i9HuAEC7g4gHNkrLzOtC2L+y9JiC+ftqFYwhsicC
         sj3PE3byP10Sc1e3CNdVUUykuVWtcWbZo8ts9/wuD/wnID9FQZeqB/xRmHlcQTQQNb30
         mS06w4G2Hqddj4QFtFg9YODqyVMDBJ3xo0+0JnUSGjKVKEwwnXvRBp9T9ruMpjdvyLJg
         OiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785298036; x=1785902836;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nv0Upv1Vj3F4AGa3oq5CtafeDcw6cWVGiKmt6d8J7/4=;
        b=GVhkg3J+KdWawgzPo0Hl20fRakYdZS7hD+4Q64SNnIsALsGOFoCsL3vw9m1BnobJUy
         TxjBAYEc9ZEcGwnpxBVauM98peslf85C3KvwIwYDo33/WK6mPyJQvH/k39fZ5ZOCuYPl
         5Bwsb8YObo1eTn1w4vttoCZ4eOBtQumHdJiZNkMqOhRyxusfZttaQ0rIOmZzk5pJws9k
         VOvUH6PJkCuq/qw9YSQJqRND+V55z/K7nvVpIcfhJyxVBASzKX6F+lTy5ZM+SohIjI3S
         VdZ+WbFlqeGPhv8J7Dmcj3LOn071pJxdwlD8CUFLqfv6xvoq8IIuHuIEJ8pR2QJF6naO
         RL8g==
X-Forwarded-Encrypted: i=1; AHgh+RrldBOoRR0UaWp+5Dc6JRvFBpj/jw06jWo89GaDC+sjj0LbqVWvWIWjeozlMHJVu1kssMd2S9DAaB/aWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAXBquxnFLaYDMyMI1/I9yb7uv1hJMyXkMeP0rRNTAAAMa+RQ
	mH2EP2XGEVERfUb8jtgIqsXdyPV+0CEX5K9NsHf3UB5pvjjnd+4zUpSq
X-Gm-Gg: AR+sD10tCL9OZiGRcIms4uPxg/R1Nq1UurnuvMVnLDNN5ccCdZMFoKdIFeiPa5oO0lx
	X8UUEzNif+GYb5foYNlJCcnkwjISa7prTupbsKzF6W7W8refMom1jTGGAYyKhSHh/bZgAvPUdBK
	ycmvkp5dRgPem6z0ZvhOlX1j54fXkd25NqSawz1Lf1woG0EsGzEXc2PjLQVBmE/dv7Scsrh3Qee
	sbfsUeVGEy6immX/e2g6BPclsTjM8WANmXt5ha/vblr0yvFFuwL45DrNfw58lkmXT5ZmhBX4SNx
	/5YRWdFHw2sew3c2l1boSaFtDh2tz83RczGeGqILqELs4XasihkQcmPifW0rzxoZUC43Vxp2JdO
	zTUnWr8FZSumsguKLmVvDwPAYxmnMpecJMcnwUnI0pQfSM4E3jeALMzygQaI/j6H0J7Sw9nYgAH
	fFr9d5tq1YYfjm3r0nkXr5BYyK+sbxu16eDNxNqTzTOW8Kh5KxjTqDRRi/cJna
X-Received: by 2002:a05:6830:6ad4:b0:7e9:e8a6:6389 with SMTP id 46e09a7af769-7effef00661mr3604326a34.4.1785298036531;
        Tue, 28 Jul 2026 21:07:16 -0700 (PDT)
Received: from desktop ([2806:107e:1a:2f14:d204:ec3e:fc64:563b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d94d41csm1330516a34.24.2026.07.28.21.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 21:07:15 -0700 (PDT)
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: sashiko-bot@kernel.org,
	Alec Hall <signshop.alec@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Subject: Re: [PATCH v2] HID: magicmouse: avoid NULL pointer deref when there is no input device
Date: Tue, 28 Jul 2026 22:07:03 -0600
Message-ID: <20260729040703.1178791-1-pepemontfort@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728185542.65F091F000E9@smtp.kernel.org>
References: <20260728184059.688513-1-pepemontfort@gmail.com> <20260728185542.65F091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 28, 2026, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but does the !input check miss
> dangling pointers if input_register_device() fails?

It does, and I checked the path: this looks like a real bug, separate
from the one this patch fixes. Thanks.

hidinput_connect() unwinds through hidinput_disconnect() when
input_register_device() fails, and that frees every input_dev it created
-- including the one magicmouse_input_mapping() cached in msc->input.

What makes it reachable is that the failure does not abort the probe.
hid_connect() only skips the claim:

	if ((connect_mask & HID_CONNECT_HIDINPUT) && !hidinput_connect(hdev,
				connect_mask & HID_CONNECT_HIDINPUT_FORCE))
		hdev->claimed |= HID_CLAIMED_INPUT;

and the "device has no listeners" bailout right below does not fire for
this driver, which sets ->raw_event (and on the USB paths hidraw/hiddev
are claimed anyway). So hid_hw_start() returns 0, magicmouse_probe()
carries on, and msc->input is non-NULL garbage: it passes the "input not
registered" check in probe just as it passes the NULL guards this patch
adds. The next report dereferences freed memory.

The v1 of this patch, which rejected the bind in probe(), would not have
covered it either, for the same reason.

I will send a separate patch for it rather than fold it in here, since
it is a different failure (use-after-free on an error path, not a NULL
deref on a normal bind) and this one already has a Fixes: tag of its own.
The fix I have in mind is to trust the core's claim rather than the
cached pointer, i.e. clear msc->input in probe when the HID core did not
claim an input device, so the existing NULL checks cover this case too.
I am open to a different shape if reviewers prefer one.

> [Severity: Critical]
> This is a pre-existing issue, but does this function have an unbounded
> recursion bug when processing a DOUBLE_REPORT_ID?

Yes, and that one is already fixed in a patch on the list, with
Reviewed-by and Tested-by from Alec Hall:

  https://lore.kernel.org/linux-input/20260715053526.574725-1-pepemontfort@gmail.com/

It bounds the depth to two levels by rejecting a nested DOUBLE_REPORT_ID,
since a double report never wraps another one.

Jose
