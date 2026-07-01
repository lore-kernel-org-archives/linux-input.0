Received: from users.org.uk (users.org.uk [91.203.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC83A5E88
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.203.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933784; cv=none; b=gWLLL0lK+cyQ42EuNjNXwK6gDLegVUqNVhM0afwtCxoHvMMS03j3ptn+k28nozVPITYjJaJQEhgTWRF1dmN9San89voYAs8hde0XAQrpn7Pnua4KSuQGS1/G6YSBXlBNgXJq9rlDRd1Vj9DHeLxR5QhNa5a50XbiwlSOeMoPOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933784; c=relaxed/simple;
	bh=LR8y51jW3/YWN7nxi+BuPezXxOa7zgsn0Tp4au0fmis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ppzGnJWtEZkyKmDz0A7CtPRU6pNTj+CgoQSObGYtf+iBqfmfYHS/Ejne4PUxb2LYrGo5/9Mzast/Clbrnh3NrTPALwoxHjUsBf5aq756ymcudO2vBxU7Tdl8ALJW20GlgZ0yzqOfO8bhFnnJBvlG16nW/d8Bluo1Fgs2aH1QySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arachsys.com; spf=pass smtp.mailfrom=arachsys.com; arc=none smtp.client-ip=91.203.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arachsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arachsys.com
Received: from [92.19.12.217] (helo=rawagajah)
	by users.org.uk with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(envelope-from <richard@arachsys.com>)
	id 1wf0Jr-000000007cL-2h1k;
	Wed, 01 Jul 2026 19:09:59 +0000
From: Richard Davies <richard@arachsys.com>
To: linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mathias Gottschlag <mgottschlag@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Richard Davies <richard@arachsys.com>
Subject: [PATCH] Input: focaltech - fix array out-of-bounds in focaltech_process_rel_packet
Date: Wed,  1 Jul 2026 20:09:32 +0100
Message-ID: <20260701190932.14960-1-richard@arachsys.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make finger2 (and also finger1) unsigned, so that if the finger index in
the packet is 0 then subtracting 1 creates an array index which overflows
above the existing check for FOC_MAX_FINGERS, as the existing comment says
it should, instead of writing to state->fingers[-1].

Fixes: 05be1d079ec0 ("Input: psmouse - support for the FocalTech PS/2 protocol extensions")
Signed-off-by: Richard Davies <richard@arachsys.com>
---
 drivers/input/mouse/focaltech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index 43f9939b7c63..d3ad4af5aa09 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -197,7 +197,7 @@ static void focaltech_process_rel_packet(struct psmouse *psmouse,
 {
 	struct focaltech_data *priv = psmouse->private;
 	struct focaltech_hw_state *state = &priv->state;
-	int finger1, finger2;
+	unsigned int finger1, finger2;
 
 	state->pressed = packet[0] >> 7;
 	finger1 = ((packet[0] >> 4) & 0x7) - 1;
-- 
2.53.0

