Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164059;
	b=hmw/gp40UIPWLwVD4MRFVAvE9OUqbxXRUP8XSdPAE/F1sWRxYsAT32hBmdPFvJqeBvXU
	 S2d4UtdYh7nz9LI7w4CeEsUbWMpcBCvhC8NdApskq1QKpyaH54bBycwati0NJuWt7w7cU
	 TmLaGiQREX6ONcRrz5dW610UN1IwlsVNcixiqQd8Dt1o9oPfsFB7aUZHxsKR/83i5HON8
	 83Wxf3J+wC2ES+2T5eKXL+v4QBj9PkspuX/d1xMK/jDFhc/ssxUqPoA0WIFKpmUfU4GBR
	 pZJ9Edhpze0AAIEgfrOG+U3Ng92KFgOpZgIiZO2ltADrQC3w9tgHDADlDRa9JkyqAnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=rgy5Vju6ditzf8RwMLDG8EIp/gd3Q1etcgAz1qHp3+Y=;
	b=b95XGgfr3KsmIRR7yXj4ZPaqpgGO8EJ2QFuqnmJpK73b0TmYNycOkpOtJ5fPp7p4JSzs
	 tDVGIHMj839urMXQLNlD3jEEMK3i+A0I8RsbgmmSJpz0MNizYHB5PDvZHY6nigthCizeY
	 0inQLW5UiqKTa3vVL1WgkhCyJ0gJF/u6FqB13R6QVIFosFRybdIeBARs/Sz54eVAzRPOZ
	 ek06XTepU9B04sOPfpWTeJ/PS1SwBKggtd/N3kl4AxidTIvTWfZyKoSW41C6U125noZlU
	 VMop5sT7kI5B3VGWfOFTmzMZt1zOPnTr3p9ha6gcSL1/nFBsrn4sOiKta/1cmXaTQag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zVEt2lt6;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDD0606A338
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEDD0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zVEt2lt6
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38564b4b017so663954eec.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164058; x=1795768858; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rgy5Vju6ditzf8RwMLDG8EIp/gd3Q1etcgAz1qHp3+Y=;
        b=zVEt2lt6j3RSrcMzVrDWhPt37eB4VammH3c6O5mGP6/7MqQwj3QDPk2mo2fzhjy7aA
         /KQo3Ab1IAt7w4ico/AVlo5hxInhIxuN88zBm4HljIlrGtWR2uEA1gAlxKaazlv5b1Gz
         qmQF+tf7a//+Z4W8mT5Bm/O98mUdTlCyg1ge7VEtLCPdZDA91A75BkPJ0ynqLsu/MXJC
         xPe4Pjr3iIqBRbFfzuTqj1iAWRHfVC3nYtpyo16Xo2h08IVs48wQGxH9cFiqxAkFkseG
         cBEcGGF4zemaWuDQevaAU+bFFbQBKPuFXhJD6dnEap9O7V9j2xRYu9dFypkT/kn2qpo5
         UO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164058; x=1795768858;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rgy5Vju6ditzf8RwMLDG8EIp/gd3Q1etcgAz1qHp3+Y=;
        b=F8vsdSnc0T0RSHl1Uz2yAwY9fFxOahHmuP4aMb/cy6JSKZ5d5+P9uePp9g5x7guifu
         P4E5eHko0eqvHDm/849FS1+CQ9yltU2k4RKxP4pp9gVQjWcrntq7tMqTfz+PQtgq6947
         O/MT1nbFTLybPnPMSzEIhwrUSpbdVG6k28zFyflCqTu2aQZdXLByFY/Y1ELUOspiPgVs
         KQJgkFfgAxUx5ASHKJpz+TMTevpvYSTjqZxSwVeNqXZCrDWzhTXl4nNNRp38LL+L/NYW
         aT9qJf7Z85d7Qu7fsw70q+mDd/ys3Gf6iT5gquAnRabFjBArEoRIFRRnR/eDM00Xo86z
         DgRA==
X-Forwarded-Encrypted: i=1; AL+hErHQFUYaIDJJwN+5eMUDc5j4w5HW4aTIrNbmTmDWUC2W2rw7BE7sVEqNoJl4TC+Jlr7Bkirk9Epvs4KIog==@vger.kernel.org
X-Gm-Message-State: APuU4Z+qsYhFMlaJXiPf63rQk57lFOpbJQZJ3ERnKRu7qw0zVigtmCcx
	kILmYlK1IFy36PERH4mtg9RL9+dpJZNS+wREVNs1BYKx5iXEzcjqTr5+
X-Gm-Gg: AZFdTZcP8I93iK9GnXmJdHj/VIUK1kOs8esPw4Vccba79oY204eIsYjBakKyOyZ4VEy
	t0pWsiuFRbkLjuS5M9Fp0Sth6mULQJHUoU7TXD+ckM6Zz9F8xW9FSzK17uHSyFTvT3I8+L09azp
	azds4bU/7iB7Ya7YNE+36NuWdC0BKPAdEJfFA/BqRFWwaWgQCFvQUToUkYPV5kTJZtj9t8g5Jtl
	AXHUU46zloVjErFPNXYH5BA/egFW5PtycPto4RS9yBS0Y2DvkVUSQLHlSf+kZgCyZrH7nJMKRqS
	4pSNSpfEbuzgljZoS8+2n03k9CvsjnrpMoSK4XIsDMjRO27XmooqI69cfwjB6GvCC2DdLx8v5JI
	EAUYdjBpnhBR8jU/nL3jk2vCa27e7JehnNL1sSRE50jm0q5yCYNg6aK258xZIBqOziv/vf2zvvk
	v/jxGyNDeGUATin7K5wubGuVMcK1PGmU45bQwSdrKr60CYskAChan9nxubph0wlqqvV1JRVXq6S
	8Yhy0FGABtijDjSgaZr9VwrfMIFMX7njZQBzlDM2w78GJ77KFVA/2u0jjVIM74lg/UxpIkQL+yn
	wgC6Atwzxtqe8orQXq+5E0LS154EQP4yXQdLKWGpxIWJ1nuM/kZfED34H9p0iZNkvfMn2h/rnKX
	TndrW8vVRsJK7hn4ajQ==
X-Received: by 2002:a05:7300:d18f:b0:36c:fdba:ee36 with SMTP id 5a478bee46e88-38570e2a37dmr1891976eec.12.1795164057789;
        Fri, 20 Nov 2026 00:40:57 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:40:56 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 00/14] HID: logitech-hidpp: G920 force-feedback and
 battery fixes
Date: Fri, 20 Nov 2026 00:40:48 -0800
Message-Id: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJAHAGsC/22Oyw6CMBBFf4V0bUkfpBRX/odxAbTQUaGkxUZC+
 HdbdMHCzSQnuffcWZHXDrRH52xFTgfwYMcI/JSh1tRjrzGoyIgRJiilBBtQ+Gl7mHVrEkwTFlI
 WTdeImhcSxeLkdAfvXXq9fdm/mrtu52RKCQN+tm7ZVwNNud8AqUi6PGdSloILTLEaYHZLHvP2Y
 Wy49EMNz7y1A0ruwA7t/+8FhgnmpCy4rqiSvDkqtm37ACiyhEAEAQAA
X-Change-ID: 20261110-hid-logitech-hidpp-6884bfb6a348
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Per Jiri Kosina's request, the v2 series has been split into this
14-patch bug-fix series targeting v7.4 and a separate 18-patch rework
and cleanup series targeting v7.5. The open-evdev-across-unbind
force-feedback teardown use-after-free (v2 patch 22/33) is now handled
in input core ("Input: destroy force-feedback device on input
unregistration") and has been dropped.

This series starts from Gideon Heinz's report of Logitech G920
force-feedback initialization timing out in v7.3 and addresses several
pre-existing bugs and lifetime races in hid-logitech-hidpp.

The force-feedback and teardown fixes temporarily enable device I/O
around g920_get_config() in hidpp_input_configured(), switch
hidpp_ff_queue_work() to GFP_ATOMIC since callbacks run under the input
event spinlock, drain the G920 FF workqueue before closing the HID
transport on input close, synchronously disable driver work items and
disconnect input devices with device I/O enabled before stopping the
transport on removal and probe failure, avoid storing an ERR_PTR in
battery->ps on registration failure, avoid NULL pointer subtraction in
the HID++ 1.0 consumer keys report fixup, and fix an off-by-one in G920
slot tracking that made the 63rd user effect in slot 64 unusable and
leaked it across reopen.

The transport and battery fixes update hidpp_send_message_sync() to stop
retrying timeouts and transport errors, initialize response buffers
before publishing send_receive_buf to eliminate races with concurrent or
spurious packets, fix HID++ 1.0 battery mileage event parsing and state
updates, properly propagate negative errors in ADC measurement (0x1f20)
queries, mark devices online on unified battery (0x1004) events while
gating 0x1000/0x1004 dispatch, fix K750 solar battery feature lookup and
reconnect handling, and expose and correctly map the charge_type
property for the battery voltage (0x1001) feature.

Note that device removal teardown still has limitations due to how HID
core's hid_device_io_start() and hid_device_io_stop() (via
driver_input_lock) gate both driver raw command/response I/O and
subdriver event forwarding, disabling I/O before .remove() and
hid_disconnect(). For instance, HIDPP_QUIRK_DELAYED_INIT devm-managed
input devices are still unregistered after hid_hw_stop(), and
hidpp_connect_event() publishes hidpp->input before input registration
completes. Resolving these teardown edge cases cleanly will require
follow-up work in HID core and driver input registration.

Thanks.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v3:
- Split out the 14 bug fixes into this series for v7.4 per Jiri Kosina,
  moving the 18 rework and cleanup patches into a separate series for
  v7.5 and dropping v2 patch 22/33 in favor of input core teardown.
- Collected Tested-by tags from Gideon Heinz on all unchanged patches in
  this series (omitted from patches 12 and 14 which were updated after
  v2 testing).
- Gated event dispatch in hidpp_raw_hidpp_event() on
  HIDPP_CAPABILITY_UNIFIED_BATTERY so 0x1000 and 0x1004 events are
  routed to their respective handlers instead of cross-corrupting
  battery state.
- In hidpp20_battery_map_status_voltage(), set charge_type to unknown
  when status is unknown, to none when discharging, full, or not
  charging, and to standard, fast, or trickle only when charging.
- Reset charge_type to unknown on wireless disconnect in
  hidpp_connect_event().
- Link to v2: https://patch.msgid.link/20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com

Changes in v2:
- Rebased the series on top of linux-next.
- Collected Tested-by tags from Gideon Heinz for 17 v1 patches (omitted
  from patch 4 where hidpp_remove() was significantly altered).
- Reorganized the series to place all 14 stable bug fixes upfront,
  followed by next refactorings and modernizations.
- Updated hidpp_remove() to enable device I/O while draining work
  items and disconnecting hidinput so in-flight transfers and
  force-feedback teardown can receive device replies (noting that
  complete resolution of delayed-init and transport teardown ordering
  requires follow-up work in HID core).
- Stopped retrying non-busy errors (timeouts and negative transport
  failures) in hidpp_send_message_sync().
- Initialized response buffers before publishing send_receive_buf to
  prevent stale response reads on concurrent or spurious events.
- Fixed HID++ 1.0 battery mileage event parsing to read capacity from
  the correct report byte and update battery state.
- Handled negative transport and timeout errors properly in ADC
  measurement (0x1f20) queries.
- Marked devices online when receiving unified battery (0x1004) events.
- Fixed K750 solar battery feature lookup and reconnect handling.
- Exposed charge_type property for battery voltage (0x1001) feature.
- Link to v1: https://patch.msgid.link/20261109061103.2887636-1-dmitry.torokhov@gmail.com

---
Dmitry Torokhov (14):
      HID: logitech-hidpp: fix G920 force-feedback initialization timeout
      HID: logitech-hidpp: use GFP_ATOMIC in hidpp_ff_queue_work()
      HID: logitech-hidpp: drain G920 FF workqueue before closing transport
      HID: logitech-hidpp: disable works before stopping transport
      HID: logitech-hidpp: do not store ERR_PTR in battery->ps
      HID: logitech-hidpp: avoid NULL subtraction in consumer key report fixup
      HID: logitech-hidpp: fix off-by-one in G920 force-feedback slot tracking
      HID: logitech-hidpp: do not retry timeouts and transport errors in hidpp_send_message_sync()
      HID: logitech-hidpp: initialize response buffer before publishing send_receive_buf
      HID: logitech-hidpp: fix HID++ 1.0 battery mileage event parsing
      HID: logitech-hidpp: handle negative errors in hidpp20_get_adc_measurement_1f20()
      HID: logitech-hidpp: mark device online on unified battery 0x1004 events
      HID: logitech-hidpp: fix K750 solar battery feature lookup and reconnect
      HID: logitech-hidpp: expose charge_type property for battery voltage feature

 drivers/hid/hid-logitech-hidpp.c | 150 ++++++++++++++++++++++++++++-----------
 1 file changed, 107 insertions(+), 43 deletions(-)
---
base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
change-id: 20261110-hid-logitech-hidpp-6884bfb6a348

Thanks.

-- 
Dmitry

