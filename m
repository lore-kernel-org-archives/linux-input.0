Return-Path: <SRS0=BonL=3E=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0E2C33CB1
	for <linux-input@archiver.kernel.org>; Wed, 15 Jan 2020 05:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2150E2072B
	for <linux-input@archiver.kernel.org>; Wed, 15 Jan 2020 05:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="ahqVmnPg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DuFQLnaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgAOFM4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 15 Jan 2020 00:12:56 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53717 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbgAOFM4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Jan 2020 00:12:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 70D5022139;
        Wed, 15 Jan 2020 00:12:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 15 Jan 2020 00:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=rqjA/bBm6Efiy
        JMjxSo/r1phlA8NYcHSBKYtzL6xSvg=; b=ahqVmnPgT6/E3N+HpzLzYB9zvFmX/
        7B0gvaO4WXUtZSG0UIdhlIC/S/uHJJRx422n1LjwWc7hcP9SyNsK8x3FWyGehSyg
        2s7nIQbuVpDr6SALmjUAyLdSwZnZ9TTI7Q8Z0Ry0J3OeBMU+klWip9rSjeRSsSqs
        ENZ50XWZ2YyUBJb9SvPmMn8b4pWy+UvlenSyajT3MQAJlJgo4EYjdMidRknprbvP
        VTbRDj2wboTYaGUs1YwcPmEQe4IaWO0pOqMjU5OaowqiowSCRg2DV9cPK2EDnQY6
        m9nm64yFH0bxa4724MjEsFhtnOmTJ1cGblU+nsKvgh2I+TXTRnGLiRBUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=rqjA/bBm6EfiyJMjxSo/r1phlA8NYcHSBKYtzL6xSvg=; b=DuFQLnaI
        oTlOBXoh69lZ44fxyNbKv4kd0dMv52rrVDabMHL393XbsTKI4C8/CV3HQjDsyp24
        c+iFVwbevg3xikbpFu3g93dSutP0+fC4j07xKo16RXDIrvSkkclKm5ZF2wWphkZx
        fLlIqTDjhI+Gl43dHYdf4XIz16Jk9QG4EPHsoAkXH+v6Y/aM81dQhiZ7SZ+xW4D6
        TcI2hrlQCAIA0snAG/Oa2hn3qOoejkC0KA+/XdUar9v+DUP1w18Mwj86f97evgDU
        mWwDBEgkv1GHKQ/S2HdU24DHn82NHpTQMo/qQmS7FvR5OcHzP25rp7CPvH+J1EVE
        setRR6Gny8Wpeg==
X-ME-Sender: <xms:V58eXrMQq7sLEazI-j0kdhMz-BFkruJyn3htCWKjbxd7499rS1pLLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtddvgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:V58eXublo9bFwQuGN3nCY7FFSrUKPvlWtbd9i4XmB_PAT3mh7W5tDw>
    <xmx:V58eXv6w8pW7bmQ2hn52-3EPeHtRBwgES2Qo9g_xToUQHFNpSHsCiA>
    <xmx:V58eXjy38VQzkYFQA_W_yuwapQ_2BRrmbQYwWaBGkxYJRrPcrZsqDg>
    <xmx:V58eXu0_AxDj2RC6Rx1-EuaYjGrdQpz26vHNkwRPviZ33DvsAzW3dA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE86180065;
        Wed, 15 Jan 2020 00:12:54 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 1/2] Input: axp20x-pek - Respect userspace wakeup configuration
Date:   Tue, 14 Jan 2020 23:12:52 -0600
Message-Id: <20200115051253.32603-2-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200115051253.32603-1-samuel@sholland.org>
References: <20200115051253.32603-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Unlike most other power button drivers, this driver unconditionally
enables its wakeup IRQ. It should be using device_may_wakeup() to
respect the userspace configuration of wakeup sources.

Because the AXP20x MFD device uses regmap-irq, the AXP20x PEK IRQs are
nested off of regmap-irq's threaded interrupt handler. The device core
ignores such interrupts, so to actually disable wakeup, we must
explicitly disable all non-wakeup interrupts during suspend.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/input/misc/axp20x-pek.c | 37 ++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 17c1cca74498..0ace3fe3d7dc 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -280,7 +280,7 @@ static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pek,
 	}
 
 	if (axp20x_pek->axp20x->variant == AXP288_ID)
-		enable_irq_wake(axp20x_pek->irq_dbr);
+		device_init_wakeup(&pdev->dev, true);
 
 	return 0;
 }
@@ -352,6 +352,40 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused axp20x_pek_suspend(struct device *dev)
+{
+	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
+
+	/*
+	 * As nested threaded IRQs are not automatically disabled during
+	 * suspend, we must explicitly disable non-wakeup IRQs.
+	 */
+	if (device_may_wakeup(dev)) {
+		enable_irq_wake(axp20x_pek->irq_dbf);
+		enable_irq_wake(axp20x_pek->irq_dbr);
+	} else {
+		disable_irq(axp20x_pek->irq_dbf);
+		disable_irq(axp20x_pek->irq_dbr);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused axp20x_pek_resume(struct device *dev)
+{
+	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev)) {
+		disable_irq_wake(axp20x_pek->irq_dbf);
+		disable_irq_wake(axp20x_pek->irq_dbr);
+	} else {
+		enable_irq(axp20x_pek->irq_dbf);
+		enable_irq(axp20x_pek->irq_dbr);
+	}
+
+	return 0;
+}
+
 static int __maybe_unused axp20x_pek_resume_noirq(struct device *dev)
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
@@ -371,6 +405,7 @@ static int __maybe_unused axp20x_pek_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops axp20x_pek_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(axp20x_pek_suspend, axp20x_pek_resume)
 #ifdef CONFIG_PM_SLEEP
 	.resume_noirq = axp20x_pek_resume_noirq,
 #endif
-- 
2.23.0

