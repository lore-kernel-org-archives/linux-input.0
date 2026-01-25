Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE318318EDE;
	Sun, 25 Jan 2026 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343195; cv=none; b=JmjCrKJpWfHsgBo6Q8sBmZJ2I2xsQewK+C4nGpFYzMERN4Qsq/N1SC9ctY1fvNa695BtJkmpQ83mn5nG05HXcAd3Bx0Fxl5VSEUtyN8fiHROFDqGew9HZSXOrDAYsDhwnWwTe6uet2GqT1NrYcohOJprn4olnRR4OK4sKTlO2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343195; c=relaxed/simple;
	bh=iKCuWM8YXTy/yzf1TwxBYIioquSKe4dvp+Osoj/MR7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nb+MqSaFEstXHTGBtl9k0cJmgnmf9DY1hJ4zXYHmRuBCf5OplDQlh9UzBZ88NpscxJLfzzS2mLZeNVEQOwGQL5goCy3pzbcxXWvZ8ptaSQIIMDWudr26FfjxkO+T9jf5I6oeXvTw8Ah0ue8h+ycttuNQqk1ywLXLs9w9EuXkirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15DC743948;
	Sun, 25 Jan 2026 12:13:04 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	"Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Nestor Lopez Casado <nlopezcasad@logitech.com>,
	Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 2/2] HID: logitech-hidpp: Add support for Logitech K980
Date: Sun, 25 Jan 2026 13:12:02 +0100
Message-ID: <20260125121257.26508-3-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheegjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeduheffveejgeefleegkedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhkohhssehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegsvghnjhgrmhhinhdrthhishhsohhirhgvshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphhfphhstghhnhgvihguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhgrihhnshesrhhishgvuhhprdhnvght

Add support for the solar-charging Logitech K980 keyboard, over
Bluetooth. Bolt traffic doesn't get routed through logitech-dj, so
this code isn't triggered when Bolt is used.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index e871f1729d4b..ca96102121b8 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4666,6 +4666,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb037) },
 	{ /* MX Anywhere 3SB mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb038) },
+	{ /* Slim Solar+ K980 Keyboard over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb391) },
 	{}
 };
 
-- 
2.52.0

