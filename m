Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A14E8DEB;
	Thu,  1 Oct 2026 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852634; cv=none; b=j+kwMEinwclA+wYxYm7iLBIjtdnshQe8Tq3UliBGQi7J/unfMCVL/n64uc7nDLuQOgADQ/SwsQOoo5g47RgV5/IyrsjGwEi/b39XwNZXJU7eV9xt26jkDl89No9UI86lVs0kdT6kWH/4j/u+tcP4qoR5y54OycSdZRt/euaBNnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852634; c=relaxed/simple;
	bh=mlqiKR8dEEGY8EOIatdYdVuuOosVjCNuhX+H1UzS8X8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R3DzlBR40PjssgtSyCJoCz+korehmpBwSDkEmHxWHIul+eUWX3PxJnYsp9wmFbKRvc0c0PWBPnOULEtLDibnhvUtIuoue7b+TYqq9f7pT6XO7mxcg4/GCznnz9yv8n/3kEyTo5Uq7HJ4A5kU846ZshktfACaUUSYaRLjoXzXwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xCEOe-000000003fJ-1Poi;
	Thu, 01 Oct 2026 10:52:16 +0000
Date: Thu, 1 Oct 2026 11:52:08 +0100
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
Subject: [PATCH 0/4] Input: hynitron-cst816x: axis properties and gesture keys
Message-ID: <cover.1790851590.git.daniel@makrotopia.org>
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
now documented in the binding as well, and it keeps gesture keys from
getting stuck.

The gesture key is reported with the controller's touch flag as its
value, so the key stays pressed once the controller stops reporting
the gesture code. The controller has no lift event to offer, so the
keys are now released on the first report carrying no gesture code, or
40 ms after the last one that carried a code, whichever comes first.

Daniel Golle (4):
  dt-bindings: input: touchscreen: hynitron,cst816x: configure axes
  Input: hynitron-cst816x: respect touchscreen DT properties
  Input: hynitron-cst816x: release gesture keys
  Input: hynitron-cst816x: time out gesture key release

 .../input/touchscreen/hynitron,cst816x.yaml   |  8 +++
 drivers/input/touchscreen/hynitron-cst816x.c  | 71 +++++++++++++++++--
 2 files changed, 74 insertions(+), 5 deletions(-)


base-commit: 6474fa070f2b8013b4b87350b775b8c3be6e8aac
-- 
2.55.0
