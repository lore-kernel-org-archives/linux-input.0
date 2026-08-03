Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C0371065;
	Mon,  3 Aug 2026 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769654; cv=none; b=OoABTupGsxAPDGgHoylNp6fgKALh3mUJ5OUopmdF/B85dcoGJlwgqSlqoEzxU+exeuJJkqr8mnqZ4+lAlS7Hr0VEEaOM+e3//dXBg6rZ93rRHnK/BsSHrZ9gX6LVNebP8VKrQDWwjEGuW7npzYqMRBkJm26fHrtTE0MVrqWGpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769654; c=relaxed/simple;
	bh=X6oGQpVZgdQv/0fuRfVXzgPV15Ki+qIArWC3froxYwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dbaasARoEUjLWkbRthf7CRjI7bad2EmmlUvmOGy4OQvspkpZmHpPlrx+E4O3O5v4cmabshkwIiFV+HKvIjzU6G507cPJ6vmPdB9cBVNzi2dFp2HrO8D8vk/KXNebG4XET3Vgm7yYdbyM15fubD4+oHXbBVVXMWwlMdV1iPBjMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=SZ5krotB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ur8Z/YdH; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SZ5krotB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ur8Z/YdH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DB0AAEC018E;
	Mon,  3 Aug 2026 11:07:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Aug 2026 11:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785769651;
	 x=1785856051; bh=ApUAsKxBE4w+lfKiY2JD2GIGKL13uUTqRLiVzj0ficI=; b=
	SZ5krotBeNn07czCtM0wl8Hsk7iQPXHWSH2rYXinKvVcXnf8k4fopN13VgI1Ap2h
	EhX8RfAeDi4Bhw4zFVeHbk131v8lAA+jkvijZrx5EQv/U4a0PSj3II5Cpy8e3i5e
	uc0ydYdCJ1EJUHfurGgjkARk0z+TXgEZAZIkFOC67H/XPKzDomp3xOjVRJ/OXEnC
	46ntaMohwiRw7hEemvn1MUa0Mulqz09ClSVPo7KGq92wbJycsEHtoZyeGIRnZjmL
	XNyVRmtWbQKKq/+oDnAuJrxfpsYMkDC7fopiam3yWUOfPaw+oVY5itIqaZKItLQE
	AbViP5bHXvJ3Caay4yxvsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785769651; x=
	1785856051; bh=ApUAsKxBE4w+lfKiY2JD2GIGKL13uUTqRLiVzj0ficI=; b=U
	r8Z/YdHWyw9ZFSxiI/wTheJIMK9mA4Yl+O1bzP7kXxP3zmz52WKlkJCe8kcx4MV5
	R/ULLKb7+OGFjlvs+d4UMf0Eb8iAy1p1L0JXx9GLssQ1tGc89lagnqehlFW7WsE3
	x38cRfJqQvzn8sIwKlBjQIoIQlmJoovIDbyvqWN/BgNdp/i/+gQtBg+7cOMQnxM8
	UggzIcxX0Fo8QeTAfyBH9bCxjC1G9WiQS5Rdmj4exmImlYPwzGnAZpYZADLwvZez
	fSXUwJa2oklIMHikuw9SSrt1jKvD1mBUFPHOOGtJtR9XRUQ7T3w5uCeDIs8t5TnB
	OjlknsxXNiLFJqDr12G7A==
X-ME-Sender: <xms:s65walQJl8bckrwCwkRGpoK8CL6pNUBXOCWKBHFFn6qHO1sDI_btNQ>
    <xme:s65waoHgDZZWj8owqWA4dhL17Oci8zHhw8Ki7Gj_OAJOeX6D9LnoyG6iIgHXMlqGI
    AyMTuiMpB2rHYHci2_B2PMs62_iOsHVCf9iyPuV2phSzlu4yx4>
X-ME-Received: <xmr:s65waiFM_pbUCepLeSUQd1JlfpKNlTVIBzyOHEaPhh7p08bV7roDOcUHDLFcCx7QKCb1ExTEs6RwUuQdsrF4QF0BjPa_f_ePtOF12qhm9_yh66XsVlo>
X-ME-Proxy-Cause: dmFkZTFKNsn2uOSOGAfNsJddI2DrNmFMhKGpqLqNoOzfNmuE7sXscLHyXTPD862jP/25l3
    2aWFTNFrDQV52GInQJRZQ1Q5PsIvUDlLYDqUkxKXUxo3h3fMzMpAD+Qzyx51AoUjMEve+t
    7R5wkJ5OBXr6tAWccGkPWxsCg1Ie2jtH9BN1hCA/1OSasgl3+yHfnWxL84BN+xT6Cbzw/i
    pnvqwjNeqx9dd4VvN/vKaKh888VPoh0iRz3vLP8MWpIKAkZmmQE/Nsnd5muDktAKBUonF9
    vb3jlO2Rf3Z7fp7QtKVzGnZIpcdZjKznbLTSrYdbRJqR9M0HleHxQMTIrc1sFYYX3oXCk7
    Hs0OiTQEtG/9agSBmlU9DRYR2V53rDGY0R/2fDdF4kBxcgB7eAVKBLczZ9tV5MqTzXwMkM
    V4XTQE5rUF7BXVhgLtbLaOBz3d9Jp3O75v2OszwRuCMOlvlwdmgrqL2Stz5RJyvWZiicCG
    uRe2SAs6/NkXbuIf3iEdkh9BxdC2m/hhP8z0MWZa1w5QEldyh19mhKxnm2yebKAWiJr3CS
    LjfJ27WB8cDcjYDuqL35jESYZfVxV4uNPcqIteLLUOXMYGKNV+CWG99It5alEsowZ3m56c
    xg1IeE72HiOAgHWNLF4WjbeOHzrfWDlPiI7nzABp74UUcdZk7BjHbAMZ8QtQ
X-ME-Proxy: <xmx:s65wauQuSB7iOPRk9uTiogU2TFl5Nt-8pTWkX8PnRqRX4kxic4Xa6Q>
    <xmx:s65warJFFb9pfYEXdJSx50CXWZ8QEQ_kiJHPjM7nf3peJzXqHGVz_w>
    <xmx:s65wahadkhNpTv2jAJYNbFQhv-YzOxBoyz0onZpGQRd4bMss8voHmw>
    <xmx:s65wal-CGt633jXcrO_SsFeJHKvG0gfblBWBKrDPCE5CfFL6o4bdZw>
    <xmx:s65waqk8GcMMw0kKLL95y0RTj9HlT0rj86aRS9C2dFGsWvQsN6grq0td>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 11:07:30 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
Date: Mon, 03 Aug 2026 17:07:24 +0200
Subject: [PATCH 1/3] Input: xpad - add safer data access framework
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-xpadone_packet_fix-v1-1-280da203f15c@kroah.com>
References: <20260803-xpadone_packet_fix-v1-0-280da203f15c@kroah.com>
In-Reply-To: <20260803-xpadone_packet_fix-v1-0-280da203f15c@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Ingo Molnar <mingo@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785769647; l=9952;
 i=griffin@kroah.com; s=20260706; h=from:subject:message-id;
 bh=X6oGQpVZgdQv/0fuRfVXzgPV15Ki+qIArWC3froxYwY=;
 b=O6QDpQKZb5nIAlSWmlzalBZod+k9qv3izpNNgxU0ClLBpH9SAg/zwsQKSCtnSiUA9+ZqWBJri
 fLAAwZLU6rrBO1RPL3ZYn8mYk2Vd6qmlY+aBNr0IuFJRi03lOFBIcRx
X-Developer-Key: i=griffin@kroah.com; a=ed25519;
 pk=Hy1TuVHERdQhLAWwjmxLFNtGj7eEEjaZWPXehAlic5M=

USB xpad devices could send short messages which would cause reads and
writes outside of the data buffer.

Fix this by adding the safe_data struct and the sdata_check() function when
accessing packet data for input events, and add the usage of this to
xpadone_process_packet(), which was vulnerable to OOB reads/writes.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
 drivers/input/joystick/xpad.c | 115 ++++++++++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 44 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..c516860711a8 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -780,6 +780,24 @@ struct usb_xpad {
 	bool delayed_init_done;
 };
 
+struct safe_data {
+	unsigned char *data;
+	u32 len;
+};
+
+/*
+ * Safe Data Check
+ *
+ * Returns the correct data when inside the array's bounds,
+ * returns 0 when accessing an out-of-bounds index.
+ */
+static u8 sdata_check(struct safe_data *sdata, int idx)
+{
+	if (idx >= sdata->len)
+		return 0;
+	return sdata->data[idx];
+}
+
 static int xpad_init_input(struct usb_xpad *xpad);
 static void xpad_deinit_input(struct usb_xpad *xpad);
 static int xpad_start_input(struct usb_xpad *xpad);
@@ -1033,41 +1051,45 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data, u32 len)
 {
 	struct input_dev *dev = xpad->dev;
+	struct safe_data sdata;
 	bool do_sync = false;
 
+	sdata.data = data;
+	sdata.len = len;
+
 	/* the xbox button has its own special report */
-	if (data[0] == GIP_CMD_VIRTUAL_KEY) {
+	if (sdata_check(&sdata, 0) == GIP_CMD_VIRTUAL_KEY) {
 		/*
 		 * The Xbox One S controller requires these reports to be
 		 * acked otherwise it continues sending them forever and
 		 * won't report further mode button events.
 		 */
-		if (data[1] == (GIP_OPT_ACK | GIP_OPT_INTERNAL))
-			xpadone_ack_mode_report(xpad, data[2]);
+		if (sdata_check(&sdata, 1) == (GIP_OPT_ACK | GIP_OPT_INTERNAL))
+			xpadone_ack_mode_report(xpad, sdata_check(&sdata, 2));
 
-		input_report_key(dev, BTN_MODE, data[4] & GENMASK(1, 0));
+		input_report_key(dev, BTN_MODE, sdata_check(&sdata, 4) & GENMASK(1, 0));
 		input_sync(dev);
 
 		do_sync = true;
-	} else if (data[0] == GIP_CMD_FIRMWARE) {
+	} else if (sdata_check(&sdata, 0) == GIP_CMD_FIRMWARE) {
 		/* Some packet formats force us to use this separate to poll paddle inputs */
 		if (xpad->packet_type == PKT_XBE2_FW_5_11) {
 			/* Mute paddles if controller is in a custom profile slot
 			 * Checked by looking at the active profile slot to
 			 * verify it's the default slot
 			 */
-			if (data[19] != 0)
+			if (sdata_check(&sdata, 19) != 0)
 				data[18] = 0;
 
 			/* Elite Series 2 split packet paddle bits */
-			input_report_key(dev, BTN_GRIPR, data[18] & BIT(0));
-			input_report_key(dev, BTN_GRIPR2, data[18] & BIT(1));
-			input_report_key(dev, BTN_GRIPL, data[18] & BIT(2));
-			input_report_key(dev, BTN_GRIPL2, data[18] & BIT(3));
+			input_report_key(dev, BTN_GRIPR, sdata_check(&sdata, 18) & BIT(0));
+			input_report_key(dev, BTN_GRIPR2, sdata_check(&sdata, 18) & BIT(1));
+			input_report_key(dev, BTN_GRIPL, sdata_check(&sdata, 18) & BIT(2));
+			input_report_key(dev, BTN_GRIPL2, sdata_check(&sdata, 18) & BIT(3));
 
 			do_sync = true;
 		}
-	} else if (data[0] == GIP_CMD_ANNOUNCE) {
+	} else if (sdata_check(&sdata, 0) == GIP_CMD_ANNOUNCE) {
 		int error;
 
 		if (xpad->delay_init && !xpad->delayed_init_done) {
@@ -1078,44 +1100,49 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 					 "unable to start delayed input: %d\n",
 					 error);
 		}
-	} else if (data[0] == GIP_CMD_INPUT) { /* The main valid packet type for inputs */
+	} else if (sdata_check(&sdata, 0) == GIP_CMD_INPUT) {
+		/* The main valid packet type for inputs */
+
 		/* menu/view buttons */
-		input_report_key(dev, BTN_START,  data[4] & BIT(2));
-		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));
+		input_report_key(dev, BTN_START,  sdata_check(&sdata, 4) & BIT(2));
+		input_report_key(dev, BTN_SELECT, sdata_check(&sdata, 4) & BIT(3));
 		if (xpad->mapping & MAP_SHARE_BUTTON) {
 			u32 offset = (xpad->mapping & MAP_SHARE_OFFSET) ? 26 : 18;
 
 			if (len >= offset)
-				input_report_key(dev, KEY_RECORD, data[len - offset] & BIT(0));
+				input_report_key(dev, KEY_RECORD,
+						 sdata_check(&sdata, len - offset) & BIT(0));
 		}
 
 		/* buttons A,B,X,Y */
-		input_report_key(dev, BTN_A,	data[4] & BIT(4));
-		input_report_key(dev, BTN_B,	data[4] & BIT(5));
-		input_report_key(dev, BTN_X,	data[4] & BIT(6));
-		input_report_key(dev, BTN_Y,	data[4] & BIT(7));
+		input_report_key(dev, BTN_A,	sdata_check(&sdata, 4) & BIT(4));
+		input_report_key(dev, BTN_B,	sdata_check(&sdata, 4) & BIT(5));
+		input_report_key(dev, BTN_X,	sdata_check(&sdata, 4) & BIT(6));
+		input_report_key(dev, BTN_Y,	sdata_check(&sdata, 4) & BIT(7));
 
 		/* digital pad */
 		if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
 			/* dpad as buttons (left, right, up, down) */
-			input_report_key(dev, BTN_DPAD_LEFT, data[5] & BIT(2));
-			input_report_key(dev, BTN_DPAD_RIGHT, data[5] & BIT(3));
-			input_report_key(dev, BTN_DPAD_UP, data[5] & BIT(0));
-			input_report_key(dev, BTN_DPAD_DOWN, data[5] & BIT(1));
+			input_report_key(dev, BTN_DPAD_LEFT, sdata_check(&sdata, 5) & BIT(2));
+			input_report_key(dev, BTN_DPAD_RIGHT, sdata_check(&sdata, 5) & BIT(3));
+			input_report_key(dev, BTN_DPAD_UP, sdata_check(&sdata, 5) & BIT(0));
+			input_report_key(dev, BTN_DPAD_DOWN, sdata_check(&sdata, 5) & BIT(1));
 		} else {
 			input_report_abs(dev, ABS_HAT0X,
-					!!(data[5] & 0x08) - !!(data[5] & 0x04));
+					!!(sdata_check(&sdata, 5) & 0x08) -
+					!!(sdata_check(&sdata, 5) & 0x04));
 			input_report_abs(dev, ABS_HAT0Y,
-					!!(data[5] & 0x02) - !!(data[5] & 0x01));
+					!!(sdata_check(&sdata, 5) & 0x02) -
+					!!(sdata_check(&sdata, 5) & 0x01));
 		}
 
 		/* TL/TR */
-		input_report_key(dev, BTN_TL,	data[5] & BIT(4));
-		input_report_key(dev, BTN_TR,	data[5] & BIT(5));
+		input_report_key(dev, BTN_TL,	sdata_check(&sdata, 5) & BIT(4));
+		input_report_key(dev, BTN_TR,	sdata_check(&sdata, 5) & BIT(5));
 
 		/* stick press left/right */
-		input_report_key(dev, BTN_THUMBL, data[5] & BIT(6));
-		input_report_key(dev, BTN_THUMBR, data[5] & BIT(7));
+		input_report_key(dev, BTN_THUMBL, sdata_check(&sdata, 5) & BIT(6));
+		input_report_key(dev, BTN_THUMBR, sdata_check(&sdata, 5) & BIT(7));
 
 		if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
 			/* left stick */
@@ -1146,7 +1173,7 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 
 		/* Profile button has a value of 0-3, so it is reported as an axis */
 		if (xpad->mapping & MAP_PROFILE_BUTTON)
-			input_report_abs(dev, ABS_PROFILE, data[34]);
+			input_report_abs(dev, ABS_PROFILE, sdata_check(&sdata, 34));
 
 		/* paddle handling */
 		/* based on SDL's SDL_hidapi_xboxone.c */
@@ -1160,38 +1187,38 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 					data[32] = 0;
 
 				/* OG Elite Series Controller paddle bits */
-				input_report_key(dev, BTN_GRIPR, data[32] & BIT(1));
-				input_report_key(dev, BTN_GRIPR2, data[32] & BIT(3));
-				input_report_key(dev, BTN_GRIPL, data[32] & BIT(0));
-				input_report_key(dev, BTN_GRIPL2, data[32] & BIT(2));
+				input_report_key(dev, BTN_GRIPR, sdata_check(&sdata, 32) & BIT(1));
+				input_report_key(dev, BTN_GRIPR2, sdata_check(&sdata, 32) & BIT(3));
+				input_report_key(dev, BTN_GRIPL, sdata_check(&sdata, 32) & BIT(0));
+				input_report_key(dev, BTN_GRIPL2, sdata_check(&sdata, 32) & BIT(2));
 			} else if (xpad->packet_type == PKT_XBE2_FW_OLD) {
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
 				 */
-				if (data[19] != 0)
+				if (sdata_check(&sdata, 19) != 0)
 					data[18] = 0;
 
 				/* Elite Series 2 4.x firmware paddle bits */
-				input_report_key(dev, BTN_GRIPR, data[18] & BIT(0));
-				input_report_key(dev, BTN_GRIPR2, data[18] & BIT(1));
-				input_report_key(dev, BTN_GRIPL, data[18] & BIT(2));
-				input_report_key(dev, BTN_GRIPL2, data[18] & BIT(3));
+				input_report_key(dev, BTN_GRIPR, sdata_check(&sdata, 18) & BIT(0));
+				input_report_key(dev, BTN_GRIPR2, sdata_check(&sdata, 18) & BIT(1));
+				input_report_key(dev, BTN_GRIPL, sdata_check(&sdata, 18) & BIT(2));
+				input_report_key(dev, BTN_GRIPL2, sdata_check(&sdata, 18) & BIT(3));
 			} else if (xpad->packet_type == PKT_XBE2_FW_5_EARLY) {
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
 				 */
-				if (data[23] != 0)
+				if (sdata_check(&sdata, 23) != 0)
 					data[22] = 0;
 
 				/* Elite Series 2 5.x firmware paddle bits
 				 * (before the packet was split)
 				 */
-				input_report_key(dev, BTN_GRIPR, data[22] & BIT(0));
-				input_report_key(dev, BTN_GRIPR2, data[22] & BIT(1));
-				input_report_key(dev, BTN_GRIPL, data[22] & BIT(2));
-				input_report_key(dev, BTN_GRIPL2, data[22] & BIT(3));
+				input_report_key(dev, BTN_GRIPR, sdata_check(&sdata, 22) & BIT(0));
+				input_report_key(dev, BTN_GRIPR2, sdata_check(&sdata, 22) & BIT(1));
+				input_report_key(dev, BTN_GRIPL, sdata_check(&sdata, 22) & BIT(2));
+				input_report_key(dev, BTN_GRIPL2, sdata_check(&sdata, 22) & BIT(3));
 			}
 		}
 

-- 
2.55.0

