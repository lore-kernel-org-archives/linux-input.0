Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0433F8A5
	for <linux-input@vger.kernel.org>; Sun,  9 Aug 2026 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786290292; cv=none; b=PCF4t5OCsi71HGqFvrJmUJ5/F7JnwF9c3UnbOlFrsu7j1a3LK8rzidY1eKbhlH4vHOettaIBhSdeC7G6IjMqSqRomcebtjvpiDmiQZb6eJbGJtfvPdJavz9qL3nh7oDq6Gb81N+Z0ZhJkDPIEO7czbkKI+F8VBQX7AbGxKcqLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786290292; c=relaxed/simple;
	bh=koY9irnp8mz+ncL9laDh13UYHJy1l4Cnpn6vneocxmk=;
	h=From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:Date; b=iVO6ARxSEoNCRzVYYU6UMaJezSsOaU6dRQOSrx6HtSWqWJTBHTLtU3HQzRg/lgjRuJPDbMptbwQ6ICF8Sjpk8Z7E2Y3tKocUfCvdHKMLPGvSMjPOFzBEv0BREWABm+npHcZDdyB+tGBu+yoPbuWVSKe3NWJFaldv26qjSMN85Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=laserology.net; spf=pass smtp.mailfrom=laserology.net; dkim=pass (2048-bit key) header.d=laserology.net header.i=@laserology.net header.b=hb0eIjWO; arc=none smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=laserology.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laserology.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=laserology.net header.i=@laserology.net header.b="hb0eIjWO"
X-Sender-Id: hostingeremail|x-authuser|admin@laserology.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 30C907A1E39;
	Sun, 09 Aug 2026 15:44:43 +0000 (UTC)
Received: from de-fra-smtpout8.hostinger.io (100-111-253-213.trex-nlb.outbound.svc.cluster.local [100.111.253.213])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id E3B6A7A1DF4;
	Sun, 09 Aug 2026 15:44:41 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|admin@laserology.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|admin@laserology.net
X-MailChannels-Auth-Id: hostingeremail
X-Tangy-Trail: 785a642f14652f88_1786290282849_1485092920
X-MC-Loop-Signature: 1786290282849:1590410516
X-MC-Ingress-Time: 1786290282849
Received: from de-fra-smtpout8.hostinger.io (de-fra-smtpout8.hostinger.io
 [148.222.55.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.253.213 (trex/8.0.2);
	Sun, 09 Aug 2026 15:44:42 +0000
Received: from toolbx (unknown [IPv6:2605:59c0:2068:2608:c60b:fd48:4dc7:1cbd])
	(Authenticated sender: admin@laserology.net)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4hJ2J66s3Pz3whS;
	Sun,  9 Aug 2026 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laserology.net;
	s=hostingermail-a; t=1786290280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=evWlGZySG40if7fODr0DieODF5WYC/AzUXZBYbL6Ptw=;
	b=hb0eIjWO92A4ZDJRTIZmWgsQXwevYiggV8CVcqpWrds7z12GORW5V0qzdADjhn/C8+xNEx
	7DLbqEtrNXtfiYKmRW13noXL+MfBCvsKpcBQ7bb7EKAcn3CExkdm8u7LlQTP3NYtRiM/78
	WYrsGVZwoUgtecXkwYWUQRsOuUTj/M7N/BA4FcR1jc31hZIv1ShgMakKgtYcfa1KojJ76y
	87ryjP6/vu81FF/Jc71e8czoza2M0swK6UXEAGEPEhIAFQcuy97+kMx94VM/nYsZB2Ug71
	PS18vNma7ZBsNdfIR3uDXTsYXUf55my1VhPDD4C7Or7t8jK7PAmUnQVf8ZPzOA==
From: Laserology OSS <development@laserology.net>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	miroslav.bendik@gmail.com,
	laserology oss <development@laserology.net>
Subject: [PATCH] Input: synaptics - add transparent pass-through mode for TrackPoint
Message-ID: <20260809154420.369073-1-development@laserology.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Sun,  9 Aug 2026 15:44:38 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=etGNzZpX c=1 sm=1 tr=0 ts=6a78a068 a=bXe6bw2OB92olpQ1pPvang==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=dBzw8yLgAAAA:8 a=bYFWOaOQKb09jF1y-McA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=VaCLXHRpAd277H8a9-af:22
X-CM-Envelope: MS4xfHSLXI3bp8HU60x8WBx/JVYc0lrD5d6JzKu/2KgsGdzqf4nizjX5CQeLpCimy2dBLK0uJ4cEYR2hETyRKIGGpldB1Ulk+PjJpntdwyoTf/mDYpsE2WHf apWa/trX/xN2tNz2KYpl0r1y1QgCw038AFpoE01bXAobuQZtQYgxiCM5Wq848KmPkJaLKUE/8eu+sKW0LYH6jM5Sm1W4QXpeJb/AnhIlRwKP/iGGTfLu3M9T 4ROZSCE8nI7WAfP80YF+CjfMZp/NaqLxalhlKXuFSP+X8ndW/SPGrFIGq3FXniIK+h4UKFwh+vGEToD8P5geFNXDiAAOCI8hvarbrFmzkI/jxbj8W31ub6uE 3tKeHxnWC1kv/IudjMEt+pY9HygrXA==
X-AuthUser: admin@laserology.net

From: laserology oss <development@laserology.net>

This reworks an earlier implementation by Miroslav Bendík from 2022
that was never merged. It keeps the same hardware-mode approach but
commits the mode flag only after a successful mode command, moves the
reconnect handling into a generic psmouse hook instead of protocol-
specific checks in psmouse-interrupt, and documents the interface.

Changes in v2 (addressing review feedback):
- Only consult the parent serio in psmouse_receive_byte() when it is a
  genuine psmouse pass-through port; a psmouse attached to a ps2mult
  child port has a parent whose drvdata is not a struct psmouse, so the
  unconditional cast could read a bogus function pointer.
- Guard the guest state reset in synaptics_set_transparent_mode() on the
  pass-through port actually being bound to a psmouse, and commit the
  protocol handler/pktsize update with RX paused to avoid a torn update.
- Exit transparent mode on the hardware as well as in software when the
  pass-through guest port is removed while the mode is active.
- Re-run the full initialization (query, identity check, mode setup)
  before re-entering transparent mode during reconnect, so the device is
  in a known configuration after a reset.
- Use psmouse_set_state(PSMOUSE_ACTIVATED) to drop stale guest data
  instead of the bare pktcnt = 0 assignment, which could leave the
  psmouse state machine (flags, state) out of sync with the packet
  counter.
- Move the dev-attr creation ahead of the pass-through port registration
  so that an attribute creation failure cannot leak a registered child
  port whose callbacks reference freed synaptics_data.

Changes in v3 (addressing AI review findings):
- Scope the serio_pause_rx guard in synaptics_set_transparent_mode() to
  the protocol-handler commit only; calling psmouse_set_state() inside
  it re-enables interrupts via serio_continue_rx() while the parent lock
  is held, which can deadlock.
- Track the child psmouse via a pt_psmouse field set in
  synaptics_pt_open() instead of reaching into serio_get_drvdata() on
  the pass-through port; a non-psmouse driver could be bound to the
  port, and the unconditional cast risks memory corruption.
- In synaptics_pt_stop(), exit hardware transparent mode before updating
  the software protocol handler, so guest data is never misparsed as
  host touchpad packets.
- Unregister and free the pass-through serio port in
  synaptics_disconnect() so it is not leaked when the parent psmouse
  driver is unbound.
---
 .../ABI/testing/sysfs-driver-synaptics        |  28 ++
 MAINTAINERS                                   |   1 +
 drivers/input/mouse/psmouse-base.c            |  17 +-
 drivers/input/mouse/psmouse.h                 |   7 +
 drivers/input/mouse/synaptics.c               | 288 +++++++++++++++++-
 drivers/input/mouse/synaptics.h               |   4 +
 6 files changed, 329 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-synaptics

diff --git a/Documentation/ABI/testing/sysfs-driver-synaptics b/Documentation/ABI/testing/sysfs-driver-synaptics
new file mode 100644
index 000000000000..bec715677e3e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-synaptics
@@ -0,0 +1,28 @@
+What:		/sys/bus/serio/devices/serioX/transparent_mode
+Date:		August 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Controls the transparent pass-through mode of Synaptics
+		touchpads that feature a pass-through (PS/2 guest) port, such as
+		those used for a TrackPoint.
+
+		In normal operation the touchpad serves as the PS/2 host for
+		the pass-through guest: it scans the guest during its own scan
+		cycle and encapsulates the guest's data into its own packets,
+		which limits the guest to the touchpad's low poll rate. When
+		transparent mode is enabled the touchpad stops generating its
+		own packets and simply relays the raw byte stream of the
+		pass-through guest, letting the guest run at its high poll rate
+		while the touchpad is effectively disabled.
+
+		Write 1 to enable the mode, or 0 to disable it. Reading the
+		attribute returns the current state ("0" or "1").
+
+		Note that both devices cannot be serviced at full rate at the
+		same time on this hardware; enabling the mode disables the
+		touchpad until it is disabled again. The attribute is present
+		only on devices that report the pass-through capability.
+
+Users:		Userspace that arbitrates between full-rate TrackPoint and
+		full-rate touchpad operation. No consumer exists yet; the
+		interface is provided so that one can be developed.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..312c13690c91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12817,6 +12817,7 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-input/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
+F:	Documentation/ABI/testing/sysfs-driver-synaptics
 F:	Documentation/devicetree/bindings/input/
 F:	Documentation/devicetree/bindings/serio/
 F:	Documentation/input/
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 6ab5f1d96eae..8acab3ef924d 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -385,8 +385,23 @@ static void psmouse_receive_byte(struct ps2dev *ps2dev, u8 data)
 		}
 
 		if (psmouse->packet[1] == PSMOUSE_RET_ID) {
+			struct serio *serio = ps2dev->serio;
+			struct psmouse *parent_psmouse = NULL;
+
 			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
-			serio_reconnect(ps2dev->serio);
+			/*
+			 * Some devices need parent to be reconnected instead.
+			 * Only consult the parent if this is a genuine psmouse
+			 * pass-through port; other serio children may have a
+			 * parent whose drvdata is not a struct psmouse.
+			 */
+			if (serio->parent && serio->id.type == SERIO_PS_PSTHRU)
+				parent_psmouse = psmouse_from_serio(serio->parent);
+			if (parent_psmouse && parent_psmouse->pt_reconnect_parent &&
+			    parent_psmouse->pt_reconnect_parent(parent_psmouse))
+				serio_reconnect(serio->parent);
+			else
+				serio_reconnect(serio);
 			return;
 		}
 
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 90ed8cd15d85..7525926f5121 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -128,6 +128,13 @@ struct psmouse {
 
 	void (*pt_activate)(struct psmouse *psmouse);
 	void (*pt_deactivate)(struct psmouse *psmouse);
+
+	/*
+	 * Called on the parent device when a pass-through guest reports a new
+	 * device announcement (0xAA 0x00). Return true if the parent, and not
+	 * the guest, should be reconnected.
+	 */
+	bool (*pt_reconnect_parent)(struct psmouse *psmouse);
 };
 
 struct psmouse *psmouse_from_serio(struct serio *serio);
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index c70502e24031..1fc8943cab14 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -636,12 +636,88 @@ static void synaptics_set_rate(struct psmouse *psmouse, unsigned int rate)
 /*****************************************************************************
  *	Synaptics pass-through PS/2 port support
  ****************************************************************************/
+static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse);
+
+static psmouse_ret_t transparent_process_byte(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	struct serio *pt_port = READ_ONCE(priv->pt_port);
+
+	if (!pt_port)
+		return PSMOUSE_BAD_DATA;
+
+	serio_interrupt(pt_port, psmouse->packet[psmouse->pktcnt - 1], 0);
+	return PSMOUSE_FULL_PACKET;
+}
+
+static void synaptics_update_protocol_handler(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	struct serio *pt_port = READ_ONCE(priv->pt_port);
+	bool absolute_mode = priv->absolute_mode;
+	bool transparent_mode = READ_ONCE(priv->transparent_mode);
+
+	if (transparent_mode && pt_port) {
+		psmouse->protocol_handler = transparent_process_byte;
+	} else {
+		if (absolute_mode) {
+			psmouse->protocol_handler = synaptics_process_byte;
+			psmouse->pktsize = 6;
+		} else {
+			/* Relative mode follows standard PS/2 mouse protocol */
+			psmouse->protocol_handler = psmouse_process_byte;
+			psmouse->pktsize = 3;
+		}
+	}
+}
+
+static int synaptics_enter_transparent_mode(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	int error;
+
+	error = synaptics_mode_cmd(psmouse, priv->mode | SYN_BIT_TRANSPARENT_MODE);
+	if (error)
+		return error;
+
+	priv->mode |= SYN_BIT_TRANSPARENT_MODE;
+
+	return 0;
+}
+
+static int synaptics_exit_transparent_mode(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	int error;
+
+	/* Send scaling 2:1, 1:1 to exit transparent mode */
+	error = ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE21);
+	if (error)
+		return error;
+	error = ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
+	if (error)
+		return error;
+
+	/* Re-enter the regular operating mode of the touchpad */
+	error = synaptics_mode_cmd(psmouse, priv->mode & ~SYN_BIT_TRANSPARENT_MODE);
+	if (error)
+		return error;
+
+	priv->mode &= ~SYN_BIT_TRANSPARENT_MODE;
+
+	return 0;
+}
+
 static int synaptics_pt_write(struct serio *serio, u8 c)
 {
 	struct psmouse *parent = psmouse_from_serio(serio->parent);
+	struct synaptics_data *priv = parent->private;
 	u8 rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
 	int error;
 
+	if (READ_ONCE(priv->transparent_mode))
+		return parent->ps2dev.serio->write(parent->ps2dev.serio, c);
+
 	error = ps2_sliced_command(&parent->ps2dev, c);
 	if (error)
 		return error;
@@ -661,6 +737,8 @@ static int synaptics_pt_start(struct serio *serio)
 	guard(serio_pause_rx)(parent->ps2dev.serio);
 	priv->pt_port = serio;
 
+	synaptics_update_protocol_handler(parent);
+
 	return 0;
 }
 
@@ -668,9 +746,30 @@ static void synaptics_pt_stop(struct serio *serio)
 {
 	struct psmouse *parent = psmouse_from_serio(serio->parent);
 	struct synaptics_data *priv = parent->private;
+	bool exit_mode;
 
-	guard(serio_pause_rx)(parent->ps2dev.serio);
-	priv->pt_port = NULL;
+	exit_mode = READ_ONCE(priv->transparent_mode);
+
+	/*
+	 * The guest is going away. Take the hardware out of transparent
+	 * mode first so the device stops relaying the guest's byte stream
+	 * and resumes producing host packets, then update the software state
+	 * with RX paused so the interrupt handler never observes a torn
+	 * configuration.
+	 */
+	if (exit_mode) {
+		if (synaptics_exit_transparent_mode(parent))
+			psmouse_warn(parent,
+				     "failed to exit transparent mode after pass-through port removal\n");
+	}
+
+	{
+		guard(serio_pause_rx)(parent->ps2dev.serio);
+
+		priv->pt_port = NULL;
+		WRITE_ONCE(priv->transparent_mode, false);
+		synaptics_update_protocol_handler(parent);
+	}
 }
 
 static int synaptics_pt_open(struct serio *serio)
@@ -680,6 +779,7 @@ static int synaptics_pt_open(struct serio *serio)
 
 	guard(serio_pause_rx)(parent->ps2dev.serio);
 	priv->pt_port_open = true;
+	priv->pt_psmouse = psmouse_from_serio(serio);
 
 	return 0;
 }
@@ -691,6 +791,19 @@ static void synaptics_pt_close(struct serio *serio)
 
 	guard(serio_pause_rx)(parent->ps2dev.serio);
 	priv->pt_port_open = false;
+	priv->pt_psmouse = NULL;
+}
+
+/*
+ * When the touchpad is in transparent mode resetting the guest alone is not
+ * enough, the host needs to be reconnected so that transparent mode is
+ * re-established.
+ */
+static bool synaptics_pt_reconnect_parent(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+
+	return READ_ONCE(priv->transparent_mode);
 }
 
 static int synaptics_is_pt_packet(u8 *buf)
@@ -725,6 +838,10 @@ static void synaptics_pt_activate(struct psmouse *psmouse)
 	struct synaptics_data *priv = psmouse->private;
 	struct psmouse *child = psmouse_from_serio(priv->pt_port);
 
+	/* don't need change mode if transparent mode is active */
+	if (READ_ONCE(priv->transparent_mode))
+		return;
+
 	/* adjust the touchpad to child's choice of protocol */
 	if (child) {
 		if (child->pktsize == 4)
@@ -741,6 +858,7 @@ static void synaptics_pt_activate(struct psmouse *psmouse)
 static void synaptics_pt_create(struct psmouse *psmouse)
 {
 	struct serio *serio;
+	struct synaptics_data *priv = psmouse->private;
 
 	serio = kzalloc_obj(*serio);
 	if (!serio) {
@@ -760,10 +878,12 @@ static void synaptics_pt_create(struct psmouse *psmouse)
 	serio->parent = psmouse->ps2dev.serio;
 
 	psmouse->pt_activate = synaptics_pt_activate;
+	psmouse->pt_reconnect_parent = synaptics_pt_reconnect_parent;
 
 	psmouse_info(psmouse, "serio: %s port at %s\n",
 		     serio->name, psmouse->phys);
 	serio_register_port(serio);
+	priv->pt_serio = serio;
 }
 
 /*****************************************************************************
@@ -1437,6 +1557,87 @@ PSMOUSE_DEFINE_ATTR(disable_gesture, S_IWUSR | S_IRUGO, NULL,
 		    synaptics_show_disable_gesture,
 		    synaptics_set_disable_gesture);
 
+static ssize_t synaptics_show_transparent_mode(struct psmouse *psmouse,
+					       void *data, char *buf)
+{
+	struct synaptics_data *priv = psmouse->private;
+
+	return sysfs_emit(buf, "%c\n",
+			  READ_ONCE(priv->transparent_mode) ? '1' : '0');
+}
+
+static ssize_t synaptics_set_transparent_mode(struct psmouse *psmouse,
+					      void *data, const char *buf,
+					      size_t len)
+{
+	struct synaptics_data *priv = psmouse->private;
+	unsigned int value;
+	int err;
+
+	err = kstrtouint(buf, 10, &value);
+	if (err)
+		return err;
+
+	if (value > 1)
+		return -EINVAL;
+
+	if (value == READ_ONCE(priv->transparent_mode))
+		return len;
+
+	/* Transparent mode only makes sense while the guest is attached */
+	if (value && !READ_ONCE(priv->pt_port))
+		return -ENODEV;
+
+	/*
+	 * Switch the hardware first and only commit the new mode and protocol
+	 * handler once it succeeded, so a failing command cannot leave the
+	 * driver with bookkeeping that does not match the device. The touchpad
+	 * is deactivated for the duration of this write (see
+	 * psmouse_attr_set_helper), so no live data can be misparsed in
+	 * between.
+	 */
+	if (value) {
+		err = synaptics_enter_transparent_mode(psmouse);
+		if (err)
+			return err;
+	} else {
+		err = synaptics_exit_transparent_mode(psmouse);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * Commit the software state with RX paused so the interrupt handler
+	 * never observes a torn (protocol_handler, pktsize) pair while the
+	 * pass-through guest keeps streaming.
+	 */
+	{
+		guard(serio_pause_rx)(psmouse->ps2dev.serio);
+		WRITE_ONCE(priv->transparent_mode, value);
+		synaptics_update_protocol_handler(psmouse);
+	}
+
+	/*
+	 * The touchpad is stopped for the duration of the mode switch, but the
+	 * pass-through guest keeps streaming. It may therefore be left with a
+	 * partially assembled packet from the previous mode. Drop it so the
+	 * stream restarts cleanly in the new mode and no stale bytes are
+	 * misparsed as pointer motion or spurious button clicks.
+	 */
+	if (READ_ONCE(priv->pt_port)) {
+		struct psmouse *child = READ_ONCE(priv->pt_psmouse);
+
+		if (child && child->state == PSMOUSE_ACTIVATED)
+			psmouse_set_state(child, PSMOUSE_ACTIVATED);
+	}
+
+	return len;
+}
+
+PSMOUSE_DEFINE_ATTR(transparent_mode, 0644, NULL,
+		    synaptics_show_transparent_mode,
+		    synaptics_set_transparent_mode);
+
 static void synaptics_disconnect(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
@@ -1447,10 +1648,24 @@ static void synaptics_disconnect(struct psmouse *psmouse)
 	 */
 	psmouse_smbus_cleanup(psmouse);
 
+	if (READ_ONCE(priv->transparent_mode)) {
+		synaptics_exit_transparent_mode(psmouse);
+		WRITE_ONCE(priv->transparent_mode, false);
+	}
+
 	if (!priv->absolute_mode &&
 			SYN_ID_DISGEST_SUPPORTED(priv->info.identity))
 		device_remove_file(&psmouse->ps2dev.serio->dev,
 				   &psmouse_attr_disable_gesture.dattr);
+	if (SYN_CAP_PASS_THROUGH(priv->info.capabilities))
+		device_remove_file(&psmouse->ps2dev.serio->dev,
+				   &psmouse_attr_transparent_mode.dattr);
+
+	if (priv->pt_serio) {
+		serio_unregister_port(priv->pt_serio);
+		kfree(priv->pt_serio);
+		priv->pt_serio = NULL;
+	}
 
 	synaptics_reset(psmouse);
 	kfree(priv);
@@ -1477,8 +1692,35 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 			 */
 			ssleep(1);
 		}
-		ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETID);
-		error = synaptics_detect(psmouse, 0);
+		if (READ_ONCE(priv->transparent_mode) && READ_ONCE(priv->pt_port)) {
+			/*
+			 * psmouse_reset() above put the touchpad back into its
+			 * power-on state, so run the full initialization before
+			 * re-entering transparent mode. Otherwise the device
+			 * would come back missing the configuration set up by
+			 * synaptics_set_mode() (e.g. Advanced Gesture Mode) and
+			 * would stay uninitialized once transparent mode is
+			 * disabled again.
+			 */
+			error = synaptics_query_hardware(psmouse, &info);
+			if (!error &&
+			    (info.identity != priv->info.identity ||
+			     info.model_id != priv->info.model_id ||
+			     info.capabilities != priv->info.capabilities ||
+			     info.ext_cap != priv->info.ext_cap))
+				error = -ENXIO;
+			if (!error)
+				error = synaptics_set_mode(psmouse);
+			if (!error)
+				error = synaptics_enter_transparent_mode(psmouse);
+			if (!error) {
+				serio_reconnect(priv->pt_port);
+				return 0;
+			}
+		} else {
+			ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETID);
+			error = synaptics_detect(psmouse, 0);
+		}
 	} while (error && ++retry < 3);
 
 	if (error)
@@ -1647,14 +1889,7 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 	psmouse->model = ((info->model_id & 0x00ff0000) >> 8) |
 			  (info->model_id & 0x000000ff);
 
-	if (absolute_mode) {
-		psmouse->protocol_handler = synaptics_process_byte;
-		psmouse->pktsize = 6;
-	} else {
-		/* Relative mode follows standard PS/2 mouse protocol */
-		psmouse->protocol_handler = psmouse_process_byte;
-		psmouse->pktsize = 3;
-	}
+	synaptics_update_protocol_handler(psmouse);
 
 	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
@@ -1664,9 +1899,6 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 	/* Synaptics can usually stay in sync without extra help */
 	psmouse->resync_time = 0;
 
-	if (SYN_CAP_PASS_THROUGH(info->capabilities))
-		synaptics_pt_create(psmouse);
-
 	/*
 	 * Toshiba's KBC seems to have trouble handling data from
 	 * Synaptics at full rate.  Switch to a lower rate (roughly
@@ -1690,9 +1922,35 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 		}
 	}
 
+	if (SYN_CAP_PASS_THROUGH(info->capabilities)) {
+		err = device_create_file(&psmouse->ps2dev.serio->dev,
+					 &psmouse_attr_transparent_mode.dattr);
+		if (err) {
+			psmouse_err(psmouse,
+				    "Failed to create transparent_mode attribute (%d)",
+				    err);
+			goto init_fail;
+		}
+	}
+
+	/*
+	 * Register the pass-through port only once all initialization steps
+	 * that can fail have succeeded, so that a failure in one of the steps
+	 * above cannot leak a registered child port whose callbacks would
+	 * dereference the freed synaptics_data.
+	 */
+	if (SYN_CAP_PASS_THROUGH(info->capabilities))
+		synaptics_pt_create(psmouse);
+
 	return 0;
 
  init_fail:
+	if (!priv->absolute_mode && SYN_ID_DISGEST_SUPPORTED(priv->info.identity))
+		device_remove_file(&psmouse->ps2dev.serio->dev,
+				   &psmouse_attr_disable_gesture.dattr);
+	if (SYN_CAP_PASS_THROUGH(priv->info.capabilities))
+		device_remove_file(&psmouse->ps2dev.serio->dev,
+				   &psmouse_attr_transparent_mode.dattr);
 	kfree(priv);
 	return err;
 }
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 3853165b6b3a..eb37dd0a9dff 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -24,6 +24,7 @@
 /* synaptics modes */
 #define SYN_BIT_ABSOLUTE_MODE		BIT(7)
 #define SYN_BIT_HIGH_RATE		BIT(6)
+#define SYN_BIT_TRANSPARENT_MODE	BIT(5)
 #define SYN_BIT_SLEEP_MODE		BIT(3)
 #define SYN_BIT_DISABLE_GESTURE		BIT(2)
 #define SYN_BIT_FOUR_BYTE_CLIENT	BIT(1)
@@ -186,8 +187,11 @@ struct synaptics_data {
 
 	bool absolute_mode;			/* run in Absolute mode */
 	bool disable_gesture;			/* disable gestures */
+	bool transparent_mode;			/* pass packets directly from guest */
 
 	struct serio *pt_port;			/* Pass-through serio port */
+	struct serio *pt_serio;			/* Allocated pass-through serio port */
+	struct psmouse *pt_psmouse;		/* Child psmouse bound to the pt port */
 	bool pt_port_open;
 
 	/*
-- 
2.55.0

