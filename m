Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7F439917
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418832; cv=none; b=tvEo4YF96vi0Zf4w2j0uAyRWlhLBFPUT9DJO1YQcryKLRAW56FjGQSM6+UX+Am40wA7L/wXE6oGi/cCLG/USC7LiWoPny9U3LxABF8Wv2uUPit/cVQX21FechuGX/XE1vzU4PA4whU+vx7kX/xYujzM3FVcZJ6ZjWgEk50b3Wko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418832; c=relaxed/simple;
	bh=2ixlKtCsITzOcTeXqNephJUaZacWCXQceZOKel/dW9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT9e+x/ICE93sOIJjEJFMkJoXADGi8ZwH4ne/MVu2lgfIhx8r8ME9iWve6d6XifIhcMukA5yZNYJx73ls4q9Val1UeyavXcGcwkWN/iIP7bQGmHn6z/8AZ9BoOUQ80ruIj/DQYY2iqsSzICJa/31ysU902aZpWey7FU3b32exBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBuQcw9K; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBuQcw9K"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49557167508so18148785e9.1
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785418829; x=1786023629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bKfjt2cHDv3xaHdoiWiG6KJPWOg1YD5kHemO33DsuQ8=;
        b=PBuQcw9K2E31EvWcR8VF1VHUlbZoVIc6PDAD1dffIvwFIznmTy9PnR9889D3gD5+zT
         12XQ+Jgkx1ppqRykmtGmHSurj0I8FiHAO2SfZhqs249UWVTF6oDtZ90Z9V9+SIpCYFd8
         RuWowOBX32mZKJSnNTXj0b6OgpcJVFLSNwTMDlinmhGITzSbEBR24Bd0Er/rkClD/6kk
         mx8rYXarOgZHsGoAPT+87p6HlkjAK/mT8+rTsC8iqNNGc+pi3aJk+bs1o7twQFsvXBKL
         YE5xA7HBTx4isX0PXvVx+d7S4ZuA3K+ViWgltCebr1HZ3XbgzZwgy//16ezBaV5PcYDs
         wNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785418829; x=1786023629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bKfjt2cHDv3xaHdoiWiG6KJPWOg1YD5kHemO33DsuQ8=;
        b=ZlHPRtTM2HpmVdXZVsQ2X1mffogeDEQhdz9Sg2KC37bANkq32q6mBU2aOvXeJgGEt9
         OcSckCTgM+4O2sMLnfPo15dlM2xBmDXGr/CXiUSwdOiPwPk8uPaP6AOkk8xrSusfUbxz
         bWwbZNces561a7hZXSBlM+BQzCxIVOJaJdxOH1wBVOqgwmIlTicsCLhRQwKO8G/z0uh+
         e3Fj5T6FbDgpT8o2DykkwJjcXF4mGXzz7owu48OmH8fH1ltxb7wAMtVQwK4Isg0HPWoG
         CKTCdX2Ntd5jOgV/RrYrte/huZWc/1ZQ459Y2HHqJY6CfbF7DeOEnu75s5xNc8yrgTcm
         c0rg==
X-Gm-Message-State: AOJu0YzdyHVi7N85mxX1aJt+BjN6pBsVrf4dENvvcFi8Nl2jJLmmIE5P
	HY8yyB2Qm8k0h4Amgptnjofgmw92W+bP8/nO6SraquvDKMqt1SeG04E6
X-Gm-Gg: AR+sD12U5VtpeFd2d6sT+nMV5dzzWNW0MkdeXaK4PUtdnTdP6nEScslymlrp3NJDQt5
	GMT+wXVhdviozJc1E5CHLyRxps4YGWKfTLqOgK0ZdTVU+o4SWn30kkmwnYHjnfH5e9d4uVKbIav
	kdigbdHBTs/hia4U3hVZNBjlLgqv2zE7dXxSfjFkwdqBRmubije65J8aCEBRaULnDxAg5uHnZ8p
	V00S9TlmI+nu7TSsG4P4sWmRcMkDWfLUXtOdao+SdoBvqZzISNBSVuEA5vnrL0tx89oyenthpzo
	r6rpLyZp1p0ZGXyHQMegK6SGIJI7+GGlhS5dLfI8vA8lk2UubWzl1GRivc8CtPObe9A/ylb/+24
	GZNP/OvlWPdi3QCREfUI9GJTqeLNNAfCrxiIqMv3dZM18ENRboRirbgdMmuJp6wjXKTjX8Gqlfo
	YZ/sYLB7Mwji3FgvGkgmogO40lcKxJTKR1n+0aBq2hRgZaztcsCNiPQnzbllv0VpSs49EAHOyki
	N9DJIPIGMFKCimIc6EA
X-Received: by 2002:a05:600c:4487:b0:495:5858:e163 with SMTP id 5b1f17b1804b1-49800ec6d8fmr23565095e9.27.1785418828577;
        Thu, 30 Jul 2026 06:40:28 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498012168e7sm66405305e9.15.2026.07.30.06.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:40:28 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH v2 1/4] input: Add FF_TRIGGER_RUMBLE effect type
Date: Thu, 30 Jul 2026 15:40:01 +0200
Message-ID: <20260730134004.1118476-2-guillaume.casal.42@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
References: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
 <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
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
@@ -438,6 +438,20 @@
  * @repeat_count: number of times to retrigger effect
  * @retrigger_period: time before effect is retriggered (in ms)
  */
+/**
+ * struct ff_trigger_rumble_effect - parameters of a trigger rumble effect
+ * @left_magnitude: magnitude of the motor behind the left trigger
+ * @right_magnitude: magnitude of the motor behind the right trigger
+ *
+ * Some gamepads carry rumble motors behind their triggers, in addition to
+ * the ones in the grips that FF_RUMBLE drives. Xbox controllers call them
+ * impulse triggers.
+ */
+struct ff_trigger_rumble_effect {
+	__u16 left_magnitude;
+	__u16 right_magnitude;
+};
+
 struct ff_haptic_effect {
 	__u16 hid_usage;
 	__u16 vendor_id;
@@ -483,6 +497,7 @@
 		struct ff_periodic_effect periodic;
 		struct ff_condition_effect condition[2]; /* One for each axis */
 		struct ff_rumble_effect rumble;
+		struct ff_trigger_rumble_effect trigger_rumble;
 		struct ff_haptic_effect haptic;
 	} u;
 };
@@ -491,6 +506,7 @@
  * Force feedback effect types
  */
 
+#define FF_TRIGGER_RUMBLE	0x4e
 #define FF_HAPTIC		0x4f
 #define FF_RUMBLE	0x50
 #define FF_PERIODIC	0x51
@@ -501,7 +517,7 @@
 #define FF_INERTIA	0x56
 #define FF_RAMP		0x57
 
-#define FF_EFFECT_MIN	FF_HAPTIC
+#define FF_EFFECT_MIN	FF_TRIGGER_RUMBLE
 #define FF_EFFECT_MAX	FF_RAMP
 
 /*
