Received: from e234-54.smtp-out.ap-northeast-1.amazonses.com (e234-54.smtp-out.ap-northeast-1.amazonses.com [23.251.234.54])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47307346E58;
	Mon,  7 Sep 2026 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759837; cv=none; b=gStoNgRWzGTRh33k5Ys9eqR6ZHgW0ewvfmLYthhtAPyzvAU+Iw49CkrJkrWbbuBWI55cEI39YAW+kJxLPSgTCsY+hRS/fjNlDtgUwBz/ul+vw+EtoJRzq4FCf6t25CisL4CKY03RMdpwj1f+nyTJQpT+4P8w17+eHBfQwj8uJ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759837; c=relaxed/simple;
	bh=5o462wHK2nnnyPpuvQzACH92a4ZCUEwQALmCiONu6MI=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=hOGBL1uRmlfiWX3T/Ws4qWvqVeEtkCdacaHWbL5Zxj7W8QpMjH+1ItYNd2oJwza/7HqsyWGTxGLA/dJy9LRNjzzKzFdXePtPSoxiG1OyvXn5uqf6IH24L5RMJ6f0/xmc1svWIN+Rs48fMwaCSPIRO2AjwFpPio9DVib9MpEE8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=6VLaJNvc; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Yz3GJK0X; arc=none smtp.client-ip=23.251.234.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="6VLaJNvc";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Yz3GJK0X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1788759835;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=5o462wHK2nnnyPpuvQzACH92a4ZCUEwQALmCiONu6MI=;
	b=6VLaJNvcpC4SV6/fBbdBhYbzasA1MM8kSq5hP7y37j1BnjShkoXnLohYle74FcS/
	n0wr5v5gD33yf2UdiCb8dWfXcvwCTLfzwFyUOwZyOSMV1C90epLmH9orjQycZyXMjZo
	zgRKloJP8q0oXJfcvocXXuyAlKOgKIQraQplBfZY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1788759835;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=5o462wHK2nnnyPpuvQzACH92a4ZCUEwQALmCiONu6MI=;
	b=Yz3GJK0XSzFjW3FIPTgeyvziKIrlQ+KB7yF1wpFqL+mTcbsydnbPS8WCM6UAMowJ
	YikvJCPYJE1OTh+Koi/yedhhrKjTnrSLESe6fsn39QunYevrNoQ5KncO2w20e7Da+bC
	LMnx5VbDBYVteS896pv7YxeNmZxPyQS2pWvs0aic=
X-Mailer: git-send-email 2.53.0
From: fQwQf <fqwqf@fqwqf.xyz>
To: devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmitry.torvalds@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, konradybcio@kernel.org, bentiss@kernel.org, 
	jikos@kernel.org
Subject: =?UTF-8?Q?=5BPATCH_0/2=5D_arm64=3A_dts=3A_qcom=3A_?=
 =?UTF-8?Q?enable_touchscreen_on_Surface_Laptop_7_?=
 =?UTF-8?Q?=2813=2E8=22=29?=
Message-ID: <010601a07a6500d7-57284739-a505-4dc0-b12e-f92177607374-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: 7bit
Date: Mon, 7 Sep 2026 05:43:54 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.09.07-23.251.234.54

Enable the touchscreen on the 13.8-inch Surface Laptop 7 (Microsoft
Romulus 13, SNPS/ELLX).

Patch 1 allows the HID-over-I2C binding to describe an optional reset
GPIO, which the OF driver already handles during power sequencing.

Patch 2 adds the touchscreen node (ITCH MSHW0468, I2C 0x34, HID
descriptor at register 0x0000) to the romulus13 device tree.

The touchscreen has been verified working on this machine (keyboard and
touchscreen functional; other devices still in progress).

fQwQf (2):
  dt-bindings: input: hid-over-i2c: allow reset GPIO
  arm64: dts: qcom: microsoft-romulus13: enable touchscreen

 .../devicetree/bindings/input/hid-over-i2c.yaml   |  4 ++++
 .../dts/qcom/x1e80100-microsoft-romulus13.dts     | 15 +++++++++++++++
 2 files changed, 19 insertions(+)


base-commit: cf2543bcb1902e969d0d632a586c07acd9dc85d7
-- 
2.53.0
