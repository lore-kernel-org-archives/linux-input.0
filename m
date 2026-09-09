Received: from outbound.st.icloud.com (st-2002i-snip4-3.eps.apple.com [57.103.78.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C596582B89
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972799; cv=none; b=rD37P/MtPxxE1bZffjtVICSSWNyozfdyKWhPhnAURAG7ws59WaAjE2LtqxIGzJ8oNe+tCX5/x3MkWOxHx4zdCX9LnXaGnIHR5nl4e4TvSX6P/js9HM/2I7YSr5Ij0cYTySb2zi09/Jlwzz2RgN2EEEwY9M45eLQWp6Fbju3hLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972799; c=relaxed/simple;
	bh=TH7xiUmPiRN2Ke2LH9Q18r641ZzoWsOEoevLvCJWrWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky/bDfPH/To+L/XdCuulGfEG/KrfY5V0DBu6Ho+ZytZ/xe+dN4a4eTSceB6p+ieu7yP9lsMUF85HJtM8CcUI4oIt/4LpALxiCuA8HfzcgPs3D6etWp2j9/VA993p844CEdrbnRxRoq7+6fr0RagxZnJaH4XoPmt48dRxlsEwAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lg97nVUJ; arc=none smtp.client-ip=57.103.78.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lg97nVUJ"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id 6D50B180193A;
	Wed, 09 Sep 2026 16:53:13 +0000 (UTC)
X-ICL-RepId: 01a08716-7e14-70f4-8ead-51da4714811b
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQBOHVUZWQdDF0kFWRcOVk1aFV4MTRFdMFAbXwJCDxwTVhUTC1NWWxNVF0YJGQhdHRkKUFAPS1oVVRcOAkIfUB9MFldDRB8cGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKAlEcVg1XQ1QEX1BUEVdQC1kCQg9ICl0OWgRFC00EQwReAEUATx5YGghfHVgCSQJ3AlEcVg1XQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1788972795; x=1791564795; bh=FV9k8NWb+dh8I3nrEsWiD0bNBM7jwcON6rQ4XazRym4=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=lg97nVUJvkg48regGbqooOsgBppdtdYYj2cpsAJ2NIhxbXPnSkltfn66M5RBi9nrgrPwdTUqydz7sZu2LSMxxoSbZ2dWwiaAowLmzOJ+XiCxkoGQzhZ23sN/lPzPI4+I9zZlcr3hq981eCGwWGChZrngderBzJdt4KzsRhnU5kySI6JKEJigpbjO6IBtwbYn9rE8hwzwEjM9sVJdX6YsYp89T2z5nkl8EqhfsRGY7JbTHLZU/erCxDIGmdV8/BkmcT3SD2s0IqXu7w2G9267pbF0zxQRPNNQ/cIYGBytSFPcpInD9L8DS9c2c9saSt8xLH4iPr/sSpI9h91Pisr+pQ==
Received: from komputa (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id 53D6818000BD;
	Wed, 09 Sep 2026 16:53:12 +0000 (UTC)
From: Cristian Mazzotta <cmmazzo@icloud.com>
To: aer@tuxedocomputers.com
Cc: W_Armin@gmx.de,
	bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wse@tuxedocomputers.com,
	Cristian Mazzotta <cmmazzo@icloud.com>
Subject: [PATCH 4/4] HID: lamparray: blank lamps across suspend and restore on resume
Date: Wed,  9 Sep 2026 11:52:57 -0500
Message-ID: <20260909165257.352597-5-cmmazzo@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909165257.352597-1-cmmazzo@icloud.com>
References: <a62d1907-73cb-4cfd-98b1-7cdce3b37541@tuxedocomputers.com>
 <20260909165257.352597-1-cmmazzo@icloud.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE4OCBTYWx0ZWRfX6/o8zzYFgiGw
 ojEWaaZ+7HWWhLMi5gxq2M62220esYGETSpkwkLSoQRb5EHnvF+pd1kobSYETnH5o0/lvr97TsK
 vEWzfDwun6WNBvSfqzS+AhcN0v45w38WXtuKlKzOp8AznxmbPtQ0bj5QmCuuy+BJwj19alkAIKq
 o3MKKYCIiki+ZIS4s5fhkDMqm1O4R9obLzM5WUeCEtxr5tlyRz94FmA87XD2Wf4r00VCkqsGy3g
 ItliDMdlS7dJKAIW4W/fr+/w5ZkjKbyNOXcdPGOjfaWiv/rXZiC038gXNN4YfC3wFByBkDudkEU
 JsN4UoVOSOXKh0RgkBD+7bMgEeZ5XWzFWWjfhC2yVKueVqFJtOjLsv/cKrMKBo=
X-Proofpoint-GUID: X5w_crjx1FW4-3r6q5OJwPs9w8vCZW7b
X-Authority-Info-Out: v=2.4 cv=KrNAGGWN c=1 sm=1 tr=0 ts=6aa18efa
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10
 a=zMoZyIPnO1cA:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8 a=yDUiu3_GAAAA:8
 a=9EF4LWCgBoztrZfFWooA:9 a=gafEeHOdjwYkg5oUpzAY:22 a=Uh4tPsEYL5Xn7yYgV4Nn:22
 a=djM25Df-3sMe0xqo8c8Q:22
X-Proofpoint-ORIG-GUID: X5w_crjx1FW4-3r6q5OJwPs9w8vCZW7b
X-JNJ: AAAAAAABboOgikKWHLMsBtHh+szyrlpvO5Z8rJb46l+uTOS8CYs8LUgogpJFw6bqXwq8AsB8MuabKY0YFf76X4MJrW1KdZDfl7tHJGvFpK4ww6Bbo4fzL2RR/wawGABPWlIjc335ZMPXXVKNhxHAbdY0lPxY4AVsxkBd/Wly4peebCBesqD87XECjSPzOlWfv5ueHf63vORLgcJ4ew61qqe4nvzqKSRZxLn9lQkAbkXOQog/R919v6BXgRxjQoJmskp+7xRGVOtoNU25ng+86cKYI0eMjySIjtrTVST4zoF/7rnJcINHO5FAd/32ZdD53RuXo+4uHB063pNNfpX69yy0sYFNDV2aKYiR+f959oIAcSfB3hHCGWodvhJ4c84oecmobvLN+9Z1mO6a3XhT6xyjpPdIRkR/vOXsDbOyKEAN+3nuXWQYLdqYaPiT4DSj5oKVYIP3vFJsac2K0OaLPFYdRO6t9W5l8snAYsKr7bfAhGwRI60kRPVFcdV9qZXhuoeMf/Rg+e+pEkJjchhGyfFEneYX7Ji+PKaVfwD7XEhUx1MFCMDcXjeWSaI9YTmw9oR86Bch53fAJjPC8Mmh3xSn6bwUPsOaij/C6HoIhgqTPk61jivKR5PV6DlJb3X3chqQCDgK4ngXqLmP1qZnuM3fMuaL1QYxuit30fgmJvPMP8PAaQyuXdBiMGmWyFfjLnfGMK37Gjvj9TXe41/nRvcU3C8NNq/HMqeFgwdnA0Q4kmfRwfaUuVNiWzKIXnhW6hujrYI2TsizgVkSoc86SXqP8M4QJaUvEP2vBsAJf2NnX5xDj+18AhZWvSAzKe/bcJfMUM/Ehg9DcTkpMawibKNn

The helper installs no PM callbacks, so lamps keep their last state
across suspend. Firmware is not required to turn them off in low power
states, and on devices where it does not, they stay lit for the whole
suspend.

On an Acer Predator PT14-52T, system power draw during s2idle is 12.35W
with the lamps lit and 3.14W with them blanked, measured at the charger.

Add lamparray_suspend(), which writes zeroes to the color channels
while leaving the cached RGB and brightness untouched, and
lamparray_resume(), which restores that cache. Both return early when
use_leds_uapi is 0 so a userspace driver keeps full control. hid-generic
gains suspend and resume callbacks to drive them, and calls
lamparray_resume() from reset_resume as well.

Some devices return to firmware control across a hibernate transition
while still reporting AutonomousMode = 0, and ignore host lamp updates
until the value genuinely transitions. Force a 1 -> 0 on resume
before restoring state.

Signed-off-by: Cristian Mazzotta <cmmazzo@icloud.com>
---
 drivers/hid/hid-generic.c     | 27 +++++++++++++++++++
 drivers/hid/hid-lamparray.c   | 51 +++++++++++++++++++++++++++++++++++
 include/linux/hid-lamparray.h | 35 ++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index c3d2283198e8..dc1cca45d599 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -99,9 +99,34 @@ static int hid_generic_probe(struct hid_device *hdev,
 
 static int hid_generic_reset_resume(struct hid_device *hdev)
 {
+	struct lamparray *la = hid_get_drvdata(hdev);
+
 	if (hdev->claimed & HID_CLAIMED_INPUT)
 		hidinput_reset_resume(hdev);
 
+	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && la)
+		lamparray_resume(la);
+
+	return 0;
+}
+
+static int hid_generic_suspend(struct hid_device *hdev, pm_message_t message)
+{
+	struct lamparray *la = hid_get_drvdata(hdev);
+
+	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && la)
+		lamparray_suspend(la);
+
+	return 0;
+}
+
+static int hid_generic_resume(struct hid_device *hdev)
+{
+	struct lamparray *la = hid_get_drvdata(hdev);
+
+	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && la)
+		lamparray_resume(la);
+
 	return 0;
 }
 
@@ -127,6 +152,8 @@ static struct hid_driver hid_generic = {
 	.match = hid_generic_match,
 	.probe = hid_generic_probe,
 	.reset_resume = hid_generic_reset_resume,
+	.suspend = hid_generic_suspend,
+	.resume = hid_generic_resume,
 	.remove = hid_generic_remove,
 };
 module_hid_driver(hid_generic);
diff --git a/drivers/hid/hid-lamparray.c b/drivers/hid/hid-lamparray.c
index bbde006d119b..dec9d7883887 100644
--- a/drivers/hid/hid-lamparray.c
+++ b/drivers/hid/hid-lamparray.c
@@ -869,6 +869,57 @@ void lamparray_unregister(struct lamparray *la)
 }
 EXPORT_SYMBOL_GPL(lamparray_unregister);
 
+/*
+ * Blank all lamps on suspend rather than handing control back to the firmware,
+ * which may not turn them off in low power states. On an Acer Predator PT14-52T,
+ * system power draw during s2idle was ~12.35W with lamps lit, and ~2.84W with
+ * them blanked; the lighting accounted for ~77% of the power draw during suspend.
+ * Since writing zeroes is well defined on all lamparray devices, always do it.
+ * This is ignored if use_leds_uapi is 0; let userspace keep full control.
+ *
+ * Lamps are written to without holding the lock because PM will freeze userspace
+ * first, which makes concurrent writes impossible.
+ */
+int lamparray_suspend(struct lamparray *la)
+{
+	if (!la)
+		return 0;
+
+	struct lamparray_device *ldev = &la->ldev;
+
+	if (!ldev->use_leds_uapi)
+		return 0;
+
+	lamparray_hw_set_state(ldev, 0, 0, 0, ldev->last_brightness);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lamparray_suspend);
+
+int lamparray_resume(struct lamparray *la)
+{
+	if (!la)
+		return 0;
+
+	struct lamparray_device *ldev = &la->ldev;
+
+	if (!ldev->use_leds_uapi)
+		return 0;
+
+	/*
+	 * After a S4 transition, some devices report
+	 * AutonomousMode = 0 while still ignoring host lamp updates.
+	 * Writing 0 again does nothing; forcing a 1 -> 0
+	 * will guarantee the device will update.
+	 */
+	lamparray_hw_set_autonomous(ldev, true);
+	lamparray_hw_set_autonomous(ldev, false);
+	lamparray_restore_state(ldev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lamparray_resume);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Tim Guttzeit <tgu@tuxedocomputers.com>");
 MODULE_AUTHOR("Aaron Erhardt <aer@tuxedocomputers.com>");
diff --git a/include/linux/hid-lamparray.h b/include/linux/hid-lamparray.h
index a77869728d12..a9f827743baa 100644
--- a/include/linux/hid-lamparray.h
+++ b/include/linux/hid-lamparray.h
@@ -65,6 +65,31 @@ struct lamparray *lamparray_register(struct hid_device *hdev,
  */
 void lamparray_unregister(struct lamparray *la);
 
+/**
+ * lamparray_suspend() - blank all lamps ahead of sleep transition
+ * @la: LampArray handle returned by lamparray_register()
+ *
+ * Writes zeroes to the rgb values only, keeping the brightness, unless the
+ * use_leds_uapi sysfs attribute is 0, in which case, it will return early
+ * before writing anything. The cached state is left untouched so
+ * lamparray_resume() can restore it.
+ *
+ * Return: 0
+ */
+int lamparray_suspend(struct lamparray *la);
+
+/**
+ * lamparray_resume() - restore host control and LampArray state
+ * @la: LampArray handle returned by lamparray_register()
+ *
+ * Disables autonomous mode (in case device returns to firmware control after suspend)
+ * and restores the cached state of the device. If the use_leds_uapi attribute is 0,
+ * it will return early and prevent any unwanted writing.
+ *
+ * Return: 0
+ */
+int lamparray_resume(struct lamparray *la);
+
 #else /* !CONFIG_HID_LAMPARRAY */
 
 static inline bool lamparray_is_supported_device(struct hid_device *hdev)
@@ -83,6 +108,16 @@ static inline void lamparray_unregister(struct lamparray *la)
 {
 }
 
+static inline int lamparray_suspend(struct lamparray *la)
+{
+	return 0;
+}
+
+static inline int lamparray_resume(struct lamparray *la)
+{
+	return 0;
+}
+
 #endif /* CONFIG_HID_LAMPARRAY */
 
 #endif /* _HID_LAMPARRAY_H */
-- 
2.55.0

