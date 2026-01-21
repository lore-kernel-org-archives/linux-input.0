Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7079200110;
	Wed, 21 Jan 2026 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037941; cv=none; b=Ty7Q3Yzr6eTDtLXUcDYlncmwK3SlzUG7WV6uQUs9+4IORJvxTVT8SMz4xbc2KuaEEOFXl46EB6rWet6j4kUXS2aQ1SfSG1OPkujtc/a0dH4CSbIFaYk2VlDcfnq4PnP34PglcbfkqPFw5v/qJTVQdLtGLL8/9KfdyJ+bdRJbYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037941; c=relaxed/simple;
	bh=O0PS+BL4QHBiCrRhDmjpZt6wDloOgKZAIhbG8Mpc0jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eiI+MyIj527NnR4H/apQKKefjnb5pwbnyrYsDBfb+8ObipI5qhgoUnu9mCI5dM0+2o+I+r+077hLkr7aw7l368pt6OF4atuPj9mJh4F2RPLZ2QvdK2DyDwLDNN/ilHZYVxicOd/OPypEgSBUvxm99fzpI36ShdtkyEMT5izOqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Pm64mUVl; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TUqzYtNY; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Pm64mUVl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TUqzYtNY"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dxL0D0Cg1z9vDL;
	Thu, 22 Jan 2026 00:25:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769037932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9arw67GH+f/5kGjRhfNrg+tq6/rnHL3W8z9hdZKbl8c=;
	b=Pm64mUVl2ERUFGFTxnXxSdbH1Uy+1mepUlgptPzWFBJSHe1ZdDAYtqLEBh/rMWdmSvin+v
	i4hKm9a+PWt1xk6ED17GSgIMjBN56KNnBMJCb2hkHdeyk/kzGXFItv7eApd3uE9X52vPXy
	4h9ZTNK6WDZS84JUM5+EcbzivWfyfCAAsuR/qn7j2Inci3rmx/ttXZGvAM+N3wSvN4dced
	hYumJcTWjC2C1roXaLyc/MB8lz8s1naU790U4Ynxlj7s6OUjXMpP1Z+ggHAMVuLviiqIoE
	fYApcbrjtFJDk/M2hL4Wq2jcWGZqugVbRga1HiFoGoIKeszczHDuCHLwnRXE1Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769037930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9arw67GH+f/5kGjRhfNrg+tq6/rnHL3W8z9hdZKbl8c=;
	b=TUqzYtNYj+ul8NZ3XQfl24Eh4XMlPFmQ+KZZ2PET7ZwdQTxDBHmzCwP3KCakoaDK05TXO3
	KHc/79cS/Ea4vJ8UQTpQ9IlfYiDnDwgQFSRNWFPN4AXCPsIwY/peHTcpEOUk2T5pDjBa9C
	hLxy2Tbo8J24gja+YQgYd/TA+C8Jsfyk3WfGNGDYyM5bfANSvjICosSESDmLL2M10RGWkR
	snIxQYo7HctgBqLbSnRBOSYJ565Ha6+cDGnVW3JNrdo7RmneLCqoBD/j28cGH4aBgdmELP
	QrSJ7DvqMW62bdy9yReoNcQYC4O3Dq+k42wksUtV2Eet3x77KpsX/JlQf9lb1g==
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Marc Zyngier <maz@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] linux/interrupt.h: allow "guard" notation to disable and reenable IRQ with valid IRQ check
Date: Thu, 22 Jan 2026 00:23:47 +0100
Message-ID: <20260121232522.154771-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1hqgficb3dpq9zbmuxunfejqiy67heup
X-MBO-RS-ID: 298dcfcc0b48c75f1e3

Introduce disable_valid_irq scoped guard. This is an extension
of disable_irq scoped guard, which disables and enables IRQs
around a scope. The disable_valid_irq scoped guard does almost
the same, except it handles the case where IRQ is not valid,
in which case it does not do anything. This is meant to be used
by for example touch controller drivers, which can do both IRQ
driven and polling mode of operation, and this makes their code
slighly simpler.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 include/linux/interrupt.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 00c01b0a43be1..becbeab4a7473 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -242,6 +242,21 @@ extern void irq_wake_thread(unsigned int irq, void *dev_id);
 DEFINE_LOCK_GUARD_1(disable_irq, int,
 		    disable_irq(*_T->lock), enable_irq(*_T->lock))
 
+static inline void disable_valid_irq(unsigned int irq)
+{
+	if (irq > 0)
+		disable_irq(irq);
+}
+
+static inline void enable_valid_irq(unsigned int irq)
+{
+	if (irq > 0)
+		enable_irq(irq);
+}
+
+DEFINE_LOCK_GUARD_1(disable_valid_irq, int,
+		    disable_valid_irq(*_T->lock), enable_valid_irq(*_T->lock))
+
 extern void disable_nmi_nosync(unsigned int irq);
 extern void disable_percpu_nmi(unsigned int irq);
 extern void enable_nmi(unsigned int irq);
-- 
2.51.0

