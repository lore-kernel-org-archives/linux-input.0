Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795751358;
	b=tJJZDcAi+Vbgccujuy1zZcbuxqBFObZhy8weK27l8aMA5saufWLrbKu7AYdVTT9SySxs
	 dk6imqqUJ13qp97I8YGoxYdjbCsvOHGwK6vcrmjhOTZZA+QJH+SDEOKNu8/5Kn2CiEnSV
	 +hTSXuEj/PMW+ZZw6s3Z/SepGrtZa6iQ7FJX1mwsNy5OLtElKLa+BaVP9MGrvtPhRtRGo
	 90mQAGnHCHmLg5rjGCs3cCLzBb7VoVaeYJnQkCS9tvvSq52F1K2UtEbKMlFCKxhHb0L6u
	 nz0A3n01DTAGElWHubocd0UcfrA1m0QfGXVhqeM7ozBs3Fku8ZhbF6DAScP4GOPuzjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795751358;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xT6pD/hv9oqc/Rzgrbiwofpup13QY7DlN78228L1ofk=;
	b=GgGQIf0pnr7X/0s8vD0RFNQ0QCkVSmDbkhXimLTl0T0xh69j4Ey80TAfHzPmUlX0JvfD
	 B3Qd2Tlp+2Ct22D9ccLUJ/QBe1OPPQqak28RSHvtV/bxj+tPhKzK8c6pL0v3XllNIXsfw
	 ynMLTwRPuSNUxOAb1d831iwMlbgnt5bSXu7/1DJnFOAL85xCzB/2SO6hPE1d1/KFXP9AG
	 zdxuQ5t/xir/TxXCt1YfKWwpiuiIxExlbhhfT9Y+7088JYmf1Gz6vivhaytZ7xOuxEBp7
	 H/mt0TJASMuHi+pkBTZo6ywsjR83AAH5Iir4Cp1FPRCL6SGT0xgS7/DxGjsHqgUUvIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=swyT18N2;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03F606A323;
	Fri, 27 Nov 2026 03:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB03F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=swyT18N2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=swyT18N2sbLPo0/OI6CBHn3b40kC2mXpl6kHaYpM2gqbX5SLpP1guDMEerc1NIPCWlIGsBmjH+D0U
	 ja2Z0yboLSybLF66wKJSNlhdrN1ceHAdd0cnEWEu+VcxfZ4uPrYYD/44upvcAvKw5Q1IeVYGTSdAS6
	 0aD7ze1NE6Q6TY6Y=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56b08fdb4c64-5eb75;
	Fri, 27 Nov 2026 11:49:08 +0800 (CST)
X-RM-TRANSID:2ee56b08fdb4c64-5eb75
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16b08fdb1330-84e32;
	Fri, 27 Nov 2026 11:49:08 +0800 (CST)
X-RM-TRANSID:2ee16b08fdb1330-84e32
From: Aibing Chen <chenaibing@cmss.chinamobile.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: sidewinder: use scnprintf() for the comment and physical path
Date: Fri, 27 Nov 2026 11:49:04 +0800
Message-ID: <20261127034904.288-2-chenaibing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261127034904.288-1-chenaibing@cmss.chinamobile.com>
References: <20261127034904.288-1-chenaibing@cmss.chinamobile.com>
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

sw_3dp_id() appends the PnP information to the caller's comment buffer
with snprintf(), and sw_connect() composes the physical path of each
device as "%s/input%d" from gameport->phys, which is a 32 byte string.
Both strings can be truncated, which is acceptable for informational
text, but with W=1 the file does not build:

  drivers/input/joystick/sidewinder.c:538:58: error: '%s' directive
    output may be truncated writing up to 8 bytes into a region of size
    between 5 and 21 [-Werror=format-truncation=]
  drivers/input/joystick/sidewinder.c:727:29: error: '/input' directive
    output may be truncated writing 6 bytes into a region of size between
    1 and 32 [-Werror=format-truncation=]

Use scnprintf() so that the writes are explicitly bounded and the file
builds warning free.

No functional change.

Signed-off-by: Aibing Chen <chenaibing@cmss.chinamobile.com>
---
 drivers/input/joystick/sidewinder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
index 7f37d18c8..f6f76108d 100644
--- a/drivers/input/joystick/sidewinder.c
+++ b/drivers/input/joystick/sidewinder.c
@@ -535,7 +535,7 @@ static void sw_3dp_id(unsigned char *buf, char *comment, size_t size)
 
 	pnp[7] = rev[8] = 0;
 
-	snprintf(comment, size, " [PnP %d.%02d id %s rev %s]",
+	scnprintf(comment, size, " [PnP %d.%02d id %s rev %s]",
 		(int) ((sw_get_bits(buf, 8, 6, 1) << 6) |		/* Two 6-bit values */
 			sw_get_bits(buf, 16, 6, 1)) / 100,
 		(int) ((sw_get_bits(buf, 8, 6, 1) << 6) |
@@ -723,7 +723,7 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
 
 		snprintf(sw->name, sizeof(sw->name),
 			 "Microsoft SideWinder %s", sw_name[sw->type]);
-		snprintf(sw->phys[i], sizeof(sw->phys[i]),
+		scnprintf(sw->phys[i], sizeof(sw->phys[i]),
 			 "%s/input%d", gameport->phys, i);
 
 		sw->dev[i] = input_dev = input_allocate_device();


