Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791135;
	b=sHX7mHoYuDVGbCEZHj40s6epBUF/sesZKoIn405QkaC8ZqyfaMyBL0QN25DQXkgzAIfk
	 zQoLwNjocYtRgSjYx04g/mQnYhEq55IGgNb2wtHCXloRrjMOplf6INU5yW8cr7u8m7MKt
	 fYJ8uBJNkFW+xvy/qapEOP11owqZQZ+4cTRhpgPVlz9S36XzyAzWPLYz4eDuKTDPF1xO9
	 C2sE6TpN8CfMGVTdLMpx21qQh6u9o/+0RU4IkkXehDwT6lIswhE9ZvTy7iQbVajZDLmh5
	 0Tu8I18q71oI61f0KtQWBkqQyFSVVbk1Od4o+ZsRqua9TZkrB7Q/Yh/bxhacGC84Now==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791135;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tJ+HAfc50j6Csk2baNU2qOA3WfxP34SMU4vclZpMhHI=;
	b=bAUusbW6qvw1caZbqOpI7E5CU9oRRgjEn9luHFhOcSjaQH1kYpQbP5R/RXeQDsbZTIxF
	 dfPkiRh/jAsqXmsxnfTJS+hj5MIUp1e8RbsO/rXA8WHNp325KAx+DotJ7hPY4GQGWrrQW
	 6ayp8tqElHTQSTJV4nIZSXHtXZpu5Hl1e7OyRYi0G9pfHSSVugx2e2ka7HJDnAPyIFTgS
	 HDuYiabxzM0XYEt/A0vuuClx9/rZ53d9qjDnbiNkqppbNjy15kYMFkLzdy53AeXEeiOFq
	 zpDz+9VCTIA1FSE8Sgs6PsrOK6tLPS+ChU0t91v81uDQO/xt7jYdbGcVbOtPRjlJtyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mh1sSSFO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A47606A31C;
	Fri, 27 Nov 2026 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mh1sSSFO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4721F000C1;
	Fri, 27 Nov 2026 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791134;
	bh=tJ+HAfc50j6Csk2baNU2qOA3WfxP34SMU4vclZpMhHI=;
	h=From:To:Cc:Subject:Date;
	b=Mh1sSSFOez+jP6cgY6Fv0jpZN87fLp7DWOfJe1p9zZJVmOnioIw+11oLSrvLrLit1
	 Dk+mV1DZXU5UcidPpapGOZ8t1m6ekUrEqrAYd8Mk2w+Uu5QW73Mrii16CMREZQ/fHv
	 IZ7gzuOYYdPvvQQDZXvbki0l9FKeoi0eT0z7LIeoImPTzPJ1l97cyW4/CaMqPl1rm6
	 2xu6y103P8eW/QWZfM3Yx41UUDS39HzreuCgtTDkmr7KwdJWxoRYFGzsZIZIyuLSLM
	 4QQH22xbwuK3QNja/CWvUrpMtMFV4yjiPNrGpSleuKqjyGMO26oRhkb90G7BRGvxH4
	 VArKdtORnztGg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Miao <eric.y.miao@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-input@vger.kernel.org,
	Marek Vasut <marek.vasut@gmail.com>,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@arm.linux.org.uk>,
	Trilok Soni <soni.trilok@gmail.com>
Subject: [PATCH v2 0/3] Input: Fix GPIO bounds, work teardown, and suspend bugs
Date: Fri, 27 Nov 2026 14:51:53 +0000
Message-ID: <20261127145209.2884170-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These issues were reported by Sashiko.

This v2 series contains the remaining three patches from the initial
Input Sashiko bug-fix set, rebased onto input/next now that the other
seven patches have been applied.

v1 => v2:
 - Drop the seven patches already applied to input/next.
 - Drop the redundant zero GPIO count check and stable tag on matrix_keypad GPIO bounds validation, per Dmitry Torokhov's review.
 - Switch applespi removal from cancel_work_sync() to disable_work_sync(), per Dmitry Torokhov's review.
 - Update the Fixes tag on the matrix_keypad sleep fix.

Cc: "Ronald Tschalär" <ronald@innovation.ch>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Trilok Soni <soni.trilok@gmail.com>

Lee Jones (3):
  Input: matrix_keypad - validate GPIO counts against matrix limits
  Input: applespi - disable touchpad registration work on removal
  Input: matrix_keypad - only stop and start active device across sleep

 drivers/input/keyboard/applespi.c      |  1 +
 drivers/input/keyboard/matrix_keypad.c | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.56.1.839.g22a8290db9-goog

