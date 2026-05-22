Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF628CF5F
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415247; cv=none; b=GSdqlmYkSz/oIM+ARp/kzP7VnVstkpwfT1g7jZFlrtwNPVRH1IwTcgeAVAOw4vppSdGTwDGNp3TjaeBQUI/g+RwJMQ3pXp19GlMokrf6UbCv4oEqyMeHpanWU3iVGMq++na60cAngMw2ZjlN6YttnfgK7nEskhNa/2Wv0ng/clM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415247; c=relaxed/simple;
	bh=d+TP/vV6eQPCmODq9bsBQ+d+Haq4o8ggGfF0NUoEYoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hf01bWiiHwFbD1kAYZruPG78gq9zc6ZrsRjZFuoaYfanRroAqGDhLPQoPOpFQW1V2o1Lkjmv7tDjnyUwileGD67vap0w+0bsWdH+FSMRVkf3LwzsdisfqX8fE5hakwysLE90id5Vp+KHgMkCfeeByvLA4MMnmbidJiIWFhIsvgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=OJ1HJyVa; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="OJ1HJyVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1779414691; bh=d+TP/vV6eQPCmODq9bsBQ+d+Haq4o8ggGfF0NUoEYoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJ1HJyVavrIeFDr/p6ytJRqpFzApQXG1wNNL+jq1rO8N4/1fs/PtXAduXBnRgx5ie
	 QtcjUYe3/aCKNsK8ZYUCZgmw/synJoRQHIqHFoDwuDqL/M8/lU4GTz4UiDdxUmGXe6
	 ocfZhZWihayTEoV6FWdWpFl9l0j+SDc3Hnw8bQ+HXG7Ou30fnLH6UcxNK3hFCZf6AB
	 BijW6pnzXMuzPQXCocNWPdWGt6m9/kgAJNGnpm+D54c7cVRS3ka/V1wuL0oqxhbOlv
	 45AbcKN7n0XorSvUTXy1ETtFmdxLfbVXqRbZOKOigyy7jTM3h+EFECHCaTtg+d8nbT
	 5AkdQRhf27fSA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id D2E8BA0EE;
	Thu, 21 May 2026 18:51:30 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lyude Paul <thatslyude@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH 2/2] Input: userio - Allow setting other id values
Date: Thu, 21 May 2026 18:50:40 -0700
Message-ID: <20260522015040.3953472-2-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522015040.3953472-1-vi@endrift.com>
References: <20260522015040.3953472-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, only the type value was settable. The proto value is used
internally for choosing the right drivers, so we should expose it. The
other values make sense to expose as well.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 Documentation/input/userio.rst | 23 +++++++++++++++++++++--
 drivers/input/serio/userio.c   | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/userio.h    |  5 ++++-
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/Documentation/input/userio.rst b/Documentation/input/userio.rst
index 415962152815..7aaaa629bde0 100644
--- a/Documentation/input/userio.rst
+++ b/Documentation/input/userio.rst
@@ -66,8 +66,27 @@ USERIO_CMD_SET_PORT_TYPE
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 Sets the type of port we're emulating, where ``data`` is the port type being
-set. Can be any of the macros from <linux/serio.h>. For example: SERIO_8042
-would set the port type to be a normal PS/2 port.
+set. Can be any of the serio type macros from <linux/serio.h>. For example:
+SERIO_8042 would set the port type to be a normal PS/2 port.
+
+USERIO_CMD_SET_PORT_PROTO
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Sets the protocol of port we're emulating, where ``data`` is the protocol being
+set. Can be any of the serio proto macros from <linux/serio.h>. For example:
+SERIO_IFORCE would set the port type to be an I-Force serial joystick.
+
+USERIO_CMD_SET_PORT_ID
+~~~~~~~~~~~~~~~~~~~~~~
+
+Sets the ``id`` value on the identification of port we're emulating, where
+``data`` is the value being set.
+
+USERIO_CMD_SET_PORT_EXTRA
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Sets the ``extra`` value on the identification of port we're emulating, where
+``data`` is the value being set.
 
 USERIO_CMD_SEND_INTERRUPT
 ~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/drivers/input/serio/userio.c b/drivers/input/serio/userio.c
index abca8cb6aca5..8c19975c84bf 100644
--- a/drivers/input/serio/userio.c
+++ b/drivers/input/serio/userio.c
@@ -206,6 +206,36 @@ static int userio_execute_cmd(struct userio_device *userio,
 		userio->serio->id.type = cmd->data;
 		break;
 
+	case USERIO_CMD_SET_PORT_EXTRA:
+		if (userio->running) {
+			dev_warn(userio_misc.this_device,
+				 "Can't change port extra on an already running userio instance\n");
+			return -EBUSY;
+		}
+
+		userio->serio->id.extra = cmd->data;
+		break;
+
+	case USERIO_CMD_SET_PORT_ID:
+		if (userio->running) {
+			dev_warn(userio_misc.this_device,
+				 "Can't change port id on an already running userio instance\n");
+			return -EBUSY;
+		}
+
+		userio->serio->id.id = cmd->data;
+		break;
+
+	case USERIO_CMD_SET_PORT_PROTO:
+		if (userio->running) {
+			dev_warn(userio_misc.this_device,
+				 "Can't change port proto on an already running userio instance\n");
+			return -EBUSY;
+		}
+
+		userio->serio->id.proto = cmd->data;
+		break;
+
 	case USERIO_CMD_SEND_INTERRUPT:
 		if (!userio->running) {
 			dev_warn(userio_misc.this_device,
diff --git a/include/uapi/linux/userio.h b/include/uapi/linux/userio.h
index 98fe7e9089c4..550c7465af1f 100644
--- a/include/uapi/linux/userio.h
+++ b/include/uapi/linux/userio.h
@@ -27,7 +27,10 @@
 enum userio_cmd_type {
 	USERIO_CMD_REGISTER = 0,
 	USERIO_CMD_SET_PORT_TYPE = 1,
-	USERIO_CMD_SEND_INTERRUPT = 2
+	USERIO_CMD_SEND_INTERRUPT = 2,
+	USERIO_CMD_SET_PORT_EXTRA = 3,
+	USERIO_CMD_SET_PORT_ID = 4,
+	USERIO_CMD_SET_PORT_PROTO = 5,
 };
 
 /*
-- 
2.54.0

