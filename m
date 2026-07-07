Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3121383984;
	Tue,  7 Jul 2026 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404265; cv=none; b=fRWxUZ18JcjtsQostBhncP5h/5lV0DxUsluD9S91K2UFjqxIxyIyg8hC79KkoB78VrZ+v3LFRjzhda1jzq8HUpPgSrJCrkCRzyRK9LDtO1V/Stit52Mw4tYx066lnPjftJZiywV5NwKyiQ3k0sxcjyTxw4VdbgcaF9qOxTkD8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404265; c=relaxed/simple;
	bh=Ey4xgIo7cMrSLfaud8FhCrrLv1JBtRs1tIXIaRX9Mes=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P2J83XeFRN1yMtaKSVbRSrPndq8sSxPyl5jVhy+wiviENKTFxpAukr7iigqfZKhLvQG+gm0CqgruhH5K47eHPGc8UxPVXFkt+GiwZJPHd7/CbutqClW1jh3yd9HBVa5y8iVr0UoLEqnsIT/Mj8gPk6CDWWxdflto99Jz+5ZEYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=iys7ZHvd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j+ktTqMT; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="iys7ZHvd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j+ktTqMT"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id EF2F91380123;
	Tue,  7 Jul 2026 02:04:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 07 Jul 2026 02:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1783404261; x=1783407861; bh=XFN7IQX34vwhDwGzEawiNNROg+5OqZ1/
	JqxQily8nv8=; b=iys7ZHvdQ83Ox6KYKhsbdSvJD46RC0Khll1JD9RfOOmIgRi/
	T18MS7ftuSoysVG+mhcJzxxJ8YNAjfX9mXzMuW81sZvRqjyM43ug4upazU5cvTir
	IslTNlCYEPxXeviDMqqkGbRbaS/sZHTrNyoudTPGF8ZQE3H2zvUDCuniloJ8u8bp
	Z+FYvMh2A9rmegtgtkWcGBIdJdrRkFqSHXdVEDvzpg7ZSfFQAxgz0waBi4dPJFJP
	1Zm7sqFrkSkrfyXJd2PnU4zjO4S1eUoL6oXS1GtWycJdyS1BG2eaw6QQ/1pnwZZP
	nb/NtbkvhuDBwdUsRUvqkI36UoH/qdmc9d8owA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783404261; x=
	1783407861; bh=XFN7IQX34vwhDwGzEawiNNROg+5OqZ1/JqxQily8nv8=; b=j
	+ktTqMTToqme/MrpKz4KI5QvvM40Mnex9Dta/qkSXSllXPln0NUafzXgKOJT9PSE
	WtzwPDPhIY4U1UR3DCVYB4tx7vFqWU0/35VC6sIww2BfAPtxOkhpq5C09b5BuDrA
	TgjF69PZ6eAIsh1usaKe9kfEmUdwim0P+p9SmFiuVPdwQvwtBVoiBZrPVKpnjqLj
	1ppMo+yFWgss8YZis4xb52pg4+3Uc53jve0AAqu2BIUIqbSE/tUp9mdCBNnV2GNJ
	KvdSeIQKunHhhGGn9DrQR2lvcmL5aaxwjBTqAOV6ZrIKor8K491+DD+TrWgwlcB3
	IRpIiDsNTVOxTDBdnV/BQ==
X-ME-Sender: <xms:5ZZMahesiAGl1Yv9uWw7M93moiCggqo9JJccyM_Cni6L1JQUDsveXw>
    <xme:5ZZMaqo9mFduhnsU7P4a05D_LRt1SLoGva6W3PqvIwrBA1C7lRM3q4uNIC8bkMQWb
    D_m5gs7TSDtdf0mGUmwFs3COdiVv5iAds7KclxAnCPauIQ0pAeROq8>
X-ME-Received: <xmr:5ZZMauAQ3N9gpXYyp29cf7OuBx4rgAP8L36pY5nffvKde5E-8eClBxDUGMQ>
X-ME-Proxy-Cause: dmFkZTF//z1g68D77zm4Lj4ds+NPMXKq1C/eV6N07CwtL2I4PykCG/dMsbD0Kv39Ph0lnJ
    jDMH8Ho5m/R5HdhLQtd9K41UF82yquKSAnWkMk7WAPh5Dg67z4cj+XTozie6gyFjR6VFMQ
    BAeaolKrQdImn4dANbHWOKNZvEivvWjzuUEnE1oEgdVteAl0nx6FhrXb2+b6G2BR62bgwM
    TrxSw8gAi/HVwqzObYDdyg98jrjvuS/xTPt9fJ8Ku2UbuWy2ajjkm0cLnhB+id4mbG2mVf
    OCZ3x9YeTpadoe7Wy0oZv1o+suFORo5TYl3uJgHhOAEaQGeJ6P8lwpYxd+lui2/AvU44PN
    reNBcsgC3xfIeR40bOoDa4XJsLbdLEqNBdSR870A2sOEBWIKs/oQE+5WoQBvBhNvqgzgVj
    jAjeVb0cYLriSvwZ+MYvZME0DejumOWbeKBv/uOlKgh8OPrdk4uDd47oh+kkle4ESCXPlQ
    udlnuGfVa364ur3ZCSAl7afqigardmni7ivAao7D+X7h6e40kLNghOpUBQ3LkjJVrgiVHD
    C6H96IToO7Ejs+DTB5dws9jo+1qx7YXi3ojvZIDCPns/VESoeVIKEm0PWrOqBIoEyiRFEm
    e47hCW5+VRApn0vyFilRFesscXj2/Ba6VzmOiGe62HXLpIv/6V5LFxD+z+qw
X-ME-Proxy: <xmx:5ZZMavZVifGmZcgWXvqq_Mw6fVKAufE3ZsRWywaLhbYU3XWBy66z4Q>
    <xmx:5ZZMap4wj3B1oX_ghBkjd0JXrtT49eKIRGAx0Dll8ohsBd75YPzYjA>
    <xmx:5ZZMaobR7u0ZLpIh1Qp044TovworFDRDwFyFeqBn0LybVToZ2TGgbw>
    <xmx:5ZZMaghXi294eMse9VryOQAtIJ_KHtXAqsvg0lxIkOkLtSmg_b3zlA>
    <xmx:5ZZMatNDdA2jjycccEh5ejT5EdV7LxP7c_OLH1QnvYI6DcqlmxnjMdZ0>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 02:04:21 -0400 (EDT)
Date: Tue, 7 Jul 2026 01:04:19 -0500
From: Ian Bridges <icb@fastmail.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] Input: i8042 - replace strlcat() with seq_buf and scnprintf()
Message-ID: <akyW4xkvCCROM0SE@dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In preparation for removing the strlcat() API[1], replace its uses in
i8042-acpipnpio.h.

i8042_pnp_id_to_string() accumulates a variable number of PNP ids in
a loop, which is what seq_buf is for. The kbd and aux probe functions
build a name from at most three parts that are all known up front, so
the whole construction becomes a single scnprintf() there.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
scnprintf() is used rather than snprintf() because the name buffers
tolerate truncation by design and the builtin snprintf() triggers
-Wformat-truncation at W=1 for it. The output is unchanged in all
cases.

The possible truncation predates the patch. The name buffers hold 32
bytes, which is 31 characters plus a terminator. A full entry is a
7 character PNP id, a ':' separator, and up to 49 characters of PNP
device name, or 57 characters in the worst case. That leaves 23
characters for the device name, so a BIOS name longer than that is
cut short in the i8042 PNP console line. The old and the new code
truncate at the same point and produce the same bytes. Enlarging the
buffers would be a visible behavior change and is left for a separate
patch.

The patch was tested as follows:
 - An x86_64 build of drivers/input/serio/i8042.o at W=1 produces no
   warnings.
 - A userspace comparison of the old and new construction ran with
   randomized PNP id chains, device names, and buffer sizes. The
   outputs were byte-identical in every case.
 - Base and patched kernels were booted in QEMU, whose PS/2
   controller exposes PNP0303 and PNP0F13 devices. The serio
   firmware_id sysfs strings and the PS/2 controller console line are
   identical before and after the change.

 drivers/input/serio/i8042-acpipnpio.h | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 412f82d7a303..9ecb0eed48c4 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -3,6 +3,7 @@
 #define _I8042_ACPIPNPIO_H
 
 #include <linux/acpi.h>
+#include <linux/seq_buf.h>
 
 #ifdef CONFIG_X86
 #include <asm/x86_init.h>
@@ -1479,17 +1480,21 @@ static char i8042_pnp_aux_name[32];
 
 static void i8042_pnp_id_to_string(struct pnp_id *id, char *dst, int dst_size)
 {
-	strscpy(dst, "PNP:", dst_size);
+	struct seq_buf sb;
+
+	seq_buf_init(&sb, dst, dst_size);
+	seq_buf_printf(&sb, "PNP:");
 
 	while (id) {
-		strlcat(dst, " ", dst_size);
-		strlcat(dst, id->id, dst_size);
+		seq_buf_printf(&sb, " %s", id->id);
 		id = id->next;
 	}
 }
 
 static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
 {
+	const char *name = pnp_dev_name(dev);
+
 	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
 		i8042_pnp_data_reg = pnp_port_start(dev,0);
 
@@ -1499,11 +1504,8 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	if (pnp_irq_valid(dev,0))
 		i8042_pnp_kbd_irq = pnp_irq(dev, 0);
 
-	strscpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
-	if (strlen(pnp_dev_name(dev))) {
-		strlcat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
-		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
-	}
+	scnprintf(i8042_pnp_kbd_name, sizeof(i8042_pnp_kbd_name), "%s%s%s",
+		  did->id, strlen(name) ? ":" : "", name);
 	i8042_pnp_id_to_string(dev->id, i8042_kbd_firmware_id,
 			       sizeof(i8042_kbd_firmware_id));
 	i8042_kbd_fwnode = dev_fwnode(&dev->dev);
@@ -1517,6 +1519,8 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
 
 static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
 {
+	const char *name = pnp_dev_name(dev);
+
 	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
 		i8042_pnp_data_reg = pnp_port_start(dev,0);
 
@@ -1526,11 +1530,8 @@ static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	if (pnp_irq_valid(dev, 0))
 		i8042_pnp_aux_irq = pnp_irq(dev, 0);
 
-	strscpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
-	if (strlen(pnp_dev_name(dev))) {
-		strlcat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
-		strlcat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
-	}
+	scnprintf(i8042_pnp_aux_name, sizeof(i8042_pnp_aux_name), "%s%s%s",
+		  did->id, strlen(name) ? ":" : "", name);
 	i8042_pnp_id_to_string(dev->id, i8042_aux_firmware_id,
 			       sizeof(i8042_aux_firmware_id));
 
-- 
2.47.3

