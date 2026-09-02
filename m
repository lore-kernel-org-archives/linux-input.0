Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F507349CDD
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311069; cv=none; b=YbDp5qLTKiixMlDO6NHiFa8/pqZcRyXv/eglKEI7e3VYIouptpL7sDPHgFln1K/f6TX2O8LaK1KMphbu2COq4TuaU3IeWbMqC7NexBQO92ZLnbzg2TKjgrI2jJCmUFpCWqQAMHKWT2dHt5641mzMcLQQwRxds7IMerf27G6wgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311069; c=relaxed/simple;
	bh=hmpEm1iQREvv6xqecXbBvzDEykBg6VO0WVCyslh1m0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN8mwxp8IwwDY824gnlTXN7upjrhdYdumoF1pLBoOd2j0gPdCwFhGESHNXOs+8kdPQE8QYMetVuXwFUBgk2oMuLnTeXTnMeFRkwaMviFeZHpm481+txGQHI9NwNSJVqeOlfyjt89naGY1n2Fg7Y9cadbAXx+6LS5CEPGlKr/caA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=RqVaM5iF; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="RqVaM5iF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1788311060; bh=hmpEm1iQREvv6xqecXbBvzDEykBg6VO0WVCyslh1m0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RqVaM5iF/Y9PwHbaujJJ8AQxgsoXXVIY4Fsu85oSfrutSKPK+sbmLqsuNf2D54vtF
	 3mESC94WLhOlJizxqtokfPbArVTFwJvxcHQvboT0+UxhlSaeqDvl2020LlxosO2l6J
	 tfE+H+Q3Rjabd4zFlu60J1cllA5kDLCA8YPW6XF9B3IOBpwXKDPLxjhk6AbJ4qXM8z
	 5kKmxIXtpb8b9jMqvSs41gpm/vpsRZZjlBu1YAjHp7HxHUJcjHPX/2CXU8OvX798Lb
	 CtiaFGvk9W94jyTj7eEI8cSFN0kKnkodPRpiX7lk35SjSzPGN+2uwbh0WYiWQQ55c+
	 /zylcg0Tqp3tQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id A7CCF13208C;
	Tue, 01 Sep 2026 18:04:20 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH v5 11/12] HID: Map more automobile simulation inputs
Date: Tue,  1 Sep 2026 18:02:32 -0700
Message-ID: <20260902010237.865772-12-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902010237.865772-1-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HID usage tables section 5.3 specify clutch and shifter values that had
previously been ignored. As the ABS_CLUTCH and ABS_SHIFTER bits now exist,
we should use them appropriately.

Signed-off-by: Vicki Pfau <vi@endrift.com>
Acked-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3487600cadb4..6ade969412c6 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -828,6 +828,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0xbb: map_abs(ABS_THROTTLE); break;
 		case 0xc4: map_abs(ABS_GAS);      break;
 		case 0xc5: map_abs(ABS_BRAKE);    break;
+		case 0xc6: map_abs(ABS_CLUTCH);   break;
+		case 0xc7: map_abs(ABS_SHIFTER);  break;
 		case 0xc8: map_abs(ABS_WHEEL);    break;
 		default:   goto ignore;
 		}
-- 
2.54.0

