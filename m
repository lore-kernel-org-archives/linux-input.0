Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B2A3B994A;
	Mon,  3 Aug 2026 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769656; cv=none; b=ettG+TB8WXK33GF/WMoe4knCABZWi+BfV17gIkJRh8nqNOFZH66cvllyHu1aofhmOANP82VXw42P7WVLN7whX7WnzuDS4l8U5PszXqMonJGPM7H9LuTv3EM6IPv+oOh+7yWB1jTmFWQ38n5tpWcQ2w28J9xCKRYTry7JDF9cBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769656; c=relaxed/simple;
	bh=JBxlXTJ12EuSmrmIEodyxZE6gMq5dEmkQEho9bU+fow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+vfm8uC7M8nfjH59v2BEHKoVUY6ASmC/By0H8HtL0RNRr8snkxgtwdy/ZorLPbeiYCT0NjO0ldzWUKNA7COJSktleypREYInveyM9t02k20VkRhLn+qg4VVT+HzAm9RNrAYz7572bbtyxApTlqW90ZpHoyX0/gI7/Zs5QKB7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=NgX4vE4/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwzGnR96; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="NgX4vE4/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwzGnR96"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8722BEC0190;
	Mon,  3 Aug 2026 11:07:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 03 Aug 2026 11:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785769654;
	 x=1785856054; bh=LCw89qpW+Gg7yOPoB26vTpmWnNAV5jXbKMDv9Up1Lk8=; b=
	NgX4vE4/Ju0iA2S7J9hkyMHsoXNrfNzCJcmUbRwYvwHY2gDF8qTDWe5osEw/e7wI
	MGiDKhHiF4YH6OwLrB0fR+9Qree8OSwOVhlbUho3eUaRkKnR7I+BUBJvobxYIGHC
	H7c5q7+I0Cjj0YcSuTBz5EhstzyGbES7jFnEs34KmGrYrCfo2iCIIQj5OMwLauqn
	Mqehm9O1F4pypOGW3sic3gA0r9YCwIPo2zwn1tX7TMApWmUpocTxtXamQ4/6LKSj
	tFuRfIkzy73Hj8uvKG+V+zP93dU1a3+qF+oqJTKiYoLxJfdv1uCg7HkCIJl1w2/8
	bi3iD+EOXXYGhwWq1UGfEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785769654; x=
	1785856054; bh=LCw89qpW+Gg7yOPoB26vTpmWnNAV5jXbKMDv9Up1Lk8=; b=k
	wzGnR96WqeqoWO+t/vDIhvwUQ9qstCln1KcScja/UUZflrc9CN/Q1kMe+vpo90g0
	N6IsEIY1FDIDzRjbwto0JMHwFRtMMaIsK0GmU3qpCb+nidny/3YWDNuP8Fbm4H+W
	BuaDwrQnbok8NGEVE+WUeqt1qriNJrmClrJyXdsw6gHdtClXgWDVb4p965bpdVOo
	IvPDu98I99NZ7jikYUGJxpufawEaclLTYefmD4pDqOVxZ71OJBg/csRPOSwV8R8r
	9Jq0nUaHG4sPYxOXTIxd7PuoS6LbhAaTTALWjll8wViyHMcJZlZVkurtjh16/CBf
	2edZGA9lKjZd6/eKkLMVg==
X-ME-Sender: <xms:tq5wat1g7CIFJk1MpMB-ex-XFKMgSkzVIvaOVVIele14n2jgstZIDA>
    <xme:tq5watY7VRO7Y9h82ZTHL9_uOwucQKjgK5j4fZkFLpOoHVmuIDZW-5Z5D6mVUb5Tq
    w2M8LYVjiJ2heCKqPLlJIq7ww3ZFfVbN3G5KBbtlBxsb4Bc_g>
X-ME-Received: <xmr:tq5walKNyvKORrhaxVLIHj1TNHV-TISIb4aDpolWNEvs6BSgLz3sUdy18VTXQgVweWINz6sOu74fTSLwpvCz9T5KlBADuX9CH_uWJT_dgg1iLL_qtyM>
X-ME-Proxy-Cause: dmFkZTFKNsn2uOSOGAfNsJddI2DrNmFMhKGpqLqNoOzfNmuE7sXscLHyXTPD862jP/25l3
    2aWFTNFrDQV52GInQJRZQ1Q5PsIvUDlLYDqUkxKXUxo3h3fMzMpAD+Qzyx51AoUjMEve+t
    7R5wkJ5OBXr6tAWccGkPWxsCg1Ie2jtH9BN1hCA/1OSasgl3+yHfnWxL84BN+xT6Cbzw/i
    pnvqwjNeqx9dd4VvN/vKaKh888VPoh0iRz3vLP8MWpIKAkZmmQE/Nsnd5muDktAKBUonF9
    vb3jlO2Rf3Z7fp7QtKVzGnZIpcdZjKznbLTSrYdbRJqR9M0HleHxQMTIrc1sFYYX3oXCBW
    uw7FG06vdDMfHYIqEUkyOqlzzB4VqoLA6ESohc4EoB5JTFEzv0IiY9AMIq2OSW4S3kl8mM
    hxN1YUGd+/SIU7XeRGmruukWLNnaP6G6fDWF1S72ShkGi2h7U5Y9GvkM7bqptsNRfqBrV2
    zKwOpBXMW8hRVzqDZHkCu7sjH9Mtlan2v2/ErI6R+7QRKQ8GQ1/jdgK94gRlmC4a1cMQ0+
    k1DDeJE2+pE5ddIK8XGH8xWMEO/xKn/IYUlsEL4vBrdopbkgRJ5kw9gce48xsXKBa9qaXz
    Ld75J86Ocw4ML859Ybfuq32yzDZR5uAGF/A3l8dVH2wiU5rebwi5ebllMymg
X-ME-Proxy: <xmx:tq5wasH2_U1781zv0xgXxH-IBGN9wnwC1TGwyQ24yz8NBYbkP4SQ8g>
    <xmx:tq5wasvsx0b5TwjAax9s38OZ-9JLYGQVzKyjC6q41uL6_gG89WD7GA>
    <xmx:tq5wars40BVkJSGW9j-yoWg28iNPwydP4WD2MRS9ey6ph8SiCps3qQ>
    <xmx:tq5waqAFSL7_GMFBuI0QaxlSi9AEnCGtfalIBoU24tBJj6BSLzLE6g>
    <xmx:tq5wamI_D6qbWCGXONCCYl3N4K1HugpfgwDfCds0MXGQKF97krD7JGpb>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 11:07:33 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
Date: Mon, 03 Aug 2026 17:07:26 +0200
Subject: [PATCH 3/3] Input: xpad - add sdata_check() to xpad360 branches
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-xpadone_packet_fix-v1-3-280da203f15c@kroah.com>
References: <20260803-xpadone_packet_fix-v1-0-280da203f15c@kroah.com>
In-Reply-To: <20260803-xpadone_packet_fix-v1-0-280da203f15c@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Ingo Molnar <mingo@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785769647; l=6496;
 i=griffin@kroah.com; s=20260706; h=from:subject:message-id;
 bh=JBxlXTJ12EuSmrmIEodyxZE6gMq5dEmkQEho9bU+fow=;
 b=1bR7gZsBhq+yFx4ePHjDHBpfeNEAp+XRLX6tG+J5ZGB+GdrPN7qJnpNGIbY33NUOUiWTSUc6n
 en5SOg/A4K1DNFPCgSn2AuXntzXQzkSEeEtPq6xcdwwu5QJUA+MtzyC
X-Developer-Key: i=griffin@kroah.com; a=ed25519;
 pk=Hy1TuVHERdQhLAWwjmxLFNtGj7eEEjaZWPXehAlic5M=

Add the sdata_check() safety wrapper to the xpad360_process_packet() and
xpad360w_process_packet() functions, covering the Xbox 360 wired and
wireless controllers.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
 drivers/input/joystick/xpad.c | 75 +++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 319a4c4a695f..304229782e45 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -891,19 +891,24 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
  */
 
 static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
-				   u16 cmd, unsigned char *data)
+				   u16 cmd, unsigned char *data, u32 len)
 {
+	struct safe_data sdata;
+
+	sdata.data = data;
+	sdata.len = len;
+
 	/* valid pad data */
-	if (data[0] != 0x00)
+	if (sdata_check(&sdata, 0) != 0x00)
 		return;
 
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
 	}
 
 	/*
@@ -915,27 +920,29 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 	if (!(xpad->mapping & MAP_DPAD_TO_BUTTONS) ||
 	    xpad->xtype == XTYPE_XBOX360W) {
 		input_report_abs(dev, ABS_HAT0X,
-				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
+				 !!(sdata_check(&sdata, 2) & 0x08) -
+				 !!(sdata_check(&sdata, 2) & 0x04));
 		input_report_abs(dev, ABS_HAT0Y,
-				 !!(data[2] & 0x02) - !!(data[2] & 0x01));
+				 !!(sdata_check(&sdata, 2) & 0x02) -
+				 !!(sdata_check(&sdata, 2) & 0x01));
 	}
 
 	/* start/back buttons */
-	input_report_key(dev, BTN_START,  data[2] & BIT(4));
-	input_report_key(dev, BTN_SELECT, data[2] & BIT(5));
+	input_report_key(dev, BTN_START,  sdata_check(&sdata, 2) & BIT(4));
+	input_report_key(dev, BTN_SELECT, sdata_check(&sdata, 2) & BIT(5));
 
 	/* stick press left/right */
-	input_report_key(dev, BTN_THUMBL, data[2] & BIT(6));
-	input_report_key(dev, BTN_THUMBR, data[2] & BIT(7));
+	input_report_key(dev, BTN_THUMBL, sdata_check(&sdata, 2) & BIT(6));
+	input_report_key(dev, BTN_THUMBR, sdata_check(&sdata, 2) & BIT(7));
 
 	/* buttons A,B,X,Y,TL,TR and MODE */
-	input_report_key(dev, BTN_A,	data[3] & BIT(4));
-	input_report_key(dev, BTN_B,	data[3] & BIT(5));
-	input_report_key(dev, BTN_X,	data[3] & BIT(6));
-	input_report_key(dev, BTN_Y,	data[3] & BIT(7));
-	input_report_key(dev, BTN_TL,	data[3] & BIT(0));
-	input_report_key(dev, BTN_TR,	data[3] & BIT(1));
-	input_report_key(dev, BTN_MODE,	data[3] & BIT(2));
+	input_report_key(dev, BTN_A,	sdata_check(&sdata, 3) & BIT(4));
+	input_report_key(dev, BTN_B,	sdata_check(&sdata, 3) & BIT(5));
+	input_report_key(dev, BTN_X,	sdata_check(&sdata, 3) & BIT(6));
+	input_report_key(dev, BTN_Y,	sdata_check(&sdata, 3) & BIT(7));
+	input_report_key(dev, BTN_TL,	sdata_check(&sdata, 3) & BIT(0));
+	input_report_key(dev, BTN_TR,	sdata_check(&sdata, 3) & BIT(1));
+	input_report_key(dev, BTN_MODE,	sdata_check(&sdata, 3) & BIT(2));
 
 	if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
 		/* left stick */
@@ -953,11 +960,11 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 
 	/* triggers left/right */
 	if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
-		input_report_key(dev, BTN_TL2, data[4]);
-		input_report_key(dev, BTN_TR2, data[5]);
+		input_report_key(dev, BTN_TL2, sdata_check(&sdata, 4));
+		input_report_key(dev, BTN_TR2, sdata_check(&sdata, 5));
 	} else {
-		input_report_abs(dev, ABS_Z, data[4]);
-		input_report_abs(dev, ABS_RZ, data[5]);
+		input_report_abs(dev, ABS_Z, sdata_check(&sdata, 4));
+		input_report_abs(dev, ABS_RZ, sdata_check(&sdata, 5));
 	}
 
 	input_sync(dev);
@@ -973,7 +980,7 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 		}
 
 		/* mode button down/up */
-		if (data[3] & BIT(2))
+		if (sdata_check(&sdata, 3) & BIT(2))
 			xpad->mode_btn_down_ts = ktime_get_seconds();
 		else
 			xpad->mode_btn_down_ts = 0;
@@ -1019,14 +1026,18 @@ static void xpad_presence_work(struct work_struct *work)
  * 01.1 - Pad state (Bytes 4+) valid
  *
  */
-static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data, u32 len)
 {
 	struct input_dev *dev;
+	struct safe_data sdata;
 	bool present;
 
+	sdata.data = data;
+	sdata.len = len;
+
 	/* Presence change */
-	if (data[0] & 0x08) {
-		present = (data[1] & 0x80) != 0;
+	if (sdata_check(&sdata, 0) & 0x08) {
+		present = (sdata_check(&sdata, 1) & 0x80) != 0;
 
 		if (xpad->pad_present != present) {
 			xpad->pad_present = present;
@@ -1035,13 +1046,13 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 	}
 
 	/* Valid pad data */
-	if (data[1] != 0x1)
+	if (sdata_check(&sdata, 1) != 0x1)
 		return;
 
 	rcu_read_lock();
 	dev = rcu_dereference(xpad->x360w_dev);
-	if (dev)
-		xpad360_process_packet(xpad, dev, cmd, &data[4]);
+	if (dev && len > 4)
+		xpad360_process_packet(xpad, dev, cmd, &data[4], len - 4);
 	rcu_read_unlock();
 }
 
@@ -1262,10 +1273,10 @@ static void xpad_irq_in(struct urb *urb)
 
 	switch (xpad->xtype) {
 	case XTYPE_XBOX360:
-		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
+		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata, urb->actual_length);
 		break;
 	case XTYPE_XBOX360W:
-		xpad360w_process_packet(xpad, 0, xpad->idata);
+		xpad360w_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	case XTYPE_XBOXONE:
 		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);

-- 
2.55.0

