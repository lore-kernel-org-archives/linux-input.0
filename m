Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8C3CE481
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586762; cv=none; b=Bha2GiZOj6Gnh4udZKgZLzmaewNAzkPeEkspGuk39eTD/QTL5xn9uKw1okCsQrttC8TofJGwa9H+P0JyxorKc+GD/hpkOrLveEO+BHSNoQOSdDetALt/cTuASdM2SxcoZW13s2NgmC0Svi3Iuroutjv7Q4harwgawyHiN0FuVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586762; c=relaxed/simple;
	bh=rANNsDQV7Y9xPKYr2MaoP+P4LqSIH4cyrTDkqqhOOEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrgT5n+4Y3iQpnx9Ao437Y6YJehV1fKTnIBGavrfCTPFi9prjkS/HmL7aD6Itef/h+4I0+1T8DfHddcOuEB07oeawVr91Pjac8lEPa3du0oBkOBOPiVue6UKv0QgXgRmvTosfce0qD1al6vs/xn5UyxrPNu/eiWlw8iL7bNa5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewWGhR8I; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewWGhR8I"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1384eb94d20so7531212c88.1
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 22:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586760; x=1782191560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=npOZ0JdHRj0qzq/T7JuKw3W720zNV5l12WuNHIU6TT8=;
        b=ewWGhR8IO6ksCF+h+x+YHNa/HOY5Uh5v4e9AKuqngPuvlCeI6hLmz0O1DpYfROYpdH
         MIEHs0MHij6VXq170sj4yRJSxpfkCPkoKRcDNLXohYQFYAaXik1I9yI45F+HS693P+nE
         p0ZMhHdlV3+QZpYo2N4Qs5V9pfHv9TQrYmmPzWF7fQ1j+/N2WGgi1wSCtrTJ0OOy9MiQ
         EHcw11XArAQTlUHS/D80dOPvyZHyMtDHFP2kiK1ecuw7kl/ndpP9RSoQU2mdBYSFS9Nz
         BBfruOcl/oDv1kvxN3L42BEs5wd4IyYQMujP3EiGMjQBvHtom+C4OSAbZOldTpc0SeLK
         HRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586760; x=1782191560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npOZ0JdHRj0qzq/T7JuKw3W720zNV5l12WuNHIU6TT8=;
        b=e3H/aSoQqUqC6WCzaPAJU6VfRFUbIcnfpQrymM4izVgTP855Nu1lrz/wca6BYUmf/7
         JAWusdjeSpAScihktC/p0zYOpoqOAPXW/oxtUUICwTb3Yjh6bIjoc4SPvJeaYecrCQek
         e7FGMZB8jKH3SVrIbd7gxu5b3y0ICo3CwlgYudg7+ekfeW597MVPSBSiLw9BbjAExkXN
         7Cirr+9/FRc4ncjAmGiy+1LIYS3JnkfHGqdpTbyx9yOD6m1DlxqgoB9pk7EY/zD6OhEm
         FiqVJDx+GuMRnJHmNhoZJ1w22838Yzp8B90qCJIFkEgYXrgbR6lZrjzjM2pQKmbvcWcW
         Q/SQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZJFqAps76CfvQgzDEFjIC1OWpRV+xueNBxVnP0ctCOIGGDmmVLIsgB0L1IF5+RmEufyuxKQgoCxB4Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpMl0j+bYU9qEWZJt5gvvqu+l3LN4Rerb/O3cSkxO+ghe8iJf3
	bRipCMv84klBdT7dgWJNYlAtshsoiyLCDPUNuyvFRP5d43zu8NEePEPy
X-Gm-Gg: Acq92OGwpgCIF1TcD/pOR2FNmqbzcbep7hzwranN43MuIdVnOICaZmS4mATRK/PSu4O
	ODLu0FBv7cqBHneV/UtmXYGvJCokLnrVWZt20Gpg2TpmmJDb6OqHO2JeUHTe80X5ffczkH/gXBx
	7IkJVVNPNjtvSXRJGDJGmAtj739rnswaO4Owh30Q/dRXHpeJSxxP4BgciPtyCkMsD1b6ILvFv+h
	kjUFmYWV/60r347UAP1QgnB73CObYJtkUJWmKC5wf00DICK4RTn0Spt4BfxmCKqnjooprLlGKbs
	i477RJO/xOHbwd+XtxAGr0HdWArCjOqkQe5gQ6Yhk6aK/vGnVwPll+7MxdZzRhhb7uzOf4KjKOy
	nYUKM4knq8iJoz4SVj4/kqjKdpALUqTotcLURkIR2mgm1q30UAKcdWE9PxBdUW7KP8hf8TyGRa5
	djN8+J+94Us1cYvMcTgVO+RT0V8THaYOqT30X1UhfXL0CuFMAoA+o58D/3jlm2MHmc0ZIZuaq6I
	qcSCbLJgon3fw0=
X-Received: by 2002:a05:7300:4304:b0:304:e58b:cccb with SMTP id 5a478bee46e88-3093816c7dbmr7715691eec.2.1781586759645;
        Mon, 15 Jun 2026 22:12:39 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43b80sm16726052eec.21.2026.06.15.22.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:12:37 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/4] Input: sur40 - fix input device registration ordering
Date: Mon, 15 Jun 2026 22:12:29 -0700
Message-ID: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sur40_probe(), input_register_device() was previously called early before
the V4L2 video device and vb2_queue components were fully initialized. If
userspace opened the input device immediately upon registration, sur40_open()
would trigger and start the sur40_poll() worker thread. This worker thread
invokes sur40_process_video() and accesses the uninitialized vb2_queue
structure, leading to a data race and potential system crash.

Furthermore, if V4L2 or video registration failed after input_register_device()
succeeded, the error path fell through to calling input_free_device() on a
successfully registered device instead of input_unregister_device(), corrupting
input core state.

Move input_register_device() to the very end of sur40_probe(). This ensures
the V4L2 and video queue structures are fully initialized before polling can
start, and naturally resolves the error path bug since input_free_device()
is now only called when input registration has not yet occurred.

To maintain strict LIFO (Last-In, First-Out) teardown ordering, also move
input_unregister_device() to the very beginning of sur40_disconnect(). This
guarantees that the input polling worker thread is stopped before V4L2
video components or control handlers are unregistered.

Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sur40.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index fe63d53d56db..8639ec3ad703 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -725,21 +725,13 @@ static int sur40_probe(struct usb_interface *interface,
 		goto err_free_input;
 	}
 
-	/* register the polled input device */
-	error = input_register_device(input);
-	if (error) {
-		dev_err(&interface->dev,
-			"Unable to register polled input device.");
-		goto err_free_buffer;
-	}
-
 	/* register the video master device */
 	snprintf(sur40->v4l2.name, sizeof(sur40->v4l2.name), "%s", DRIVER_LONG);
 	error = v4l2_device_register(sur40->dev, &sur40->v4l2);
 	if (error) {
 		dev_err(&interface->dev,
 			"Unable to register video master device.");
-		goto err_unreg_v4l2;
+		goto err_free_buffer;
 	}
 
 	/* initialize the lock and subdevice */
@@ -798,6 +790,14 @@ static int sur40_probe(struct usb_interface *interface,
 		goto err_unreg_video;
 	}
 
+	/* register the polled input device */
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&interface->dev,
+			"Unable to register polled input device.");
+		goto err_unreg_video;
+	}
+
 	/* we can register the device now, as it is ready */
 	usb_set_intfdata(interface, sur40);
 	dev_dbg(&interface->dev, "%s is now attached\n", DRIVER_DESC);
@@ -823,11 +823,12 @@ static void sur40_disconnect(struct usb_interface *interface)
 {
 	struct sur40_state *sur40 = usb_get_intfdata(interface);
 
+	input_unregister_device(sur40->input);
+
 	v4l2_ctrl_handler_free(&sur40->hdl);
 	video_unregister_device(&sur40->vdev);
 	v4l2_device_unregister(&sur40->v4l2);
 
-	input_unregister_device(sur40->input);
 	kfree(sur40->bulk_in_buffer);
 	kfree(sur40);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

