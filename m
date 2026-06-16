Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AFB3CEB89
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586771; cv=none; b=P8Hq5Ebr4Dh1bFs29KBMfLjKapI+E4aBnwUtqSNO3UB/QaI244jc7q4qJzqZ+jrV1EK+xpyt8vFYBDDP8eLDRPZWYdyMREsDW1vDuY3K/65gwECk+YKKYa/s7iXo3HyEJAavVrKRW+1vqsuU46WFj3nb/r0NpogPUDnM2Asd0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586771; c=relaxed/simple;
	bh=jRm5BKdrWbSx6QhorT2ZQ9qmT3GuxjxZKNXk1rRkeIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLbfz/Zr4zxTEf6HmJqtcs35SE1rLfIpMavMcItZF1hfxCeEu+AGFbqEIfTn2m9TgK4naE22xMeYVPBuxKK4jMUujwQLEHJcldosLy8D0IZ6zr9m0vsfk/wRlbYKoS8bfpju/tc880Bcscs4uMaTJhxUhyGJwgf0sNAR0kYlKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYbSRDn7; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYbSRDn7"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30b6dad2382so3641755eec.0
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 22:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586769; x=1782191569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a06GnFTgOZ8VawHWEGB4YwWHIzCduqDiZ9BtHLrmlk=;
        b=SYbSRDn7p18XwSc57xUoJivPTMTs23UorX5eoCd+3F40Rpm1Mn4YhzUtDmAzT7vvHb
         9wybNBIzJJYhV6vEJObGAqvHOXnya41pjHm09DEYpNDwZI6cTO3hdMq5ZdywzzhAJ7IT
         CRYF7tUln3jAzsu+t+pdO4xl2sOK/B4vJu+9qXPufnYj/smWnJGMjunEGHCUnZAfXpZY
         GXiDO51tMpDboqs9XBXU5aIe47rVmYaSKJ+zbpR3ANFGoPSdfRs/winGWhIH4eU0uYbF
         M8a4eBsS60tA9lhk0ket2fCJjAKN5j68YdEUfDcuMPDOQZI9QZ2If0Sig/ZNfZT9il6H
         SAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586769; x=1782191569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9a06GnFTgOZ8VawHWEGB4YwWHIzCduqDiZ9BtHLrmlk=;
        b=PYehS1zYACKQljjgHjSIw6MRaQh/NhvyiG5URYb4wbin1YFxv3fwO1gZukqpG49IR0
         n+l5aA5AePrLT2Ud6FcVI2WiTeKG3amBaC5aO1dQQd2p12rw5caltVxho90XJeYmHzvM
         8a+DlvF0HVU6thlwXRUsMUbuiHXg4lRMmZx5b0X97yCXggTPAzcRNNpNR/UyIopekPg7
         YXSikRGSsorf2eVb/SX1Avvz0XE0SkmcAp4Fmkqy5t7Zhj5GHRNzw1rpq+maj4sLN4qm
         6PUgS9hiYnWQPg+fsRvoEViXTLMbPXVvrjBWOQzAcIDKYJbBqbqNnCWEJqaONHS2fWcW
         /+ww==
X-Forwarded-Encrypted: i=1; AFNElJ+V/pQ/0VDdfsIbsj4tLmi/8Q1L5X+A3sFNo7Zc5hbkzfz80vQjBx7GIS8k5DFXKFVmyhPrlOYBenveiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8On3YKm6GyUQSo1gBH2VWEokses8mT5TzkyM9xmYJb4jkEyx
	JGVDkybZ7Zf7ZA7eDvPN+9WJqPQbh4g8lNrjKjEPBXJNipzggDjUVrxnXx37HQ==
X-Gm-Gg: Acq92OHLbcl+Zq9v6IFgEWS5bVjwD6E2t7yaySt1F1NTN9nNjOc3xHh4FkdoWHV1Tgd
	tiBiOwPsMYWsrslLOZAPWxbRNHdqrVU7ujRKa+0bkyIJXnO/udzVvnZaMYCovs1x66uJaAki9bh
	ehBlemzY6t5PJBOxC9mxaMcxJznkvxuAfxx53LOGpk9HolPUamUCbOI3XsGqK6Hzwmo5JwHpW3W
	rp1BQr9RnjueEceaqabEFGFB4GOuj3cl8W4P+6SgcKexq8NUjfVJE42w6CQqCh5s3uM/0HKmMU4
	tIc23WaUJaQ8RNFB/mvECzn/9XPtFWTWP53xU3z20AYKfSChzGpnqJxvdJ5wKcdhSCWojgtphdd
	9lQKKZPQTa2ae/YbGdI9fFtv4b1Tcf6d8fBcw0VOlImngHizVSH2BR04/lsvIfyRzYFATUWIqGz
	y+axAtMBtPZyf7bVfzzxnA46y4K8dokFkktayduDVxW9+tcC6cEILryQLUpdcUwXPssEmsOKWGd
	YaqS5N9lbr/kI8=
X-Received: by 2002:a05:7300:8b84:b0:304:e587:5063 with SMTP id 5a478bee46e88-3081ff7ca07mr9443416eec.12.1781586768879;
        Mon, 15 Jun 2026 22:12:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43b80sm16726052eec.21.2026.06.15.22.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:12:48 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/4] Input: sur40 - fix V4L2 video device lifetime
Date: Mon, 15 Jun 2026 22:12:32 -0700
Message-ID: <20260616051235.1549517-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
References: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sur40_disconnect() synchronously frees the sur40_state structure (kfree(sur40))
while userspace might still hold an open file descriptor to the V4L2 video
device node. When userspace later accesses or closes the lingering file
descriptor, the V4L2 core invokes file operations (such as vb2_fop_release)
that dereference the already freed sur40 memory, resulting in a use-after-free
vulnerability.

Fix this by implementing a V4L2 release callback (sur40_video_release) in
sur40_video_device to clean up V4L2 components and free the sur40 structure
only when the last video file descriptor is closed.

Additionally, update the sur40_probe() error path to call video_unregister_device()
and return inline if input initialization fails after video device registration
succeeded, allowing the V4L2 release callback to manage cleanup.

Also, call v4l2_device_disconnect() in sur40_disconnect() to safely dissociate
the V4L2 device from the parent USB device during unplug.

Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sur40.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 1ad68131e3a6..2f0efee23d1e 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -806,8 +806,10 @@ static int sur40_probe(struct usb_interface *interface,
 	}
 
 	error = sur40_init_input(sur40);
-	if (error)
-		goto err_unreg_video;
+	if (error) {
+		video_unregister_device(&sur40->vdev);
+		return error;
+	}
 
 	/* we can register the device now, as it is ready */
 	usb_set_intfdata(interface, sur40);
@@ -815,8 +817,6 @@ static int sur40_probe(struct usb_interface *interface,
 
 	return 0;
 
-err_unreg_video:
-	video_unregister_device(&sur40->vdev);
 err_free_ctrl:
 	v4l2_ctrl_handler_free(&sur40->hdl);
 err_unreg_v4l2:
@@ -835,13 +835,8 @@ static void sur40_disconnect(struct usb_interface *interface)
 	struct sur40_state *sur40 = usb_get_intfdata(interface);
 
 	input_unregister_device(sur40->input);
-
-	v4l2_ctrl_handler_free(&sur40->hdl);
 	video_unregister_device(&sur40->vdev);
-	v4l2_device_unregister(&sur40->v4l2);
-
-	kfree(sur40->bulk_in_buffer);
-	kfree(sur40);
+	v4l2_device_disconnect(&sur40->v4l2);
 
 	usb_set_intfdata(interface, NULL);
 	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);
@@ -1176,11 +1171,21 @@ static const struct v4l2_ioctl_ops sur40_video_ioctl_ops = {
 	.vidioc_streamoff	= vb2_ioctl_streamoff,
 };
 
+static void sur40_video_release(struct video_device *vdev)
+{
+	struct sur40_state *sur40 = video_get_drvdata(vdev);
+
+	v4l2_device_unregister(&sur40->v4l2);
+	v4l2_ctrl_handler_free(&sur40->hdl);
+	kfree(sur40->bulk_in_buffer);
+	kfree(sur40);
+}
+
 static const struct video_device sur40_video_device = {
 	.name = DRIVER_LONG,
 	.fops = &sur40_video_fops,
 	.ioctl_ops = &sur40_video_ioctl_ops,
-	.release = video_device_release_empty,
+	.release = sur40_video_release,
 	.device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_TOUCH |
 		       V4L2_CAP_READWRITE | V4L2_CAP_STREAMING,
 };
-- 
2.54.0.1136.gdb2ca164c4-goog

