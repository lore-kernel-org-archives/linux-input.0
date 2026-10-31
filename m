Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793482610;
	b=OKO+SqznTz/5aP7/gObJGEvqkbzoQSPkoXEaeOa+vzYS7GCP1I5+NoViJglmmRqV2Kt8
	 AHqEJ/Wdz4saMvxj0N9rGMf2vHpo4f+6Tvp1BpooNj/4gud27ro5KszUCr+bxCiz/OKZo
	 NjxRC6Jtpt3Y4qsNFSypEaaEg6MgZZvdAL/jliuZ6eIY7D36CYqT+S3D+vcJgqskcklbB
	 XeuWfIiyqHh3PIrUxSano9dgPY1T/R+F6V0MHJljvB33rKTnRY3tz8tmFCigANbj4B6f3
	 XIECniv9wrQqpe6NFUBeqavBgdcQC9vyu+Zpwi+l8R7P8T9zdaaMIchPxifrlAPwa8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793482610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=+DJfERSDYa5qSRqnsSIj/9fxpY7NzP5ypoF6//szyFw=;
	b=f/TlCVEqOcIgJaToK257JeZt86BLfo7sivCni4KDFw4fPoOflw/Oouh7iyRimPhw+fiZ
	 HXtzU4Inw0fFzGMuMCTYGCv0BwNxZo1tXx9PXIeA9X59SZffywM/MbosiGjOpISzvA+cL
	 R9Rrto5HaUhQb44AwL/QGh1MhkAVAfko8GkWv5OojOSEYjMaW8xDFyt1oOR2e/35eL2hR
	 j5kk94YVhXXsaijLrcOZdA/5ThMzaBa5BbueLZqSYjMjayk3HdLN13NxJ0ID5XS4yy29l
	 sPeEj6cqusWDD8p1QyL+atwN4em2WoWKKuop8lNUNWSabELXh1V74djpPZjQHDo92Hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="FtX/k3Qa";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB88C606A31A
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 21:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB88C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FtX/k3Qa
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-53ec9237600so1075268b6e.3
        for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 14:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793482608; cv=none;
        d=google.com; s=arc-20260327;
        b=De1It0ZDgHVowfnPV4K/PFrFbtFnSO9mX7momUuxDz4/aYT3GHXnlzdA8YS6MHshYI
         kArWVWRoNGhVrppigPmsizeV2FHyHZPOU/MqX59kvy+9zCqUWxDH79eY/OzGM/I8nq9R
         MeibNH6lPrWyz381EIVRjOeqXhnnIhbFUuMq3I6OAXLaHx4CNjeVoW+gkQhKWWfkRCoe
         JVmFnn9MeKR1qDUUU1kMUkxP6O8DtLGN4InbQF32jKFK1lWQspnjlvzsGOJxrjV5hNsS
         Ijwx8vHHWwEbyIpO93aianHrMGcfXPUOYhrsMtTVqg3hlIWz06UkyAGI+cbJrHV+AfAu
         VAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+DJfERSDYa5qSRqnsSIj/9fxpY7NzP5ypoF6//szyFw=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=dXm3Z/wsOsCD8YP0RxNWYw84FZjikJK18YXh+FQ9HU3rUPgcOiNL3t5bMRyf+1224L
         YW3Eni7u88MkE870djXOqMTIjZK5BSpaJwfLw+uEFhsSe36T81B8ASj/qGAenhhG13Ye
         gVQ/prnYUoEcv6nDgOhNY7IGxs3/wV7HXbylhhc6PK9RD+HTd0XzJdorRicefm2k4tpD
         NGOEPRtidg4xyMplJD8UANyp9jP9j1hAKX6LWA2tUyWh1Kr+VENuZuThjVoCMcVWoh0S
         1ijFuuA4I3YJ0xKExtt85oYBvwaolQnR1hr0X02j4bNQEsKLa6PuB+wmTBDgPRlXH9Oi
         RaNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793482608; x=1794087408; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+DJfERSDYa5qSRqnsSIj/9fxpY7NzP5ypoF6//szyFw=;
        b=FtX/k3QaIIwsef+bgBbhbg9qiAx9QSs2BM2vosC7h1SIxneGWamTS5l4TjkblxkI8L
         PXaKGMTa7N3V2FWOEvVX78RV0gobPffxPFbRRRe0/Mn4dWoupkPL3bGCHJkPPrk3YKwR
         5FtAlJHBRZaZdMFOUJTUH6Bv4eX4fn2edBvhz8GxFe8oa8R65UFw5lqE14ejKPrPyLl6
         2Ge4vzRdMXzuJ4eGzuIW9dXTrejqF2qw2/arz1+Eypa7z7RW2BGK3OkfCH9aSNozojFH
         0IQs6vsbLR6nog69n37x0qUMMrO78wOYFvBxs+765aC5QjSsLRP/W1571N1aJQD/mJrg
         BYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793482608; x=1794087408;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+DJfERSDYa5qSRqnsSIj/9fxpY7NzP5ypoF6//szyFw=;
        b=QxTcSt7Gna8z1YYBzKdOS2m0CKr5lknu2ekFRs14IMzgzKMih0ScpPn2rPyQ4JpdXu
         V7Y5BIoQy8XsPB8spr4XI17PDdiZsfdttYVHbdFvmX7Z6hhJZ7xW+BlN/x5W8RxiJmxx
         PxqTNE7RWxi6uKBIePmLIJQ/noOMXRzHA4LBW+kB/SSHr95njDQi/Jr00Od4Pa1iVbgS
         hFL/eB/vk2ywv/2aB9Y++JbZKCylspk7M1yHA3Z5poCcYlvuVcZkgM4r548OTMjs507z
         qU5HryRXXxnNN8jjU5H4YbZiwRtoZqXaLL5M4JrxAzJ2Ksea4IyQk6pjq0Ljq3RWGUzJ
         Fh4A==
X-Gm-Message-State: AFq9FYIr3A8vstCRNgyvcX3kOb8aWq/bEDA9ReofLsizsJYMpZjiTD+K
	UuwyM3n+C2pWwaVRRRA9KEHp7bGmVEYL4yPlgBt1Cidyr8aqAluPk7XRJGO10qzBpt9zQjnsAv4
	kYX6/MCqzaYvCfekav8nfqPByy8GAK2PFq2PA
X-Gm-Gg: AYBFou2gRT3VhsLILjWGsbcEsS48g+xO3HgOXjF8Hi7Uf8o8M6MV40zAY4i7XnPvYDw
	NpR8p3+IxUmdpJtRLrC6qJR0meyygRHtgT5exyF8QBDtJc4GxbhdEig2uv4cGykEGqkXfsJz4fl
	DA/wZNXwNzU/nYt6Wm22fY2jYpESEFejxfLqTfjDjolZj/Kt+2wayB38iv+PB+vu/ajyuUNjC+G
	WsmGFKqq6x0Sj5w+Tl/ihsslFvXiCFLjnZhcPpjcCWBb7O9QPZSMBO0gawiS05A1MoqqfSgQnms
	caOmxV/j2WUdwaZzDeoERG0EoGKg/LXiK1D/VZIk9kX228EpZEYWZEof2Zzl60brKrv5Ao/NjGa
	Nv2aDq0V5gIK6/NF5wJL2GPfRj9Z/wwyE
X-Received: by 2002:a05:6808:2209:b0:4dd:18c7:544d with SMTP id
 5614622812f47-5640df42463mr3985980b6e.31.1793482608646; Sat, 31 Oct 2026
 14:36:48 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?Q?Juan_Parrado_Garc=C3=ADa?= <jparrado.1817@gmail.com>
Date: Sat, 31 Oct 2026 22:36:37 +0100
X-Gm-Features: AclHuK8n-WxwDLeEM1gnyN6x4RI00YlqcL9SoRy0TqbHkLkSn96yQeo2HV8fmj8
Message-ID: <CAFkAFXpOOSEiGEMqGjJp2yTf82LSRkUykYg9Uit3Q0fO0R4Tfg@mail.gmail.com>
Subject: [PATCH] HID-DR.C: fix button count and report descriptor for PID 0x0011
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From bf8c43a670eb83e94c2e7b69b504126b6679fdd5 Mon Sep 17 00:00:00 2001
From: Juan Parrado <jparrado1817@gmail.com> Date: Sat, 31 Oct 2026
21:08:56 +0100
Subject: [PATCH] HID-DR.C: fix button count and report descriptor for
 PID 0x0011

Some variants of DragonRise Inc. gamepads (PID 0x0011) report 12 buttons
instead of the restricted 10 defined in the static fixup descriptor,
causing physical buttons mapped to bits 6 and 7 of byte 6 to be ignored
by the kernel.

Expand the button Report Count and Usage Maximum to 0x0C (12) and adjust
the trailing constant padding accordingly so all physical buttons
are correctly reported to input/evtest.

Signed-off-by: Juan Parrado <jparrado1817@gmail.com>
Assisted-by: Gemini
---
 drivers/hid/hid-dr.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
index a1e10ee8d..e30b7fd94 100644
--- a/drivers/hid/hid-dr.c
+++ b/drivers/hid/hid-dr.c
@@ -196,7 +196,13 @@ static inline int dr_input_configured(struct
hid_device *hid,
 /* Size of the original descriptor of the PID 0x0011 joystick */
 #define PID0011_RDESC_ORIG_SIZE 101

-/* Fixed report descriptor for PID 0x011 joystick */
+/* Fixed report descriptor for PID 0x011 joystick
+ * Addition:
+ * Some DragonRise PID 0x0011 variants (such as the Retro-bit Legacy16
+ * and similar controllers) feature 12 physical buttons instead of the
+ * restricted 10. Expand button report count and maximum usage to 12 (0x0C)
+ * and adjust trailing constant padding accordingly.
+ */
 static const __u8 pid0011_rdesc_fixed[] = {
  0x05, 0x01,         /*  Usage Page (Desktop),           */
  0x09, 0x04,         /*  Usage (Joystick),               */
@@ -215,12 +221,12 @@ static const __u8 pid0011_rdesc_fixed[] = {
  0x95, 0x04,         /*          Report Count (4),       */
  0x81, 0x01,         /*          Input (Constant),       */
  0x25, 0x01,         /*          Logical Maximum (1),    */
- 0x95, 0x0A,         /*          Report Count (10),      */
+ 0x95, 0x0C,         /*          Report Count (12),      */
  0x05, 0x09,         /*          Usage Page (Button),    */
  0x19, 0x01,         /*          Usage Minimum (01h),    */
- 0x29, 0x0A,         /*          Usage Maximum (0Ah),    */
+ 0x29, 0x0C,         /*          Usage Maximum (0Ch),    */
  0x81, 0x02,         /*          Input (Variable),       */
- 0x95, 0x0A,         /*          Report Count (10),      */
+ 0x95, 0x08,         /*          Report Count (8),       */
  0x81, 0x01,         /*          Input (Constant),       */
  0xC0,               /*      End Collection,             */
  0xC0                /*  End Collection                  */

--
2.56.0
