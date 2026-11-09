Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187157;
	b=mc7ukcF16W/EnkOtvv85hhd3XSLGlzGm5jzoOwLOEZIsUOvbnitCRUFMr0t6TEQ53y2e
	 j62VUlY/Mjc97HbhIR6crVwwLV2Bjg0I85cwT+byYWmQrh315vYQLHqPNd89If5z7kGCP
	 B9UuDwYPo4r39GqpsVIAIFA8CbhN6EyOvcrzyPuNx+MnTVTYXd5dNFeAawi6naWsd6QFp
	 GIyaq+x1a9rVqgY/T3snlcWe+I7wFI7T3rGpdbcodlqrZTiyuOTvCOUw1DUtOg8jvie4L
	 wlgAqKujD8ekahkESvJItMbo2zTAOSZr/q/3yyW9lYappRlft/kvngEjDT2zhlwWafg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187157;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Yai90Hd3dLOe+5rDvODu2eCI5bMe6nPfP5rfjydqf1g=;
	b=CjCa9BgqNJTPd10TwUmKP6w+7hbsRDDebWp1zCaqB6EWWkjxT8yhV2RK0uD7SM238gCx
	 k9Ue9kRx21oz2fz3R0J4sExq9yoBf7lT/aMQa3lopWYjdAf0E275988Osimq1p73PUCie
	 f2CjD2qdvNSIb2DJreQn5Usp23JbFk6QIntXS0lJz/TGIzC3GEbF6eXRKKWC/5MSozO0t
	 V+xq4Y+0BSPlfhyO4iw7DyY1Avf/27i2EPvni7TFE7dVs0Y9XFww+4zQW4DqIWtwSNj0d
	 WVFSkKxfLfYCSwwncOUdKIz1vkNFH4DnYOcBqtFY7geOUrtd5fce5d0rNBi9m738+DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Z+fT3uBe;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD78606A31C;
	Mon,  9 Nov 2026 01:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CD78606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Z+fT3uBe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Z+fT3uBeKI5H00stxVWvw6tW0NBlICoyKhOxF5MjZIHMX/Uw5vLzeo67Xqbj6YZcQUv6arfSH251R
	 AABWCJImj1Cj5LMjXlTOseLTzhhmrRYvSardM3Iq8ZlJwW+RR4sdAKmr3Hm396hm5mT8SUaM911vek
	 4pNT/aDYgya6fM1w=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af11f8d5ac-c382e;
	Mon, 09 Nov 2026 09:19:10 +0800 (CST)
X-RM-TRANSID:2ee96af11f8d5ac-c382e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af11f8d89a-7b223;
	Mon, 09 Nov 2026 09:19:10 +0800 (CST)
X-RM-TRANSID:2eea6af11f8d89a-7b223
From: xujiahao <xujiahao@cmss.chinamobile.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xujiahao <xujiahao@cmss.chinamobile.com>
Subject: [PATCH v2] Input: sidewinder - use scnprintf() for the port names
Date: Mon,  9 Nov 2026 09:05:48 +0800
Message-ID: <20261109010548.438699-1-xujiahao@cmss.chinamobile.com>
In-Reply-To: <20261106033300.3439313-1-xujiahao@cmss.chinamobile.com>
References: <20261106033300.3439313-1-xujiahao@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sw_connect() composes the physical path of each port as "%s/input%d"
from gameport->phys into a 32-byte array, and sw_3dp_id() builds
" [PnP %d.%02d id %s rev %s]" into the 40-byte comment buffer of
sw_connect().  GCC reports that both formats can overflow their buffers
in a W=1 build:

  drivers/input/joystick/sidewinder.c:538:58: warning: ‘%s’ directive output may be truncated writing up to 8 bytes into a region of size between 5 and 21 [-Wformat-truncation=]
  drivers/input/joystick/sidewinder.c:727:29: warning: ‘/input’ directive output may be truncated writing 6 bytes into a region of size between 1 and 32 [-Wformat-truncation=]

The values seen in practice fit these buffers, and a truncated name is
harmless, so keep the sizes as they are and switch to scnprintf() to
make the truncation explicit instead of letting the compiler warn about
a possible one.

Link: https://lore.kernel.org/all/20261106033300.3439313-1-xujiahao@cmss.chinamobile.com/
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
 drivers/input/joystick/sidewinder.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
index 7f37d18c8..bca81df19 100644
--- a/drivers/input/joystick/sidewinder.c
+++ b/drivers/input/joystick/sidewinder.c
@@ -535,12 +535,12 @@ static void sw_3dp_id(unsigned char *buf, char *comment, size_t size)
 
 	pnp[7] = rev[8] = 0;
 
-	snprintf(comment, size, " [PnP %d.%02d id %s rev %s]",
-		(int) ((sw_get_bits(buf, 8, 6, 1) << 6) |		/* Two 6-bit values */
-			sw_get_bits(buf, 16, 6, 1)) / 100,
-		(int) ((sw_get_bits(buf, 8, 6, 1) << 6) |
-			sw_get_bits(buf, 16, 6, 1)) % 100,
-		 pnp, rev);
+	scnprintf(comment, size, " [PnP %d.%02d id %s rev %s]",
+		  (int)(((sw_get_bits(buf, 8, 6, 1) << 6) |	/* Two 6-bit values */
+			  sw_get_bits(buf, 16, 6, 1)) / 100),
+		  (int)(((sw_get_bits(buf, 8, 6, 1) << 6) |
+			  sw_get_bits(buf, 16, 6, 1)) % 100),
+		  pnp, rev);
 }
 
 /*
@@ -723,8 +723,8 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
 
 		snprintf(sw->name, sizeof(sw->name),
 			 "Microsoft SideWinder %s", sw_name[sw->type]);
-		snprintf(sw->phys[i], sizeof(sw->phys[i]),
-			 "%s/input%d", gameport->phys, i);
+		scnprintf(sw->phys[i], sizeof(sw->phys[i]),
+			  "%s/input%d", gameport->phys, i);
 
 		sw->dev[i] = input_dev = input_allocate_device();
 		if (!input_dev) {
-- 
2.43.0



