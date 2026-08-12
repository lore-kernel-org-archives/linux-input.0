Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4538D686
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564742; cv=none; b=VLev5m0+XCqrIFRuHXIMINXBNrNvSkhMfygG84A0avSgpuks8kj2cPRjrpwshoumJvNLAYQZL52nHXFWOXc9P9JJauQCQeI1rl2b1NSbtQZ5C6H6ZcjDhx7Xn4/MtoKuDf63tIrRYCmaFkS8xbCFqaIsS1WSVhUtFwIMhh0vZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564742; c=relaxed/simple;
	bh=n0GH+OWCPiQbCK+pOjN8zQWOAE90DEWqe0vP8H4K+Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSsiXp2fySMn39Nq3wPzQWllhTsCAQGotIAuvALrOlE3gB4Uc+B/XvSeEV4eMyI1EOlZvRxTeeOV0wObu3POn8esh1yk7uJNhGGDTrVnB0tRY8nKu6e2OdfwF/36Kn51SGV2Gv0tCVbSuyBV586Oe8gKhXu46EWuOa6jYTMlECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWbG6iGc; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWbG6iGc"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f7854678cso920879f8f.1
        for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564738; x=1787169538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n1F/zEbFxiWva+aKEZ6lMQmJ8M7Zi836+yqUd1iNpzs=;
        b=cWbG6iGc1mUglLrx0/CeSOKuiP2dA87qpCcGua6W8B+anMCHmfgXcLZNL9+oxZhATe
         F3hgfsHjQT3epfyyCGXfvJkrCiRPHsaBngvNyK5hH75bCpoCd+ZPu/AYb4eQPzdVhWRt
         IvoGk9OIHkvKD4JaV7hiKOVfU2KqbYuxncp3hLL3X1oc2o9xkOsYUI69yMJDIlk0FZsf
         zJ16dDtapVK0OIALGesBlLYufxGaQ3Vy4CrOy9fiIGEgdHqLP6yphBYCqDgvebnbAAWQ
         1N8nIYWiJtC1/3n9M8yA+Yx657eTQjlwyuQ3hAYiZmu+qTJsBjt5aox01J3bdxTev8C+
         5QZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564738; x=1787169538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n1F/zEbFxiWva+aKEZ6lMQmJ8M7Zi836+yqUd1iNpzs=;
        b=XrIY+Tul39z7xurSJDaNskiI0QFRsaPfw3iIP7Rv5DcvvNegW3ri3aHPQsXCPpw76o
         i/9qsK0uIw+IHh8yNxkeBpvsOqKhHRtfniMWnqdUEwr9wx8cGOwtfKNAk/d7X1ulju4Y
         Ew04pUKeRMK7x+SNf2Rs7ns0ztH9EUe+Gc7NVzdJGAB49z74XNL3tStLlpgxNRJJJJhl
         DtgjsSYNccA9tReDWR5Qwob310CcHlX7zrHzj1mMPM6lkzd7vYb5MhSUS4NhaTI3m4cn
         dwRKF5k7gTQumPn1l3lbgAHljBY6KYgQHsl7Dk9ZWR6QrCHDkhY/da0nXP4oTNOYpjFk
         NGPA==
X-Gm-Message-State: AOJu0YzZdwh6J6vpJtcSUti1yDYYSlKackaq1rveG6yS/rgvi7bbkOvx
	UhE0ZhuFbHDHbv8m+J/QdLDoHGn0N5CZnw1zP7zaZtPh5Jbr2B6fAjvUYY9Nr7y/
X-Gm-Gg: AR+sD10JkxlPHOUhFu0LNqZATFwd+DrysQBJbB/3iDwMH9eWFpJPjXmI4xQSZhRQkv3
	4eoA9OhiC6bN8I5aJbsBM4mnLr5UEn0n0hsUs6aeRvuC0yQKTje5nR+ka1KSUzTo5tx9u5MXjLH
	kZ5/kq2Z/ggkJVJvACM/3A1xJpV66kPGo1Tx7u6Agp+VXfzecEVVw5ncCP7z1z4HKESmVxWCmWd
	oUoGTweM/BFEu7Ba3XjzKDyBqt9/hCk/beHPXnO9DICYglJxCE6+27IK/7y9rnZ0OhWYjRg8hDE
	I8PfyPORTIWr853AXR519+r4+HHO33NwWJ+uUhprOUDxgUUPWGuA5G0ge5d23fGO6N0g1iBwe9S
	3HAxHXISaAsx4pp9XtddwYsg90HLk6hPt9r0oiCq1/Ven6/rASGQ/RSkO4p9DNFEVeoNLTgAO6H
	daNRXb84UHd3JyEhz8rFeTT5jdSgiZxuUIhkuDXCfRr4SwWRrPg981E6R8vrwNXkeUQt8MEMTZ+
	eVaPnGDkLp0jLs=
X-Received: by 2002:a05:6000:2089:b0:481:573d:9d29 with SMTP id ffacd0b85a97d-48159fe5225mr844254f8f.14.1786564737843;
        Wed, 12 Aug 2026 12:58:57 -0700 (PDT)
Received: from localhost (97-115-90-76.ptld.qwest.net. [97.115.90.76])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4815a569325sm153780f8f.14.2026.08.12.12.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 12:58:57 -0700 (PDT)
From: Elliot Douglas <edouglas7358@gmail.com>
To: linux-input@vger.kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	edouglas7358@gmail.com
Subject: [PATCH v3 0/2] HID: logitech-hidpp: fix Signature M650 side button timing
Date: Wed, 12 Aug 2026 12:58:40 -0700
Message-ID: <20260812195842.77724-1-edouglas7358@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Logitech Signature M650 over Bluetooth exposes its side buttons in the
normal mouse report, but the reported BTN_SIDE/BTN_EXTRA events are short
click-like events emitted around button release rather than physical
press/release events with the real hold duration. The device appears to reserve
the held side-button state for a built-in gesture mode: holding a side button
more than approximately 2 seconds, or holding it while using the wheel for
horizontal scrolling, can mean the normal mouse report never emits a usable
side-button press at all. That makes the buttons unusable for standard Linux
hold actions such as push-to-talk, drag modifiers, or remapping rules that
depend on key-up timing.

When HID++ 2.0 feature 0x1b04, SpecialKeysMseButtons /
REPROG_CONTROLS_V4, temporarily diverts the same controls, the device sends
diverted-control notifications with real press and release timing. This series
adds quirk-gated support for those notifications and enables it for the
Bluetooth Signature M650.

Before enabling diversion, the driver verifies that each mapped control is
present in the device's HID++ control table and is advertised as a divertable
mouse control.

The kernel only programs temporary diversion when the device connects. It
does not continuously force the setting. A userspace HID++ tool such as
Solaar can still issue HID++ commands through hidraw; if Solaar changes the
reporting mode for the same controls afterwards, the last writer wins. That
means Solaar can still take over those controls for custom actions, but the
kernel will no longer receive the diverted button notifications for normal
evdev reporting until the kernel diverts the controls again, for example after
reconnect. While the controls remain diverted, hidraw clients should still
receive the raw reports and the kernel reports the matching evdev state.

The diverted M650 controls are reported as BTN_BACK and BTN_FORWARD. Logitech's
Signature M650 getting-started page labels these physical controls as
Back/Forward buttons and describes their default page-navigation behavior:
https://support.logi.com/hc/en-nz/articles/4414473810583-Getting-Started-Signature-M650

The reprogrammable-control support is per-product and parses the full HID++
divertedButtonsEvent pressed-control list, so it can support devices with more
buttons without relying on a single last-control release heuristic. Only the
Signature M650 opts in for now. Other Logitech devices should only be enabled
after their HID++ control IDs and divertedButtonsEvent behavior are captured
and verified.

There is evidence that this is not unique to the M650. A prior MX Anywhere 3
patch used the same HID++ feature to fix thumb buttons that only activated on
release, and Logitech documents side-button + wheel horizontal scrolling for
both the MX Anywhere 3/3S and Signature M650. Solaar's device reports and rules
documentation also show HID++ divertable back/forward controls on MX Master 3
and MX Master 3S class devices. This series remains conservative and only
enables the device tested here.

Tested with a Logitech Signature M650 L over Bluetooth, HID ID
0005:046D:B02A. Baseline evtest showed short release-time BTN_SIDE/BTN_EXTRA
events. Earlier local testing of the same HID++ diversion path showed real
hold-duration press/release events, including holds longer than 4 seconds for
both buttons.

Changes in v3:
- Move the M650 product ID define to drivers/hid/hid-ids.h.
- Clarify the M650 long-hold threshold in the patch text.
- Add Bastien's Reviewed-by tag to patch 2.

Changes in v2:
- Replace the profile/count wrapper with NULL-terminated mapping arrays.
- Cache the selected reprogrammable-control mapping in struct hidpp_device.
- Add a named constant for the M650 Bluetooth product ID.
- Use common Back/Forward names for the 0x0053/0x0056 HID++ control IDs.

v2: https://lore.kernel.org/r/cover.1783094954.git.edouglas7358@gmail.com
v1: https://lore.kernel.org/r/20260613175109.44365-1-edouglas7358@gmail.com

Elliot Douglas (2):
  HID: logitech-hidpp: add HID++ 2.0 reprogrammable button support
  HID: logitech-hidpp: enable reprogrammable buttons on Signature M650

 drivers/hid/hid-ids.h            |   1 +
 drivers/hid/hid-logitech-hidpp.c | 223 ++++++++++++++++++++++++++++++-
 2 files changed, 223 insertions(+), 1 deletion(-)


base-commit: f0866517be9345d8245d32b722574b8aecccb348
-- 
2.55.0
