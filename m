Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597599;
	b=Jj96uFHWhmFgGrKqQPFB2YIVcUUe/YcxeD808UQwMxFf+oelOj6rl6jrD2Yew0zQvo0e
	 Q1Tmv5ws+ObZqRQuVYgocWtgEJsrVd7hE33a3oIlHId1Nms/Gy1DaM7mpc4oO23H8CXX9
	 hy4WwATsPGe3RTLvzCH4mZkfsCRLJIDRpIqbdB5ECO9rEbfAWzLFn7BRB7VhUy9v8NOAb
	 +lfUWwMbSQqe5hm1WuTzsymikt6hPVOcabC78I5lfj71UlLhf6ZhPztdNB3Novt4F/4ig
	 yM5WwNzvsP+di9tJKCgjqLSeVmeBBy05CavTcUtXX7Y/CrHrjqcGya/wTquykLdN8zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oE7Aic43oySX2ufBY/K+5voFcrRN+KlpsTc8hK+MGxY=;
	b=rty6LrcU6grQXk1aR+5f0UbyuFKy5CLlmXwfrDCIqLU7fKHq8XL0yRcgRdFEzHf1sEOk
	 bA+8TICIxollGMOZ1amqAbuQLJJI5+lZ+dwYLMDKqcQDKhw7hwNhDcK4RX++PCoboA/sE
	 w+NjskaPAQ+/n2lJvQ2nMMkE6qdfBu3cK4+y6Ui13iPozfF9ropmsHvTBpozG346Y9eOQ
	 Mtn/APRHhJFa1/su5mPrLOcDOHozUbtv0GurCVIO207fzMAkesoRuVWKuWoXlA4GNT8wN
	 AYBEGdlY6Yg1yPgYuW06/8tWY7vJCzx1Na6VadbyMMicImgaHJ7Xph1/2M74v/jcu/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFnisHrC;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D90606A32D
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 09:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14D90606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFnisHrC
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38431138772so7111978eec.1
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 01:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597598; x=1796202398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oE7Aic43oySX2ufBY/K+5voFcrRN+KlpsTc8hK+MGxY=;
        b=eFnisHrCI7kZN77oTOFlqkMxz0qfVB8BVNADcvtjDNXTyPbki94moUDi1hNWCDL6nC
         FZSd/dxe4yjAD/IZWRvYkbcWOp4fECdnUYGq7sx1S9l4S6JAdzRlS3FYckb4OtMaVoDm
         qQ8r8gKFYmBsz7LMXZMKZezwXQqNqvBeWLqF94kwjMEm8NCd0OpJCBhz48Rnlq8q+IoS
         4V5ssMZmDiNMfdqdvmb3+JSzU/cvEL6N+6uqy6tgRKsYCs0anVRyJLSRKzbVu/SPr2Ih
         SPuknuy9+Y7o1QnO38xejXYgTy8bYbbRFhadUhs/3xADslqJh/YnB6esDl2Wpw1ShIXy
         X1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597598; x=1796202398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oE7Aic43oySX2ufBY/K+5voFcrRN+KlpsTc8hK+MGxY=;
        b=XhdlxwrF3zUEouoLPnqkul5GmzWZVJ9HQMY6FaOmoyO5fk62M/sNsxXRfbcA+iBBoU
         trXdsh2lp5QdE/6a+7B8CsbtKq7T3aA1Ga7FtSlt0hRzG1o1dkN7SxqvJj6h1GHaLrJi
         TZxelgdT1eCVHc8jG/AkuPt1MCH0VZnO22R7OrrD9V3cGGhiWZzuns3lamduYqU3wRE7
         gufr4Fy8pCW4QL5Dy1IDDKVks5/pgUbhb4JR685E2DxSpSDchjWdFG+TeXm62bH8b2JG
         YI4Mvz6pV+iSnbfxilxkTlGr5aI+MjtVi2BvfJpKMLkfGKYO0rSwgiF4I05dFuMBia1e
         zRLQ==
X-Forwarded-Encrypted: i=1; AL+hErFScjmEwG06T/EDW9KD6qD7wuYeg8aUlUBDly7uML9Fn6vieROpKTuXntgFp8zc1rq74O0KlLJ7ZFTiyQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+yMK9+rAvaGW1yGn0CfFyoBvXp83xJ44RQlSdsiMYkvJFWjCpt
	DYfZZP/RIqa+dNLWudhPAGooVtk52/qXbUgP/aYV8F0XDnN6GutJRQGsqMDcKw==
X-Gm-Gg: AZFdTZeGFYNb97OCGN0cKwy7LlQ/YIOlvgL31E2CSn4PziKgLh86aoUhu46lOCaUqGG
	6MHk7Hq98RWqPND7vW0eaKqBek7JnjSYJrhi2kGy5vA0O82SrPbGLeSDcNjSD+FKWgHSAsE+T8C
	xZzUnH3Wqe9tLlqlqRgf6kp1aMYAhLfARAUa43QpKOZ3/CtDeTKgC2R0Li/cQ4SmgJ+rFXJfMJY
	y5UNf+TGArIt4CwsQ3ZTWhjAIMH1zDHm1IYdSI6mMQ8wmKvAv52lAm8vvNMFbxav11paGJ2qrHP
	d4yJ5PehlobUwUT/d9CiPGaMry1BDISPiMT3x2Fd0DIPBRz/TkPPiDNu40SL5cbWaK5VvKccMC6
	yDt+esMgHuY2bTxneI+LJKk681cu8eLOvPSG6HHBWwh+RtaEwODbKE/MJtgXwf8oc8VaXf+NapX
	xCTfHTY+dy4VYuP1yL/BpuYX/4NnYBh/hhEuZLaWX993DUWJNHW4LO0PvJHYvAwekujhwfiEcBg
	lH/BFPjR+k1k3I6S9UazXA6EKlKM7cUkO+FPOCbhf5sNVl7s098rtN/dL96fU/je45kUXd7c2k5
	YPgzHKuUUYnFl7ACQbMir9Qe0ICy4olX/G8sV1c1x3pb5SQ/0UXABuvTDAHeqMugIGU3wiwqnH8
	=
X-Received: by 2002:a05:693c:65c7:b0:386:cffd:bda6 with SMTP id 5a478bee46e88-386cffdd34fmr1205867eec.5.1795597598099;
        Wed, 25 Nov 2026 01:06:38 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm58712596eec.24.2026.11.25.01.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:06:37 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] HID: intel-ish-hid: Size the buffers for a later, larger response
Date: Wed, 25 Nov 2026 17:06:31 +0800
Message-Id: <20261125090633.1385386-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Both patches fix buffers in process_recv() that are allocated for the
first firmware response and then reused for later, larger ones.

A pending patch [1] limits hid_dev_count to MAX_HID_DEVICES, and it is
still needed with this series. Patch 2 does not depend on [1], so it
allocates U8_MAX entries (2295 bytes). With [1] applied first,
MAX_HID_DEVICES entries would be enough.

The series is based on hid.git for-7.4/upstream-fixes. In mainline,
patch 2 conflicts with the treewide devm_kmalloc_obj() conversion
(4dd10fbbeb9c). I can send a version for mainline if you prefer.

I used an LLM to help write the harness and these patches.

Changes in v2:
- Patch 1 ignores a response whose done flag is already set.
- Patch 2 allocates hid_devices once for the largest count and does
  not reallocate it. The subject of patch 2 and of this letter changed
  with that.
- Both changes follow the Sashiko review of v1.
- v1: https://lore.kernel.org/linux-input/20261123092816.2200718-1-maoyixie.tju@gmail.com/

[1] https://lore.kernel.org/all/tencent_130404E5ABECE66E8D0E70D8E6892C751C0A@qq.com/

Maoyi Xie (2):
  HID: intel-ish-hid: Reallocate the descriptor buffers for a longer
    response
  HID: intel-ish-hid: Allocate hid_devices for the largest device count

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 27 ++++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)


base-commit: 10bc1d627c297097cfdc099377f8a13efdfffd86
-- 
2.34.1

