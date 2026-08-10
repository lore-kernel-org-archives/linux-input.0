Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D940861B
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376475; cv=none; b=deoORSpCnU0Uf66uCUJwkTX4lGUZ8/d6c0M3K+yGPS0MBYvacLj06qJ9Ds1apD1mj0jOKYmrQqnsPKBv8z6rWqXjF5sGkZN2gxiLMeZdvWzCoTGqNpCaIw51S1HrbRmjdUgUMQ+5pvzeeFIU3GBXO7SQI0/Ymkd/fbq/wdikFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376475; c=relaxed/simple;
	bh=sIvc+qRTlecbnLVSkFBTefhpTgM/1qJnmOAIuB4qWsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYkPTbGjRoeh0s6Nbwd923oq1RnZdkG3cztdA8ehDl/ZrKOD8UUV8bjz82dtdLHAOI+5thz90dSdQWNYjUxB5Bzc6cYub14+kqBYnLVXK9LUeIArmdl44ZR7DJQpCn43gwvqLlz2VaZhzJyV0SmsdmxKHjMe+iMAYjST7w2mg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Rt51/RnX; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Rt51/RnX"
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward204d.mail.yandex.net (postfix) with ESMTPS id 0F0CB84D8F
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 18:35:32 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:d788:0:640:6e4d:0])
	by forward103d.mail.yandex.net (postfix) with ESMTPS id 8DAABC0035;
	Mon, 10 Aug 2026 18:35:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (smtp) with ESMTPSA id NZPSd41hCW20-5Fhf6vgr;
	Mon, 10 Aug 2026 18:35:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1786376124; bh=UK+04lDi0xPlawA/G/3r78eCr6SeCh0SDDkft8Qcv4U=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Rt51/RnXmaouOzIDITDgfWyUriolSxsC2ZH4ISCrBF2g/9YxbD8nfF6lkNcdXsRFm
	 OV7tb0W2YH28OdQwrtCACgrwePx6NVyG1DL8REBkFicNyy2aOYT/DTjJ/UFuYBe591
	 NTnw2lBywK4d8xPEunfFjLqE/9U644xRLLvjFcug=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vasileios Almpanis <vasilisalmpanis@gmail.com>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+2a123f6269da57ffefaa@syzkaller.appspotmail.com
Subject: [PATCH v2] input: sur40: fix error recovery in sur40_probe()
Date: Mon, 10 Aug 2026 18:35:09 +0300
Message-ID: <20260810153509.124147-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178637340988.1434984.13114510500553043049.b4-review@b4>
References: <178637340988.1434984.13114510500553043049.b4-review@b4>
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
v2: setup sur40 input device pointer after 'input_register_device()' and
    adjust error handling path to ensure that 'input_unregister_device()'
    is always called for a registered device only (Vasileios)
---
 drivers/input/touchscreen/sur40.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index fe63d53d56db..35a946979cb0 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -713,7 +713,6 @@ static int sur40_probe(struct usb_interface *interface,
 
 	sur40->usbdev = usbdev;
 	sur40->dev = &interface->dev;
-	sur40->input = input;
 
 	/* use the bulk-in endpoint tested above */
 	sur40->bulk_in_size = usb_endpoint_maxp(endpoint);
@@ -733,6 +732,9 @@ static int sur40_probe(struct usb_interface *interface,
 		goto err_free_buffer;
 	}
 
+	/* now we have a completely initialized input device */
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
@@ -806,12 +807,17 @@ static int sur40_probe(struct usb_interface *interface,
 
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
+	if (sur40->input)
+		input_unregister_device(input);
+	else
+		input_free_device(input);
 err_free_dev:
 	kfree(sur40);
 
-- 
2.55.0

