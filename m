Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA73191D3
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837827; cv=none; b=Ku4Z23PuBLGfnwc1A6LgT8pEg+p1c0dIzlX4B7BJIpC5KCjTE0le+d1IWzOPDWl7qISYrFbvTSFjGWClVygl5kf38SBC5Ux3jaBAAYzPW8CS9r0SfTOhX7Ef9QxbubByNQ+0GSgQP0yLmtkiLBG0iI+k1IFY/Wb3Eh+NX/lubMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837827; c=relaxed/simple;
	bh=Itt1UqIE47tNFBJwSvHMEcDZy1dKykkXfcyDBHg5Rkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdcGsOxLBz5w4gxE/MlGOPkL2hRXqBsS2YNcHrmKFPJJ/yPCPx+uwUtup1Q7cGELf0TCiVuIL/1F7OeqAARat5hPvy3x7oS4c4IaHvVP9DiJwKyMLLXxY6P6XHYYY5Gs07TA74qW9mW0XYdNAgUcb2mUughjXV8DqHvVwWaMwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=Tslok2yR; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="Tslok2yR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1788837817; bh=Itt1UqIE47tNFBJwSvHMEcDZy1dKykkXfcyDBHg5Rkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tslok2yRxpske6Eg4HifJTXY0GorBVfehZlXE1wpk9Idnyg8wWMvdPYsa64cn9XZQ
	 Jki1HnpNqXnJKt1A+/PdVIQO6SuCZQPTkw5zDBEL2+qvC4MDCizB6YE73vZsEfJFhz
	 7QLSmpnRdS5c9V0rHKzibuwV0J246kubTRnDZhibA/ZNrZMXTUaCVs+1MAIMDhvD8U
	 LJLzTI+5VHmLRhJKZiWlgzrkvg8oh+yg14y0sqzXV3G0EFomacdb/+F5wkyzLq61wG
	 6gGrVmpZHPLo5vL4VEEVkKV2S6UYSimL0b1c4bQTWbyq93eTI6jQzwYEvWZVUReCQq
	 zslEYgSFavhrg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id A620B132037;
	Mon, 07 Sep 2026 20:23:37 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v6 06/12] Input: xbox_gip - Allow sending fragmented and ACME messages
Date: Mon,  7 Sep 2026 20:21:37 -0700
Message-ID: <20260908032145.2118234-7-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908032145.2118234-1-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
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
 drivers/input/joystick/gip/gip-core.c | 385 ++++++++++++++++++++++++--
 drivers/input/joystick/gip/gip.h      |  20 ++
 2 files changed, 388 insertions(+), 17 deletions(-)

diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 568877a4ce4b..f61b5f18b819 100644
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
@@ -40,6 +40,9 @@
 #define GIP_DATA_CLASS_SHIFT 5
 #define GIP_DATA_CLASS_MASK (7u << 5)
 
+#define GIP_ACME_RETRY_TIME	(HZ / 10)
+#define GIP_ACME_MAX_RETRIES	8
+
 /* Undocumented Elite 2 vendor messages */
 #define GIP_CMD_RAW_REPORT		0x0c
 #define GIP_CMD_GUIDE_COLOR		0x0e
@@ -437,6 +440,13 @@ static uint8_t gip_sequence_next(struct gip_attachment *attachment,
 	return seq;
 }
 
+static unsigned int gip_fragment_id(const struct gip_attachment *attachment,
+	const struct gip_out_fragment *fragment)
+{
+	return BIT(attachment->attachment_index * MAX_OUT_FRAGMENTS +
+		(unsigned int) (fragment - attachment->out_fragments));
+}
+
 static void gip_handle_quirks_array(struct gip_attachment *attachment,
 	const struct gip_quirks *quirks)
 {
@@ -479,6 +489,50 @@ static void gip_handle_quirks(struct gip_attachment *attachment)
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
+	cancel_delayed_work(&fragment->timeout);
+	kfree(fragment->data);
+	fragment->data = NULL;
+	fragment->active = false;
+	fragment->message = 0;
+	fragment->flags = 0;
+	fragment->seq = 0;
+	fragment->retries = 0;
+	fragment->total_length = 0;
+	fragment->fragment_offset = 0;
+}
+
 static int gip_send_raw_message(struct gip_attachment *attachment,
 	uint8_t message_type, uint8_t flags, uint8_t seq, const uint8_t *bytes,
 	int num_bytes)
@@ -486,20 +540,25 @@ static int gip_send_raw_message(struct gip_attachment *attachment,
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
@@ -511,6 +570,89 @@ static int gip_send_raw_message(struct gip_attachment *attachment,
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
@@ -520,17 +662,13 @@ static int gip_send_raw_message(struct gip_attachment *attachment,
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
 
@@ -545,11 +683,106 @@ static int gip_send_raw_message(struct gip_attachment *attachment,
 			__func__, rc);
 		usb_unanchor_urb(urb->urb);
 		rc = -EIO;
+		goto err_free_fragment;
 	}
 
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
+		if (flags & GIP_FLAG_ACME)
+			schedule_delayed_work(&fragment->timeout, GIP_ACME_RETRY_TIME);
+	}
+
+	return rc;
+
+err_free_fragment:
+	if (fragment)
+		gip_free_fragment(fragment);
 	return rc;
 }
 
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
+		guard(spinlock_irqsave)(&intf->device->message_lock);
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
+	if (next_bytes == 0 && !(fragment->flags & GIP_FLAG_ACME)) {
+		/* Finished sending the message */
+		gip_free_fragment(fragment);
+	} else if (flags & GIP_FLAG_ACME) {
+		fragment->acked = false;
+		schedule_delayed_work(&fragment->timeout, GIP_ACME_RETRY_TIME);
+	}
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
+}
+
 int gip_send_system_message(struct gip_attachment *attachment,
 	uint8_t message_type, uint8_t flags, const void *bytes, int num_bytes)
 {
@@ -1587,6 +1820,25 @@ static void gip_fragment_timeout(struct work_struct *work)
 	gip_free_in_fragment(attachment);
 }
 
+static void gip_out_fragment_timeout(struct work_struct *work)
+{
+	struct gip_out_fragment *fragment = container_of(to_delayed_work(work),
+		struct gip_out_fragment, timeout);
+	struct gip_attachment *attachment = fragment->attachment;
+
+	guard(mutex)(&attachment->lock);
+	if (!fragment->active || !fragment->data || fragment->acked)
+		return;
+
+	fragment->retries++;
+	if (fragment->retries >= GIP_ACME_MAX_RETRIES) {
+		gip_free_fragment(fragment);
+		gip_warn(attachment, "Reliable message transmission failed\n");
+		return;
+	}
+	gip_send_next_fragment(attachment, fragment);
+}
+
 static void gip_free_devices(struct gip_attachment *attachment)
 {
 	struct input_dev *input;
@@ -1657,21 +1909,102 @@ static int gip_ensure_metadata(struct gip_attachment *attachment)
 
 static void gip_reset_attachment(struct gip_attachment *attachment)
 {
+	int i;
+	int pending_out_bits =
+		BIT((attachment->attachment_index + 1) * MAX_OUT_FRAGMENTS) -
+		BIT(attachment->attachment_index * MAX_OUT_FRAGMENTS);
+	unsigned long flags;
+
 	cancel_delayed_work(&attachment->metadata_next);
 	cancel_delayed_work(&attachment->in_fragment_timeout);
 
 	if (attachment->in_fragment_data)
 		gip_free_in_fragment(attachment);
 
+	spin_lock_irqsave(&attachment->device->message_lock, flags);
+	attachment->device->data.has_pending_out &= ~pending_out_bits;
+	attachment->device->audio.has_pending_out &= ~pending_out_bits;
+	spin_unlock_irqrestore(&attachment->device->message_lock, flags);
+
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
+		return -EINVAL;
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
+	fragment->retries = 0;
+	cancel_delayed_work(&fragment->timeout);
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
+	gip_send_next_fragment(attachment, fragment);
+	return rc;
 }
 
 static bool gip_handle_command_hello_device(struct gip_attachment *attachment,
@@ -2218,6 +2551,7 @@ static struct gip_attachment *gip_ensure_attachment(struct gip_device *device,
 	uint8_t attachment_index)
 {
 	struct gip_attachment *attachment = device->attachments[attachment_index];
+	int i;
 
 	if (!attachment) {
 		attachment = devm_kzalloc(to_gip_device(device), sizeof(*attachment), GFP_KERNEL);
@@ -2233,6 +2567,11 @@ static struct gip_attachment *gip_ensure_attachment(struct gip_device *device,
 			attachment->product_id = device->udev->descriptor.idProduct;
 		}
 
+		for (i = 0; i < MAX_OUT_FRAGMENTS; i++) {
+			attachment->out_fragments[i].attachment = attachment;
+			INIT_DELAYED_WORK(&attachment->out_fragments[i].timeout, gip_out_fragment_timeout);
+		}
+
 		device->attachments[attachment_index] = attachment;
 
 		mutex_init(&attachment->lock);
@@ -2542,6 +2881,7 @@ static void gip_urb_out(struct urb *urb)
 	switch (status) {
 	case 0:
 		/* success */
+		schedule_work(&intf->send_fragment);
 		break;
 
 	case -ECONNRESET:
@@ -2738,9 +3078,11 @@ static int gip_probe(struct usb_interface *intf, const struct usb_device_id *id)
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
@@ -2772,8 +3114,17 @@ static int gip_probe(struct usb_interface *intf, const struct usb_device_id *id)
 static void gip_shutdown(struct gip_device *device)
 {
 	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&device->message_lock, flags);
+	device->data.has_pending_out = 0;
+	device->audio.has_pending_out = 0;
+	spin_unlock_irqrestore(&device->message_lock, flags);
 
 	cancel_work_sync(&device->receive_message);
+	cancel_work_sync(&device->data.send_fragment);
+	if (device->audio.intf)
+		cancel_work_sync(&device->audio.send_fragment);
 
 	for (i = 0; i < MAX_ATTACHMENTS; i++) {
 		struct gip_attachment *attachment = device->attachments[i];
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index 1c6854540f08..007edbb628b2 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -25,6 +25,7 @@
 
 #define MAX_IN_MESSAGES 8
 #define MAX_OUT_MESSAGES 8
+#define MAX_OUT_FRAGMENTS 2
 
 #define GIP_VID_MICROSOFT	0x045e
 #define GIP_VID_PDP		0x0e6f
@@ -194,6 +195,20 @@ struct gip_extended_status {
 	struct gip_status_event events[5];
 };
 
+struct gip_out_fragment {
+	struct gip_attachment *attachment;
+	bool active;
+	bool acked;
+	uint8_t message;
+	uint8_t flags;
+	uint8_t seq;
+	uint8_t retries;
+	uint16_t total_length;
+	uint32_t fragment_offset;
+	uint8_t *data;
+	struct delayed_work timeout;
+};
+
 struct gip_attachment;
 typedef int (*gip_command_handler)(struct gip_attachment *a, const struct gip_header *header,
 		const uint8_t *bytes, int num_bytes);
@@ -222,6 +237,8 @@ struct gip_attachment {
 	struct delayed_work in_fragment_timeout;
 	int in_fragment_retries;
 
+	struct gip_out_fragment out_fragments[MAX_OUT_FRAGMENTS];
+
 	uint16_t firmware_major_version;
 	uint16_t firmware_minor_version;
 
@@ -275,6 +292,9 @@ struct gip_interface {
 
 	struct usb_anchor out_anchor;
 	struct gip_urb out_queue[MAX_OUT_MESSAGES];
+
+	struct work_struct send_fragment;
+	unsigned int has_pending_out;
 };
 
 struct gip_device {
-- 
2.54.0

