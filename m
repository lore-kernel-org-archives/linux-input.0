Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0A233149;
	Sun,  4 Oct 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791106487; cv=none; b=p950xEgExQ2Hu66oxLQlZcMlvI1gQZ05prSu7mkI7xDLA9xXKRpeQPJ2pufW1tElbhrcwajL2mfUwGXqiePKri7LKJadEQEOUjeK+z9vVrTipTAEkPscnODNVyemI6fAGlrvbMeUrAj+hTBjWBV6TuCN+/jWsfvMRwn1Bd4ObNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791106487; c=relaxed/simple;
	bh=khJQCG/9B81gZ8vWLftMyzCamfy4twkyVZbvjMHzP/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hSm8ZBd6WGLqCIDc2PFCsxRRYPykZMIgubO40pJ/h8QgPymzBiv0bWekxP28mqdR5P0NTvpc80ve3VM+tJXo5O/N53ZUbNN3L+nFl3WLSSroKyTPlS6j6naU68d7vyNNmw9MoVjc4gtTdF5QLmi/TNIP3Lg4RitX4KYvzvpJ4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xDIcB-000000004om-47sV;
	Sun, 04 Oct 2026 09:34:40 +0000
Date: Sun, 4 Oct 2026 10:34:36 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>
Subject: [PATCH v3 0/4] Input: hynitron-cst816x: axes and gesture keys
Message-ID: <cover.1791103511.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series improves the hynitron-cst816x touchscreen driver. It makes
the driver respect the common touchscreen axis properties, which the
binding now describes along with the rest of touchscreen.yaml, and it
keeps gesture keys from getting stuck.

The gesture key is reported with the controller's touch flag as its
value, so the key stays pressed once the controller stops reporting
the gesture code. The controller has no lift event to offer, so the
keys are now released on the first report carrying no gesture code, or
40 ms after the last one that carried a code, whichever comes first.

Changes since v2:
- the binding describes the whole of touchscreen.yaml through
  unevaluatedProperties (Krzysztof Kozlowski)
- the panel follower patch is dropped. It serves a panel that
  registers a drm_panel, while a MIPI DBI display driven by
  panel-mipi-dbi owns the DRM device itself and registers none, so on
  such a board the lookup defers for ever and the touchscreen never
  probes.
- the release timer is stopped with timer_shutdown_sync() in the
  devres action (Sashiko AI review)

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
Link: https://lore.kernel.org/r/cover.1790944534.git.daniel@makrotopia.org

Daniel Golle (4):
  dt-bindings: input: touchscreen: hynitron,cst816x: axes and panel
  Input: hynitron-cst816x: respect touchscreen DT properties
  Input: hynitron-cst816x: release gesture keys
  Input: hynitron-cst816x: time out gesture key release

 .../input/touchscreen/hynitron,cst816x.yaml   |   6 +-
 drivers/input/touchscreen/hynitron-cst816x.c  | 122 ++++++++++++++----
 2 files changed, 103 insertions(+), 25 deletions(-)


base-commit: 6474fa070f2b8013b4b87350b775b8c3be6e8aac
-- 
2.56.0
