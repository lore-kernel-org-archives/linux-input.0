Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047FC37701A
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 02:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792292217; cv=none; b=LPWyyKMlHtSzTmbNL3W0n78VLoP+WQoK08w9e8FlBLKX84I2uhD6MRSI/R8g+8pYwYcyY8geFvoc3T6aKqHLWfMYlTTbbr4J3ktaJL4+vsTda8R98Txdw/pszAJut1ehllXsVnFe/7e9Na5QWfwktfJac4rsn7oD81/+TCi8i48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792292217; c=relaxed/simple;
	bh=UbdV8dkOdR9vPuOfO9gFCEr2A0/7OA8pXSL2w/2FWYc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nW1C6CG8xbIEcSZpdlFzl3aIKMrB8OlYswD+JvJGrKJB6Zy7CDqCrNmKKHpEjYR1ldbDNe6eboXeiWTWhMLLVODPJTn6+V0rpYfRJdQ3kltMkbdNCNTGep0dE97+HpTBHxjXxe0plXnFwZUUIRGc6wJFWw1wKQ/JEBuN/HrR0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwc4TSOg; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwc4TSOg"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93efc0452b5so69307185a.0
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792292213; x=1792897013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Rs959E2LcbDEDwb+XDadmIuU6nNMzUxfauxEwFd3lE=;
        b=Wwc4TSOgVHs49rPWe999nXYaetiLXAx1UGMiw4WcKBmsmrISz91kEZbN63A/9RfaW3
         5IlrtMdsmJ35Y84nXBrVeQWw3lSTTnxULKM+PWx4v1jemIDGQCW6QAFkiIWc6S6k+2Kc
         Zq97FN3RJuGvEcup/ey3H8WYtJdna23UEWMGqTafSNhx2ASCi7R0pmJ1IGiB1QXUwuPj
         Tr9s/QNduCFjU8VOJokqN7xsPTE4NB0JqjQm8z2NXJjBkPWx0OzQ9hwAf6kIWIn8s32s
         Y3znqdRdO6/9YDsbTVFTW0hzkDhrGoNaeUvDKptHqgMLIvD2QDolSez6aurn4BjpDZAG
         aUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792292213; x=1792897013;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Rs959E2LcbDEDwb+XDadmIuU6nNMzUxfauxEwFd3lE=;
        b=yK5i0j6Vr/VdDPLM6kb4RsbKirLcyXwi8Os7nH9SmCIQ9duQmQG5logPZysARkIpdm
         0iRATV/SVYEusWQVmlqNFG7/BDBosgse94mQJmatEZPNOoeg+xZAIjZh/vIaA8y+Qaq7
         62+OjpTMAxdigDMBccENJ4hdWhKOtjV3Qa55/huvH2APT4z5CSbvKPWHJsos4fc80ve/
         6HDIBHQU985O1ypElZJHdwG/0ey5A3+uKdM91dz7OU7N6/QN6cLCKMR01V+wsUmnAHbE
         2Hbd2hNk9fCkkOmeof+jAnyjxYZaX8T4vwY5MTsxdhcHddyCbyM6wEAzpMtMBb4Tq8J/
         O6zw==
X-Gm-Message-State: AFq9FYIk0dhhXvgRLlP/Kdc985pdKKeuxaoqI4rHEyTANhIdAlcnB7Mo
	V2uQ2rGzKHG1lNSMthfB6hoiTvx1/i8C7h5cAHEkWJ9QI0byyuQ9u0A=
X-Gm-Gg: AYBFou0PaMpj/0yOakmIJQhVnWSaFuXN2c9kpqLy9pGMPDbapLrNwcPEa5hLJZPj6Ii
	4JSFAE/WS9jqdAGPVpJzctE6j4KfEzO+3sKsz5epNONM/8q7ZKd17rX3qEAdv4/9mt2+94Ox/BV
	kBqtDNuaQLJTH9eHydecp1tJlj0f7pj8gMOQgw48DwT/0Lgizbk1WPgDjSJ+s7/rKLVBKHtJAPg
	TtCFspo+gXmpt+cMi+bbM9Pd9lS312yh4NegvBOf29nuyr7RRVFJi4EQsMY/UsP2Dcw6YGvgQbT
	Njinda+jYfuE5fh0NoZm/P4zV3v462gkXiOy+lrT86Q2ZZfQ2YHjzPj1DiNY0WDmN4ekZltYRta
	fS4DlyxEOAVdYz6jj8L6COX2uZaWV2aCq9gTQ4nXOvV+rBtiKu6EGwkavMSXEbciC3LJ9D+YQUq
	RQZuW4cywAIPFvk8Wc0qBz5FYGLBfxgn0z6CyKxCa41b8aBKXFrlsv1jpSyU4YlZm0VHcOLaAPi
	reCiZVMhWn4194q82T9WSienap4CNSSThu7Av8HQogI9A0uBMEs6mytSaKY/rfgvy/dPqflIX2D
	f0WA4OlK/2SGy15TDn6iXjJYs2xK
X-Received: by 2002:a05:620a:26a4:b0:93b:bce3:5499 with SMTP id af79cd13be357-93f29b80618mr714198785a.6.1792292213458;
        Sat, 17 Oct 2026 19:56:53 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1850cbsm597676985a.24.2026.10.17.19.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:56:52 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Support Opensource <support.opensource@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] Input: da9055_onkey - free the requested IRQ on removal
Date: Sat, 17 Oct 2026 22:56:50 -0400
Message-ID: <179229215687.3924264.8583597004889642167.da9055-onkey@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_get_irq_byname() returns the Linux IRQ number already
translated by the MFD core. The probe path requests this IRQ directly,
but remove passes it through regmap_irq_get_virq() again as a chip-local
index.

This can access beyond the chip IRQ table or yield a different IRQ, so
the requested ONKEY interrupt is not released. An interrupt after the
work cancellation can then access the unregistered input device or queue
work referencing the freed onkey state.

Remove the second translation so free_irq() stops the same producer that
probe installed before the delayed work and input device are torn down.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: 06491e84f0f9 ("Input: da9055_onkey - remove use of regmap_irq_get_virq()")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
Compile-tested with Clang, W=1. No hardware runtime testing.

Based on mainline 0fcb05b72344f40806cbe810de8872f1698bf053.

diff --git a/drivers/input/misc/da9055_onkey.c b/drivers/input/misc/da9055_onkey.c
index 3e4fc2f..20ee79a 100644
--- a/drivers/input/misc/da9055_onkey.c
+++ b/drivers/input/misc/da9055_onkey.c
@@ -137,7 +137,6 @@ static void da9055_onkey_remove(struct platform_device *pdev)
 	struct da9055_onkey *onkey = platform_get_drvdata(pdev);
 	int irq = platform_get_irq_byname(pdev, "ONKEY");
 
-	irq = regmap_irq_get_virq(onkey->da9055->irq_data, irq);
 	free_irq(irq, onkey);
 	cancel_delayed_work_sync(&onkey->work);
 	input_unregister_device(onkey->input);
