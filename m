Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E95341660
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311067; cv=none; b=ObZgdB4tVTjjD2Cyem2P9A+9uknfBC2R5mxd1VF0Mt53hqqLhVVsQtXCAfkeRNX84w9y6h0gSW4aHkNXH9RovngD+ejS1HaM9dF9BDsvAYT20yOe8ATWPcUtV+o5qDoSdWShEGx+mSo566wQHVg1bHzXJzePUeU5Y9hxZFd8Qy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311067; c=relaxed/simple;
	bh=/DVHQ1Dua5ZtPJp1SdwcuYv6UIR33ObO/aQIbPJvfdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze0C43ii/rU9VP5WP2IfirjtBwcaHW6YgIEKwGMrJkVPx80Mrbwwv5U6jgCoUCoI5x4794EfFAYgghi7jaUmKPvVBK2lcMDKZoNjJm+nhgjPT41W4VKOJ9PyKWEcT9Q1vdak9qjrfE9VrPDrU38FfM6yOKo2IDPxdIQcQ3pTf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=RcL63LUR; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="RcL63LUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1788311059; bh=/DVHQ1Dua5ZtPJp1SdwcuYv6UIR33ObO/aQIbPJvfdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RcL63LUR7+qw/jCrvTwHGntV90HzpbJYWoQjrkqMHXKTFF22EVL2c8NSILSnPtLsu
	 XkXrBw9Bg0Q3ghW0yDXtzt+AQreD7Z+MJxJQoHoRcJR+VEovGjGmh+e0V7T2qtRip+
	 Df8PN/hhWAyHobMblBnq9IF2kkN/uWMwHpmscMn2svTmTq8Mpt8sGm2ySdiT9kmx7u
	 jqOCeULxCX6ngtY084etfhKI9SDfOW5T2cS8lJNcCKY8/8v2O01YLfdsvDYP2Mx3JW
	 eNcecLvbufdevE8NeKM6qNbWhxVUEzTrTuknK9QVrwocM3b92DCouKSJRuIL0R5oPx
	 MIK2Zo9r5qOkw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 19FDD132035;
	Tue, 01 Sep 2026 18:04:19 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 06/12] Input: xbox_gip - Allow sending fragmented and ACME messages
Date: Tue,  1 Sep 2026 18:02:27 -0700
Message-ID: <20260902010237.865772-7-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902010237.865772-1-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GIP supports sending messages that exceed the length of the MTU using a
fragmented message flow. It sits on top of a reliable message transmission
flow, which uses the ACME flag to signal that a message must be ACKed if it
is received properly. We already supported receiving and coalescing these
messages, but the ability to send them wasn't yet present due to not
needing it for basic usage. This patch adds it for future use with the
security flow.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/input/joystick/gip/gip-core.c | 330 ++++++++++++++++++++++++--
 drivers/input/joystick/gip/gip.h      |  17 ++
 2 files changed, 330 insertions(+), 17 deletions(-)

diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 57d638408daf..544becf8badd 100644
--- a/drivers/input/joystick/gip/gip-core.c
+++ b/drivers/input/joystick/gip/gip-core.c
@@ -8,7 +8,6 @@
  * - Audio device support
  * - Security packet handshake
  * - Event logging
- * - Sending fragmented messages
  * - Raw character device
  * - Wheel support
  * - Flight stick support
@@ -28,6 +27,7 @@
 #define GIP_WIRED_INTF_DATA 0
 #define GIP_WIRED_INTF_AUDIO 1
 
+#define GIP_DUAL_LENGTH 6
 #define MAX_MESSAGE_LENGTH 0x4000
 
 #define MAX_AUDIO_MESSAGES 9
@@ -437,6 +437,13 @@ static uint8_t gip_sequence_next(struct gip_attachment *attachment,
 	return seq;
 }
 
+static unsigned int gip_fragment_id(const struct gip_attachment *attachment,
+	const struct gip_out_fragment *fragment)
+{
+	return BIT(attachment->attachment_index * MAX_OUT_FRAGMENTS +
+		(unsigned) (fragment - attachment->out_fragments));
+}
+
 static void gip_handle_quirks_array(struct gip_attachment *attachment,
 	const struct gip_quirks *quirks)
 {
@@ -479,6 +486,42 @@ static void gip_handle_quirks(struct gip_attachment *attachment)
 		gip_handle_quirks_array(attachment, attachment->driver->quirks);
 }
 
+static struct gip_out_fragment *gip_find_fragment(struct gip_attachment *attachment,
+	uint8_t message_type, uint8_t flags, uint8_t seq, bool strict)
+{
+	int i;
+
+	for (i = 0; i < MAX_OUT_FRAGMENTS; i++) {
+		if (!attachment->out_fragments[i].active)
+			continue;
+		if (attachment->out_fragments[i].message != message_type)
+			continue;
+		if ((attachment->out_fragments[i].flags ^ flags) & GIP_FLAG_SYSTEM)
+			continue;
+		if (attachment->out_fragments[i].seq != seq) {
+			if (strict)
+				continue;
+
+			/*
+			 * Found one with  the wrong sequence number. For some
+			 * reason the official driver allows this.
+			 */
+			gip_warn(attachment,
+				"Found fragment with different sequence number %02x, wanted %02x\n",
+				attachment->out_fragments[i].seq, seq);
+		}
+
+		return &attachment->out_fragments[i];
+	}
+	return NULL;
+}
+
+static void gip_free_fragment(struct gip_out_fragment *fragment)
+{
+	kfree(fragment->data);
+	memset(fragment, 0, sizeof(*fragment));
+}
+
 static int gip_send_raw_message(struct gip_attachment *attachment,
 	uint8_t message_type, uint8_t flags, uint8_t seq, const uint8_t *bytes,
 	int num_bytes)
@@ -486,20 +529,25 @@ static int gip_send_raw_message(struct gip_attachment *attachment,
 	struct gip_interface *intf;
 	int offset = 3;
 	struct gip_urb *urb = NULL;
+	struct gip_out_fragment *fragment = NULL;
 	int i;
 	int rc = 0;
+	int mtu = gip_data_class_mtu[message_type >> GIP_DATA_CLASS_SHIFT];
+	int reduced_mtu = mtu - GIP_DUAL_LENGTH;
+	/*
+	 * This buffer size shouldn't need to be more than 6 (there should never
+	 * be more than 3 length bytes), but add enough extra to fit fully
+	 * extended bignums for 32 bit (5 bytes) + 16 bit (3 bytes) values to be
+	 * safe and then WARN_ON if we go over. If this ever happens it would be
+	 * due to driver bugs.
+	 */
+	uint8_t header[11];
 
 	if (num_bytes < 0) {
 		gip_warn(attachment, "Invalid message length %d\n", num_bytes);
 		return -EINVAL;
 	}
 
-	if (num_bytes + 6 > gip_data_class_mtu[message_type >> GIP_DATA_CLASS_SHIFT]) {
-		gip_err(attachment,
-			"Attempted to send a message that requires fragmenting, which is not yet supported.\n");
-		return -EOPNOTSUPP;
-	}
-
 	if ((message_type & GIP_DATA_CLASS_MASK) == GIP_DATA_CLASS_AUDIO)
 		intf = &attachment->device->audio;
 	else
@@ -511,6 +559,90 @@ static int gip_send_raw_message(struct gip_attachment *attachment,
 		return -EOPNOTSUPP;
 	}
 
+	header[0] = message_type;
+	header[2] = seq;
+
+	if (num_bytes > reduced_mtu ||
+		(flags & (GIP_FLAG_ACME | GIP_FLAG_FRAGMENT)) == GIP_FLAG_ACME) {
+		for (i = 0; i < MAX_OUT_FRAGMENTS; i++) {
+			if (attachment->out_fragments[i].active)
+				continue;
+
+			fragment = &attachment->out_fragments[i];
+			break;
+		}
+
+		if (!fragment) {
+			gip_err(attachment, "Fragmented message queue is full; dropping message\n");
+			return -EALREADY;
+		}
+
+		fragment->data = kmalloc(num_bytes, GFP_KERNEL);
+		if (!fragment->data)
+			return -ENOMEM;
+		fragment->active = true;
+		fragment->message = message_type;
+		fragment->flags = flags & GIP_FLAG_SYSTEM;
+		fragment->acked = false;
+		fragment->seq = seq;
+		fragment->total_length = num_bytes;
+		fragment->fragment_offset = 0;
+		memcpy(fragment->data, bytes, num_bytes);
+		bytes = fragment->data;
+
+		if (num_bytes > reduced_mtu) {
+			gip_dbg(attachment, "Starting new reliable message: %02x%02x%02x, total length %u\n",
+				message_type, flags, seq, num_bytes);
+			flags |= GIP_FLAG_INIT_FRAG | GIP_FLAG_FRAGMENT | GIP_FLAG_ACME;
+			fragment->flags |= GIP_FLAG_FRAGMENT;
+			/* The spec says to extend the value to fit in 3 bytes */
+			offset += gip_encode_length(reduced_mtu, &header[offset], sizeof(header));
+			if (offset == 4 && reduced_mtu < 0x80 && num_bytes < 0x80) {
+				header[3] |= 0x80;
+				header[4] = 0;
+				offset = 5;
+			}
+			offset += gip_encode_length(num_bytes, &header[offset],
+				sizeof(header) - offset);
+			WARN_ON(offset != GIP_DUAL_LENGTH);
+			num_bytes = mtu - offset;
+		} else {
+			offset += gip_encode_length(num_bytes, &header[offset],
+				sizeof(header) - offset);
+		}
+	} else if (flags & GIP_FLAG_FRAGMENT) {
+		fragment = gip_find_fragment(attachment, message_type, flags, seq, true);
+		if (!fragment) {
+			gip_err(attachment,
+				"Attempted to send message fragment with no associated message\n");
+			return -EINVAL;
+		}
+
+		num_bytes = min(reduced_mtu, fragment->total_length - fragment->fragment_offset);
+		offset += gip_encode_length(num_bytes, &header[offset],
+			sizeof(header) - offset);
+		if (offset == 4 && num_bytes < 0x80 && fragment->fragment_offset < 0x80) {
+			header[3] |= 0x80;
+			header[4] = 0;
+			offset = 5;
+		}
+		offset += gip_encode_length(fragment->fragment_offset, &header[offset],
+			sizeof(header) - offset);
+		WARN_ON(offset != GIP_DUAL_LENGTH);
+
+		if (num_bytes && fragment->fragment_offset + num_bytes == fragment->total_length) {
+			/* The final fragment in a fragmented message must be ACKed */
+			flags |= GIP_FLAG_ACME;
+			fragment->acked = false;
+		}
+		bytes = &fragment->data[fragment->fragment_offset];
+	} else if (num_bytes >= 0) {
+		offset += gip_encode_length(num_bytes, &header[offset],
+			sizeof(header) - offset);
+	}
+
+	header[1] = flags;
+
 	guard(spinlock_irqsave)(&attachment->device->message_lock);
 	for (i = 0; i < MAX_OUT_MESSAGES && !urb; i++) {
 		if (!intf->out_queue[i].urb)
@@ -520,17 +652,13 @@ static int gip_send_raw_message(struct gip_attachment *attachment,
 	}
 	if (!urb) {
 		gip_err(attachment, "Output queue is full; dropping message\n");
-		return -ENOSPC;
+		rc = -ENOSPC;
+		goto err_free_fragment;
 	}
-	urb->data[0] = message_type;
-	urb->data[1] = flags;
-	urb->data[2] = seq;
-	offset += gip_encode_length(num_bytes, &urb->data[offset],
-		sizeof(urb->data) - offset);
 
+	memcpy(urb->data, header, offset);
 	if (num_bytes > 0)
 		memcpy(&urb->data[offset], bytes, num_bytes);
-
 	num_bytes += offset;
 	urb->urb->transfer_buffer_length = num_bytes;
 
@@ -545,9 +673,96 @@ static int gip_send_raw_message(struct gip_attachment *attachment,
 			__func__, rc);
 		usb_unanchor_urb(urb->urb);
 		rc = -EIO;
+		goto err_free_fragment;
+	}
+
+	if (fragment) {
+		/*
+		 * Sending further fragments is handled in gip_urb_out if this fragment doesn't need
+		 * ACKing or in gip_handle_command_protocol_control if it does. The flag should also
+		 * be cleared if we're done sending this packet.
+		 */
+		if (fragment->total_length > reduced_mtu && !(flags & GIP_FLAG_ACME))
+			intf->has_pending_out |= gip_fragment_id(attachment, fragment);
+		else
+			intf->has_pending_out &= ~gip_fragment_id(attachment, fragment);
 	}
 
 	return rc;
+
+err_free_fragment:
+	gip_free_fragment(fragment);
+	return rc;
+}
+
+static int gip_send_next_fragment(struct gip_attachment *attachment,
+	struct gip_out_fragment *fragment)
+{
+	struct gip_interface *intf;
+	int next_bytes;
+	int flags = GIP_FLAG_FRAGMENT | fragment->flags | attachment->attachment_index;
+	int mtu;
+	int rc;
+
+	mtu = gip_data_class_mtu[fragment->message >> GIP_DATA_CLASS_SHIFT] - GIP_DUAL_LENGTH;
+	if (fragment->fragment_offset == fragment->total_length) {
+		if ((fragment->message & GIP_DATA_CLASS_MASK) == GIP_DATA_CLASS_AUDIO)
+			intf = &attachment->device->audio;
+		else
+			intf = &attachment->device->data;
+
+		next_bytes = 0;
+		intf->has_pending_out &= ~gip_fragment_id(attachment, fragment);
+	} else if (fragment->fragment_offset + mtu >= fragment->total_length) {
+		next_bytes = fragment->total_length - fragment->fragment_offset;
+		flags |= GIP_FLAG_ACME;
+	} else {
+		next_bytes = mtu;
+	}
+
+	rc = gip_send_raw_message(attachment, fragment->message, flags,
+		fragment->seq, &fragment->data[fragment->fragment_offset],
+		next_bytes);
+
+	if (rc < 0)
+		return rc;
+
+	if (fragment->acked)
+		fragment->fragment_offset += next_bytes;
+	if (next_bytes == 0 && !(fragment->flags & GIP_FLAG_ACME))
+		/* Finished sending the message */
+		gip_free_fragment(fragment);
+	return next_bytes;
+}
+
+static void gip_send_fragment_work(struct work_struct *work)
+{
+	struct gip_interface *intf = container_of(work, struct gip_interface, send_fragment);
+	struct gip_out_fragment *fragment;
+	unsigned int has_pending_out;
+	unsigned long flags;
+	int i, j;
+
+	spin_lock_irqsave(&intf->device->message_lock, flags);
+	has_pending_out = intf->has_pending_out;
+	spin_unlock_irqrestore(&intf->device->message_lock, flags);
+	for (i = 0; i < MAX_ATTACHMENTS; i++) {
+		struct gip_attachment *attachment = intf->device->attachments[i];
+
+		for (j = 0; j < MAX_OUT_FRAGMENTS; j++) {
+			/* Check for pending output fragments */
+			if (!(has_pending_out & BIT(i * MAX_OUT_FRAGMENTS + j)))
+				continue;
+
+			guard(mutex)(&attachment->lock);
+			fragment = &attachment->out_fragments[j];
+			if (!fragment->active)
+				continue;
+			if (!(fragment->flags & GIP_FLAG_FRAGMENT))
+				continue;
+			gip_send_next_fragment(attachment, fragment);
+		}
+	}
 }
 
 int gip_send_system_message(struct gip_attachment *attachment,
@@ -1659,6 +1874,8 @@ static int gip_ensure_metadata(struct gip_attachment *attachment)
 
 static void gip_reset_attachment(struct gip_attachment *attachment)
 {
+	int i;
+
 	cancel_delayed_work(&attachment->metadata_next);
 	cancel_delayed_work(&attachment->in_fragment_timeout);
 
@@ -1668,15 +1885,84 @@ static void gip_reset_attachment(struct gip_attachment *attachment)
 		attachment->in_fragment_message = -1;
 	}
 
+	for (i = 0; i < MAX_OUT_FRAGMENTS; i++) {
+		if (attachment->out_fragments[i].active)
+			gip_free_fragment(&attachment->out_fragments[i]);
+	}
+
 	gip_free_devices(attachment);
+
 }
 
 static int gip_handle_command_protocol_control(struct gip_attachment *attachment,
 	const struct gip_header *header, const uint8_t *bytes, int num_bytes)
 {
-	/* TODO */
-	gip_warn(attachment, "Unimplemented Protocol Control message\n");
-	return -EOPNOTSUPP;
+	const struct gip_protocol_control_ack *ack;
+	struct gip_out_fragment *fragment = NULL;
+	uint32_t fragment_offset;
+	uint16_t remaining_buffer;
+	bool ok = true;
+	int mtu;
+	int rc;
+
+	if (num_bytes < 1)
+		return -EINVAL;
+
+	if (bytes[0] != GIP_CONTROL_CODE_ACK) {
+		gip_warn(attachment, "Unimplemented Protocol Control code %i message\n", bytes[0]);
+		return -EOPNOTSUPP;
+	}
+
+	if (num_bytes < sizeof(*ack))
+		return -EINVAL;
+
+	ack = (const struct gip_protocol_control_ack *)bytes;
+
+	fragment = gip_find_fragment(attachment, ack->message_type, ack->flags,
+		header->sequence_id, false);
+	if (!fragment) {
+		gip_warn(attachment, "Received ACK for unknown message\n");
+		rc = -EINVAL;
+		goto resend;
+	}
+
+
+	fragment_offset = le32_to_cpu(ack->fragment_offset);
+	remaining_buffer = le16_to_cpu(ack->remaining_buffer);
+
+	if (fragment_offset > fragment->total_length)
+		ok = false;
+	mtu = gip_data_class_mtu[fragment->message >> GIP_DATA_CLASS_SHIFT] - GIP_DUAL_LENGTH;
+	if (!ok) {
+		gip_warn(attachment, "Received invalid buffer offset in ACK, "
+			"got offset=%u + remaining=%u, expected offset=%u + remaining=%u\n",
+			fragment_offset, remaining_buffer,
+			fragment->fragment_offset, fragment->total_length - fragment->fragment_offset);
+		rc = -EINVAL;
+		goto resend;
+	} else if ((fragment->flags & GIP_FLAG_FRAGMENT) &&
+		(fragment->fragment_offset > fragment_offset ||
+		fragment->fragment_offset + mtu < fragment_offset)) {
+		gip_warn(attachment, "Received unexpected buffer offset in ACK, "
+			"got offset=%u, expected offset=%u\n",
+			fragment_offset, fragment->fragment_offset + mtu);
+	}
+
+	fragment->acked = true;
+	if (fragment->flags & GIP_FLAG_FRAGMENT) {
+		fragment->fragment_offset = fragment_offset;
+		rc = gip_send_next_fragment(attachment, fragment);
+		if (rc < 0)
+			return rc;
+	} else {
+		gip_free_fragment(fragment);
+	}
+
+	return 0;
+
+resend:
+	// TODO
+	return rc;
 }
 
 static bool gip_handle_command_hello_device(struct gip_attachment *attachment,
@@ -2220,6 +2506,7 @@ static struct gip_attachment *gip_ensure_attachment(struct gip_device *device,
 	uint8_t attachment_index)
 {
 	struct gip_attachment *attachment = device->attachments[attachment_index];
+	int i;
 
 	if (!attachment) {
 		attachment = devm_kzalloc(to_gip_device(device), sizeof(*attachment), GFP_KERNEL);
@@ -2235,6 +2522,9 @@ static struct gip_attachment *gip_ensure_attachment(struct gip_device *device,
 			attachment->product_id = device->udev->descriptor.idProduct;
 		}
 
+		for (i = 0; i < MAX_OUT_FRAGMENTS; i++)
+			attachment->out_fragments[i].message = -1;
+
 		device->attachments[attachment_index] = attachment;
 
 		mutex_init(&attachment->lock);
@@ -2549,6 +2839,7 @@ static void gip_urb_out(struct urb *urb)
 	switch (status) {
 	case 0:
 		/* success */
+		schedule_work(&intf->send_fragment);
 		break;
 
 	case -ECONNRESET:
@@ -2745,9 +3036,11 @@ static int gip_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	gip->data.device = gip;
 	gip->data.intf = intf;
 	gip->data.mtu = BASE_GIP_MTU;
+	INIT_WORK(&gip->data.send_fragment, gip_send_fragment_work);
 	gip->audio.device = gip;
 	gip->audio.mtu = MAX_GIP_MTU;
 	gip->audio.isoc_messages = MAX_AUDIO_MESSAGES;
+	INIT_WORK(&gip->audio.send_fragment, gip_send_fragment_work);
 
 	INIT_WORK(&gip->receive_message, gip_receive_work);
 	spin_lock_init(&gip->message_lock);
@@ -2779,6 +3072,9 @@ static int gip_shutdown(struct gip_device *device)
 	int i;
 
 	cancel_work_sync(&device->receive_message);
+	cancel_work_sync(&device->data.send_fragment);
+	if (device->audio.intf)
+		cancel_work_sync(&device->audio.send_fragment);
 
 	for (i = 0; i < MAX_ATTACHMENTS; i++) {
 		struct gip_attachment *attachment = device->attachments[i];
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index 13a182145577..c7751f96e8ac 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -25,6 +25,7 @@
 
 #define MAX_IN_MESSAGES 8
 #define MAX_OUT_MESSAGES 8
+#define MAX_OUT_FRAGMENTS 2
 
 #define GIP_VID_MICROSOFT	0x045e
 #define GIP_VID_PDP		0x0e6f
@@ -194,6 +195,17 @@ struct gip_extended_status {
 	struct gip_status_event events[5];
 };
 
+struct gip_out_fragment {
+	bool active;
+	bool acked;
+	uint8_t message;
+	uint8_t flags;
+	uint8_t seq;
+	uint16_t total_length;
+	uint32_t fragment_offset;
+	uint8_t *data;
+};
+
 struct gip_attachment;
 typedef int (*gip_command_handler)(struct gip_attachment *a, const struct gip_header *header,
 		const uint8_t *bytes, int num_bytes);
@@ -222,6 +234,8 @@ struct gip_attachment {
 	struct delayed_work in_fragment_timeout;
 	int in_fragment_retries;
 
+	struct gip_out_fragment out_fragments[MAX_OUT_FRAGMENTS];
+
 	uint16_t firmware_major_version;
 	uint16_t firmware_minor_version;
 
@@ -275,6 +289,9 @@ struct gip_interface {
 
 	struct usb_anchor out_anchor;
 	struct gip_urb out_queue[MAX_OUT_MESSAGES];
+
+	struct work_struct send_fragment;
+	unsigned int has_pending_out;
 };
 
 struct gip_device {
-- 
2.54.0

