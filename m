Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784130B533;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381237; cv=none; b=YSF8mmgEVVQOSYFqx4NpL/A3jn9X3qud80KdgCpET1XqU34wBlYup+yBTY2KJ6DuAyIIcBd6BLawx+8715muPY8f9iG2af33PGZoghWNqdCw3sJMPYlu7jVXZluvbFoyb5ynwTdafMHy1fJuxpT6WK9SL/skJlWFdTocGwIhLWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381237; c=relaxed/simple;
	bh=hBNSassvHp22I8n0Rdny6FBg5i1FuQGAA6jCWjJDhw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CGytpFUsZZOYBuVfkFno60Kt0OdzIWFs0xC58QD37WbZBKQETZ1O2nYFJ1RngC+XH62LmVziKPGEa7X70XlTfnIftF/gibUZWhi6NhP0QfwwVytGDPvVtfOKKJzR88dM87Z+KAUuPPVLh3W/8ts5MkICe5DSv1nGYox62GQFFjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMBJL+kx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMBJL+kx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ACE8C2BC9E;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774381237;
	bh=hBNSassvHp22I8n0Rdny6FBg5i1FuQGAA6jCWjJDhw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XMBJL+kxGdbm0ZdHGaz0kprqaGjvV2LuYKkyLIVmYRAi/aHn6BwhXv6DlFMhfE32W
	 xOX5zghQMz5PvgP46uCGYDyjt0L0AXLd2LqWyRnnjlD81vh2K22tISVjnhRs7Mn/hI
	 qnA/lSNOcWWVsHxAkLFZzMtHevibRBm8y2l2mVD/FuAR9tIV2H1cHkWC7b1D0v2+zX
	 uH8Nia/rsscAhkRcEQyZjX9iNsHFqxid+zP2NwCCgLz6q4W19l2Gi4ns/xN0/JiSfu
	 iIgw9OMCkUgfUtGF/e0+Ae3Au6+yT0sfeqe7FTybBJmMHMNUG2CCAj2VGm0NM9rujJ
	 20w0MHveLxHbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815ADFEC103;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 24 Mar 2026 20:40:35 +0100
Subject: [PATCH v8 2/7] Input: synaptics-rmi4 - handle duplicate/unknown
 PDT entries
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-synaptics-rmi4-v8-2-2168d2df68f5@ixit.cz>
References: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
In-Reply-To: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3764; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=D7LTxErg5nBRM3MbUkmE1QMDLecysc7WaWg0nG8dins=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpwuizA75+UF16qnuk37Z0x+LaA45EdHnR0fIQH
 GDIR5eKTRSJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacLoswAKCRBgAj/E00kg
 cuX0D/9fYCD3ElUInuZCs8htEiR3PokFl09Jk/fwUoyj8IN2zS28Xl+oky7AZx3njSxn9LL9kCL
 a0NvQHUoJmBc8y21USbPu/14+fKkJZmqLxCOyLkQIc3Dnw0G/zn6z9uswccBxBBePUYfVp7uN76
 xjKAc+ETiULlqubujiSLiV1Uk8zkbYhbWtfoY0YbKeKvuf2xX09jW6jSCVAEH4+9+Jkyx+7zKzL
 gtVyFEpy5Ciw5T1pqlAHWP2QM2Exu4HaKfen6LPO6J4M9wTauWxw5bClMldC9cn0l7S40mxhYUC
 fzmRi5AJhGfXQwf5Bqz9xxHkHGkclGgYftbq8Bm6zOCH9nsuWgOMBYngDoUHwsmrGms7yt2yNM+
 SALIBgNald6Z7zglmxHQviXJw4a9ULCNLqLsZu+ehVw5/mQblAqOcyouT7EtmDahnbQWbCNORke
 ignjgrbC1pXnXQa1+UnpvkCmAN1iISfQFv+wHrjhLhIGhfumTZsDkhHysoWgBO/xxPcWUveWova
 uEpuOpdrf3s2xPD7WgEwy7mnre5buCQqWaR+ZQdFGbhI4uufD+pMJF1Zn2ahEQ2NAYEsvtkhpQC
 DU6XUEJMTkji5aXjnLU2EkWfEsxsg5kw7LGAhLmTvXsJRB6NGrYo0uXT5M1P6xaipbjcuDOcsEk
 4l1O1K36NTsgPHA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Casey Connolly <casey.connolly@linaro.org>

Some third party rmi4-compatible ICs don't expose their PDT entries
very well. Add a few checks to skip duplicate entries as well as entries
for unsupported functions.

This is required to support some phones with third party displays.

Validated on a stock OnePlus 6T (original parts):
manufacturer: Synaptics, product: S3706B, fw id: 2852315

Co-developed-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Co-developed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/input/rmi4/rmi_driver.c | 41 +++++++++++++++++++++++++++++++++++------
 drivers/input/rmi4/rmi_driver.h |  7 +++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ccd9338a44dbe..dea04cf076eb4 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -494,12 +494,38 @@ static void rmi_driver_copy_pdt_to_fd(const struct pdt_entry *pdt,
 	fd->function_version = pdt->function_version;
 }
 
+static bool rmi_pdt_entry_is_valid(struct rmi_device *rmi_dev,
+				   struct pdt_scan_state *state, u8 fn)
+{
+	switch (fn) {
+	case 0x01:
+	case 0x03:
+	case 0x11:
+	case 0x12:
+	case 0x30:
+	case 0x34:
+	case 0x3a:
+	case 0x54:
+	case 0x55:
+		if (state->pdts[fn] == true)
+			return false;
+		break;
+	default:
+		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
+			"PDT has unknown function number %#02x\n", fn);
+		return false;
+	}
+
+	state->pdts[fn] = true;
+	return true;
+}
+
 #define RMI_SCAN_CONTINUE	0
 #define RMI_SCAN_DONE		1
 
 static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 			     int page,
-			     int *empty_pages,
+			     struct pdt_scan_state *state,
 			     void *ctx,
 			     int (*callback)(struct rmi_device *rmi_dev,
 					     void *ctx,
@@ -522,6 +548,9 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 		if (RMI4_END_OF_PDT(pdt_entry.function_number))
 			break;
 
+		if (!rmi_pdt_entry_is_valid(rmi_dev, state, pdt_entry.function_number))
+			continue;
+
 		retval = callback(rmi_dev, ctx, &pdt_entry);
 		if (retval != RMI_SCAN_CONTINUE)
 			return retval;
@@ -532,11 +561,11 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 	 * or more is found, stop scanning.
 	 */
 	if (addr == pdt_start)
-		++*empty_pages;
+		++state->empty_pages;
 	else
-		*empty_pages = 0;
+		state->empty_pages = 0;
 
-	return (data->bootloader_mode || *empty_pages >= 2) ?
+	return (data->bootloader_mode || state->empty_pages >= 2) ?
 					RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
 }
 
@@ -545,11 +574,11 @@ int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
 		 void *ctx, const struct pdt_entry *entry))
 {
 	int page;
-	int empty_pages = 0;
+	struct pdt_scan_state state = {0, 0, {0}};
 	int retval = RMI_SCAN_DONE;
 
 	for (page = 0; page <= RMI4_MAX_PAGE; page++) {
-		retval = rmi_scan_pdt_page(rmi_dev, page, &empty_pages,
+		retval = rmi_scan_pdt_page(rmi_dev, page, &state,
 					   ctx, callback);
 		if (retval != RMI_SCAN_CONTINUE)
 			break;
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index e84495caab151..2c47373c3d177 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -46,6 +46,13 @@ struct pdt_entry {
 	u8 function_number;
 };
 
+#define RMI_PDT_MAX 0x55
+
+struct pdt_scan_state {
+	u8 empty_pages;
+	bool pdts[RMI_PDT_MAX + 1];
+};
+
 #define RMI_REG_DESC_PRESENSE_BITS	(32 * BITS_PER_BYTE)
 #define RMI_REG_DESC_SUBPACKET_BITS	(37 * BITS_PER_BYTE)
 

-- 
2.53.0


