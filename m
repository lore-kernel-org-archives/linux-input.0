Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D81321457
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575111; cv=none; b=hC9AnpK6K7RiW2JtzX0BGJFWDZF7gn+R+0AXHwN+1mbYrEsABoOEjjJKkMzUcoT97oITaDCBsW3eNWaw6xLvf5XK9Nvv8QYL5dH62Or8r4puY3vhlXGJKNvkA9URlwd+03f9k1nnmfqrNAOh0Bb5lrT63F5VLXAfMBhKkooxPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575111; c=relaxed/simple;
	bh=mJjHNeNQFb06i9KIWJ5eRe+MLCnfIHy3P/brr631AHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFMUmP4ofnHnt4sXY4bDtdiA8LKWeRUhQt9oyuyYPGm1abQsLtQLY8IY4XGlkQW4ZEuAMrLFNdMHJtCXCxgIhwAYFaD3Wq+ILvnmVWd9q81Eo3yDr9qjxXVTzGaE/jrVcBNux/tRtsI4GPI+ciXkvnB+FFMt0tYLfUY+TfOCFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdiCAua/; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdiCAua/"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e512a9a6bso152167485a.2
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 05:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787575109; x=1788179909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xAB+NmvBAcZ4IstuIvk2EQR1HP75T+FczXIpTdl3mvg=;
        b=mdiCAua/Y89rzwsFYqTIXmknXB8exf2Rv/boTxPCWBInh9sqg0yCsmb2cM3YCm4Qt5
         77XOZ4PXaYtJKJSb9oH6c8+fVZgj/x78wsNqB2L+McX/+yWyVt0D+mImZ/LWhmSsFk7o
         i+X/6q6zmT1WIVUTi/1RoP+fEv1TeuHzuPRmgs4kCmCWbOEJ0B4zB/V2vvRRwoc6C0BR
         wr9XrIEuNO0EK0gDSOBgDQP5suiDZjVPetZTpmDI7WaNQQAVYTDXKQaJJZjcQwXx1bAG
         6wItIzQZea889wcYu9Rj5LlscgxLXpWOImEMUzU+MhckHZYO0Wl8t7BtyJZIlEF/y6Jb
         izeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787575109; x=1788179909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xAB+NmvBAcZ4IstuIvk2EQR1HP75T+FczXIpTdl3mvg=;
        b=QoCY5sZEm+Rqjn+S+fmfafhOuy+meQLlwJ3gzqRZag84HJaPESfE2BsrwOkKutC0JR
         mdEmmj7Jk6D+K41xgFGzr18AijMHmwMr6mGjzhUwc9L5SfcboTIWqheEYjenQe9eBUem
         8lR8UZPHxtGKhrsj4s01CECiSP7f3N8J1ABnLZDFyQa03ZaDI0uBTqkNfzlNfXgF4WXs
         oN+RiC1SI0gMcDaFk5zL4V1Jr/TRxA88B3af2AaK1qVmS6WyTLyDqN/WVBDiHJP8GU6z
         qJZ5NIyQLpQX1Z4Db+fUVXn0UKdTUUkETgU3MmZe0EUifVULTFPsUBw40L1rWS4UGgiR
         Wgqw==
X-Forwarded-Encrypted: i=1; AHgh+RoGiQY13BEge5W2gsGsE19EwyKoa86gruaBKI2TRjylZPYL2Ah39uXQ2FEHwTACW2zc/GpviOZggO5vAQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nckcZNxyVtOKMPsIt/e17YxvYGOtM+a40IoSNSotoGl7AnzffR
	hSnFGkuH5VH2u31xCaYLsENGi0Sw5qTkmqlqjoID9eDqBKYXUmrKjIou
X-Gm-Gg: AR+sD135d+mHqulv0c862oN7ACa3uVEhW1dHIbN01rZgVWbJxAtEWu11N/X6niDtM2X
	5jcfAzHUfmhbhaywBzYGQcwPX9ULs3tCuYWVzJFRm4vkXcSnHwOQXsqMteW3TK8Ra5w0ySeZd44
	OT7LzkEh4VFgum1WbMpAV+KF2Y5jQXoVI/NR8m4aM3FNVc+bZvjz+guvYvBP16sIjf3BLlSCWHR
	5V5341TZr5sWOPjA2/AVKrEp0vYeDuhwq7DgDbIfjNqRb69s2s2smp94mrXFwQzrigqgPQFtWfH
	QjHF7KCy1t5G+zWLBNys/YNpIKG311M114xhRK/dIUd1uUSVPK+DGv+VOfEUn9PtCdgAN5FapVW
	WwUvVwnbbsN+1bCtMNMh9C8NCUjVVo7C54+K4FIYP8oq8e5Bq6ik9SGZA6vr/Dl4xgTH02E8lpg
	3eKH6cHRGJ9VwlCpjFUYSCvfatQa2eqEuV8S5YhDMt+r9+ezU7P0hGrq1XjF9Iw2zFBRXWZIHC/
	YyYvqSzGxzBdkuGr0bC1De9wFbeQ2o9z5TXWY6cHtGZKHH6bfDYtYfbZ+RB6O8Ric61LP3TYRU7
	dJpy++kIL/VsWu4x/bizQhk4vsttdfktvWw=
X-Received: by 2002:a05:620a:3198:b0:937:13a1:dee0 with SMTP id af79cd13be357-9373944fe40mr2392834085a.5.1787575109077;
        Mon, 24 Aug 2026 05:38:29 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749d91ca3sm493416285a.28.2026.08.24.05.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:38:28 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: synaptics-rmi4 - reject a PDT that grows between scans
Date: Mon, 24 Aug 2026 20:38:24 +0800
Message-ID: <20260824123824.78628-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2c26d7ce8c6b7371ab55607f53443961220e4b24.1787549234.git.98lawweijie@gmail.com>
References: <2c26d7ce8c6b7371ab55607f53443961220e4b24.1787549234.git.98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Superseded by v2 2/2:
https://lore.kernel.org/linux-input/20260824122733.76321-3-98lawweijie@gmail.com/

Please do not apply this version.  The rejection path it adds calls
put_device(&fn->dev) before rmi_register_function(), which is where
device_initialize() happens, so fn->dev is still all zeroes at that
point.  kobject_put() then warns that the kobject was never initialised,
refcount_dec_and_test() warns about the underflow, and because the
saturated refcount makes kref_put() return false the release never runs
-- so the function is leaked on every rejection, i.e. on exactly the
malicious device this patch is meant to reject:

  rmi4_physical rmi4-00: F40: interrupt count changed between PDT scans (pos 1 + 6 > 1)
  kobject: '(null)' (00000000cfabc269): is not initialized, yet kobject_put() is being called.
  WARNING: CPU: 0 PID: 9 at lib/kobject.c:734 kobject_put+0x1cf/0x4b0
  refcount_t: underflow; use-after-free.
  WARNING: CPU: 0 PID: 9 at lib/refcount.c:28 refcount_warn_saturate+0xf2/0x150

v2 uses kfree() instead.

Please mark this one superseded.

Thanks,
Wei Jie
