Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5599234D392;
	Mon, 23 Feb 2026 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771844629; cv=none; b=Z3elSxAFvZqTF6sYVQoFMGiVTWkE92+NfxO8/u9/5ixA8jnmm8uF9mQbu5cm9AaXnIQXQf3mO+DhEKDWF6yPWCpmYlliMLXcaxmlNAt0in7o0JcWUFeYOXs6/9Y69pU0pPv9VNcYwrZjEU75QuKhAGlcwNSHXy6nFr8AzBbUZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771844629; c=relaxed/simple;
	bh=/Lwi2SQOmjSZoQ2lD1J/F6NVtGfgvtYG1FZkkyq+TAA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jky5zy/Km3jY/P9GmVw+KhcUIkuuglWvTp54RIzQN2A1OGAwmp8MeLIo3invnhOHWXV+L2+wAKjzDEO1ElJOSFLm9jP1xTRQmtpsi+S1NbVH0NLt4nJs3FhqhCfEE0LyVOlodP353IJjvzk5/4Dw+0p+LfWl5KBnExWOKQBfUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBN8Jfc/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBN8Jfc/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E342DC116C6;
	Mon, 23 Feb 2026 11:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771844629;
	bh=/Lwi2SQOmjSZoQ2lD1J/F6NVtGfgvtYG1FZkkyq+TAA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=iBN8Jfc/OAl7uI7q3LHGuzdQwgaBKYKd1wrhHeLBqgFx0p+l75GBXFne2ZVkNszQ7
	 fpekw/uThYF1MTereXKa8vSGB2zCyQJXiPnJXCoWDjLFq3+RYyVFKKUR3grpZjKA9W
	 GSUV5q7URrNKJEaCtQL6fiVLbTHaJAjeUM7TiJScpGt6ZScMCbolNHDR5fk9+oWuZt
	 ThXX9z6VW275hrkgiUvOCFmZRpNeK6DSq4uV+7UH6xN6KlJ49Q2rkB8ve9SNn9PhrK
	 Tyogsn6wwLyQ/Hak5p43MZfWopKLWZeFCB5YNP8JFQay3HsJP5jMUq3mOaTXeBvYN7
	 AQmmYQsYFAW0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2611EA4FA9;
	Mon, 23 Feb 2026 11:03:48 +0000 (UTC)
From: Marc Paolo Sosa via B4 Relay <devnull+marcpaolo.sosa.analog.com@kernel.org>
Subject: [PATCH 0/2] add driver for max16150
Date: Mon, 23 Feb 2026 19:03:38 +0800
Message-Id: <20260223-max16150-v1-0-38e2a4f0d0f1@analog.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAo0nGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyNj3dzECkMzQ1MDXYvUNEuTVDMT4+QUAyWg8oKi1LTMCrBR0bG1tQD
 RFD5dWgAAAA==
X-Change-ID: 20260223-max16150-8ef94e643cd0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Paolo Sosa <marcpaolo.sosa@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771844627; l=1100;
 i=marcpaolo.sosa@analog.com; s=20260223; h=from:subject:message-id;
 bh=/Lwi2SQOmjSZoQ2lD1J/F6NVtGfgvtYG1FZkkyq+TAA=;
 b=o3wekkboUVy8NBZSvp/U6yVbN8moHRJrRb8NnTDV8XQ0Oywr77RoE5H4oqQLufr06GLhqpII+
 98yT4xjK/R2DpYIvYGCXGHtLcQRiOzRawl2DaXhmEH7x6l320NiIwzY
X-Developer-Key: i=marcpaolo.sosa@analog.com; a=ed25519;
 pk=RR72PZYRimO/84huVqlVyHN3IM3AL984DRKCEXnOJuE=
X-Endpoint-Received: by B4 Relay for marcpaolo.sosa@analog.com/20260223
 with auth_id=646
X-Original-From: Marc Paolo Sosa <marcpaolo.sosa@analog.com>
Reply-To: marcpaolo.sosa@analog.com

Introduce pushbutton control and debouncing support for the
MAX16150/MAX16169. The component is a low‑power on/off controller
featuring an integrated switch debouncer and internal latch, designed
to accept a noisy mechanical pushbutton input while providing a clean,
stable latched output. It also includes a one‑shot interrupt output for
event signaling, enabling reliable switch interfacing in low‑power embedded
systems.

Signed-off-by: Marc Paolo Sosa <marcpaolo.sosa@analog.com>
---
Marc Paolo Sosa (2):
      dt-bindings: input: add adi,max16150.yaml
      input: misc: add driver for max16150

 .../devicetree/bindings/input/adi,max16150.yaml    |  57 ++++++++
 drivers/input/misc/Kconfig                         |   9 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/max16150.c                      | 161 +++++++++++++++++++++
 4 files changed, 228 insertions(+)
---
base-commit: e7b53288d9ea899abc6d47a7f20065ab511a810c
change-id: 20260223-max16150-8ef94e643cd0

Best regards,
-- 
Marc Paolo Sosa <marcpaolo.sosa@analog.com>


