Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81022279DCE
	for <linux-input@vger.kernel.org>; Fri,  3 Apr 2026 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775208617; cv=none; b=kuWXBU6N/2x1ttW1axArA3lAXauSq74fpi0u2PlWJdSaml7/d/yLDfzgDKSSbNfuesj1DLsugZe5V3zVYJqj8Pzhq42aE7egxpwvzOJG2+uHhrcop52nbOpF6IU+DjJvFGnyC2z+kiDKBNKOXCXLo/OoKzFBm6kiH52ZSDCLjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775208617; c=relaxed/simple;
	bh=4fqzD2Jd5fZk85TN/K4kDSueqqIoNdXxWasjFnVpA/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jo0TG1X36B+SIq4vZKoxLA67n3/7aCuFkA2NhEU2IV0LmXmf1Hj8I9TDHixQ1OQcU4Jp9BNmQETyVDNKh9xhRyGHhNTuuSCG8B+cs7MIE0oH77FOd765+1kbGc218XmsyQ+aip4l+dcXfTdxwAzG2u/ZO0D6SheIBsIc3xmLJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsGv8XTb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsGv8XTb"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so795227b3a.3
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 02:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775208611; x=1775813411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXj8r+QbXWQOf+yZwOhSL4Dvg6wSwyt2o76vw30M6mQ=;
        b=PsGv8XTb0PxxBcbsImHj1aaQE4YrOCmiObcFxr9w5AnwwhK2UfdWJdTtswsAlpn+jq
         YbC+mxu5mbZODRFRFhwjTkHEuqOMWJxgT/D9AyB7QkHY3FUFggHLSStKFJ7u1KK6+HU8
         jMLwAC7jwGg0HwVT4QGp11t6drQ4AxcYfapaKuS6RshTGoOi8PZHBN+UGVwKzBTuazNt
         htj+Y60QPcG+KdgLmu1BvGzsr1mYOIhA8j4B0pDmJxLgEr1ORmOoROHyFVx/QNn1J4mw
         UyXDo75rPNHGdKYLc1c4GlUvTzgPfL9anHkWMrFBo2r0pxEuxRdlsTljfhzHC2EABvEL
         DcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775208611; x=1775813411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXj8r+QbXWQOf+yZwOhSL4Dvg6wSwyt2o76vw30M6mQ=;
        b=XCoqylGZvQC8g5fHNv/5Qg41LtYjfwZczqRuXd55K63FCV0zeOui88y/4jqwGSn0+G
         SQ4+lkjy2PxJdJOM3G56Xq+wgXLegAbdG7awqTGaGczc2OKaZpKRqp1uukIU+Mdrvf2r
         d/v/7JNPYX9LyhakSXC2prGF45TsOAClNNQR9YPSjKUUq2Hms5FQhR62mQXSJn7vtMip
         rTNBfvPHZv3LJYd2hGOZQ6fk7TTgYi7Exz86g9GyNJhS1wYAklWDKs05Rii/0tIXoUhD
         d0wwDNY5y/iXPS+gflihX1DT44BJp1XuNuefOjRdKA7DjFzNLefB8+K1lrF+ZDnbn1zg
         b4IA==
X-Gm-Message-State: AOJu0YwkW1bz9PjYYUNXfsHK+5qzcAAyA7hjtPM6o/kXrfpvwMpCGt+5
	HieAFIByjfhOkgT9xNQ0tq5s3gheO2zmWgi616vw91ceux4u/FAIbnmO
X-Gm-Gg: AeBDievIJEme7YRezYKsuFSrjoiznZqhS+ndGS8Rp3iSdnmLuBC0/BsIMsPeZkWd4IH
	aUpTS8fV5c50jXjgRZdysEJNWw6cHg3qglfWpR8y2ulEwgFPJzrS7o8SOXrB3IWoVXRwnRE7cNx
	d0MDsPEfOICtW7f5p5RPlu6+tYb1+z3P+Z8dQwIAB6NMFCF20eXVDhEYnIMH1AKPMJNqH56huR2
	qKZYZPR4V1TY/86+PJ+34/cBdmzzqCRPRA93nfrNTeN0tlZOF6W9ALvz8QfU9W2HTL9KM34vn02
	XlhIJRlUCetjl8KxCkZydDQmbYjchT0Iyude3hCb2DpUmxCQZCTYOsLiYlD+f05TseqbC5W8vju
	FjvNcEhfEAGjy8hToi++gtDnc1VmQvTUHFenyIpPt6FEKUer7qzpq78HkYhmyVyUT6LzuZyms7S
	yOTbu/kg9t+xBsb723Z0FPgTj5
X-Received: by 2002:a05:6a00:2e22:b0:82a:708f:316f with SMTP id d2e1a72fcca58-82d0da2e732mr2644110b3a.1.1775208610873;
        Fri, 03 Apr 2026 02:30:10 -0700 (PDT)
Received: from gmail.com ([2405:4802:8548:f4f0:ffff:ffff:ffff:ffa1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca4efesm5498889b3a.61.2026.04.03.02.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:29:49 -0700 (PDT)
From: buingoc67@gmail.com
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hmtheboy154 <buingoc67@gmail.com>
Subject: [PATCH 0/2] HID: multitouch: Add support for Dell Pro Rugged 12 Tablet RA02260
Date: Fri,  3 Apr 2026 16:28:46 +0700
Message-ID: <20260403092848.10223-1-buingoc67@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: hmtheboy154 <buingoc67@gmail.com>

This patch series adds multitouch and stylus support for the eGalax 
I2C touchscreen found in the Dell Pro Rugged 12 Tablet RA02260.

hmtheboy154 (2):
  HID: multitouch: rename MT_CLS_EGALAX_P80H84 to MT_CLS_EGALAX_WIN8
  HID: multitouch: add support for Dell Pro Rugged 12 Tablet RA02260

 drivers/hid/hid-ids.h        |  1 +
 drivers/hid/hid-multitouch.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.53.0

