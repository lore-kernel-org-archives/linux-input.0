Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772182;
	b=1VB+wq034O8e2rh17XpPTzv7fvlVfXl3P0iBhYjmCgjFD7oX7bra2Mu1VaKbAw19EyiD
	 CQBPpdWaZgkHiUJoq9x6BSM2V9if47wRC0vHGdJU/tExXeUa2MhjZYIhxmDBeCEt0AM6y
	 zpCkgogvYhmRl8DVQ4QdGYjsntreJeMM58arSqsxXDOL1h/brGKhvsbICf8R2gzvt7wlU
	 JHkaZqHTiJ1vbhDJaL2/3CnMaO21vBAiusS6pBhGWNaGx0RxXu/rMYDuapRHHO3LDRRg9
	 WGXDAtWDy0fAIOT9ARkO+Qz6WRyKnnt6ZQCXXyFGurINq5eZmPOUYWfYFxKu78czNug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772182;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2vGBkGwiK1WSR+wIQv0WPV/9HRkyseM9MtfKJJimKH4=;
	b=1YQNj5G/spWfhKiYGzHuVGPPhdSLp+P6YfVzfxSyDLLGJlTJMlPMs9k/6w6dUHEbFmyp
	 9iooF5V2SLxpF+k14IrbZSR7O4s4gyaBXgtlql2K+6ajkFAcj1pODL/H5ARGI9dF8eQ/M
	 rH1TK7avY0k0GeG3gj8UrEeUMXUkj4wrlOkWdPX9A39R0DdKNDSM9jYE1Of1BILc4c37Z
	 hQNkYYh2oCVn101b8szwcqABC8q1NUYghtekeXLYlA369p92qfdaWuuCnwSgEbVTyzlyj
	 /L5aveTVX390d8ywxF1Tb7LKIZzsrVt9id5X2QlYMjBRs/YE4XPsikuG+ayy+WtRozQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=G+X2RjID;
	arc=none smtp.remote-ip=115.124.28.221
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7DC606A31B;
	Wed,  4 Nov 2026 06:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D7DC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=G+X2RjID
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793772173; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2vGBkGwiK1WSR+wIQv0WPV/9HRkyseM9MtfKJJimKH4=;
	b=G+X2RjIDXQepSr9wSUyvh4kdyJVc86c7AGL2vEu+kh8sKRrAzChVE0AXx6kL+mwOdiGE321FQB/zjTtcu2afO6P6TxssWIXsZSLKO1YoiCLeZ+Izi5/dzAPH2ynbg2GtAetYznmrGgpITu5LXNlM3NzZ9rTGWILFqz6isX2GuYw=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.5354029|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.152454-0.00047825-0.847068;FP=5282155146690107547|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033071099199;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.jwN911e_1793772172;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jwN911e_1793772172 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 14:02:53 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com
Subject: Re: [PATCH v3] Input: joydev - avoid signed overflow in the broken-axis correction
Date: Wed,  4 Nov 2026 14:02:52 +0800
Message-ID: <20261104060252.859605-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8063a24bb9f75bb9096c947d8ffa7123@gmail.com>
References: <8063a24bb9f75bb9096c947d8ffa7123@gmail.com>
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

Verified your rework with a three-way comparison (old / v3 / a
64-bit reference), compiled with -fno-strict-overflow: identical
output for in-range coefficients, all the boundaries (value ==
coef[0], value == coef[1], the dead zone, malformed coef[0] >
coef[1]) and CORR_NONE, and the wrap case behaves as you described -
coef[0] = coef[2] = INT_MAX with a large axis value makes the old
code return -5 where the 64-bit math saturates to -32767, and v3
matches the reference throughout.
