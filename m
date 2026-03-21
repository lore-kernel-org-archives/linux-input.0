Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCDF253F13
	for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774078413; cv=none; b=FZD8Yu8QK3PwGSzWVu8ltzkow4WX+LbHrSbpp5gn5nTguX+By3Ecnr88hlhU1u/vgSOiBW/Y539V8hdcr3TK/1ytfvggDKxNodHEyXeUqXbNa4qz2EBzFMelbF1mreoqj2VD3jnLivVjTlT+vxuLsAsr/DE843vhhlRe10dgadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774078413; c=relaxed/simple;
	bh=ohd6sExu0boJe37wSbF8PjokdWTXmSyxm0K7qXBQ5T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OlLnldVVNv4oQUY8PP4ZKhCjuzpfz/5ZiWUg01R4xwSyhzDayMtNjEIWYoLWSKJQKDlsIJECWDEJR/kiXwENTqmsH6HatcXU23z5Tsmn8XgqAyugKi/ByxlC7GZwnhLF2Kn31HTIwiwjZNvxqLIe/WN8srbkDHteEIETXUMuS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=EjBYmNLr; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="EjBYmNLr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1774078408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=okBqHNZetlSObACyiKEtIep5x52Gimb817rennDzcCs=;
	b=EjBYmNLrmAgk9A0ZuLVS2hiWCcRNXNAgCcKt5emjohE7XXAVyXzhNPx2vxFubsBZdL7UQE
	W16g1obNopC3A2CJyoljobuJBsOkb9Z1yZDOJ1cnUvTevT89w3ev8rH+lpi3Q5hPs9drln
	iyEFuwvpHivY6lPGMcQs05JJvE4fSKA2lweOpeG8wCJdONH6R0NwwZEQjZpdATGV83M1H3
	hrwhnf+Za5MK+W5rKFUf6pNJKiBAupKa8yK80Q1SFEQgmxiYryFhvW8/4r5DXj+W9Lky5g
	ODjxN6AJU0zq1a2W6fbwDc3zYu6hDioIWqSvtFyp9nEeX9WqYNSx3hyN50a8QQ==
From: Val Packett <val@packett.cool>
To: Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: Val Packett <val@packett.cool>,
	Stanislav Zaikin <zstaseg@gmail.com>,
	linux-input@vger.kernel.org,
	phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: goodix-berlin: report a resolution of 10 units/mm
Date: Sat, 21 Mar 2026 04:30:07 -0300
Message-ID: <20260321073242.556253-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Without a reported resolution, userspace was assuming 1 unit/mm which
is wildly wrong: a regular smartphone is clearly not 2.4 meters tall.
Most applications do not care much for this kind of raw mm value,
but Phosh's on-screen keyboard would accidentally trigger swipe-to-close
gestures due to misinterpreting small movements as huge ones.

Do what the older goodix.c driver does and set the resolution to 10
units/mm to make sure the numbers calculated by userspace are reasonable.

Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/input/touchscreen/goodix_berlin_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
index 83f28b870531..b0938a4f3fec 100644
--- a/drivers/input/touchscreen/goodix_berlin_core.c
+++ b/drivers/input/touchscreen/goodix_berlin_core.c
@@ -628,6 +628,14 @@ static int goodix_berlin_input_dev_config(struct goodix_berlin_core *cd,
 
 	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
 
+	/*
+	 * The resolution of these touchscreens is about 10 units/mm, the actual
+	 * resolution does not matter much since we set INPUT_PROP_DIRECT.
+	 * Set it to 10 to ensure userspace isn't off by an order of magnitude.
+	 */
+	input_abs_set_res(cd->input_dev, ABS_MT_POSITION_X, 10);
+	input_abs_set_res(cd->input_dev, ABS_MT_POSITION_Y, 10);
+
 	error = input_mt_init_slots(cd->input_dev, GOODIX_BERLIN_MAX_TOUCH,
 				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
 	if (error)
-- 
2.53.0

