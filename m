Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66C3C9ED1;
	Fri, 20 Mar 2026 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025085; cv=none; b=JScudnadUz76fBLzUkUg7n1v1u3sDzcwwS9XWbBopMpS83gqUXKZzAMVVI4pLRP9RkxuR7nYeqcE3nzPRrKF/kGWly6K0po+CSuWg/gqA0vhu1lC8KKu0SPZqH/vcftmwYFF8JPYrNIAHMrV1PF7GU+tULNLFMFzTbdGexDcMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025085; c=relaxed/simple;
	bh=mx4BBb4FfvTCLbKpeQw8LtCyrmtuoUdH6OgDIV5QXZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PyQjYsoPLeT3oOyqJWrlYBovtH5Xi6ZSLxWU3K3UidWQAXKyLKOIxuGz7Bl8gOGWs/zJUHpnFB6YFGyz+fm02DvtAx+xh+mhOE0HFBXQAN71ZYYnuIKVZebDZkGX6ZfE0gytpVyl2QIYaeYD4+yn6ld55olCElUTK5A/W6Whu9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0ZCvXA8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0ZCvXA8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2690C2BC87;
	Fri, 20 Mar 2026 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774025084;
	bh=mx4BBb4FfvTCLbKpeQw8LtCyrmtuoUdH6OgDIV5QXZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z0ZCvXA8KWwyWhuq0Ob0gk3PhdpzOnGNGXm4pVNBzBu5eFZHU2+KscZp6BIBzHnSt
	 MkNEseU5SOEpU2qmSCB3FrmfiRv/FqciP1ohgywyFaea1IfzrHCaY8f9NOe6a8Q00r
	 FL1QB+L6LNi3RuUcH3BPbvZ5F5dwh3OfXZkrHPo8fPN9vnmo+jRrE0oQvaPVJNmOF+
	 tK2Ro5eMmO7WtZ2c8XnVb3EBwf9YTweEDJkylPlBWwAJxQrpmFb1TJmQOGBPpTF5Ce
	 4uz0s/vcIh1j4pyKnNsKm9dq+7Z0BVTVdOOdxAakMwaj3ie30H8ds/udDhrYSaQp/q
	 3S8y+A+t5xm4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A710987B3;
	Fri, 20 Mar 2026 16:44:44 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 20 Mar 2026 17:44:43 +0100
Subject: [PATCH v7 2/7] Input: synaptics-rmi4 - handle duplicate/unknown
 PDT entries
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-synaptics-rmi4-v7-2-379360de18d0@ixit.cz>
References: <20260320-synaptics-rmi4-v7-0-379360de18d0@ixit.cz>
In-Reply-To: <20260320-synaptics-rmi4-v7-0-379360de18d0@ixit.cz>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Casey Connolly <casey.connolly@linaro.org>, phone-devel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3801; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=86uZKh7RWLmJOMtEcC3sJGbiTauy/sS6lizTqTxChes=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpvXl6C1ta5vyYx6wULHbaQ3MYh5yG33y3bevCx
 OIzzNHWGk2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCab15egAKCRBgAj/E00kg
 csyED/0ZrwcS23TEnGMKkuMAxUV601ExyBBW+Ngwi80ORpCnEdbosRgdYDfHzKRwWLz9kWzixAv
 0h2eh7edlSJh0z3wrRZPG6MRA0tJG3vVM8HXh5WaDo5niDFrpzhOvDdaKiHWW4zGiX651mgS0XL
 sWcLEQLcmExiGOMgOGOGLKRduxqTA6+KPeA/V0r87QsatJo3N/DBx8r8G6+vUQWME4lxe8dRkp8
 iA1W5UfnyXu0VqmEpMjM+MlFLfBpuOq9mMFLS0orX4VGMv1X0uumbdYl5hDTMW/Xwkj8iNRFBwC
 6Bjyifhac+b/pyxBYUGb6udnnoXNl0qGDJtUvvKatoHCJFNvRMDTkmMe5wIOWQl3QkjdtlTlFl7
 cRPLNu9URFhDkNxbZPG4QyCz41ZpFbWrN3PvTJaw3Wcah69bmcnRSL+0c3b25EjPUpu1d7lB7te
 gUFeTRABpRAZGDfmDQHVRrs+cs3UElW+rx+u/I/wTxUUbP4kM3pIG/SUPYzgTsCDK4yKOwiv0Kq
 iNZv2oWKqWsd97uMk01TpdC+rpFabDo6Ovx8kSMVZOqxEz1oKnr7dkxYo7JehgJPTBLbGLcvby5
 3tiVnm6sCRRCOtqWXoOjgwHPqPKKX9MCGgt8SrpZxcfaf6OaiRk1gpBFRTUSOXxvdmsFX5QqZph
 ieQTwhHoxvFv4vg==
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
 drivers/input/rmi4/rmi_driver.c | 42 +++++++++++++++++++++++++++++++++++------
 drivers/input/rmi4/rmi_driver.h |  8 ++++++++
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ccd9338a44dbe..c7d2f68e65487 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -494,12 +494,39 @@ static void rmi_driver_copy_pdt_to_fd(const struct pdt_entry *pdt,
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
+	state->pdt_count++;
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
@@ -522,6 +549,9 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 		if (RMI4_END_OF_PDT(pdt_entry.function_number))
 			break;
 
+		if (!rmi_pdt_entry_is_valid(rmi_dev, state, pdt_entry.function_number))
+			continue;
+
 		retval = callback(rmi_dev, ctx, &pdt_entry);
 		if (retval != RMI_SCAN_CONTINUE)
 			return retval;
@@ -532,11 +562,11 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
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
 
@@ -545,11 +575,11 @@ int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
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
index e84495caab151..a4ae2af93ce3a 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -46,6 +46,14 @@ struct pdt_entry {
 	u8 function_number;
 };
 
+#define RMI_PDT_MAX 0x55
+
+struct pdt_scan_state {
+	u8 empty_pages;
+	u8 pdt_count;
+	bool pdts[RMI_PDT_MAX];
+};
+
 #define RMI_REG_DESC_PRESENSE_BITS	(32 * BITS_PER_BYTE)
 #define RMI_REG_DESC_SUBPACKET_BITS	(37 * BITS_PER_BYTE)
 

-- 
2.53.0


