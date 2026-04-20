Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9502333445;
	Mon, 20 Apr 2026 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701588; cv=none; b=kyXeCjjL9ESjdMvtY+rYZdbVQoY+iRIR8Gupg/sjDegF0gaDNg96jwLcXXEiT2MYOfa5b4CgUcKGK0SRGHr7Jf5Z9Rsb6BRFYWnRzaChrOviPePikC6ew6qgm0GvszOoP3p9hRW54syJrdPF4rOrzt1CfCa6abmmWWLjEKf7nt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701588; c=relaxed/simple;
	bh=klhWlSVxK5e64Yga79ZW1PO44jlWsBsHK3f0lIx9i6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dtvJcKmkU27A1ksSnUiLrAHCPv88iZsuLsbeWpKh0Uzc6hGuVUdO6n4DFPvNTF6lK6Vm9vQIVZhL28s6HFwMd0jUfvdgtM3TcdDRAOHNrJf2IhdNIlD+edNB4sgFtD6Zw1Lhc7kGJ8gGPMI1YXC06SKB4ZYaLQq9VG1vn4NhLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j8/xbm04; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j8/xbm04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80535C19425;
	Mon, 20 Apr 2026 16:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701587;
	bh=klhWlSVxK5e64Yga79ZW1PO44jlWsBsHK3f0lIx9i6A=;
	h=From:To:Cc:Subject:Date:From;
	b=j8/xbm04JmOggS+ksgP6ftIonFwn5CYlmNGqwTFbXgAIg1pftmOdsK+0ZHfNu0wYE
	 kgqA4b1RZugJu1qWwcvqucwcHVMsz/wYfEInOFN6Qg98XokW/xTyK1psd/mLdQP4rg
	 mgBlh+k1GmEvUzt+RZlBK6cTnX8mMwL+ExEd9TfM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH] Input: xpad - reject short Xbox One packets before len-relative share-button index
Date: Mon, 20 Apr 2026 17:53:15 +0200
Message-ID: <2026042014-freestyle-deluxe-48e4@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=klhWlSVxK5e64Yga79ZW1PO44jlWsBsHK3f0lIx9i6A=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnPvF9vm5wiUv25dLLZreUz2I4tT4+Q7w3J8DWx+V8bu 5XpfahPRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExEZhHD/PSI9o1KP3/c+MG9 sd9s/aHzZz+KTGCYZ2Z1XtPJQ2ZbwO6Lr06U/fuSZvrEHAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

xpadone_process_packet() receives len directly from urb->actual_length
and uses it to index the share-button byte at data[len - 18] or
data[len - 26].  Since both len and data[0] are under the device's
control, a broken controller can send a GIP_CMD_INPUT packet with
actual_length < 18 (e.g. 5 bytes) and reach this code path, causing
accesses beyond the actual array.

Since len is u32, 5 - 26 wraps to 0xFFFFFFEB, and data[0xFFFFFFEB] can
dereference about 4 GiB past the 64-byte usb_alloc_coherent() idata
buffer.  On a KASAN system this is an immediate splat otherwise the read
will either fault on an unmapped page (DoS) or pull a bit from arbitrary
kernel memory and report it as KEY_RECORD.

Fix this all up by properly bounds checking the value provided by the
device.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: 4ef46367073b ("Input: xpad - fix Share button on Xbox One controllers")
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/joystick/xpad.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d6fc3d6006bb..7d99fe0ecf91 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1110,10 +1110,13 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 		input_report_key(dev, BTN_START,  data[4] & BIT(2));
 		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));
 		if (xpad->mapping & MAP_SHARE_BUTTON) {
-			if (xpad->mapping & MAP_SHARE_OFFSET)
-				input_report_key(dev, KEY_RECORD, data[len - 26] & BIT(0));
-			else
-				input_report_key(dev, KEY_RECORD, data[len - 18] & BIT(0));
+			if (xpad->mapping & MAP_SHARE_OFFSET) {
+				if (len >= 26)
+					input_report_key(dev, KEY_RECORD, data[len - 26] & BIT(0));
+			} else {
+				if (len >= 18)
+					input_report_key(dev, KEY_RECORD, data[len - 18] & BIT(0));
+			}
 		}
 
 		/* buttons A,B,X,Y */
-- 
2.53.0

