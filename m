Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793373651;
	b=mBQBoJQvn1kHOWnnrp38p6BH2Ol82/FwQik/1+xWRZDLBIir+KFLFBCdU+/3UwxS7EOn
	 DORge4CZvcFeHMnsI6SQ/9hU4jQ3AYEoukqEZtFeoum8ZIUzJ25Pt29TE9Yttpjqh2tzR
	 HRBcWZDuc2eFY2UtMt9BInmGAWLxm34SirittQBwczFGEPl8t4wmELB160RPcDt8xIkUo
	 GRikjSO4yNuIuY3Ls/GWmc758otX/z1Pkn6j+OJhnKAoD7inVTs0JFCnTlcyqN5X9J5tb
	 xtPyed2YIZ9/K27Bre8CmCRXNHtTMynITntW5V5yZ7D39gJ4nrKVuoIaGfa6v3N27mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373651;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UywTeJ3b/nMRoVFm0BMzcCNvr4agf/sI4YfJGQPztEY=;
	b=lXtm87+waRSRnFy3ZEum1zIFQHGOCaMp59lmkzPqvFEIOpHXBpeoiZmSyB6l2hgmzTMI
	 VgBO5CSeUhbMXtXt/79ETgcpINueo68O5qZUsfKcBnrb7HEV4PJCr87NpsRS3XRjD9A6c
	 Ilc4KutNykau2a2w2f/17OEXuRJyuew4UDa4+JkQ/vgg6RLNvSd6B2HxjYAAwtgS/iu7/
	 S7WgjQUwpLM/n6A7WMclcE6uhIS31qgKD+1LNd+VPNzoi845ILYulUzog+dVghKL7FQY+
	 m6h35WkzA7rVfQFqNn6N2zdl+/lIOYgQFkN7FjE+Zt/PmHhIhUm8auHULqW448XBWcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5EiP9Gf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A3606A31A;
	Fri, 30 Oct 2026 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5EiP9Gf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793373650;
	b=tvajSqw8aydcOJ6aODXa7Qe9eWOcV2oq+OytEUpwIHaWz4+1+tJ4Q4bEUbLstqJc+pnB
	 XEUDMPmQXj2gqoj8fQt6rdXGp5MJDWxgIeoVtobfyzUYbQSkg+PrcmV8+M7tM8eX7V+rT
	 hji/GOk77BpyLn+o+QHjVWh+zQyz47uM+uZ/iVqzq/PgoMqNhE4ZRYMaJS9SyLwwYnmNi
	 k9zVpWJhY4ckg76strlKKjXgj91JIk4BUqCKJzTZBR28ROC3UrDGV4E4V6QjG87YMuU14
	 ZWXiG5kGkSsRCDstKEXzjON7WWOyvAZomUPQu6ItLDqkBfL+6+XbFmvwdW/HGg/YoJA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793373650;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UywTeJ3b/nMRoVFm0BMzcCNvr4agf/sI4YfJGQPztEY=;
	b=UoFZTjwGjUkysdpzy0BEokThvZoNW7k/y8+hCgc/dqX4SmG6iXSKujOgUXm2Qir+G0V3
	 14wdQnH+Pwprpffa8l+kELnEHF2vH0VcnPDDGZhUq5fEjyo9SkVAP9Ia6Cfm+sWAwYtgV
	 ZMVeljBVaVJKOGkMev4f+9kNr9sZ4r8N/jxjiBdQOKHl8mZfH1KNo/srrymuvYqOOkfOn
	 GsYmf4+qd5jVBXW6z9I85LwmH49fTSR3QnHiWt/O6zI7C+lAaPnEGdIz0TVk6hlKjlyPH
	 xMDJfKUGyIoFpsiiLrWcN6ITDkN9WT55CgQAVydcqdg6w8nM7EQzkyY2Z66weDVIFmQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 05A0C1F000C1;
	Fri, 30 Oct 2026 15:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373650;
	bh=UywTeJ3b/nMRoVFm0BMzcCNvr4agf/sI4YfJGQPztEY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=c5EiP9GfADec5ub6TGu3mPiAQGXqHQpJ9w5g2vHbheAnntN2+VM2F0VPq31ZEPFYr
	 zA0JpRliCHzbe6qdmedJpjCSHt8yrt7oEQn6JicVfxkTf44yHt8o6Flk9K8gFQ+oLK
	 kvjY8EjDg19PAgA28s/475X4zMmqSSqUle3WLYDFEm4+ub7dNpFQ4ldjuQ/+Fx8en1
	 /qKrHfvwjK7CmylzAyJ/W+ribd7U6juT+Z/4qfCXiJYPbtEtGrjnR36hWjAfqXWYtF
	 Nix4xhV0/hFGj3CC4/8SmAreDAdhpTHUmcID9x9/uw31MS29U8ZrieBRC7BTrREwMg
	 mjsjjb7d6svaA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 55C6B4381C;
	Fri, 30 Oct 2026 15:20:49 +0000 (UTC)
From: Jonah Dybas via B4 Relay <devnull+jonah.w.dybas.protonmail.com@kernel.org>
Date: Fri, 30 Oct 2026 11:20:49 -0400
Subject: [PATCH] HID: asus: add support for the GL553VW keyboard
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261030-gl553vw-kbd-v1-1-cbbd88493511@protonmail.com>
X-B4-Tracking: v=1; b=H4sIANC15GoC/yXMTQ5AMBBA4avIrDVpSwlXEQutwSBI6y8Rd1csv
 8V7Fzi0hA7y4AKLOzmaJw8RBmC6amqRUe0NkstE8IizdlQq2g826JplcaVSZaQUOgVfLBYbOr9
 bUf52m+7RrO8C7vsBeLuSt28AAAA=
X-Change-ID: 20261030-gl553vw-kbd-94a575c221b7
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonah Dybas <jonah.w.dybas@protonmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373648; l=3905;
 i=jonah.w.dybas@protonmail.com; s=20261030; h=from:subject:message-id;
 bh=MLUYdGu6qDugl1acxLXpGGQXtKgpDGo2n+A1gQJjwFM=;
 b=ftLtJr/eej3b1KrFKugwpb2CftenPPYelJ4Db2+1A8KPOTC65Bu06xiLORpx579mIIHqR6SIE
 ruSIK/eN2Y3BmmRVmy3QmEDom0LBgAneHpWJIi5B7lb77YzPBnqm2zC
X-Developer-Key: i=jonah.w.dybas@protonmail.com; a=ed25519;
 pk=xj+D5YSRYYNylSntmoQSj9kbGTB3QprYsXr53ZDSP0c=
X-Endpoint-Received: by B4 Relay for jonah.w.dybas@protonmail.com/20261030
 with auth_id=1363
X-Original-From: Jonah Dybas <jonah.w.dybas@protonmail.com>
Reply-To: jonah.w.dybas@protonmail.com
Content-Transfer-Encoding: 7bit

From: Jonah Dybas <jonah.w.dybas@protonmail.com>

The built-in keyboard of the ASUS GL553VW (ITE Device(8910),
USB 0b05:8176) is handled by hid-generic, so its backlight cannot be
controlled and the Fn+F3 and Fn+F4 backlight keys arrive as plain F3
and F4.

The laptop's BIOS (306) offers no working WMI path either. DSTS for
ASUS_WMI_DEVID_KBD_BACKLIGHT always returns 0x8000 and the related
DEVS handler is an empty stub, so asus-wmi never registers
asus::kbd_backlight on its own.

The keyboard does implement the vendor interface used by other ROG
keyboards (usage page 0xff31, report 0x5a). After the "ASUS Tech.Inc."
handshake it reports backlight support in the functions query and
accepts "5a ba c5 c4 <level>" to set the brightness (0-3). The
backlight keys are reported on the same report:

  5a c5 -> Fn+F3 (backlight down)
  5a c4 -> Fn+F4 (backlight up)

Add the device ID with QUIRK_USE_KBD_BACKLIGHT |
QUIRK_ROG_NKEY_KEYBOARD.

Tested on a GL553VW (BIOS 306) by binding the keyboard to hid-asus
with these quirks through new_id on a 7.0-based kernel. The keyboard
backlight (asus::kbd_backlight) is registered through the asus-wmi
listener and can be changed from sysfs and the desktop. Fn+F3/Fn+F4
adjust it, and the level is restored after suspend/resume.

The investigation, this change and a first draft of this changelog
were produced with the help of Claude Code (Claude Opus 5.5), then
reviewed and tested on the hardware above.

Signed-off-by: Jonah Dybas <jonah.w.dybas@protonmail.com>
---
- The handshake readback does not match the request, so probe logs
  "Asus handshake 5a returned invalid response". It is only a warning.
  The keyboard answers the handshake read with
  "5a 05 20 31 00 08 01 00 ...", which looks like the reply to the
  functions query, so it does not seem to echo the handshake at all.
  The functions query that follows works and reports backlight support
  (byte 6 = 0x01). Worth keeping in mind if the handshake check is ever
  made strict.
- Compile-tested against hid/for-next. I could not boot-test the
  for-next build because Secure Boot on this machine rejects unsigned
  modules. The hardware testing above used the distro 7.0 hid-asus with
  the same quirks via new_id.
- The investigation (ACPI table analysis, HID descriptor decoding,
  hidraw experiments), this patch and a first draft of the changelog
  were produced with the help of Claude Code. I reviewed the result
  and ran the tests on my hardware.
---
 drivers/hid/hid-asus.c | 3 +++
 drivers/hid/hid-ids.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index f6aa1be09..97b601f20 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1814,6 +1814,9 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_FX503VD_KEYBOARD),
 	  QUIRK_USE_KBD_BACKLIGHT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+		USB_DEVICE_ID_ASUSTEK_GL553VW_KEYBOARD),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa65..edf7bdd37 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -234,6 +234,7 @@
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X		0x1b4c
 #define USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD	0x196b
 #define USB_DEVICE_ID_ASUSTEK_FX503VD_KEYBOARD	0x1869
+#define USB_DEVICE_ID_ASUSTEK_GL553VW_KEYBOARD	0x8176
 #define USB_DEVICE_ID_ASUSTEK_XGM_2022	0x1970
 #define USB_DEVICE_ID_ASUSTEK_XGM_2023	0x1a9a
 

---
base-commit: 720806515cb6921ab05caaa6f470f7054b56385e
change-id: 20261030-gl553vw-kbd-94a575c221b7

Best regards,
--  
Jonah Dybas <jonah.w.dybas@protonmail.com>


