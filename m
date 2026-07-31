Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DDC332637
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476548; cv=none; b=tMhK7aiqyX728b2dtP8QVg+2w3Ru/q7mxzKKrhM5IxLslYT3PdJPl/Q7jhGu829oSsnBtt5MYzaekoO+jmGU/0ELEcjYxl+3QwQ87V5QD2D4+soPbg2zwVkYCpwXaZEdajAUkf68QKOJFV+WBgNej7/9Nak3or0FtJGn3uf/FwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476548; c=relaxed/simple;
	bh=HL7q5zTLUMwMbIHiiJUYnijU/84M/zm0u4bGEcYkRo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1xODfZMCAej2gBKfpt0MKuPJHCfDsMo2FTBOtvGV+2iuv4u7SL1q6q6ktl6PD4F30oJZc4e2+x4b3YAW2Kta/VMUAvb1eBPkqYTbhETNQfqU4t3AgzAIuIsG8M3L9LYgHqZi0KOKU/uQGQE3WXWGQsnrqSInevGXiiVTjBLXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9SiNvih; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9SiNvih"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f9ab7ee38so298431f8f.2
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 22:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785476545; x=1786081345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Foj1K9Ubp68YMleene5c/TgrPIeWOgq/EfFOV7pa8SE=;
        b=g9SiNvih55CX/SqilkVxLe4eDS4KFBj367Q8cmVSDroWtKBQMCxNr1oyfuXbTBU6NN
         WQa29tqpyIyIUmQqPXKwJZHRRta8Zix81ssM8OFTAylqHyrHlH8mZsIyTXTQfb5ooWtD
         9Tx/g7bFiH0d3oAdCSQsqKZxUoN/fx4+R8xhyLCVlSknVdzT8MONnei9CsuSWoy3cNyI
         4q8zBeWTXMNlfhR/3egEKeaYESqnplLC8taENTACL9KW++NpIXVtzr3CWWkZo8VDOENl
         4g46/Xndqcyw4tuUJi5wShj/ZthgIH8VjvcOGeEXBKuViI9/xfaqn8yfuaXBhctAPJcd
         s+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476545; x=1786081345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Foj1K9Ubp68YMleene5c/TgrPIeWOgq/EfFOV7pa8SE=;
        b=Q7JYvv2wQukjwPlkgLUP4Kh4LSYokYrOIDNzUNq2KvnbO7NSYgub//GO4Z0ZmEk4ZE
         LMxblkw4mujCsQ8zU7qlLbUmv9OBbpheCL81p3lvf5UjVKVeeJDGDrn3h9GVue+sE1OA
         IiCzKTuVReqkZqu3xifwjmbyxW8wZrnP8vCJy/6zqOucSrGdM0ZYGSbytiTa38SaIyTA
         09k2VYc1xueMMIt59Ckr4aOF5Ln/Yn+4oxTYC19PDJqvYGs0VXN53Dd2V8ohgJ0nS0D4
         +n/olS03fXL1C1l2nVQyrntJqJyJoZPPRNeI2LPDW4pVzRHRI2q7QoVKca9vcBggo2Co
         Qv0A==
X-Gm-Message-State: AOJu0YzNFf1iPmPkNljTCV8ISFnTKg48pth5baQ7ds2GLCiOT2NhGOZz
	uVaJMEYyYLjYW+ZAyGGGwVzyv9NyJ/4Da/P96z0tif1Nzlz+oK/EE/pg
X-Gm-Gg: AR+sD11ezaWz2I+lZKWEjy3s+a0HvJj0KzwBVZvQFtzqw1ilNp/GhLnhzpmFGHdvJvr
	jZjxWVD7kePfs9ClbiUtuH6jhxLiGTD3+KMvw4hUV9q7Ojhgzn2F4JrxIpGIjwef2LwXyLZSSkl
	hkuTg0LknFO2Ry3dLp/tWJMYpnuF5lVPeHMEKR3YyMZGa3cnd/wfBvo5q4AWhIwjqsovob0Zg+d
	nYEErSagoFWBERFULiWFuOuzvEBimHckQdfIFqSNXgWCuboPtgQnq094M4ZOAcgvx37MHGCkb8F
	VSgF+t1Jih9c+85S4mmuEVjuqwLvjkKBzxa9//NaASL5jpwHqNg8DPW2hvM3tbssIWqEMzzIekk
	TwFhVHbSJpUJmzCYxNnPvjD/gTFsffo47zk6JbfjdFVGO5If6bxmVgAAJVTTcmiROXCdYod/MzG
	nW6AkKuvhCtOkq7sgCLd/EZneeAAW9qfiJhAdhp5p7TmTKW2T5yBti0ZA1TiNmvFTDPUxb8PZ7I
	XmWHXxSvxNgODaSqQga
X-Received: by 2002:a05:6000:22c7:b0:47d:ea8a:d224 with SMTP id ffacd0b85a97d-47fd2ad2a58mr1628994f8f.23.1785476545375;
        Thu, 30 Jul 2026 22:42:25 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0ae0sm412873f8f.33.2026.07.30.22.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 22:42:23 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH v3 1/4] input: Add FF_TRIGGER_RUMBLE effect type
Date: Fri, 31 Jul 2026 07:41:56 +0200
Message-ID: <20260731054159.1982164-2-guillaume.casal.42@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731054159.1982164-1-guillaume.casal.42@gmail.com>
References: <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
 <20260731054159.1982164-1-guillaume.casal.42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some gamepads carry rumble motors behind their triggers, in addition to
the ones in the grips that FF_RUMBLE drives: Xbox controllers call them
impulse triggers, and handhelds such as the ASUS ROG Xbox Ally X have
them too. The force feedback API cannot reach those motors.

Add FF_TRIGGER_RUMBLE as a new effect type carrying its own
struct ff_trigger_rumble_effect, and move FF_EFFECT_MIN down to it, in
the same way FF_HAPTIC was added.

v1 took the approach of the 2022 series and added two members to
struct ff_rumble_effect instead:

  https://lore.kernel.org/linux-input/20260730095317.767418-1-guillaume.casal.42@gmail.com/

That is not safe. EVIOCSFF copies the whole struct ff_effect from
userspace, and an application that leaves the tail of the union
uninitialised, which is common when only strong_magnitude and
weak_magnitude are set, would have had that stack content interpreted as
trigger magnitudes. Working programs would start buzzing their triggers
at random. Keeping the size of the union unchanged makes the ABI
compatible in layout, not in meaning.

A distinct effect type has no such problem: no existing application ever
emits it, so no uninitialised byte can be mistaken for a magnitude. It
also removes the need for a separate capability bit, since userspace
discovers the type in the EVIOCGBIT(EV_FF) bitmap exactly as it does for
FF_RUMBLE.

Based on an earlier attempt by Daniel Bomar:

  https://lore.kernel.org/lkml/20220410220449.5071-1-dbdaniel42@gmail.com/

Signed-off-by: Guillaume Casal <guillaume.casal.42@gmail.com>
---
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -448,9 +448,27 @@
 };
 
 /**
+ * struct ff_trigger_rumble_effect - parameters of a trigger rumble effect
+ * @left_magnitude: magnitude of the motor behind the left trigger
+ * @right_magnitude: magnitude of the motor behind the right trigger
+ *
+ * Some gamepads carry rumble motors behind their triggers, in addition to
+ * the ones in the grips that FF_RUMBLE drives. Xbox controllers call them
+ * impulse triggers.
+ *
+ * Magnitudes span 0 to 0xffff, as for struct ff_rumble_effect. The effect
+ * has no direction: each magnitude addresses one fixed actuator.
+ */
+struct ff_trigger_rumble_effect {
+	__u16 left_magnitude;
+	__u16 right_magnitude;
+};
+
+/**
  * struct ff_effect - defines force feedback effect
  * @type: type of the effect (FF_CONSTANT, FF_PERIODIC, FF_RAMP, FF_SPRING,
- *	FF_FRICTION, FF_DAMPER, FF_RUMBLE, FF_INERTIA, or FF_CUSTOM)
+ *	FF_FRICTION, FF_DAMPER, FF_RUMBLE, FF_TRIGGER_RUMBLE, FF_INERTIA, or
+ *	FF_CUSTOM)
  * @id: an unique id assigned to an effect
  * @direction: direction of the effect
  * @trigger: trigger conditions (struct ff_trigger)
@@ -483,6 +501,7 @@
 		struct ff_periodic_effect periodic;
 		struct ff_condition_effect condition[2]; /* One for each axis */
 		struct ff_rumble_effect rumble;
+		struct ff_trigger_rumble_effect trigger_rumble;
 		struct ff_haptic_effect haptic;
 	} u;
 };
@@ -491,6 +510,7 @@
  * Force feedback effect types
  */
 
+#define FF_TRIGGER_RUMBLE	0x4e
 #define FF_HAPTIC		0x4f
 #define FF_RUMBLE	0x50
 #define FF_PERIODIC	0x51
@@ -501,7 +521,7 @@
 #define FF_INERTIA	0x56
 #define FF_RAMP		0x57
 
-#define FF_EFFECT_MIN	FF_HAPTIC
+#define FF_EFFECT_MIN	FF_TRIGGER_RUMBLE
 #define FF_EFFECT_MAX	FF_RAMP
 
 /*
