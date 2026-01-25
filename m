Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F4258CD0;
	Sun, 25 Jan 2026 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343193; cv=none; b=rD83CounjGEX/GO5yPSOLzLfFMHPB1yg4BC7w7/Z0RdD3vkpcUfU7S3vHyU5OWUyKnoiShFnYKwC/wAS/VCsxt7UKo0ygEoiMM0c2R+su4Kefn3eClC+jV/1UrdC8Q5eXXVcj7FsvJIlDlBzPD8LOiMt9U+cjwmo9Hwf3uL59uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343193; c=relaxed/simple;
	bh=1jxbfVysUmrAdavil+SX+Zb1Pd0GnmHZDE3YIvZKl58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1lGGE9Em+NOU1mT6TDROUm0L7jknzFHcvly2OUezBDhpDlMJ6moGxC/7xtWsaVXY9oz36H0cH4b0OEqswA5MZ1p7JzyL+b22TKRlpl1cxuNExsTURQQa12uD98XicEVQUAkpxUgYliJ25Q/XOShJ4cu6LlpX6EfSKlWyx1saSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13BBC4393E;
	Sun, 25 Jan 2026 12:13:03 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	"Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Nestor Lopez Casado <nlopezcasad@logitech.com>,
	Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 1/2] HID: logitech-dj: Differentiate "invalid device index" error
Date: Sun, 25 Jan 2026 13:12:01 +0100
Message-ID: <20260125121257.26508-2-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125121257.26508-1-hadess@hadess.net>
References: <20260125121257.26508-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheegjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupedufeeuueevgeefleefgfdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhkohhssehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegsvghnjhgrmhhinhdrthhishhsohhirhgvshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphhfphhstghhnhgvihguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhgrihhnshesrhhishgvuhhprdhnvght

We had 2 codepaths throwing the "invalid device index" error, but one of
them was about the index not matching the receiver, so change the error
to "invalid receiver index".

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-dj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 44b716697510..e728f00f5bdc 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1664,7 +1664,7 @@ static int logi_dj_dj_event(struct hid_device *hdev,
 		 * so ignore those reports too.
 		 */
 		if (dj_report->device_index != DJ_RECEIVER_INDEX)
-			hid_err(hdev, "%s: invalid device index:%d\n",
+			hid_err(hdev, "%s: invalid receiver index:%d\n",
 				__func__, dj_report->device_index);
 		return false;
 	}
-- 
2.52.0

