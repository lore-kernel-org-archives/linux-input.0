Received: from forward204a.mail.yandex.net (forward204a.mail.yandex.net [178.154.239.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668D3B47DF
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431109; cv=none; b=JjKfmsxUEuo/izMlrZFWEljwolOgxcxeBVrOd7DMWUHVLAl0eZv01IkM01Yzlg0zNBCEcrd5fNn85LVJhPPweXZvJn90+QiUBVNvrIwbOodpqbDrwqGSbGENCq5DL/imjMIiYKyMehJTvCT8gRm7XdHU4JrZ4OZhsURlPxUgIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431109; c=relaxed/simple;
	bh=wdHZqAEzFn0T0noQsYOfAvtIQsp/ASVtCNDjomPjN40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHfLzpli8zXiDbtcXvcG91aXuYDVD+ELLY2iUc9lUiYzttYruq/am/r9PlWhRZyQHM9RHY1vjK6/PyM/FraefUu0Am7oTRLSK0RpMGOd0uEXGJMnIYqyUShc/O7lLOuDiDc6dWShXl2z+sYayVdha4hKVCy3KZUTLEDupfUmkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=wBa0dJD6; arc=none smtp.client-ip=178.154.239.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="wBa0dJD6"
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward204a.mail.yandex.net (postfix) with ESMTPS id DE6D481FD8
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 09:44:16 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8c92:0:640:e75e:0])
	by forward103a.mail.yandex.net (postfix) with ESMTPS id 4E3638077B;
	Tue, 11 Aug 2026 09:44:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id 6iHIfZ5fXqM0-vK0RrYlw;
	Tue, 11 Aug 2026 09:44:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1786430648; bh=JOB0Gct27bnpcqzXKjT56YtpLZ3eR7/sTP3nzxqHITg=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=wBa0dJD6Y6xVq1XfLVa/F6qSUw0666nPyPCsO6nv8+Mm9PC0HleuH8lSEiLeoxC3w
	 yoWgpKFCXs7sR7LsUSdT48oiamYC7wJvVIseXAWsCDcjceJKhoX6J9D6iUKubIZAM8
	 XOImJlvolfQBg+gV/Yt24Q2gkEEJ5AZjnLa4CYac=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vasileios Almpanis <vasilisalmpanis@gmail.com>,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+2a123f6269da57ffefaa@syzkaller.appspotmail.com
Subject: [PATCH v3] Input: sur40: fix error recovery in sur40_probe()
Date: Tue, 11 Aug 2026 09:44:04 +0300
Message-ID: <20260811064404.142265-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810155707.2C5751F00A3D@smtp.kernel.org>
References: <20260810155707.2C5751F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since an input device which has passed 'input_register_device()'
should be released with 'input_unregister_device()', adjust
'sur40_probe()' to do so and call 'input_free_device()' to handle
device register error only. To avoid V4L2 memory leak, ensure that
'v4l2_ctrl_handler_free()' is called on all error handling paths,
including the one after 'video_register_device()' failure. Finally,
since 'sur40_poll()' which reads 'bulk_in_buffer' may become active
immediately after 'input_register_device()' has succeeded, ensure
that this buffer is freed after 'input_unregister_device()', just
like it's done in 'sur40_disconnect()'.

Reported-by: syzbot+2a123f6269da57ffefaa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2a123f6269da57ffefaa
Fixes: 08b936012964 ("Input: sur40 - switch to using polled mode of input devices")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: free 'bulk_in_buffer' after an input device has passed
    'input_unregister_device()' (Sashiko)
v2: setup sur40 input device pointer after 'input_register_device()' and
    adjust error handling path to ensure that 'input_unregister_device()'
    is always called for a registered device only (Vasileios)
---
 drivers/input/touchscreen/sur40.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index fe63d53d56db..f7d6d89a028b 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -713,7 +713,6 @@ static int sur40_probe(struct usb_interface *interface,
 
 	sur40->usbdev = usbdev;
 	sur40->dev = &interface->dev;
-	sur40->input = input;
 
 	/* use the bulk-in endpoint tested above */
 	sur40->bulk_in_size = usb_endpoint_maxp(endpoint);
@@ -730,9 +729,12 @@ static int sur40_probe(struct usb_interface *interface,
 	if (error) {
 		dev_err(&interface->dev,
 			"Unable to register polled input device.");
-		goto err_free_buffer;
+		goto err_free_input;
 	}
 
+	/* announce an input device as completely initialized */
+	sur40->input = input;
+
 	/* register the video master device */
 	snprintf(sur40->v4l2.name, sizeof(sur40->v4l2.name), "%s", DRIVER_LONG);
 	error = v4l2_device_register(sur40->dev, &sur40->v4l2);
@@ -786,9 +788,8 @@ static int sur40_probe(struct usb_interface *interface,
 	if (sur40->hdl.error) {
 		dev_err(&interface->dev,
 			"Unable to register video controls.");
-		v4l2_ctrl_handler_free(&sur40->hdl);
 		error = sur40->hdl.error;
-		goto err_unreg_v4l2;
+		goto err_unreg_ctrl;
 	}
 
 	error = video_register_device(&sur40->vdev, VFL_TYPE_TOUCH, -1);
@@ -806,12 +807,19 @@ static int sur40_probe(struct usb_interface *interface,
 
 err_unreg_video:
 	video_unregister_device(&sur40->vdev);
+err_unreg_ctrl:
+	v4l2_ctrl_handler_free(&sur40->hdl);
 err_unreg_v4l2:
 	v4l2_device_unregister(&sur40->v4l2);
-err_free_buffer:
-	kfree(sur40->bulk_in_buffer);
 err_free_input:
-	input_free_device(input);
+	if (sur40->input)
+		/* device was successfully registered */
+		input_unregister_device(input);
+	else
+		/* device just needs to be freed */
+		input_free_device(input);
+	/* this should be done after unregistering an input device */
+	kfree(sur40->bulk_in_buffer);
 err_free_dev:
 	kfree(sur40);
 
-- 
2.55.0

