Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37747396B8C;
	Fri, 21 Aug 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347845; cv=none; b=cKbBVhwWFzGvfUIj+rqSSJwBNlflUwoHrVVB62P4nKhZxwwIiyTJQYRWgHAY9UXG5AMW2tAljIdUSXUlU4x/kUQRZVMg+/0GH9Q+jzs9bqlAcqGKY62wqupfA0Hy5POb60TvrCFK1alDN5Py7iCYUu9rjsj6oQ9HJDBipYNQULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347845; c=relaxed/simple;
	bh=gM+VE59mgPgIHvqvH2NrY8reOz4KWliz6TSlKSo9/vY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UJGVm+PbJGh63g+KwP4WwPgwRbUSsX4PgtCtM+ZCHW6dQ3IZAjJlo3b0iQ2uVQy28I3HG1eRFnN4AeWVtqRRZCHdGTfKZfbwD7JBhkKG2B0Qstx9LxtYcjmSbOHvT2skZLqpFwlqeHnSSlaheUsJ2r8nJE4plh6k+QaRdS5N5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPk7g5Ue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPk7g5Ue"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C69BEC2BCF4;
	Fri, 21 Aug 2026 21:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787347844;
	bh=gM+VE59mgPgIHvqvH2NrY8reOz4KWliz6TSlKSo9/vY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RPk7g5UevUZJFlqE1LMeKI693ZtihO4ZmJ75gCd2Uda/zb5eS0xKlMfk3s7o1ZaSo
	 jRHs4nfPrd2xq/+cX1MvMRkogkGY+JkBCkneW6Gy5X20lKYyA1Mz+t99kUByrkk/pS
	 7GAQxxo3hc8gObNHnjC6j08cFRiaCo5GSDLcwYnvC8bcfLt9kGkMi8mfMPQXM70zf2
	 XROJdFwEs5w6Bo2WsdOoMLIRA0gxapuYSwiHHstpbGwcbt+P7M51s2TN8XTktNmCvT
	 XCmmH0x2F2F1rY0dyhbNbSLeI+fGaDHULgcY424Y0E0o3PbIxjP/CvQsGfuLiSKn6/
	 +TT9fkqETyUIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F16C5DF94;
	Fri, 21 Aug 2026 21:30:44 +0000 (UTC)
From: Markuss Broks via B4 Relay <devnull+markuss.broks.gmail.com@kernel.org>
Subject: [PATCH 0/5] Minor Imagis driver refactoring and support for
 IST4050
Date: Sat, 22 Aug 2026 00:30:12 +0300
Message-Id: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqAIBBA4avErBNUoqSrRIvKsSboB6dCkO6e1
 fJbvBeB0RMy1FkEjxcxbWuCyjMYpm4dUZBNBi11KY2WgpZuJBaFDEGU2lmlnLGVM5CK3aOj8N2
 a9jef/YzD8S7gvh/cd2PgbwAAAA==
X-Change-ID: 20260820-imagis-40xx-62fd11f8d7f8
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787347843; l=2116;
 i=markuss.broks@gmail.com; s=20260803; h=from:subject:message-id;
 bh=gM+VE59mgPgIHvqvH2NrY8reOz4KWliz6TSlKSo9/vY=;
 b=Gy/grGBceYqKJmETFQbw01FH6glBfkZBBjdKTxF9xuLubvsmHQb/83UyKyEza+cAZnK6oHUTd
 FehXiE62lW3BVKfC/p+yfWfAFDaA8Rn1prT+cPha7i9rH7SCXuR+o08
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=oKzGUTm30BCDqinRMpiHQqByOx1mp2mwmhg80Mv7Zg4=
X-Endpoint-Received: by B4 Relay for markuss.broks@gmail.com/20260803 with
 auth_id=911
X-Original-From: Markuss Broks <markuss.broks@gmail.com>
Reply-To: markuss.broks@gmail.com

The Imagis IST4050 is a touchscreen IC of the IST40xx family. It shares
the register interface, the power-up sequence and the coordinate format
with IST3038C, but reports touches differently: instead of a per-index
contact snapshot paired with a "pressed" bitmask in the interrupt
message, the controller exposes one record per contact, 8 bytes apart,
carrying a hardware-assigned touch ID and a press/release event type in
its upper byte. The bits which hold the contact area on IST3038C hold
the event type on these chips, and no contact area is available in the
coordinate word.

Patch 1 documents the IST4050 compatible. Patch 2 stops reporting
coordinates of released contacts; besides avoiding pointless events on
slots which have just been deactivated, this is required for IST40xx,
where release records must not be parsed for the contact area. Patch 3
replaces the protocol_b flag with an enum which describes each touch
reporting format, patch 4 adds support for the IST40xx reporting format
and patch 5 wires the chip up.

The series has been tested on IST4050 (Samsung Galaxy A70 SM-A705FN).
No functional change is intended for the already-supported chips,
except that coordinates are no longer reported for contacts being released.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
Markuss Broks (5):
      dt-bindings: input: touchscreen: imagis: add compatible for IST4050
      Input: imagis - do not report coordinates of released contacts
      Input: imagis - replace the protocol_b flag with a protocol enum
      Input: imagis - add support for the IST40xx touch reporting format
      Input: imagis - add support for IST4050

 .../input/touchscreen/imagis,ist3038c.yaml         |  3 +-
 drivers/input/touchscreen/Kconfig                  |  2 +-
 drivers/input/touchscreen/imagis.c                 | 83 +++++++++++++++++++---
 3 files changed, 76 insertions(+), 12 deletions(-)
---
base-commit: 415606a7be939835db9b0d6b711887586646346d
change-id: 20260820-imagis-40xx-62fd11f8d7f8

Best regards,
--  
Markuss Broks <markuss.broks@gmail.com>


