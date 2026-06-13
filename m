Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD73538B7AA
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364648; cv=none; b=mTY28fteSU5YDTk7t33msWjXOhZwzmcbnBXRUTuBePIiiqx0/uWcEfrTf5qFBj5rzMNHQ6UeCAwXFhEixWAg9HH8uFZ8aNae4tiKtjjS9MHibzSLL+++ZJMQ5ci3Tjle8WEVh2RbkAJN3yVHHsVBBBxe9TYcVeY9OrzBHnEK0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364648; c=relaxed/simple;
	bh=94YcZ6ZNYmxuTKDWrd+gjT+yz9DM+SHIJ1aRQXaE8T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXT3sNc7NE797CTo3/EJqnptE3N/wqc+/rS60NcBzlHoLnqW7cErlu5UZ9FxTEju5jsl0xQ5/Os2ib/831pAPQhA3/3egut6gNWIAdrTXxWMDo9CFqNdWX4TZsUGvOwYsLF7jMgwRPynMQH+epzTGnrv2J5xLyLRBAWBY/ahtDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZM9iriy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hZM9iriy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781364637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CbW640+mmnY2NwwdExxOb7zmHslMNCB8Z3rzlSkO0Co=;
	b=hZM9iriyQm6Nu1wLxr3Bt4n7ceJ6Z4iFtbeySAP8OXilZo5MxRMfASkFlewSiT7RNlUy1c
	924rJKBL81JhGTbt8/82GA+7dkFBYlNPERD7Fbjgzlhao/3OStWZiRspIUzGoKX7SzJ3ir
	WI6eAsdf1vE7SfF4rWiFJwnhqKQzz38=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>,
	"Antheas Kapenekakis" <lkml@antheas.dev>,
	"Connor Belli" <connorbelli2003@gmail.com>,
	sahiko-bot@kernel.org
Subject: [PATCH v3 4/8] HID: asus: cleanup keyboard listener on failure: avoid use-after-free
Date: Sat, 13 Jun 2026 15:30:25 +0000
Message-ID: <20260613153029.2559774-5-denis.benato@linux.dev>
In-Reply-To: <20260613153029.2559774-1-denis.benato@linux.dev>
References: <20260613153029.2559774-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

asus_kbd_register_leds(), I noticed it registers a listener to a global list
and uses devm_kzalloc(). If a subsequent initialization step in asus_probe()
fails the driver returns without unregistering the listener, and the devres
subsystem will automatically free the memory, leaving a dangling pointer
in the global list.

Fixes: b34b5945a769 ("HID: asus: listen to the asus-wmi brightness device instead of creating one")
Reported-by: sahiko-bot@kernel.org
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 0a6c97155549..f38b18ad65c6 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1426,11 +1426,17 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (drvdata->tp) {
 			ret = asus_start_multitouch(hdev);
 			if (ret)
-				goto err_stop_hw;
+				goto err_unregister_backlight;
 		}
 	}
 
 	return 0;
+err_unregister_backlight:
+	if (drvdata->kbd_backlight) {
+		asus_hid_unregister_listener(&drvdata->kbd_backlight->listener);
+		devm_kfree(&hdev->dev, drvdata->kbd_backlight);
+		drvdata->kbd_backlight = NULL;
+	}
 err_stop_hw:
 	hid_hw_stop(hdev);
 	return ret;
-- 
2.47.3

