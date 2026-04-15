Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A837BE96
	for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253684; cv=none; b=rcGLi4q8ZFjHCgvv0i/PvD8YrSKEeqXARQCz5itBDO78Creg20yLlLfh0J14WyrYdXvWo5WUS0Y2ss1yGJRNalF2/K8Z8r4zemQpxP58HpJR7fWfPmIOe5NFRHBFoHAZw0TR97VrT4VB6HbrKsRSmoTnESKfAYWtn9PmQ2BmPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253684; c=relaxed/simple;
	bh=wYBYWS0U3wn+JrPKpLtSjLr8wl2VYLOC3vTu/H5RgJ0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qsaMvPgh9ErO6IXIhgFAozD5RZjZMoz7f9395VVTABcH8Zr97uxF6BKDzWRTA/9vG4ARxsLpedxo1nZ7FCvbeFN8TrxBiPTVqNKhjpqjog6VfA6UtpX2oRSByg+US1zMRPks2rX7+HP5Wnrr7vCC4ZRFythoCQ95jCxKkZOuNOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzzQ0EgW; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzzQ0EgW"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488d6ebe9cfso42440895e9.2
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 04:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776253682; x=1776858482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lP3RjDHSPzb1NPTjUWSB2m8qqv8z9lgjkWSUnxmWGgM=;
        b=pzzQ0EgWxtT2kR2LjQW2dsV2LoCAh+7SLcufSfzCtuhYqvGqVCwLQIQGjnjL6YvCeZ
         HDMCKrvnK2RjLCI4m0X6OqSIFM0G/Ugv8JQHmR3ZOcz3ScEJ75h1I+lYsPWLlc2tbMip
         MxXKEzEma/hZml6vSi8q6P650WssvpSV8FWlagxMX6w2y+/Ae5UYMN6NJ2uLscXxXh6w
         LuqisoL0EuoU27iv59Vsoh86//jZKZEcWV2h9F28i3VKDiPfSxhvk+Zs9qzmLCRugtvh
         IZoPoT/iR9BProX8ytShB8mbKWBAbQSKKTjQWvenWtJ0SjFcvl5IZD94aOFf1F+pg2sW
         koaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776253682; x=1776858482;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP3RjDHSPzb1NPTjUWSB2m8qqv8z9lgjkWSUnxmWGgM=;
        b=n7gvfubzXUChr+0nqQWTYdHpUFOGpz8a4WEFZfjloAYRcjHRk1xA18aSwV/spgD1Y3
         QQGmVyjfXTstd+3opEtg0JENpXj5pu7UrySBiwORCsSo6BxUWPFFysxd1cYxUDVXjBrV
         nQFaoPovanNSyeFL8VoRTTuL0YKZlyilHxSLqCFjkRO2J2H3ddL8dyNYiQ0+J0dKBy4X
         K7489mejb4XB583VIhneKPGzCLHz2dCBLM2fL0giQrUR9Cp7elnjcfFgzzjkFoOf6sC3
         0/hFAdx2IfGUOF+IWly/ePs+vwl0EhMMUto8vdKjwrOyDfSlqM+KkFJDid1gncZNnG6q
         W9fg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ekc+zDNSFWpruf0SK78yTp9zJjP8uX7f1D+H6vkxQ2vU6TDx5/CKiFEtBh1WT7BaEi83C3GIZplJZiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRkA7hAOuSRUfr/1foEINpcC8guF5baKPi94Xxlrud8pzllOkq
	vkb5arIDlt+9k3HwifqCbicvI/kbJxJtmvTHo9WtdryM4GTKF6FKvmn7HHbcjku+HcJN6IOzss4
	LqDM0S6SuKA==
X-Received: from wmpz8.prod.google.com ([2002:a05:600c:a08:b0:485:3a2f:2f7e])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3acf:b0:485:35a4:939f
 with SMTP id 5b1f17b1804b1-488d68a8275mr254811245e9.28.1776253681593; Wed, 15
 Apr 2026 04:48:01 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:47:51 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260415114752.1181079-1-bsevens@google.com>
Subject: [PATCH] HID: mcp2221: Fix heap buffer overflow in mcp2221_raw_event()
From: Benoit Sevens <bsevens@google.com>
To: Rishi Gupta <gupt21@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Beno=C3=AEt Sevens <bsevens@google.com>

A heap buffer overflow can occur in the mcp2221_raw_event() function
when handling I2C read responses. The driver failed to check if the
total incoming data length fits within the originally allocated buffer
`mcp->rxbuf`.

Fix this by introducing `rxbuf_len` to `struct mcp2221` to keep track
of the allocated buffer size. Initialize it in `mcp_i2c_smbus_read()`
and `mcp_smbus_xfer()`, and ensure the copied data length combined with
the current index does not exceed this length in `mcp2221_raw_event()`.

Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
---
 drivers/hid/hid-mcp2221.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index ef3b5c77c38e..744561e65079 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -119,6 +119,7 @@ struct mcp2221 {
 	struct completion wait_in_report;
 	struct delayed_work init_work;
 	u8 *rxbuf;
+	int rxbuf_len;
 	u8 txbuf[64];
 	int rxbuf_idx;
 	int status;
@@ -323,12 +324,14 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 		mcp->txbuf[3] =3D (u8)(msg->addr << 1);
 		total_len =3D msg->len;
 		mcp->rxbuf =3D msg->buf;
+		mcp->rxbuf_len =3D msg->len;
 	} else {
 		mcp->txbuf[1] =3D smbus_len;
 		mcp->txbuf[2] =3D 0;
 		mcp->txbuf[3] =3D (u8)(smbus_addr << 1);
 		total_len =3D smbus_len;
 		mcp->rxbuf =3D smbus_buf;
+		mcp->rxbuf_len =3D smbus_len;
 	}
=20
 	ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, 4);
@@ -538,6 +541,7 @@ static int mcp_smbus_xfer(struct i2c_adapter *adapter, =
u16 addr,
=20
 			mcp->rxbuf_idx =3D 0;
 			mcp->rxbuf =3D data->block;
+			mcp->rxbuf_len =3D sizeof(data->block);
 			mcp->txbuf[0] =3D MCP2221_I2C_GET_DATA;
 			ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, 1);
 			if (ret)
@@ -561,6 +565,7 @@ static int mcp_smbus_xfer(struct i2c_adapter *adapter, =
u16 addr,
=20
 			mcp->rxbuf_idx =3D 0;
 			mcp->rxbuf =3D data->block;
+			mcp->rxbuf_len =3D sizeof(data->block);
 			mcp->txbuf[0] =3D MCP2221_I2C_GET_DATA;
 			ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, 1);
 			if (ret)
@@ -908,7 +913,9 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 			}
 			if (data[2] =3D=3D MCP2221_I2C_READ_COMPL ||
 			    data[2] =3D=3D MCP2221_I2C_READ_PARTIAL) {
-				if (!mcp->rxbuf || mcp->rxbuf_idx < 0 || data[3] > 60) {
+				if (!mcp->rxbuf || mcp->rxbuf_idx < 0 ||
+				    data[3] > 60 ||
+				    mcp->rxbuf_idx + data[3] > mcp->rxbuf_len) {
 					mcp->status =3D -EINVAL;
 					break;
 				}
--=20
2.54.0.rc0.605.g598a273b03-goog

