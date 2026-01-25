Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA12417E0;
	Sun, 25 Jan 2026 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343193; cv=none; b=IA0y6qlAIEip3ij8ck9AvBzn3dnb0mCYwZKxE02DiMPlAWgupNrnpKbpCxp+8JpBaexzy8IrFALYYXwrwN0tvE6oYb26g9lywLTl4wVGQPVpkVIuOYe0v7Xnvj0fhVjLoIdQx8MyVzb7S+IWLt9X5kIH6Aaw5zF5cgWpGwD/8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343193; c=relaxed/simple;
	bh=nK8MsbsGRqGdLQ+kFHyOEA78hvKRUb4WuIZeWS2tB8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUoK5Yn+aQtF7tMldJP1pe7J2k119Ee3/Vq8i+rtaVDomkdWagVHkmDMzohoO8QDCCTtLNA6WQ0D4d62uH6ABBoazzT0OHp+8KSaDgOxAURU9R1SU32C26uYUfoTRxoDmUVrrogqusj6OCw4f+uOvW5sQ7JhAsWwwQNgF8kOjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B72AA4393B;
	Sun, 25 Jan 2026 12:13:02 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	"Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Nestor Lopez Casado <nlopezcasad@logitech.com>,
	Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 0/2] HID: logitech-hidpp: Add support for Logitech K980
Date: Sun, 25 Jan 2026 13:12:00 +0100
Message-ID: <20260125121257.26508-1-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheegjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffteektdejuddvhfdtfedtvdetgeeileethfetgfdtheekvefgueeifffhvefhfeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeujedvteetgeefleefuedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhkohhssehkvghrnhgvlhdro
 hhrghdprhgtphhtthhopegsvghnjhgrmhhinhdrthhishhsohhirhgvshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphhfphhstghhnhgvihguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhgrihhnshesrhhishgvuhhprdhnvght

Tested over Bluetooth.

Bastien Nocera (2):
  HID: logitech-dj: Differentiate "invalid device index" error
  HID: logitech-hidpp: Add support for Logitech K980

 drivers/hid/hid-logitech-dj.c    | 2 +-
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.52.0

