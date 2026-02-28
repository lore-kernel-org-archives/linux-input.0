Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E58436379
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772289994; cv=none; b=EePumOqOiTC+sywj4Fb9hBDIELM9ajuOnlTmMTDSMlrhfTeASYWY7IF2ZE2IodTPigcGA4KisyEP2GuHPccsfwbIsFbplr39mY52o+NkK16EuGBytpZOoMPakQHMlkMUQ/rAsJ9OpDfEj1lGXdX4uErpmbceaSgg8qBX2VoM0tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772289994; c=relaxed/simple;
	bh=R0qSUigzfgZ63ZRFEFdOebSJH15cwM/Qa3xWkNVN9OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnwMQd2xVfzV1aa/yR1kXcv3ThKw4nrQCABE0+s/n11hw41+XlmIr7fHY2WgA+fL51E7ffGUyBoWiKGG+eG2YWgLXWwa4Mo7fu4Jv3/0NvxMsIGOV678XoeXGb8ANqg+alAZ9XTXpI1kA5Ssi47uUzxi+SheRQljFOwdfA4c0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ix1Fve1D; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ix1Fve1D"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772289990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6RSJl0Yz4ScYLIzRRxzymID3kLP5YTf0PaRhlSjSaxM=;
	b=Ix1Fve1DLzEbVfqB8k4E/jSwSe0s6mLX1XDklSpLQy4v8G0BVJ8qvJ2Dzt1yRu7TJB5ftT
	qR11BHmXwWWQiPQhthLKHKiOrBSK08VyxescLdydd+Xe9VGNjxAmc+Xy9mb9HPyLUyhNdp
	TTDfrMi1QnHIh8ak/heSOruZCH0/zWU=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH 0/7] HID: asus: increase robustness of the driver
Date: Sat, 28 Feb 2026 15:46:19 +0100
Message-ID: <20260228144626.1661530-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all,

Previous asus-wmi maintainer and asus-linux developer has become less
active in the project and left me in charge of advancing the support
for ASUS equipement on Linux.

I am preparing to send a patchset of his revised work to support ASUS
ROG Ally handhelds devices and since that work is also useful in
expanding support for 2025 models it is important to improve the
hid-asus driver as future patches will build on top of these changes.

Cheers,
Denis

Denis Benato (7):
  HID: asus: fix code style of comments and brackets
  HID: asus: add xg mobile 2022 external hardware support
  HID: asus: fix compiler warning about unused variables
  HID: asus: make asus_resume adhere to linux kernel coding standards
  HID: asus: simplify and improve asus_kbd_set_report()
  HID: asus: do not abort probe when not necessary
  HID: asus: do not try to initialize the backlight if the enpoint
    doesn't support it

 drivers/hid/hid-asus.c | 67 ++++++++++++++++++------------------------
 drivers/hid/hid-ids.h  |  1 +
 2 files changed, 29 insertions(+), 39 deletions(-)

-- 
2.53.0

