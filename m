Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB283B7B72;
	Mon, 30 Mar 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864807; cv=none; b=h4MXy8Ms7Hfr4Gp8g88Pomj09/TFjhHRhZu5+Q+nQt13I/CBTqnfDu6nydt9e9l3eONRbRopnIzHPTvCVfEsui5Hqm6EIZYUZG9xSXbGO7nYTFtk0deqlvT/tSKmPf/E6AE8m89i7OOl5+DyJZdA+6bn9BLlV1c1iu3VSGkBM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864807; c=relaxed/simple;
	bh=7P2OCStVtFP2THZ4OxoXpW4P9uXTJw7vsxreJLDjc9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJIfSUFa1wlmDUdVGcJxLiF2j/BgJpXMD/KoHUrCrkseR9f4aFiYR/taOBpe3rwWeSu3UrNtLsEXIgubdVUDEXQRp/5CF6tO3Fvlfh69qhGklm3IunqNOPRIFrxEDZvrG5gzrKRUbrtLEwMdGKdhxjy0TFFk4cbPmc4IFzQ9T5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOgU8v6Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOgU8v6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8C9C2BCB2;
	Mon, 30 Mar 2026 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774864806;
	bh=7P2OCStVtFP2THZ4OxoXpW4P9uXTJw7vsxreJLDjc9I=;
	h=From:To:Cc:Subject:Date:From;
	b=JOgU8v6QK7nrVJ8KatH+z8MLD6rKM3yN2EmitDMCiaxULys2QgZhbvHq6EN6loLfG
	 gFVLcYzt5GhsQExn2mnVXOIL7Emim1rKWb63wOo9BmYBT6cxQbUg/JO4kyhsdwHD/X
	 ExexJdZ0avsqcSTGrY74Y9CmscJHvkT4lZk6JSsdUqAdIsvqR/LGwEVfP/JjGsZkRD
	 +ov9lbmS0dpeu810qvTczKkh+hjExkzguclFoi74Jx0ibDDUQQabyAQ6GojRBPlprD
	 tY/1KjtNxKKEtX5YZQB5EHoeAVAHLgaKZDSNoHsQza8xfB7iWRN5EpE3eDiG4WyreZ
	 ZDdqlRhTNr94w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79Pg-00000006yfQ-3Dse;
	Mon, 30 Mar 2026 12:00:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/4] Input: refactor USB endpoint lookups
Date: Mon, 30 Mar 2026 11:59:44 +0200
Message-ID: <20260330095948.1663141-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the common USB helpers for looking up bulk and interrupt endpoints
instead of open coding.

Johan


Johan Hovold (4):
  Input: keyspan-remote - refactor endpoint lookup
  Input: appletouch - refactor endpoint lookup
  Input: synaptics_usb - refactor endpoint lookup
  Input: usbtouchscreen - refactor endpoint lookup

 drivers/input/misc/keyspan_remote.c        | 22 ++-----------
 drivers/input/mouse/appletouch.c           | 21 ++++--------
 drivers/input/mouse/synaptics_usb.c        | 23 ++-----------
 drivers/input/touchscreen/usbtouchscreen.c | 38 +++++++---------------
 4 files changed, 22 insertions(+), 82 deletions(-)

-- 
2.52.0

