Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4741D228
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789904407; cv=none; b=tVzPvUufGYBQKAx1+gh/SSlzEKmc/369ztQQCgS0pf3pC1GbPb+SGlJ72bvKL1ZWu2N7Udg8mttB++2I1Lq+cyRdR7No9LBNsCy05YvF53RLXy5bnXyzUgP/hvlcm0EsQAu92oIiYyNB2JzHda7Fp83+vDbFj4m/G4IV7lu6sUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789904407; c=relaxed/simple;
	bh=7B2LFEnl9mbenlcEhpsibESNW5OLpwmL7Ks/s1Yxw+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeVQdz9wrsWtC0uiO64f27L0630+2gu84Lkovawu9bZyFEWhPsfxK5AYwy3tL4p8FEVq0W/pfHr7zES72ifNFz7efaZ8YOCQUKJE3eJGy+4e4BIT0gfEviftm4HQUaebgnZTKZUNXc8CQD+4DiQr++TKIUXy/UVk3BZczGaVcfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdyTxujG; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdyTxujG"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ceb47d53so358173a12.0
        for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789904402; x=1790509202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VB/v9xMNCgaG9X/tex87TcBN9TifdEbvdxv9dgsPxiQ=;
        b=VdyTxujGlA+AjI3BWVel1LrY52Xdm4SW/wdERhEN4pLcALfjVHOH5W3Ho2aCZJvRHH
         vgTzkWQLjX4IyVVCGoVkju1G0CSgY05ZQq6nVxqPK09qCBMlii5YMvPtOENW2D0RdjtL
         0XjeWOWUYdJqe45wCbIET58RkzCMVJpZZGzaOAgEHxxeM1JTXP5/AZf3Z+RhPlX1KMFO
         1W52n8RcRVOSycjb9pCnVN263LDQneJOWmrYrMp3TjuoG/5ZbSFi9CEnYBU1vq9Whv3Z
         zV+ilF/egsJUMeF2/U11D7mBrGl1Ya0MukgJVTwYiwkhnco1LmJbAJlWjvNWGRG9OOIE
         dJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789904402; x=1790509202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VB/v9xMNCgaG9X/tex87TcBN9TifdEbvdxv9dgsPxiQ=;
        b=cFIPRLbTrEXQaXbeYFe1C428f9wht2e0QIWB+i1F4rVFZpSQU1uP7dS1QnUdzCbOi1
         FheHQPh5E8mNQcGTBC1gXVlUlQYdMcfwz+ZzC1ahexwQKDin7bi9eBPJmruPtL5D9mIb
         04y9WjZMUazhEx9aD3SBJitKSeYHWieEuBu2GIXV84f9INpHEtADkSb0X+8YAAVdSGax
         w45lJ7tXPzoTORSb2DE7qljLde7qoufehRWdFA1DUQjoLTtchAkjN0Y4cxdVJ4SC6aFa
         y854UM+5I243lggrh4j3kEnMIQzT8yoDGeJQGFWTpGFFPmM4j3CFtarwSDP9fAXlQ/Je
         FPdw==
X-Forwarded-Encrypted: i=1; AKwUvBznyCuEhLAsUSaCU1oNg6bgSydKkuYz3vZ9qpTbo8OGPAjHY2Drg2Q7t6CggxDy5h0rpz+a49FrwTqtXw==@vger.kernel.org
X-Gm-Message-State: AFuF++kBhJL/R+G2SMh9yp63v8G/An8UbcaoCQziH8icuZQLdjw6ZdgX
	0wVCWOerfP6tAxTZmnFnYo5ALSyTKiHOUyxk1rN0qnKhv4J5K6IpZTnk
X-Gm-Gg: AYBFou1SUeMBb1f2jw2DQizGqNn7UepXlfW55vXXXjERWGGHABC42xKufd9A5BNIB/g
	6l2xMQtj6S+8n95Dz0aB5nck/2W/7F1iUg//rKHl0oKg3VuG/Z0UKPCATfgpOnIxgFEIr3fCSAI
	M3fiJYfAFjj0ZtYEcixYS7QWV9YHmKT9+Mlo8DFkIUs1jTc0PEkr4q27ep/6D9RmAvT8IgkRDOT
	4CutA5XoDI8UEefWZUkrSf6rwrkhmrKlhlB8TZ17AEyr98OtJ5oK0T8M2yRnV7/zn1wryRjzw8d
	/lWzzNrdcbkfWZXVNcC57yhdzkJ4F5dD7nzHYxbf6gxWZQ378hUnWvq9q3fRusV5VwMrba24ueD
	cKdZ7O/+oxwBgQWdIAWinBNgjO6ZgGpl7m7Z4pFhNFy3CwxLBBPqep7KCbfQQzdp22jNw9BEtcl
	aeTX3YlAiCwiQISeEdzzOqPBXaD2fx/zvD2aaiHf/sFPH1M7p88ilzC+0yH0GUDdgTtAxZf004F
	RLCokwA2HBTaNg=
X-Received: by 2002:a17:90b:2b8e:b0:39e:4c7e:bc5 with SMTP id 98e67ed59e1d1-39e5572d5a2mr7798744a91.19.1789904401672;
        Sun, 20 Sep 2026 04:40:01 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:2022:c2a9:de8:d005])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm8490548a91.0.2026.09.20.04.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 04:40:01 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: floe@butterbrot.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+eb4706daf505f9c4b547@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] Input: sur40 - keep device state alive until the video node is released
Date: Sun, 20 Sep 2026 18:39:49 +0700
Message-ID: <20260920113949.12726-3-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920113949.12726-1-ngocthang2710.1999@gmail.com>
References: <20260920113949.12726-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sur40_disconnect() frees the sur40_state, which embeds the video_device,
the v4l2_device and the vb2_queue, while a video node may still be open.
Closing that file afterwards touches freed memory:

  BUG: KASAN: slab-use-after-free in vb2_core_queue_release+0x12d/0x150
  Read of size 4 at addr ffff888066fa8aa8 by task v4l_id/28733
   vb2_core_queue_release+0x12d/0x150
   vb2_fop_release+0x16e/0x200
   v4l2_release+0x22c/0x350
   __fput+0x418/0xa50
  Freed by task 16811:
   kfree+0x1c5/0x650
   sur40_disconnect+0xaf/0x140

Give the v4l2_device a release callback that frees the bulk buffer and
the state, and drop the disconnect path's own reference with
v4l2_device_put(). The last closer of the node then does the freeing.
The probe error paths never open the node and keep freeing directly.

Reported-by: syzbot+eb4706daf505f9c4b547@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=eb4706daf505f9c4b547
Fixes: e831cd251fb9 ("[media] add raw video stream support for Samsung SUR40")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/input/touchscreen/sur40.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 7020bcf9b81a..efd4fe557cef 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -648,6 +648,15 @@ static int sur40_input_setup_events(struct input_dev *input_dev)
 }
 
 /* Check candidate USB interface. */
+/* Runs once the last video node reference is gone. */
+static void sur40_release(struct v4l2_device *v4l2)
+{
+	struct sur40_state *sur40 = container_of(v4l2, struct sur40_state, v4l2);
+
+	kfree(sur40->bulk_in_buffer);
+	kfree(sur40);
+}
+
 static int sur40_probe(struct usb_interface *interface,
 		       const struct usb_device_id *id)
 {
@@ -733,6 +742,7 @@ static int sur40_probe(struct usb_interface *interface,
 			"Unable to register video master device.");
 		goto err_free_buffer;
 	}
+	sur40->v4l2.release = sur40_release;
 
 	/* initialize the lock and subdevice */
 	sur40->queue = sur40_queue;
@@ -831,11 +841,10 @@ static void sur40_disconnect(struct usb_interface *interface)
 	video_unregister_device(&sur40->vdev);
 	v4l2_device_unregister(&sur40->v4l2);
 
-	kfree(sur40->bulk_in_buffer);
-	kfree(sur40);
-
 	usb_set_intfdata(interface, NULL);
 	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);
+
+	v4l2_device_put(&sur40->v4l2);
 }
 
 /*
-- 
2.43.0

