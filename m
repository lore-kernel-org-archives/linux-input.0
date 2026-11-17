Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911258;
	b=CrXWYPdUS4LS+mR9A2YnPZz0aXfrdoTrNCs9e4ZfoGEV/RknHuztZ83yLb7Nv9LFEc7/
	 uhd0PM1fAz0U5Dng8Iyv/aK6Pb0J2orSGq9ogLHcSxDO8Sim/8sjwIQiro3J8AncYdGoK
	 6RIumcMmRrOTvVFIW8bepc+Pta6tbLFCoujW4vXA3kPpxk208gxUa32tWkS6Y68oMmRyo
	 cVX8wWPjOOgLcCcx+Sd/nZbPC76hG+xu5wPePrxCw6zHxXtTPzfNOiXSy8DkAj/xkljBB
	 Lz66fQV9oHFGcIW0vNHtN/SdMLrYQ6iX8XkyB0uiaVwl4T98yCmrhfMP2RdutxIxUyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911258;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=dWCem41LeCPWA+Akik3tLTfDY84VB7lbVUd3mKO480I=;
	b=Cnv/SWMCSVEppYZI0sQWOgjnNrtd/ONqf48rOMTZ+vmIYPoximGi3sG4aZ+eByG4g5e7
	 rEueXGRVADHimMejyIWG6sly6mIFoQItZ/ZPmJLyRLUbdlg8rt+AWVkvM2COkXRDJV1Yn
	 K7QT5h/pkjeTmnq4ZMIuRsWColuFhQY7HadhLj22Alk7iAH02yE1DTUB3OtjkCLpU6Uxp
	 hXyBV4BQA2KM4y6HKhgRIxopMPrsGGG/O7obe7VlhfWh7OkZfNzjTqE4cMNfy9Krsdw5r
	 rM1k4HBHrXZ5gMzxltw2dCkec+djAkQz/yqpnMTGyTu3opZzl7i3tEecf8a23CdgJ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Px1PdXAG;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2051E606A335;
	Tue, 17 Nov 2026 10:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2051E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Px1PdXAG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=dWCem41LeCPWA+Akik3tLTfDY84VB7lbVUd3mKO480I=; b=Px1PdXAGo20xsBSrYHFJKZ8AaI
	CWRY06MkYWSQi62imgGzmDA/f8RWxjrB8h0DyxbQEuKNvFR718huChe2e3mRCW30Ff2jZdr4sX5Cj
	TMhCuV0FS2KBI+TgQEmUd7GFClYYTTGvJ2ftJ/2uDgeqeGuYCq7PqhBk3jj598h/DSo8D4P1iTk02
	R6zfdsWsj7ia7WYK8bvimpcaNxlj4UQnDuAeb51fY5bWcNkhq0g6qb9ua4VUmCO3N5NyH/3Fc28gX
	GjyCLVDG9DVh8Q6TScUv67f3zMBXaeJIrpROo5agrMU/o61Gh0qwe+ISF/64afU1rkOYvXK0vvRm2
	cwMT4vUw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTGPT-000T3o-27;
	Tue, 17 Nov 2026 10:27:32 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] HID: intel-thc-hid: PRD tables under a drain
Date: Tue, 17 Nov 2026 18:27:24 +0800
Message-ID: <20261117102726.271503-1-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: emfox

The PRD tables lose capacity when a frame is left unread, and a drain can
reach a ring that a reset already rewound. Rebuild the tables before the
engine that reads them starts, hold every path that stops an engine or
moves its pointers under the lock the drain takes, and stop the drain from
treating an empty read as a frame.

Patch 1 does the ring side in the core. Patch 2 fixes the two callers that
go by the buffer instead of the length they were given.

Changes in v6:

  - The stop, the rewind and the release hold the lock as well: a drain
    that had already passed the flag could still read an entry of a ring
    whose pointer had moved, and the teardown could free the tables under
    it.

  - quickspi and quicki2c no longer process a read that returned nothing.

Link to v5: https://lore.kernel.org/r/20261117093212.4122283-1-emfox@debian.org

Emfox Zhou (2):
  HID: intel-thc-hid: intel-thc: restore PRD table capacity
  HID: intel-thc-hid: quickspi, quicki2c: skip an empty read

 .../intel-quicki2c/pci-quicki2c.c             |  3 +
 .../intel-quickspi/pci-quickspi.c             |  3 +
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 89 ++++++++++++++++++-
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  8 ++
 4 files changed, 99 insertions(+), 4 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
