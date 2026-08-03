Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21135340402;
	Mon,  3 Aug 2026 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769655; cv=none; b=IFkopC6BSAWWrw+qhDPIQgaXHyR7rSDrUvw2EnJDvCF6fgJl2XxBZjE0Gx3YI4rgKx2JYUhOfvnKschZvyMMZb6uJCYo++fTFPEkzZ+gud+5UlR0qtMH6k2xP0v8+2+63XW4m0/U5ahfZVpMZiC4vTkzrX5AaWuZThHOIzShpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769655; c=relaxed/simple;
	bh=EesKxDDhHAI4sxtiHnNP2yIZ4rWEuJT+g6zRucqo69I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SRKVxIId6Wy/cmAMrNSHI7PPzE/S9rsbguaTgFeORBS/cZspScCV5jdqfsPBwRuhkk/hqwOzVrDSypEvv469vgls5BAaSZ9+eVEyM5JFzoNNrD0DePeE6mbBhk7qFN6B2iW4zBOC9r5Ksu0gcpwHX7Ct+KG4xzWvWwoW06KQfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Ttc2+8KQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+nSHsmY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Ttc2+8KQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+nSHsmY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 41652EC011C;
	Mon,  3 Aug 2026 11:07:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 11:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785769653;
	 x=1785856053; bh=32KV9qwFIqKCwsdt3k41eVbZ01GDKWoaUuM5bmiSqfM=; b=
	Ttc2+8KQYRAs9NnVaNiGvzyMrtS33wkuh/LxMIQZOvC6yM16EFXCqnUxoZOGz8Je
	teFTtAveQ42ODXeWtwcLa4D0PWdoPZ7bTJB5yV2pD36R99cP4rZDs9pqwGGKyEi1
	NUHPBnEn0c5FlaxOrcaXVdi6WP7jUpZSn1vpcSTTSpPt8GAjxtClkk9tN2Nzj02m
	yxL3CpV52L3e4KmNUnAFJt4rEA2Id1qX4jOhAuMhocmNpAcyUZjLeTD3Oy4nN8rq
	JiHwdUj63Zi3DWQEK5gKutyIt1thkbBhaLBowPjRoMdBU3EdNBPZQGCiHUxYxRsq
	k6CXY6G08KRlnEFixGLiXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785769653; x=
	1785856053; bh=32KV9qwFIqKCwsdt3k41eVbZ01GDKWoaUuM5bmiSqfM=; b=W
	+nSHsmYRD1hoN3ijgYcWzilcI6oz/yb6To+kYfSeT1zgXNuFfEDXXjG8aFS1Vku/
	KEk+QKLsxqll7HlL36Y3evZ6JSI1+BdfRDMGkZSSeuguy20sNiwd0IiV520rClv8
	v2RG2LQSsdz3Rm3y5nlHedH7O/UWwD2x6rGsvnlMFa0/BVZyZAHRxwTrFZp0mIAv
	MRij37e9IFd4K1vKbToBlCJbqMJ0f8aZNKOU8vU8/Smy6Jz3GJjAdaCqqhGvtqRp
	Tshg6ytW/AxGabszK97khAJzYHiRy3C8wc7NfEEpAwD2HVlq2x8OuAkEPbH/whe4
	re9eUrFpCXL4MlAclLKhQ==
X-ME-Sender: <xms:ta5wauWntLiaoZ5Q6ru9JvAp2DxW_wy5QQB7hf9PdhHGNQCa6AkWsA>
    <xme:ta5waj6qzDRuHQrzgL40si04RtrD6iD_XaEu6QhKNUplSjnGGYdRwGaVbxQH0ylzK
    w7DTui-rdHak5p5Siuux5K1QeyaWg2GYVFzurCmBY1ONu6KF14>
X-ME-Received: <xmr:ta5wapr_tXfLshIOcB0Lag9YION7mulH2WL8B2yyQ7xaANG5uEfW_RW65MerpTPcUYRszXf2e6wuEExpqHf63aKwguRgcGYxz1SYRqX0IZM4WTo08vo>
X-ME-Proxy-Cause: dmFkZTF+fQKSIBfA7HwOVKseRCZh0uKnLZitkSHsUQMmaspPL8FhZxEWFaJuVaeTxg64W3
    mScE3lxp7ppuqjxzantNBTKFXRk4QweupupTQ+qGBoCS0TsMOftnN5I/P+/Tpuy16jjXLN
    RqhzqLfMCPlxUms5RRi7VBwoJB5k7TeQw5vuQe8tpMYZSyUHG9aNsWJ8GdaK7bbOkfDldf
    HJs4eAcfqnf17iDuPeUQmBUzPymVqqtHtO4Ppa0b9ezoYIsPMGxtkYbXstqTcB4Objn6U9
    ELoZAJmnwQz/2zmxjwUyWaJCHP8Zw1cLtg/t70Pyhuf7OezLQYkdD8xW6yB83ZhG4UysHS
    zXJ55l1lY9iJbEzEyerC+j/F7bSqlKkW6soXOuHFxTZWCF4d4L7e9Hfn5gDE7NUCXfx1fl
    6NoyFfoqfCVDR5bQ3TOlhBPl07b8SWN+AQ3ch/LQIAxdkSj8LC+CwM8m23C4kKP07j21RO
    Gap5Fd0j5d6cxEzVJEFaViwpXg2l+Kz2nXCmbGvsNJVw6EfiCofpNhxs3/ZPo2FChgGFib
    XxJEhkzp45FMbuNnRXnnecZVgZDKPxYQ9x9Tgujxm8C/09D/UbY8DHo2ZNyTMdIB241Eg9
    JdYl2v5+Sn53SPoktKTKt7hVkcYpzhzhwYFHOLKJ6OWP80b5D0lBKX+chnCg
X-ME-Proxy: <xmx:ta5wamlPSjmjf3CaURSu8DA5XP1ooEvHiQPJuLJ2QGyL3yMPb8AZMA>
    <xmx:ta5walOc0Hjjtj1AJ64-QENv5rBuqUpXlKQKI07cPJBAtFVh72Yd9A>
    <xmx:ta5waqMll_K59c4bpWGq4D7R6IDlW5Jgx90wwe8bi7Puihr3Cqgwfw>
    <xmx:ta5wamhUsw3LWrGbAZVM7mm9KTEgnPPGooo3zI6ZcXdr95YtbWiKQw>
    <xmx:ta5wauoDPoPxG1T1HmoWrUrXGSxl9cmLZmHYBHvZixfg6Zr63UKnH0QL>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 11:07:32 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
Date: Mon, 03 Aug 2026 17:07:25 +0200
Subject: [PATCH 2/3] Input: xpad - add sdata_check() to xpad controllers
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-xpadone_packet_fix-v1-2-280da203f15c@kroah.com>
References: <20260803-xpadone_packet_fix-v1-0-280da203f15c@kroah.com>
In-Reply-To: <20260803-xpadone_packet_fix-v1-0-280da203f15c@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Ingo Molnar <mingo@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785769647; l=4426;
 i=griffin@kroah.com; s=20260706; h=from:subject:message-id;
 bh=EesKxDDhHAI4sxtiHnNP2yIZ4rWEuJT+g6zRucqo69I=;
 b=MUjxYrYtk/pj5SWpj+9L/u4aEnw4DoQS9/CmmrWsyiOiaYoABI9QkudZy2bZqnE6G0lx9W3NY
 NKESalUxLnaB85FvsO4OfAnexfQZTyaOxctPJ43s5DuBA2prSjZ0LfT
X-Developer-Key: i=griffin@kroah.com; a=ed25519;
 pk=Hy1TuVHERdQhLAWwjmxLFNtGj7eEEjaZWPXehAlic5M=

Add the sdata_check() safety wrapper to the xpad_process_packet()
branch. Which should include the original Xbox Controller.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
 drivers/input/joystick/xpad.c | 50 ++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index c516860711a8..319a4c4a695f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -813,9 +813,13 @@ static void xpad360w_poweroff_controller(struct usb_xpad *xpad);
  *	The used report descriptor was taken from ITO Takayuki's website:
  *	 http://euc.jp/periphs/xbox-controller.ja.html
  */
-static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data, u32 len)
 {
 	struct input_dev *dev = xpad->dev;
+	struct safe_data sdata;
+
+	sdata.data = data;
+	sdata.len = len;
 
 	if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
 		/* left stick */
@@ -833,42 +837,44 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 
 	/* triggers left/right */
 	if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
-		input_report_key(dev, BTN_TL2, data[10]);
-		input_report_key(dev, BTN_TR2, data[11]);
+		input_report_key(dev, BTN_TL2, sdata_check(&sdata, 10));
+		input_report_key(dev, BTN_TR2, sdata_check(&sdata, 11));
 	} else {
-		input_report_abs(dev, ABS_Z, data[10]);
-		input_report_abs(dev, ABS_RZ, data[11]);
+		input_report_abs(dev, ABS_Z, sdata_check(&sdata, 10));
+		input_report_abs(dev, ABS_RZ, sdata_check(&sdata, 11));
 	}
 
 	/* digital pad */
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
 		/* dpad as buttons (left, right, up, down) */
-		input_report_key(dev, BTN_DPAD_LEFT, data[2] & BIT(2));
-		input_report_key(dev, BTN_DPAD_RIGHT, data[2] & BIT(3));
-		input_report_key(dev, BTN_DPAD_UP, data[2] & BIT(0));
-		input_report_key(dev, BTN_DPAD_DOWN, data[2] & BIT(1));
+		input_report_key(dev, BTN_DPAD_LEFT, sdata_check(&sdata, 2) & BIT(2));
+		input_report_key(dev, BTN_DPAD_RIGHT, sdata_check(&sdata, 2) & BIT(3));
+		input_report_key(dev, BTN_DPAD_UP, sdata_check(&sdata, 2) & BIT(0));
+		input_report_key(dev, BTN_DPAD_DOWN, sdata_check(&sdata, 2) & BIT(1));
 	} else {
 		input_report_abs(dev, ABS_HAT0X,
-				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
+				 !!(sdata_check(&sdata, 2) & 0x08) -
+				 !!(sdata_check(&sdata, 2) & 0x04));
 		input_report_abs(dev, ABS_HAT0Y,
-				 !!(data[2] & 0x02) - !!(data[2] & 0x01));
+				 !!(sdata_check(&sdata, 2) & 0x02) -
+				 !!(sdata_check(&sdata, 2) & 0x01));
 	}
 
 	/* start/back buttons and stick press left/right */
-	input_report_key(dev, BTN_START,  data[2] & BIT(4));
-	input_report_key(dev, BTN_SELECT, data[2] & BIT(5));
-	input_report_key(dev, BTN_THUMBL, data[2] & BIT(6));
-	input_report_key(dev, BTN_THUMBR, data[2] & BIT(7));
+	input_report_key(dev, BTN_START,  sdata_check(&sdata, 2) & BIT(4));
+	input_report_key(dev, BTN_SELECT, sdata_check(&sdata, 2) & BIT(5));
+	input_report_key(dev, BTN_THUMBL, sdata_check(&sdata, 2) & BIT(6));
+	input_report_key(dev, BTN_THUMBR, sdata_check(&sdata, 2) & BIT(7));
 
 	/* "analog" buttons A, B, X, Y */
-	input_report_key(dev, BTN_A, data[4]);
-	input_report_key(dev, BTN_B, data[5]);
-	input_report_key(dev, BTN_X, data[6]);
-	input_report_key(dev, BTN_Y, data[7]);
+	input_report_key(dev, BTN_A, sdata_check(&sdata, 4));
+	input_report_key(dev, BTN_B, sdata_check(&sdata, 5));
+	input_report_key(dev, BTN_X, sdata_check(&sdata, 6));
+	input_report_key(dev, BTN_Y, sdata_check(&sdata, 7));
 
 	/* "analog" buttons black, white */
-	input_report_key(dev, BTN_C, data[8]);
-	input_report_key(dev, BTN_Z, data[9]);
+	input_report_key(dev, BTN_C, sdata_check(&sdata, 8));
+	input_report_key(dev, BTN_Z, sdata_check(&sdata, 9));
 
 
 	input_sync(dev);
@@ -1265,7 +1271,7 @@ static void xpad_irq_in(struct urb *urb)
 		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	default:
-		xpad_process_packet(xpad, 0, xpad->idata);
+		xpad_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 	}
 
 exit:

-- 
2.55.0

