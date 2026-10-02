Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0453FC5CD;
	Fri,  2 Oct 2026 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945247; cv=none; b=ry3HZl3wNCJ24tHeJ/sv0HmhtU+gjCeoThlWHuiyQdAUo1e0SixK/PM5kOM/F6uOzZigPt7l1IQUof5TGpRfSkzA2BUcDO6hlV3kQ8vxsbALUJKYl+rLLpy49Ax+9FMovliS72lKFyHomA6xbXbIc+m9iY7JlVI52Ih39eOoyA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945247; c=relaxed/simple;
	bh=AHVx/Q1GmZhBuPUNmnAr3l6u5ZYKy+cNTxNKgGbss5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CPuD7H6iJiPpZqp1fV5JgqTH1i7x5OaSP6zMCst9GoO386hFeReMHsYNk14FuBz1i7TyQrzjnbrIp11eR9J8pD+51Eq2tsbGPyVEqfi4V14GPJIBsf5YmwnvM3flxiPEh10CfUk7HZbu3cykL3HWdcs45VeQGPiFOjeu8+i1KMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xCcfP-0000000039f-3IYK;
	Fri, 02 Oct 2026 12:47:11 +0000
Date: Fri, 2 Oct 2026 13:47:08 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Hendrik Noack <hendrik-noack@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>
Subject: [PATCH v2 0/5] Input: hynitron-cst816x: axes, gesture keys and panel
 power
Message-ID: <cover.1790944534.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series improves the hynitron-cst816x touchscreen driver. It makes
the driver respect the common touchscreen axis properties, which are
now documented in the binding as well, it keeps gesture keys from
getting stuck, and it lets the controller follow the panel it is
mounted on.

The gesture key is reported with the controller's touch flag as its
value, so the key stays pressed once the controller stops reporting
the gesture code. The controller has no lift event to offer, so the
keys are now released on the first report carrying no gesture code, or
40 ms after the last one that carried a code, whichever comes first.

Boards which mount the controller on the panel feed it from the
panel's rail, so the reset and the interrupt now wait for the panel to
be prepared, which the common 'panel' phandle asks for.

Changes since v1:
- the binding allows touchscreen-min-x/y, touchscreen-size-x/y and
  touchscreen-fuzz-x/y as well, which touchscreen_parse_properties()
  already honours; the 240x240 default is unchanged
- the binding allows the 'panel' phandle, and patch 5 is new: it
  follows the panel's power sequence
- the binding commit message carries a justification (Conor Dooley)
- keycodes above KEY_MAX are rejected, which keeps the gesture key
  lookup inside the input core's key bitmap (Sashiko AI review)
- the timed release is skipped when the interrupt handler re-armed the
  timer while the timer callback waited for the lock (Sashiko AI
  review)
- the Sashiko AI review also asked about additionalProperties next to
  a $ref, which stays, as this binding allows a subset of
  touchscreen.yaml (writing-schema.rst)

Link: https://lore.kernel.org/r/cover.1790851590.git.daniel@makrotopia.org

Daniel Golle (5):
  dt-bindings: input: touchscreen: hynitron,cst816x: axes and panel
  Input: hynitron-cst816x: respect touchscreen DT properties
  Input: hynitron-cst816x: release gesture keys
  Input: hynitron-cst816x: time out gesture key release
  Input: hynitron-cst816x: power sequence with the panel

 .../input/touchscreen/hynitron,cst816x.yaml   |  16 ++
 drivers/input/touchscreen/Kconfig             |   2 +
 drivers/input/touchscreen/hynitron-cst816x.c  | 182 +++++++++++++++---
 3 files changed, 171 insertions(+), 29 deletions(-)


base-commit: 6474fa070f2b8013b4b87350b775b8c3be6e8aac
-- 
2.55.0
