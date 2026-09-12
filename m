Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C582D0C92
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789185198; cv=none; b=kv6Nl2SOZ8mSxggCUgaSssyKLz+qNyZ5bwdMx8K5938GkbdStiOIPAPI824shPaLmhgnoPEjzBWBLODs7TVWVAzbZCsQbRnrrXRVTsPctyih2VYId1NBFLYOy7dJGCNYyOX0M0luh/TzbgoCXzdteNyv19ALBbbaZeAJRU6U1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789185198; c=relaxed/simple;
	bh=PsCYZDyg6OqXUoxdUAz6x5xkOBMQmfyIYpdA8bXjP3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJ0itBfSPUwRJ/l5NkIhecx04vM0cRngNap8vKFq/6KHBKHO+9Wohz/N9K/PHJM20lecJ8tvB7o1bRc8afZTJiiIit64GwWjhP7jJJ0fPtnG6xPRUvO7VSaqXsbeKrCHTMgs54PaPo8+5mHAPQo7LhXDHokER3SY6S/fFJtesiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdO/Sf69; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdO/Sf69"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8692a856865so671325b3a.2
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 20:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789185196; x=1789789996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o7YuU5wogL+JyJaffzvzTfGHhKGliI0qNAbr95aUNd8=;
        b=OdO/Sf69+0pC58zgE4LKT6LG78WonvZ7WZcFhn/4nT8J5adRVg/qCNhjt0cFmpCt9u
         k/LuIlTarFs3Ulge8QkehwWRitZ1B72cNHu6/8ddHYEyAneHekBEy4W8Dw8XgfAZCYm/
         KhEFmClqTJLbAnrDASW1GBfXSTcXb2sxOICEXiKM7PFBMWxvZfdGbBTyE9Gg07iil4/z
         7bfg93gJQA+kPmu7t7Dkj9SRAuGpOoochpnJxbyyOeGqsiLpCtNPjLfB7MsdbJPuFEyg
         t7JV3aaw79hfcQtdfZff2VibXMEsMcScoqymhS4TfY9iMkaa22XcN59Aj8pbNXhlSJkR
         fx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789185196; x=1789789996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7YuU5wogL+JyJaffzvzTfGHhKGliI0qNAbr95aUNd8=;
        b=XHHgjvm7mciZ2HqNYdpJPTfiegYhMen//WVrv5copBBLFeOiB2IRiWbMg3bsSwbcJe
         GwHCgbjv/VxdPOYh7S5WEeKvJW8uViCY3t3wtCTSkctgif6laK0777GYWwMKsrg+/Srv
         kxm3flXi/QEa6B17qWHRSlNd8c+RCQ92ZuyymSjX+DCRoEd9kAIwhk+wD6itFxvIeTMy
         p3DchNBa1zeG5GqTWLzu+yvMn7fttdR8WHiVM7hTiT9Ednp3PCg25eriV3r2ZIT4cmYD
         divFFx+L0DYebDYna1tlaQGRC7K7os+DMMkIfcvRU1/J7/mbIBOhiSQrAXevXazd/kMh
         w5pg==
X-Forwarded-Encrypted: i=1; AKwUvByC196pnvZHpNBza+DuVAJz1uPusjNiebfmyKn495C4A9tpCB9mYpggTQMDie1QyoAW95lmQOmALuTE1w==@vger.kernel.org
X-Gm-Message-State: AFuF++nfeg5vcm/FcUA7dPG11YI+HlNDsYOGF2u37WTSC14hJKeO1SwR
	F1ZYuse4/47m1LX33B7QykeU4wDzDPt9OmRsQWcd2zNYmg5g6j5QKdMx
X-Gm-Gg: AYBFou1p20Z/SmfbKDIuZIxMdy+ATPI+jlWSISHXtVqdJ2C75Ds3vQpIdbvqRTwT4EX
	yHLXakIHbHxJncNRGPtGRBX6pJeYMc9wUj/kYEn9DNmGLL0Hcar0ltTdh2JvcxbBT3yJhFPbNcF
	ddpAIgQ+uC7I/0M3eZfZNM7pxeEr9dzxgJ3B4EaRl9nPOL3wOysRtGKppXNMPTlIgeFLoPRT+2P
	WSxxkZ7ORi4lif+fcNixRYDJQK1JdBsy52eGI3/3AQhCtgvDTF6+T4OAOVAGJchvMWZ7hPmOS3B
	nWfcYcZed3/xmPip5s1F75BXNA8vvg7mPC8Uh9xozhtKsxs5AHqMiepfRbMAJ5QwE9j2cr8HXO3
	YHto4r++DE2hcHEpMZkPT4qGpkV+p/tDHqq9JddaDjYYL6u8Ai5E+GA72bdmPUEENZWL8gEQ/Yj
	E0RHw3u2WYbWYfg4682deYAfzSVQKiiVvonWWRoTEV5gZ0laYRm6RP/tUZIod4VPJGXWYK3Fe3P
	jbj2Hnc5SNbz6pK480j8+2XbCA6lVrXwrO1MHDd5MSn0dxUCF9tQZVilayFmWf/ueUcax/Yn54=
X-Received: by 2002:a05:6a00:2da8:b0:862:72a7:eb59 with SMTP id d2e1a72fcca58-86b3041262cmr9863869b3a.4.1789185196216;
        Fri, 11 Sep 2026 20:53:16 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:3e34:fc0e:e4a8:fba1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29bb8f28sm1901858b3a.40.2026.09.11.20.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 20:53:15 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: kees@kernel.org,
	oliverburns.kernel@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+34957180b0ed2581edaf@syzkaller.appspotmail.com
Subject: [PATCH] Input: sur40 - fix use-after-free in v4l2_release on disconnect
Date: Sat, 12 Sep 2026 09:23:06 +0530
Message-ID: <20260912035306.13130-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sur40_disconnect() unconditionally freed the sur40_state struct
(which embeds struct video_device vdev) via kfree(), even while a
userspace process could still hold an open file descriptor on the
video device. video_unregister_device() does not wait for open file
descriptors to close before returning, so if a process closed its fd
after disconnect() had already run, v4l2_release() would dereference
the already-freed vdev, resulting in a slab-use-after-free.

Fix this by giving vdev a real .release callback (sur40_video_release)
instead of video_device_release_empty, and move the v4l2_device
unregister and the kfree() calls into it. This defers the actual free
until the last reference to vdev drops to zero, whether that happens
during disconnect() (no fd open) or later when the last open fd is
closed.

Tested-by: syzbot+34957180b0ed2581edaf@syzkaller.appspotmail.com
Reported-by: syzbot+34957180b0ed2581edaf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=34957180b0ed2581edaf
Assisted-by: Claude
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/input/touchscreen/sur40.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 09d8c5f8d09f..bd8d9f6190fb 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -179,6 +179,7 @@ static uint gain = SUR40_GAIN_DEF;
 module_param(gain, uint, 0644);
 MODULE_PARM_DESC(gain, "set initial gain"
 	SUR40_PARAM_RANGE(SUR40_GAIN_MIN, SUR40_GAIN_MAX));
+static void sur40_video_release(struct video_device *vdev);
 
 static const struct v4l2_pix_format sur40_pix_format[] = {
 	{
@@ -750,6 +751,7 @@ static int sur40_probe(struct usb_interface *interface,
 	sur40->vdev.v4l2_dev = &sur40->v4l2;
 	sur40->vdev.lock = &sur40->lock;
 	sur40->vdev.queue = &sur40->queue;
+	sur40->vdev.release = sur40_video_release;
 	video_set_drvdata(&sur40->vdev, sur40);
 
 	/* initialize the control handler for 4 controls */
@@ -820,6 +822,16 @@ static int sur40_probe(struct usb_interface *interface,
 	return error;
 }
 
+static void  sur40_video_release(struct video_device *vdev)
+{
+	struct sur40_state *sur40 = container_of(
+						vdev, struct sur40_state, vdev);
+
+	v4l2_device_unregister(&sur40->v4l2);
+	kfree(sur40->bulk_in_buffer);
+	kfree(sur40);
+}
+
 /* Unregister device & clean up. */
 static void sur40_disconnect(struct usb_interface *interface)
 {
@@ -829,10 +841,6 @@ static void sur40_disconnect(struct usb_interface *interface)
 
 	v4l2_ctrl_handler_free(&sur40->hdl);
 	video_unregister_device(&sur40->vdev);
-	v4l2_device_unregister(&sur40->v4l2);
-
-	kfree(sur40->bulk_in_buffer);
-	kfree(sur40);
 
 	usb_set_intfdata(interface, NULL);
 	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);
-- 
2.43.0

