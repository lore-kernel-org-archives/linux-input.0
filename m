Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D959382F1C
	for <linux-input@vger.kernel.org>; Fri,  3 Apr 2026 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222090; cv=none; b=eSJwurvlJT8501ppA6N4n53fniSqOgpWLkUV3KUNR2ZN0Ep9Xinr59tFopM4RD1wUX44DecaPaonkRTrh1VsUvheNoLCrUoU2zT9el9M3tWfi3JJ9552dFvTMxoJAjGdjPcW/ruvajP05VWkJS/IMTBRxJbtn2iBpLGni6mgZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222090; c=relaxed/simple;
	bh=4n3YgowZn3FFBZVVvJZLEFjtH4xMQi74IPpWIbMQr0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzMnLol1VACGgy/dAX9NstMB/GsqtPl0tXyY5IIndZQwA/xek4pfzxyelAVDRJEA/2d/gFfS0tlpGRTmthjZK1Uye/23cuiccOadjGu4ukdLQiq5kOpngaZvercSvWe335NRZQdJiPSi/1qwKGcijbDVzIX/CgvDKb4mWTVyL+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=negmaster.com; spf=none smtp.mailfrom=negmaster.com; dkim=pass (2048-bit key) header.d=negmaster.com header.i=@negmaster.com header.b=A7540spq; arc=none smtp.client-ip=91.216.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=negmaster.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=negmaster.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=negmaster.com header.i=@negmaster.com header.b="A7540spq"
From: deqrocks <andre@negmaster.com>
X-Lima-ML-UUID: 415247b8-abc7-4bb1-9cb8-471556064d83
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=negmaster.com;
	s=securedbylima-20200315; t=1775221710;
	bh=4n3YgowZn3FFBZVVvJZLEFjtH4xMQi74IPpWIbMQr0c=;
	h=From:To:Cc:Subject:Date:From;
	b=A7540spqTlVoJdkcquE3lNj+stLqNYWW+OqtDVFFAxVvFgjLtEcNQ9lsCUnSQWBd9
	 hy7rNYboti33pHXRNtghTjHdGk3alVV5P+dKblchSd3b/fbS1VjM04vHVtxzeZc6h4
	 waFny/35c7bqoqBv4APU4faP1qtKdgyhf0QDIJH7SFwwu68emsh0P/4BpK3fCwj4RB
	 gbGS+oM7sdBRkssxAws8iKmgpv932YyEqdrJbskXLasl9hvNER5YXLMpwFYzCAi8yX
	 wRLurUV0oh0R6RTzM0gTobmWYgRH0R/ZJaermLNH7XsEWrhIvcUQ4H7Bh3wMTc+djm
	 byfvx4tYeoGuQ==
To: jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org
Subject: [PATCH 0/3] HID: apple: reinitialize T2 HID devices after resume
Date: Fri,  3 Apr 2026 15:06:17 +0200
Message-ID: <20260403130620.91999-1-andre@negmaster.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves suspend and resume handling for Apple T2 based Macs.

On affected systems, Apple T2 HID-backed devices can disappear across suspend and resume and come back with freshly enumerated interfaces. Reusing the pre-suspend device state leaves parts of the stack non-functional after resume, especially keyboard backlight and Touch Bar related devices.

This series adds the required Apple T2 HID identifiers, wires up PM handling for the relevant Apple HID path, and reworks teardown and reprobe handling so stale state is discarded and devices are initialized again after resume.

Tested on: MacBookAir9,1, MacBookPro15,1, MacBookPro16,1, MacBookPro16,2, MacBookPro16,4

deqrocks (3):
  Add Apple T2 HID identifiers
  hid-apple: add pm path to 8102
  Add Touch Bar and backlight reprobe support

 hid-apple.c       | 1372 +++++++++++++++++++++++++++++++++++++++
 hid-appletb-bl.c  |   44 +-
 hid-appletb-kbd.c |  109 +++-
 hid-ids.h         | 1574 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 3073 insertions(+), 26 deletions(-)
 create mode 100644 hid-apple.c
 create mode 100644 hid-ids.h

-- 
2.53.0

