Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620D39B498
	for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118986; cv=none; b=ZaK6STidbEmo8uYqRxCw4q6mBdPSNPzlN90a02FLtuE6edKUFq+o1mnjPP/hvTrazkkwgQ0bAfEsN/uuSt1Krkl8pQbJP5TPOo2zmhYVAhqJPv45Vw5dOEyhEKC3NsAyh6ba0RafXYlRCOf35dOBoHA+qSd3gGLhuwUhLxW7cmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118986; c=relaxed/simple;
	bh=hoAkRbklT4t3UJamP8PVTZTsu+egTx6heIK7H8dG1rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjHjwtOBpUloOxs93P8BYo8p7GLgvpqEZtPYpm+Ov2cIqXWThWAGFNnuckHH5AyRfv7zxt9RS1B7J8FdQ0gX2isN/jAf48nr2e31QeJDYCA/UNVmJygkeGf0i7cMjLJKuVjlGOfeODqbhfTx/BuF70MgrdUjzX6xYhCh83QFaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laFiiIZh; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laFiiIZh"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40946982a78so1635318fac.2
        for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776118984; x=1776723784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfX6HN3Cvr0FuWe5GVmxZakao4YGWPTUap0ZGvN56Rc=;
        b=laFiiIZhmJNM8ZQKlTeV5/5nm8thompfeXbR1L1mNWsJsfWuG/S6j9g7iKraqH8/iZ
         s0MaiERPP8q0do5kb4uGH7zP7Wj3wfCOn2bRBL09+WHgsGvMZBX4CJ9AYzqir60Iur2r
         /CcHLJAaMcvdCzPHfg1M2OGz5A1gaHGDiIJHoe2FsxTCqSm44H4Mw3v6khfaDCJJDt5b
         Pk8kIusLJ8jlKtN4xmllfBClSIKwsXUUrBl8uqbXSt8Dd8KQRckyqsQoZOfqabaFf7yz
         GHQokVj5k1CKDh0vvnZxzaAia4zNLbsOaJIGJeha7nBFIGOBxnu38DrVhhPM9GQtdtTM
         6NOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776118984; x=1776723784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AfX6HN3Cvr0FuWe5GVmxZakao4YGWPTUap0ZGvN56Rc=;
        b=Gdz5lsyd+IZWQi+NBMxHeQKUzGNz5ME0P6dGHdZ9TijUjdRrzW/z3ZkTFDWwEjCiyZ
         H0ZfgACEpxAF2XnvPeMSkMXooZZ/SuLce0l4i5G9xCX2NJ8ryQOSzok95khhnjUNxyor
         v4YmBEKzRU4CL7+h1c0o4uIA/HcrpGx7XkzZdxcnOLfNa4hsxPxk+Cxd6VBK8JdiuTWb
         J68Fyn48zjOWL+IrpJbRin5KUs7Mt4mWl1cOFAchos8IqjQoeBjUOBA/a/U3jmgymoPH
         4rr4LD+ZXzPkovH4wft5+JHkpTQ4ZsUXdznjI4Me886PvLI0hko+y2Y/Ui8A0tazR3AB
         NH7g==
X-Gm-Message-State: AOJu0YyqKhTEQkiAT+Bz9FwrOEh+uPhzSFyt5qpL1VvrguC5WyeclcdW
	6tGQmhYhtK/yyhFykteuloTy0lEb5legM9ruq+Evc7my4FBUmo+qz2hx
X-Gm-Gg: AeBDieuFyg4pEke7MWSlRe6h4VXOM5au7HQiPJDoRZXxaXpAIiWZo+Q1XMtXYMNWWg8
	ewhqQ5dARgqtViwyfbpiIj2BiYrNmuGD+0Vzy0cz+TJbQ3fSfR4AgWZqsPzWf5ZoPzvpcupcX29
	4YNecaWmBdG/wfHgOCJ8kVqg3zzN3YRS0tKYVR8b42zdCrC5Zrfj91uTGYyqYg+5F4+VBYwN4lJ
	YPa/csGVmCKj8tvG1bX+kpHhO5EC/grceIR7LD5SGCK6jny9Jab53DevLt+1A/jJZ+mWTil/RPd
	veZ8KuZt8hCBzvARsGzdz60GPWfRHQK0rS3b4ovK51VSXV8ASJQcdkkM1GyZ+8nAHBhrWzzEjCz
	c1/Ibykilr59ZBnQuYxy0gANg+39cFiMjmZ6glCGOOn/KbHNQDDajLxeg/IEVMIiXaa1simzz+I
	p5aHvslP0Je0fhTZmKPqw1sqhaOTqHo9A8ReyH
X-Received: by 2002:a05:6870:d364:b0:41c:3225:f98b with SMTP id 586e51a60fabf-423e0e89de0mr8390964fac.10.1776118984247;
        Mon, 13 Apr 2026 15:23:04 -0700 (PDT)
Received: from Dell.cheetah-searobin.ts.net ([2600:1702:56e9:4b40::33])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb80ccesm9403198fac.13.2026.04.13.15.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 15:23:03 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akash Sukhavasi <akash.sukhavasi@gmail.com>
Subject: [PATCH 1/2] Input: analog: Fix coding style - trailing statements on same line
Date: Mon, 13 Apr 2026 17:19:27 -0500
Message-ID: <20260413221928.21748-2-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413221928.21748-1-akash.sukhavasi@gmail.com>
References: <20260413221928.21748-1-akash.sukhavasi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checkpatch.pl script flags several errors where trailing
statements are placed on the same line as 'if', 'while', or 'for'
conditionals. This violates the kernel coding style and makes the
control flow harder to read.

Separate these single-line bodies onto their own dedicated lines to
conform with standard kernel formatting.

No functional change intended.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
 drivers/input/joystick/analog.c | 45 +++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index b6f7bce1c..6e1255a82 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -231,11 +231,13 @@ static int analog_button_read(struct analog_port *port, char saitek, char chf)
 
 	while ((~u & 0xf0) && (i < 16) && t) {
 		port->buttons |= 1 << analog_chf[(~u >> 4) & 0xf];
-		if (!saitek) return 0;
+		if (!saitek)
+			return 0;
 		udelay(ANALOG_SAITEK_DELAY);
 		t = strobe;
 		gameport_trigger(port->gameport);
-		while (((u = gameport_read(port->gameport)) & port->mask) && t) t--;
+		while (((u = gameport_read(port->gameport)) & port->mask) && t)
+			t--;
 		i++;
 	}
 
@@ -324,7 +326,8 @@ static void analog_calibrate_timer(struct analog_port *port)
 		local_irq_restore(flags);
 		udelay(i);
 		t = ktime_sub(t2, t1) - ktime_sub(t3, t2);
-		if (t < tx) tx = t;
+		if (t < tx)
+			tx = t;
 	}
 
         port->loop = tx / 50;
@@ -405,7 +408,8 @@ static int analog_init_device(struct analog_port *port, struct analog *analog, i
 				x = y;
 
 			if (analog->mask & ANALOG_SAITEK) {
-				if (i == 2) x = port->axes[i];
+				if (i == 2)
+					x = port->axes[i];
 				v = x - (x >> 2);
 				w = (x >> 4);
 			}
@@ -496,13 +500,25 @@ static int analog_init_masks(struct analog_port *port)
 
 	if (port->cooked) {
 
-		for (i = 0; i < 4; i++) max[i] = port->axes[i] << 1;
+		for (i = 0; i < 4; i++)
+			max[i] = port->axes[i] << 1;
+
+		if ((analog[0].mask & 0x7) == 0x7)
+			max[2] = (max[0] + max[1]) >> 1;
+
+		if ((analog[0].mask & 0xb) == 0xb)
+			max[3] = (max[0] + max[1]) >> 1;
+
+		if ((analog[0].mask & ANALOG_BTN_TL) &&
+		    !(analog[0].mask & ANALOG_BTN_TL2))
+			max[2] >>= 1;
+
+		if ((analog[0].mask & ANALOG_BTN_TR) &&
+		    !(analog[0].mask & ANALOG_BTN_TR2))
+			max[3] >>= 1;
 
-		if ((analog[0].mask & 0x7) == 0x7) max[2] = (max[0] + max[1]) >> 1;
-		if ((analog[0].mask & 0xb) == 0xb) max[3] = (max[0] + max[1]) >> 1;
-		if ((analog[0].mask & ANALOG_BTN_TL) && !(analog[0].mask & ANALOG_BTN_TL2)) max[2] >>= 1;
-		if ((analog[0].mask & ANALOG_BTN_TR) && !(analog[0].mask & ANALOG_BTN_TR2)) max[3] >>= 1;
-		if ((analog[0].mask & ANALOG_HAT_FCS)) max[3] >>= 1;
+		if ((analog[0].mask & ANALOG_HAT_FCS))
+			max[3] >>= 1;
 
 		gameport_calibrate(port->gameport, port->axes, max);
 	}
@@ -662,13 +678,16 @@ static void analog_parse_options(void)
 				analog_options[i] = analog_types[j].value;
 				break;
 			}
-		if (analog_types[j].name) continue;
+		if (analog_types[j].name)
+			continue;
 
 		analog_options[i] = simple_strtoul(js[i], &end, 0);
-		if (end != js[i]) continue;
+		if (end != js[i])
+			continue;
 
 		analog_options[i] = 0xff;
-		if (!strlen(js[i])) continue;
+		if (!strlen(js[i]))
+			continue;
 
 		printk(KERN_WARNING "analog.c: Bad config for port %d - \"%s\"\n", i, js[i]);
 	}
-- 
2.53.0

