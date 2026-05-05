Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331823BD635
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957199; cv=none; b=d191m0zRUXmSyK8tlEjjNffopjnZJ9jN+s90RwCyYmq6RYPTzw4eOHItcL3GJlLhc/9wmFHsfueKV6c5f3PxNpdvVr3BiuBr6NeLwfdETaNZ0Qplg+V71nSjvzvUGl14Rm6WNvqY1z1cWz4k+heBiXEAxbOSafjb3hnIpaI5bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957199; c=relaxed/simple;
	bh=VFdrAZoVLC4fQhDueHQHa6dNg4khUzfyM4bGbZqKHNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/TSL5nSDR0LCSlWk6kc1LijXYN0li7bF0mce8h1g7xQPO/xGI50z+aeg+63MOX1BxW9jNfCxyANe7ZQhQEEuiMRiGnALZGIx6Gv5tI6Xn/ELGvzPvXLQ5kVsiVIKba5tyzfcVtxFzOQO8LdAsExmnQKxbIEph89V05AGtJPH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Foz6b8ig; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Foz6b8ig"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso5276216eec.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 21:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957197; x=1778561997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxAG6wmMi0r6jkkaHKyUSCVdOHZ9UsxXPZ5kjHekB/4=;
        b=Foz6b8ig/extUdJxsormurwIUn2OXhpGhmncEDlGWg/rM+PbbN0vrCsGQQv9KQAoDE
         hXZPaH5JVga2C1nX8NR4VjjxKdrOAniBhkAO05U7AFWDY/L9Py0zMSOs0lbKVG8H/ht5
         k9D637yUjDuigqt3kaZf1ZjlZRbWfVG7efO8D9Qk91JeIdraWmAnAuEFmqLupUqrwYJj
         X/i7XNWHB/vCONLxEY/B/CFg5vYSZUYwaSTE9bc0NqfctgkAXPczN864MGmcvICT7WzE
         4/bZ3NiqW+fIED5OfpHWUEYqQLTSPOOJiSgsNHCk2Yn/x6c0AXt7EtX8LFCYPIzJ9XKR
         rfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957197; x=1778561997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxAG6wmMi0r6jkkaHKyUSCVdOHZ9UsxXPZ5kjHekB/4=;
        b=nq90IHhyuwnOsD2ypsKBDbXRXSWDLMmh4Av0rQiT73XuDrHmEMX+nWMbHy7L7eDaoE
         e7ayvey3vcIUuA89BswGb++FRBytk5rSyC3frrC5uTwMKVfPxVibr0y2mnt4uCnvj6Em
         kD4WaP8Xr/JvYq68W5EN8CaB05aPcuD6kPTOkiWC0jt4Nk88BHhLCN/om8JmH/dfJzOg
         OYgv3V5OnrLU1ycFFl2+uCaVjkZ6dHmXkkU0wOHLR93I5G+QMSjg0Y6QvMqyFuoQNrBH
         /PbjwIktinwx/QxT+376FTBa4OBTNf5XsBOBcSLUE6nm4qMS7OZJXjVxeJ0xSv991/Lc
         UgHg==
X-Gm-Message-State: AOJu0Yz273HG2fAYKQfo2U2I+qMnwKKTbtPG33eXpmeDl0AaHyVDp6V2
	uAEUHCQaMxQ/BX8N3jbX+TnRjG3/W3wnMg8KAn+toY9TFEx4DDz+h1UxWWsxYA==
X-Gm-Gg: AeBDievDe8J+4dVlY0Do2zkxoeenoT0ZHK04Yo6TydEgY7lMWOCMen5YqgIZhiudcok
	JUz5z3Xa23CBEaUbAkyKqVgnhLvtXBbjQANJ3cjTTA/tWWBzqnbbNEgk49R0XL+iH458LggtBMb
	wmEPo7+LReIGIF2fzPzLFw19VpIHAhig9CfSa9Q+YAkJML4LvSrmGUNZt07V9W9WSlW1vS9UlUg
	Ap0fir7vwfMYNGQxPI/aW6GWuQ/yptCUs7LDTIhUV/PgdG6da/ezz7YaCovu9h00yQoXsi9aN/O
	UBnl9gRvk+yzGUdt6IETRNQYrZmGOnRoIhULxAClw1Ecjm71NEfFwg2xx9gg7XOzeVFSx3l9VfQ
	z74Fye39OmyABcxORLuNvUdNOcs6aEph2HNEKXyD3+YMnI3PjoLz71GHk4fmyiVjMXWYkf34gdw
	G7+QpH/9D67f4Zmx0BxrSXjIH1mFMA20O3W4AqbMUwzSZa48P/QfygQIkE+hBLZckHJoofWgTaM
	xNJjq4PUJqQpZy9W8tnrH8OfQ==
X-Received: by 2002:a05:7022:611:b0:12c:8e7f:1b30 with SMTP id a92af1059eb24-130b163f8bbmr900233c88.2.1777957196554;
        Mon, 04 May 2026 21:59:56 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.21.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 21:59:55 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 01/20] Input: rmi4 - fix register descriptor address calculation
Date: Mon,  4 May 2026 21:59:31 -0700
Message-ID: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading the register descriptor, the base address is incremented by
1 to read the presence register block. However, after reading the
presence register block, the address is incorrectly incremented by only
1 byte (++addr) instead of the actual size of the presence block
(size_presence_reg). This causes the subsequent structure block read to
read from the wrong memory location if the presence block is larger than
1 byte.

Fix this by advancing the address by size_presence_reg.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2 of the series: added a bunch of new patches.

 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ccd9338a44db..06f5e3000cf0 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -594,7 +594,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	ret = rmi_read_block(d, addr, buf, size_presence_reg);
 	if (ret)
 		return ret;
-	++addr;
+	addr += size_presence_reg;
 
 	if (buf[0] == 0) {
 		presense_offset = 3;
-- 
2.54.0.545.g6539524ca2-goog

