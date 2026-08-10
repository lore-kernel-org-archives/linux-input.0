Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ABA3EC813
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371238; cv=none; b=kW9IqNxj21/mZSO8Oaman7cW9hewk+fQmO0I4vI4bqsdHuwRCulaEkVaL6lW9zWVsHinttmLOtJ7SZK/ZsZI3Cfujz63jXsYNMy2ZyNkK7Hqiu55/N4VcSt023HqkWUjs3Pi5+qIAsrktXKvwS3x4OovaL4Sghxa1/M19Wn/FHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371238; c=relaxed/simple;
	bh=DQzaDEns8LZAtVpzmaN0D+0qSdxmupiha0OaVg8Etrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOoUqV5aPlq/WOjLS4eVNsAsgCAMv6QNdk3YK8jYXGAeu+lJKvL5av5DjikKQ3M022vkm4Ijbo0rtTDl2IsIhUZyGwfZtF8fis2VW0GefF4+Xd0NQTdh0TW8V1wCgBXpdN3if1x5gN2qb9Y9SvMCZEjkdWUjrWEHznjaCV7MJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=t+kgkDs6; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="t+kgkDs6"
Received: from mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:59a2:0:640:b7cc:0])
	by forward100a.mail.yandex.net (postfix) with ESMTPS id B377BC05AE;
	Mon, 10 Aug 2026 17:13:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net (smtp) with ESMTPSA id iDObfP0gA8c0-VY6GI8j4;
	Mon, 10 Aug 2026 17:13:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1786371224; bh=UdcwXBGqwkBiRoKwCCQmguZHysqyud5aW7AqkjdecN0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=t+kgkDs6M92/XJOb5XLrj1SIMWv9Sc1PvGFhjmFJ+Nh1eAjPzi+mmC1k/kk3JBXt9
	 pkTdXMykgiTA+nIasvT/A9v0gvY437vWQPueurmXYn5U9MFfP3lGaOhEGGLQBxmDkx
	 V8nC5otFCKS/1HAmBGOLkQeXAukuemZQ5Lqs6ykA=
Authentication-Results: mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+2a123f6269da57ffefaa@syzkaller.appspotmail.com
Subject: [PATCH] input: sur40: fix error recovery in sur40_probe()
Date: Mon, 10 Aug 2026 17:13:19 +0300
Message-ID: <20260810141319.118259-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since an input device which has passed 'input_register_device()' should
be released with 'input_unregister_device()', adjust 'sur40_probe()'
to do so and call 'input_free_device()' to handle device register error
only. To avoid V4L2 memory leak, ensure that 'v4l2_ctrl_handler_free()'
is called on all error handling paths, including the one after
'video_register_device()' failure.

Reported-by: syzbot+2a123f6269da57ffefaa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2a123f6269da57ffefaa
Fixes: 08b936012964 ("Input: sur40 - switch to using polled mode of input devices")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/input/touchscreen/sur40.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index fe63d53d56db..fe675b937b35 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -730,6 +730,8 @@ static int sur40_probe(struct usb_interface *interface,
 	if (error) {
 		dev_err(&interface->dev,
 			"Unable to register polled input device.");
+		input_free_device(input);
+		input = NULL;
 		goto err_free_buffer;
 	}
 
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
@@ -806,12 +807,15 @@ static int sur40_probe(struct usb_interface *interface,
 
 err_unreg_video:
 	video_unregister_device(&sur40->vdev);
+err_unreg_ctrl:
+	v4l2_ctrl_handler_free(&sur40->hdl);
 err_unreg_v4l2:
 	v4l2_device_unregister(&sur40->v4l2);
 err_free_buffer:
 	kfree(sur40->bulk_in_buffer);
 err_free_input:
-	input_free_device(input);
+	if (input)
+		input_unregister_device(input);
 err_free_dev:
 	kfree(sur40);
 
-- 
2.55.0

