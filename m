Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE732D12ED
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415246; cv=none; b=dIo2FFpMnWotYeU2VmdInGY34i654vguf9Zlg0OEA/CPm2KTth/VeRHOqtYmTZVof0SC5bbodzoAijrkH6O4kP6MQMZdnGsBGbPLPmefxjGY4b1w0Mn/oXfXFDaNC3DKfN9fz/5zAA/jAoI3w8fTZSCmDFWoG2lKZUKN1kSyypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415246; c=relaxed/simple;
	bh=SdPwTQFii7j6XatnMh2nW+63fE6odgqTDELkj3rkM/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcrggx7GBClqpv/y44+9eTkIKzImYxTwlErYSpdm7BkBQJ25pqfLv/1UG6ieA3zF9QTe/RpeaZiE9XAy1aAswDQwO4MruAE32A/XrhdoHQaG/jrox9cVrHGpbCqmTyISq88ff31w4PTDYTzMlrD0z4YNjXZpeiM7rOzffwkKECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=GvFUef6z; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="GvFUef6z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1779414690; bh=SdPwTQFii7j6XatnMh2nW+63fE6odgqTDELkj3rkM/I=;
	h=From:To:Cc:Subject:Date:From;
	b=GvFUef6zuN9bRYhSdYLh0YfBXoMJiYUep/8LlphV/LWpzoA0SCQQK/6U+4CgokfIt
	 e3YkbSughw7l/F0Z/WLwUwD6FvTDABVTs73O34lYGalvjKupla4oOTCwQ1zSNX5t6n
	 SWN09DEQjnxBIfU/WVucHT9FUD9l75o/fgaHYOFvzBsC6pPFS26TGKT3Wjk6RiWYXu
	 m78wyXR8g5M1t89LOWIme+5tYUAvlZ480y9Qkgt2EAgwjWnxds9fwF5Z5kMBL+B4io
	 xzXPJiYJS+JiJIg5z7ktocvWyXQUOQqU8zWiOCBzKmY+oDUo9D1Ex2tcogUQt2UkFn
	 FmD3pJDhW6fcw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 7643AA022;
	Thu, 21 May 2026 18:51:30 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lyude Paul <thatslyude@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH 1/2] Input: userio - Update maintainer name
Date: Thu, 21 May 2026 18:50:39 -0700
Message-ID: <20260522015040.3953472-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

She's been committing under the name Lyude Paul for a while

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 Documentation/input/userio.rst | 2 +-
 MAINTAINERS                    | 2 +-
 drivers/input/serio/userio.c   | 4 ++--
 include/uapi/linux/userio.h    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/input/userio.rst b/Documentation/input/userio.rst
index f780c77931fe..415962152815 100644
--- a/Documentation/input/userio.rst
+++ b/Documentation/input/userio.rst
@@ -5,7 +5,7 @@ The userio Protocol
 ===================
 
 
-:Copyright: |copy| 2015 Stephen Chandler Paul <thatslyude@gmail.com>
+:Copyright: |copy| 2015 Lyude Paul <thatslyude@gmail.com>
 
 Sponsored by Red Hat
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 7cf5b55c5973..ceacb1c1d679 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28105,7 +28105,7 @@ F:	sound/drivers/pcmtest.c
 F:	tools/testing/selftests/alsa/test-pcmtest-driver.c
 
 VIRTUAL SERIO DEVICE DRIVER
-M:	Stephen Chandler Paul <thatslyude@gmail.com>
+M:	Lyude Paul <thatslyude@gmail.com>
 S:	Maintained
 F:	drivers/input/serio/userio.c
 F:	include/uapi/linux/userio.h
diff --git a/drivers/input/serio/userio.c b/drivers/input/serio/userio.c
index 91cb7a177b2d..abca8cb6aca5 100644
--- a/drivers/input/serio/userio.c
+++ b/drivers/input/serio/userio.c
@@ -1,7 +1,7 @@
 /*
  * userio kernel serio device emulation module
  * Copyright (C) 2015 Red Hat
- * Copyright (C) 2015 Stephen Chandler Paul <thatslyude@gmail.com>
+ * Copyright (C) 2015 Lyude Paul <thatslyude@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU Lesser General Public License as published by
@@ -278,6 +278,6 @@ module_driver(userio_misc, misc_register, misc_deregister);
 MODULE_ALIAS_MISCDEV(USERIO_MINOR);
 MODULE_ALIAS("devname:" USERIO_NAME);
 
-MODULE_AUTHOR("Stephen Chandler Paul <thatslyude@gmail.com>");
+MODULE_AUTHOR("Lyude Paul <thatslyude@gmail.com>");
 MODULE_DESCRIPTION("Virtual Serio Device Support");
 MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/userio.h b/include/uapi/linux/userio.h
index 74c9951d2cd0..98fe7e9089c4 100644
--- a/include/uapi/linux/userio.h
+++ b/include/uapi/linux/userio.h
@@ -2,7 +2,7 @@
 /*
  * userio: virtual serio device support
  * Copyright (C) 2015 Red Hat
- * Copyright (C) 2015 Lyude (Stephen Chandler Paul) <cpaul@redhat.com>
+ * Copyright (C) 2015 Lyude Paul <thatslyude@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU Lesser General Public License as published by the
-- 
2.54.0

