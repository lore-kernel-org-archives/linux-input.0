Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C943F8CD;
	Thu, 23 Jul 2026 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806030; cv=none; b=U+K97KWOSXHekwuu1kWG2VwhxcGpckGH7NJwxtpU4s3gtDrQi8wF5Re0dEb7g2vT5/IepnHnQ8LFwhOOFt61Ax5vLRwhqo+dZompcfZMplS1E0VaucWB6Y3htZbCEy6zSa4oekEmR+sfQU8JUkS+fNKNdH5YcBNfeXaEYsZICjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806030; c=relaxed/simple;
	bh=uvjbPDPruxrWtK8MfZxl0y9jWziTEYOYYxVOMFT3c5Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YAeEYBAsKjpfSCXrFkXqST3YfnJ4Uy8yO3TH2sZXdo9QQ8L+8dAP/mQ7jR719iBdtNVy8oBO6h+JQlXVm74g66IjP5KFf46/ARWjESAlZqtNtDr7OvgelSSEKpr1uVnsmw/A3xCt4Kw5TM3U7xfw3DAFt5mDzFpdLmnJPW6qDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC4GQWhE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC4GQWhE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9422C2BCB8;
	Thu, 23 Jul 2026 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784806029;
	bh=uvjbPDPruxrWtK8MfZxl0y9jWziTEYOYYxVOMFT3c5Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VC4GQWhEGw1F59SlwuDA3+FWZyvE1Hwh4doA8ERr9M1lWix5HIF5JVrHpUHmCcJF6
	 Yz0zC7gqw2sBTT+ADQzxvL+sf2LK9Lkebmbxb9PfaPhQdI+eQiQq+0Sz/J19aPb1Sf
	 RMeiYez1LvnOmt+LnynG3qD+kojvUzjYI4N82YWOt/TLn/3qOq+6stbA1+gLqszgQx
	 1Eln/IJv6risWVhtyBpvV/XbvC2PuYVEWqe1itV3W2qI9QXTGHWHKihG96GhX+UbaR
	 50XZdcyFDuLfSlYHMC/7U4rTfZvnwdgJMI2bWTN9hVnhFyz5Yp+jzArfFGe5UpK7Es
	 V3yfZSp0Wq50g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95818C531CB;
	Thu, 23 Jul 2026 11:27:09 +0000 (UTC)
From: Alexandre Hamamdjian via B4 Relay <devnull+azkali.limited.gmail.com@kernel.org>
Subject: [PATCH 0/4] Input: edt-ft5x06: robustness fixes for a FocalTech
 FT5426 on a marginal bus
Date: Thu, 23 Jul 2026 18:27:07 +0700
Message-Id: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqAIBBA4avErBNM7fcq0SJtrGlRoRZBdPesl
 h883gUeHaGHJrnA4UGe1iUiSxMwU7+MyGiIBsFFwUshmVbMhlyJgslaDlWeKVTaQuw3h5bO79V
 2v/2uZzThHcB9P2CgmFZtAAAA
X-Change-ID: 20260723-b4-ft5426-393d8514e4bf
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Alexandre Hamamdjian <azkali.limited@gmail.com>, 
 Teguh Sobirin <teguh@sobir.in>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784806028; l=1711;
 i=azkali.limited@gmail.com; s=20260510; h=from:subject:message-id;
 bh=uvjbPDPruxrWtK8MfZxl0y9jWziTEYOYYxVOMFT3c5Y=;
 b=/HYVVo2ISake2MakeSgULvVpDrj82BqGO+ZAeI6j2bw5XKsip2vkp6mJLucoxMmTImBt+XdbE
 6u+E9b8whWLBkwopmUlsMjaGJlqmwKYnlvz9kT8g6D1gNpSx+2ENlWF
X-Developer-Key: i=azkali.limited@gmail.com; a=ed25519;
 pk=I0Z0IdCdQJqNGX+FQUnXhrHg950u3cM6Xzz3YT6JOyQ=
X-Endpoint-Received: by B4 Relay for azkali.limited@gmail.com/20260510 with
 auth_id=774
X-Original-From: Alexandre Hamamdjian <azkali.limited@gmail.com>
Reply-To: azkali.limited@gmail.com

The AYANEO Pocket DS drives its FocalTech FT5426 touch controller on a
Qualcomm GENI i2c controller that has no bus recovery and, on this
board, clock-stretches close to the controller timeout. This series
collects the robustness work that helps there, smallest and most
generic first:

  1. ignore contacts reported with an out-of-range slot id -- a generic
     correctness fix, independent of the board;
  2. document, and
  3. implement an optional no-regmap-bulk-read mode that reads the touch
     frame one register at a time, for controllers whose bus aborts long
     transfers;
  4. poll while a contact is down to recover a touch release dropped by
     a missed edge interrupt.

Patch 1 stands on its own; the rest are opt-in (DT property / chip
behaviour) and inert on healthy hardware. Feedback on whether the bus
mitigations belong here vs. in the i2c controller is welcome.

Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
---
Alexandre Hamamdjian (3):
      Input: edt-ft5x06 - ignore contacts with an out-of-range slot id
      dt-bindings: input: edt-ft5x06 - add no-regmap-bulk-read property
      Input: edt-ft5x06 - poll while a contact is down to recover dropped releases

Teguh Sobirin (1):
      Input: edt-ft5x06 - allow reading the touch frame one register at a time

 .../bindings/input/touchscreen/edt-ft5x06.yaml     |   8 +
 drivers/input/touchscreen/edt-ft5x06.c             | 200 +++++++++++++++++++--
 2 files changed, 196 insertions(+), 12 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260723-b4-ft5426-393d8514e4bf

Best regards,
--  
Alexandre Hamamdjian <azkali.limited@gmail.com>


