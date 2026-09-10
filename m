Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEA64A64F4
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053074; cv=none; b=sPSUsH/ipnkf5BJ+ZILhNKwoeDGHFxY4aa1HCVMeoqHmcrZfKwuyiVfZPyJEZLkMLn2y9qCaquesAS/wKzFFuZmIdA7h/awxsXNmFtNjl7ZJfptb3P/+dlaXlHRdQncJqBPQBw5vThPJY2IM56yDejolbMqiFz5I/UqO6z6S2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053074; c=relaxed/simple;
	bh=Pix0x7ZA+vLQwBfkt3zx1HIIBxzWAfp+J7S35JuyRFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLU9tlFtDuxBrFkyK0O2fJFEZSoweNf2vs/XVtr6L+/cN8uTGXHtKub23r3aL4Np1pe5Lvl8yPvkAqcQWqXXWLfxWvGQLLoPxOWFrSoXXXNbw5qSSwe/jg3Egusvo/zpCVNiIYqR1ik5wQFSgeWCLKwNwgkJYsIgq8oqwg7YnoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enneoEoM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enneoEoM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4957eefd361so56654675e9.1
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 08:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789053064; x=1789657864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J9LDATQNDM7sK4CtXsRLQsYMPm6MmFZyIYEO/4FzPzE=;
        b=enneoEoM/ynB6cNTGNTpmswZReM3TfImTw56Mh7kMfc5q7F453Fz6UMJdjO+hQvjAH
         DpjI78LpBiiEQHXKgvz/sONBU1uIAfKfVZ5WQw0QXJcUOSGRA91ReeOXwAmwrbvtWHUS
         Zi9Cxl+X9lmgNZeTFxvfeOxzlyTNGIAI1/hT0GnbGCeXqvuPhv/MuewWhbnv5TrzvMq1
         8gtGKJYEdz1XUScOEwPrP/YEGLjCoecIOL5Yf/EFFU+dbdCXvnx+oTTwObCAGG5n2vce
         q/glHskX2ptgBZAgZqxCtwz5XBuIlmHIHcqAJM2agXxspHU0TuaqHoLjr2w2xt/ao42j
         PsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789053064; x=1789657864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J9LDATQNDM7sK4CtXsRLQsYMPm6MmFZyIYEO/4FzPzE=;
        b=Xvxaw8Z5JmVstve2WsG0PVFNl27zWWnNHu8lau29dE4QJkURnngrb1GzMBISHIHic9
         alhNEThUDek44ERbUv4ddZId2ClnutHtLGEKNAEwgBRrTV1naqHlNqhfjtNyvPbkoLy4
         h/mvynJPrhlOc3SCf+aCSR79y7dyFtMh5ezJ/t6klrKBdovBsUdALKl/RGCWSlij/Ghc
         2xLcTaor8fVvMvnjVOQBW8tO3qeabbOc/3VJ20JG1Khtza57sdXZHcTqwMTzvQIIf9ca
         IMISvRhgMRjelK9ezYJV4ldrhTpfOq6kH8DIyCir7o1TTN8chUvZtaMltlZ5qYcQUSHq
         xitg==
X-Gm-Message-State: AFuF++lLynRgexZWzPQZTu4uQ3Zc714A3slxLtbfbIJRZ2PM1Ss0eFeI
	yNdYN+MWTTIoWNJnA7bl0nmZBO4oWFTlxzvVbBnrhuf64GdMSfK90nhn
X-Gm-Gg: AYBFou3tEaGLs5Qgr0YNWIT4ybwTHPFHt+Jyz1/Yplg79dqYRGEWjBHf2Bvs+q/iUTw
	5Mcq77pFQyAqoTJ5doBD6qcwo3KHAfMklOXzh3fcy+v0Io/jYIMDH6gmbeWW+mGNBd3NUxknKkd
	sk0NipcG66YsoDumg6tmMcrMw7x0GV6o/vA5j9Srwn+xS2QrVEUpQGMwrsOqPsnDRVPExsd91Vr
	R84xToPVg3r9ZbGJ4ACJ8UgUjhOcH5a8+uYU01/atnHWAcnlh5V8e3rXDZeMCYT6JqHkCSKbIp5
	x/NtJHzT04XSIauAO134CFifz+XjOu0Wamd5lc9KXj1U52eAsDljWQ4bTibJW149XmoEwaKavEb
	RZ8MjJLgnqYByW4ShLve3uPPz1CZkwURXwAkRrGwRN4VToK/49PEVH4PbErPCYkgBXcy/qeIazU
	TnHUQWJNxiEnjwexDg9lhjTt12xUHjlkBbbrwa4oPg7U/NuT7iE8iudP2OZc5q8FTV56nhS7EK8
	Cvx3jUDALRr92whsWFpVOIV+H7Y8e/BEIN9JIw=
X-Received: by 2002:a05:600c:c3cc:10b0:49d:1d6a:4cfb with SMTP id 5b1f17b1804b1-49d1d6a4d7emr116017625e9.1.1789053064225;
        Thu, 10 Sep 2026 08:11:04 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-70-91.net.vodafone.it. [31.26.70.91])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49d1fd532dcsm123568545e9.1.2026.09.10.08.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:11:03 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Bernhard Seibold <mail@bernhard-seibold.de>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] HID: lenovo: stop the hardware before the per-model teardown
Date: Thu, 10 Sep 2026 17:10:50 +0200
Message-ID: <20260910151051.12975-2-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910151051.12975-1-okerixx@gmail.com>
References: <20260910151051.12975-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lenovo_remove() runs the per-model teardown first and calls hid_hw_stop()
last.  For the ThinkPad 10 Ultrabook Keyboard and the X1/X12/X13 Tablet
keyboards that teardown ends in cancel_work_sync(&data->fn_lock_sync_work),
but the hardware is still delivering events at that point, and
lenovo_event_tp10ubkbd() re-queues that work on every Fn-Esc press.  A
press landing after the cancel leaves the work pending when remove()
returns; devres then frees the drvdata and the work runs on freed memory.

Stop the hardware first so no event can arrive once the teardown starts.
The LED-off writes issued by led_classdev_unregister() after the stop are
harmless: usbhid sets HID_DISCONNECTED in usbhid_stop() and
__usbhid_submit_report() drops the request on it, and the raw_request path
used by the tablet keyboards is a plain synchronous control transfer.

Fixes: bc04b37ea0ec ("HID: lenovo: Add ThinkPad 10 Ultrabook Keyboard support")
Link: https://lore.kernel.org/all/20260910064345.9BF1E1F000FF@smtp.kernel.org/
Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 617bba6..ff7c5ef 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -1498,6 +1498,8 @@ static void lenovo_remove_tp10ubkbd(struct hid_device *hdev)
 
 static void lenovo_remove(struct hid_device *hdev)
 {
+	hid_hw_stop(hdev);
+
 	switch (hdev->product) {
 	case USB_DEVICE_ID_LENOVO_TPKBD:
 		lenovo_remove_tpkbd(hdev);
@@ -1518,8 +1520,6 @@ static void lenovo_remove(struct hid_device *hdev)
 		lenovo_remove_tp10ubkbd(hdev);
 		break;
 	}
-
-	hid_hw_stop(hdev);
 }
 
 static int lenovo_input_configured(struct hid_device *hdev,
-- 
2.55.0

