Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42D28E0F;
	Thu,  4 Jan 2024 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="itL4cqZW"
Received: from wse.fritz.box (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id D951C2FC006B;
	Thu,  4 Jan 2024 19:31:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1704393083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0aB5DFHEphhpzEsa8tEbbI+qGwZXi8iBkvBXj+lDk88=;
	b=itL4cqZWuvSWeToyYGnn3rj/htJHZuwDEmm2IX48ktqILwyxgGtaS11AzWPnggn4ZUN59Q
	plywXa09t3Ytq6p2ahMZq6u25DqzzARlBEZacfcALvyeUehl97Rc+vG+b/M8bSotbfffaI
	DvPQrT0UNE0ojKE3THog63M9NXrYZ4c=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: dmitry.torokhov@gmail.com
Cc: hdegoede@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wse@tuxedocomputers.com
Subject: [PATCH v4 0/2] i8042: Add forcenorestore quirk to leave controller
Date: Thu,  4 Jan 2024 19:31:16 +0100
Message-Id: <20240104183118.779778-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: Just a typo fix in commit message.
v3: Another typo fix in commit message.
v4: Spotted another typo. Note to self: Don't write commit messages when tired.


