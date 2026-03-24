Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E22EC0B0;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381237; cv=none; b=jKCzWn9P9OmEKiZgsSOolzCuHk92qgk5xK6yqsMHFwT3vBpKXrM9J49sCqqt6DCQU7w4gF5oYo6vnWq3Ymh3B8vZAsi2u6MbLuEermBfA3v2Em6WHuq9leKauGxxX3kL0qiUMcGWLlu+CvPaUlWP2XcfNvslp1L8pHNvElYDHTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381237; c=relaxed/simple;
	bh=/V7BySMjCo3jUZIyMYBn2D+gdXsd0s+9SRYDEJXm7yY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tzia8nBScFwZ5URmka/HVJ5aEqz6HReib5gq01CSOo8lCRY/2OoXKc/LmR5Bpd81vd3Xk+yTfY78irElP/zet156Gkw/rw9myQFWGVvIugdGjfzZss8yeZ/424TSW06zzsp6E9wPz34HBIEueijGG0Qy0J1RHX3o55a41ENQExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khylQcld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khylQcld"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B203C19424;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774381237;
	bh=/V7BySMjCo3jUZIyMYBn2D+gdXsd0s+9SRYDEJXm7yY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=khylQcldzYAIQNj9U95QB6Jtitc6h4phgg1W2C6HxtPRww+mwvxkDGIZGBh+l9+MG
	 DdkPwcgUzy7iWq+pqMKkQtYw12D4lgGgsNF9mA8crErFr1YPFRvUefT7vpNG9wvS89
	 sO6ZH8jeW0Pq81FV/ChrnEJV+U0h46U0H4r6yE5SRDx/o4zitdWFS2BXzcwzWwfgtc
	 yK9clUwHjw6KdKD8h5MgkAmk9v5S/gUPQVolFQS0rzJeUVSqq8B9lLw5JG2n7FqR91
	 0es7WYXgKrmc4Q7Cin3f2ldOCDZ7YP0UhsUzfXiAe8KaBCSNOiSBbiWHUMKmLVpsAD
	 gyv7OmkMuOLJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C960FEC101;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v8 0/7] Input: synaptics-rmi4 - add quirks for third party
 touchscreen controllers
Date: Tue, 24 Mar 2026 20:40:33 +0100
Message-Id: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALLowmkC/3XNy2rDMBCF4VcJWldlpNG1q75H6UI3N7OoEyRjk
 ga/e+VAmxpTtDoD368ba6VSaezlcGO1zNToNPbhng4sHcP4UTjlvpkEqQHB8XYdw3mi1Hj9JMW
 TQxnlYDGVyDo61zLQ5R58e+/7SG061eu9P+N6/Tc1Iwcuhc5YrHQ+yFe60PScvtgamtUDK5A7r
 DoWMXrdX9FGbbH+gwXssO44qpXDYF30W2x+sRACd9h0nL1DE4YQHYgttj/YAMr9z7ZjtB4N5CJ
 chgdeluUbnWeAD54BAAA=
X-Change-ID: 20250308-synaptics-rmi4-c832b2f73ceb
To: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4850; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=/V7BySMjCo3jUZIyMYBn2D+gdXsd0s+9SRYDEJXm7yY=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpwuizy1m0+IaDQ3GmkMRuLY8JfBz5A0k/molBU
 frRMcvHGMSJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacLoswAKCRBgAj/E00kg
 cqlMEADQiQ/exVultGOPe8CuxXCg1MLM/YEQKYB8lvgWPe3I500GW7Ws7PP8TY2He7EmoHCRydK
 FeUBI+tfDp/Y9jLSOEHKogJRMFRKGdmD+ZP0zMM/3PtWLMGACkDNKuhPbYg8sUmzERQz9BFBcrx
 iO0XLeAzuef1hbpToxCZG19q4lyhpmfwlMktlSZu51oGBFwlKEWLnKreSzzNMRPHUVwEt8GhiIU
 FOdl8HJSPiujDoEYuYO/0ePpfx/QAbBU8vED86MXxzzBAffpnE+4x6Axzx/kt6Clx0RtgrmOLYM
 +/CQrPK5JyKT7HPcWOZjJNX6gGC2J12zFZdMM5kAy5TEeJYi+upIUZONuKvy4BpdVh1pYykRaGI
 Lx/PrBcgpldBsmv3i7zT56x5y8XVo1Ep9so8nVdMY0/qVn3otLRViQjE1brzozJsY78+s8JKm3m
 LtsA+J9Uj3rNF1MDRSehs8o+/rCjK1gZP8KCYC26k2AAagjjdEc6Z5JeJyC2qdc51HzQaon0N8d
 Vg/jMKdBFxUEoeTWQALGwaS3+IWxT9BZ9iWLUD10jWsoBYdySZ6KSOnYL/oSb0CLVpvmbdkB3mm
 BKperEFfwf+EjapHotJhNv6E/37qiPxvvUKUnF2OfZmLg7V7Vwwp7Lz1JapILViXECddT7bmolI
 XyhupG3jF1RaY/Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

With the growing popularity of running upstream Linux on mobile devices,
we're beginning to run into more and more edgecases. The OnePlus 6 is a
fairly well supported 2018 era smartphone, selling over a million units
in it's first 22 days. With this level of popularity, it's almost
inevitable that we get third party replacement displays, and as a
result, replacement touchscreen controllers.

The OnePlus 6 shipped with an extremely usecase specific touchscreen
driver, it implemented only the bare minimum parts of the highly generic
rmi4 protocol, instead hardcoding most of the register addresses.
  
As a result, the third party touchscreen controllers that are often
found in replacement screens, implement only the registers that the 
downstream driver reads from. They additionally have other restrictions
such as heavy penalties on unaligned reads.
 
This series attempts to implement the necessary workaround to support  
some of these chips with the rmi4 driver. Although it's worth noting
that at the time of writing there are other unofficial controllers in
the wild that don't work even with these patches.
 
We have been shipping these patches in postmarketOS for the last several
years, and they are known to not cause any regressions on the OnePlus
6/6T (with the official Synaptics controller), however I don't own any
other rmi4 hardware to further validate this.

The series is also available (until merged) at
  https://codeberg.org/sdm845/linux/commits/b4/synaptics-rmi4

---
Changes in v8:
- The pdt_scan_state->pdts array should actually be of size
  (RMI_PDT_MAX+1). (Casey)
- Move the pdt_count introduction to the relevant patch. (Casey)
- Link to v7: https://lore.kernel.org/r/20260320-synaptics-rmi4-v7-0-379360de18d0@ixit.cz

Changes in v7:
- Rebased on top of next-20260320, no other changes.
- Link to v6: https://lore.kernel.org/r/20251113-synaptics-rmi4-v6-0-d9836afab801@ixit.cz

Changes in v6:
- Rebased on top of next-20251113.
- No other change since the Rob Herring comment.
- Link to v5: https://lore.kernel.org/r/20250410-synaptics-rmi4-v5-0-b41bb90f78b9@ixit.cz

Changes in v5:
- Removed -i2c suffix from rmi4-s3706b-i2c (Krzysztof).
- Link to v4: https://lore.kernel.org/r/20250402-synaptics-rmi4-v4-0-1bb95959e564@ixit.cz

Changes in v4:
- Replaced patch "dt-bindings: input: syna,rmi4: document syna,pdt-fallback-desc"
  with patch documenting specific touchscreen model used in OnePlus 6 and 6T.
- Fixed zero electrode return code (Dmitry).
- Switched the duplicate detection algo to bitmap (Dmitry).
- Optimized rmi_device_platform_data struct to avoid unnecessary
  padding.
- Changed fallback_size from int to unsigned int.
- Changed SoB from nickname and old address (methanal <baclofen@tuta.io>) to
  Kaustabh Chakraborty <kauschluss@disroot.org>.
  Verified ownership through the sdm845 chatroom on Matrix.
- Link to v3: https://lore.kernel.org/r/20250308-synaptics-rmi4-v3-0-215d3e7289a2@ixit.cz

Changes in v3:
- reworded dt-bindings property description
- fixed the rmi_driver_of_probe definition for non device-tree builds.
- fixed some indentation issues reported by checkpatch
- change rmi_pdt_entry_is_valid() variable to unsigned 
- Link to v2: https://lore.kernel.org/all/20230929-caleb-rmi4-quirks-v2-0-b227ac498d88@linaro.org

Changes in v2:
- Improve dt-bindings patch (thanks Rob)
- Add missing cast in patch 5 to fix the pointer arithmetic
- Link to v1: https://lore.kernel.org/r/20230929-caleb-rmi4-quirks-v1-0-cc3c703f022d@linaro.org

---
Casey Connolly (1):
      Input: synaptics-rmi4 - handle duplicate/unknown PDT entries

David Heidelberg (1):
      dt-bindings: input: syna,rmi4: Document syna,rmi4-s3706b

Kaustabh Chakraborty (5):
      Input: synaptics-rmi4 - f12: use hardcoded values for aftermarket touch ICs
      Input: synaptics-rmi4 - f55: handle zero electrode count
      Input: synaptics-rmi4 - don't do unaligned reads in IRQ context
      Input: synaptics-rmi4 - read product ID on aftermarket touch ICs
      Input: synaptics-rmi4 - support fallback values for PDT descriptor bytes

 .../devicetree/bindings/input/syna,rmi4.yaml       |  11 +-
 drivers/input/rmi4/rmi_driver.c                    | 124 +++++++++++++++++----
 drivers/input/rmi4/rmi_driver.h                    |  10 ++
 drivers/input/rmi4/rmi_f01.c                       |  14 +++
 drivers/input/rmi4/rmi_f12.c                       | 117 ++++++++++++++-----
 drivers/input/rmi4/rmi_f55.c                       |   5 +
 include/linux/rmi.h                                |   3 +
 7 files changed, 234 insertions(+), 50 deletions(-)
---
base-commit: 85964cdcad0fac9a0eb7b87a0f9d88cc074b854c
change-id: 20250308-synaptics-rmi4-c832b2f73ceb

Best regards,
-- 
David Heidelberg <david@ixit.cz>


