Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793936309;
	b=3iUcs/4tFtiOVVFDY9M0pzj3xcIKEcO3JaIS5/9KoCBsZj1X6VAbmC9LZISvNZ6gdyW2
	 krASZT2mLpOKqCvidDneafkKOXp5F2LZpCyssHGHScGzo1QcOvmGkkeKqDM8VFB8EZc09
	 eKM1rvqAeTyDKbTNbe0X5s2weddjPspXZm6EWC6Kf0voaaQDW7qSOFiaz8EHCT0b0eZ/s
	 FqspSowp3f+xir+vzkDeHk5yLKkTYT8tATFGK/WWLCyh60wAUTJkVRIkH/bDbuL2MAItd
	 yy9f5olmUkJmXKp2hukVJsP5MJ3Rp6QamCQDbKs2lB/ph2s5PH8UMN/vdoHbR8zl1xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793936309;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QCTP1WpAnO9KpSsZ5O25jqewilYuTLvfoK65lKYMhYo=;
	b=P6RkyAFNqUDhdtnxpSrRgohXdSAoScfVAh/Xgz6xtEfYPo36zbhhyDMAz/dAMYlW4U+f
	 UP2kcoHmUU4wlKjDiIYEAtRJZFGlQWHxZLw8Pj1Rlg1bp2ZrE2IF8DdrmtudsQjWFPxi7
	 igFbH2IUM6TFX/c0dUl+X5uz8hdtBn7NJtmP8I1BHlxfbgHJj/FOohUNrTL2lBYTplcmJ
	 T9xf1BI2ARKeKCYWy6Tg1FjKiKe3fbm8xn19sxNp6u4BZapZctYdWBIOHGQqQbwMZGsX5
	 HIn1V6bR6FFb4DcUJeFVgzqk1PMEkiOs76mJyrctDgwwutLhUUJhwZgn9GV2uJ8/+jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=gj66B+yW;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE0606A31B;
	Fri,  6 Nov 2026 03:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34CE0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=gj66B+yW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=gj66B+yWJG5D//6Kwtvdh5WXDcj3LW80ib2pY1z2KPKYaAVeQXo93uPItUcbHhOsillD3roTGDZUO
	 m/u63sDGQUEVyvnAI1nT5t19w0NrIxO4qmavTeDaIVp6jd6Khcxl2iRH5Qx0nX99Xer7L6TdY1B6Og
	 421u322qL5YrXlBQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46aed4bb11cf-4bca4;
	Fri, 06 Nov 2026 11:38:26 +0800 (CST)
X-RM-TRANSID:2ee46aed4bb11cf-4bca4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66aed4bb24b7-1060a;
	Fri, 06 Nov 2026 11:38:26 +0800 (CST)
X-RM-TRANSID:2ee66aed4bb24b7-1060a
From: xujiahao <xujiahao@cmss.chinamobile.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xujiahao <xujiahao@cmss.chinamobile.com>
Subject: [PATCH] Input: sidewinder - size the name buffers to their formats
Date: Fri,  6 Nov 2026 11:33:00 +0800
Message-ID: <20261106033300.3439313-1-xujiahao@cmss.chinamobile.com>
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
Content-Transfer-Encoding: 8bit

sw_connect() composes the physical path of each port as "%s/input%d"
from gameport->phys into a 32-byte array.  gameport->phys is a 32-byte
string and the port number is an int, so the worst case is 31 + 6 + 10
characters plus the terminator and does not fit.

sw_3dp_id() builds " [PnP %d.%02d id %s rev %s]" into the 40-byte
comment buffer of sw_connect().  The PnP ID is 7 characters, the
revision string 8, and the %d arguments are a full-range int as far as
the compiler can tell, so 44 characters plus the terminator do not fit
either.

Size both buffers to their formats.  Truncation is theoretical with the
values seen today, but a buffer should not be smaller than what it is
asked to hold.  Building with W=1:

  drivers/input/joystick/sidewinder.c:538:58: warning: '%s' directive output may be truncated writing up to 8 bytes into a region of size between 5 and 21 [-Wformat-truncation=]
  drivers/input/joystick/sidewinder.c:727:29: warning: '/input' directive output may be truncated writing 6 bytes into a region of size between 1 and 32 [-Wformat-truncation=]

Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
 drivers/input/joystick/sidewinder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
index 7f37d18c8..2bd5cfe5c 100644
--- a/drivers/input/joystick/sidewinder.c
+++ b/drivers/input/joystick/sidewinder.c
@@ -97,7 +97,7 @@ struct sw {
 	struct gameport *gameport;
 	struct input_dev *dev[4];
 	char name[64];
-	char phys[4][32];
+	char phys[4][64];
 	int length;
 	int type;
 	int bits;
@@ -574,7 +574,7 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
 	unsigned char *buf = NULL;	/* [SW_LENGTH] */
 	unsigned char *idbuf = NULL;	/* [SW_LENGTH] */
 	unsigned char m = 1;
-	char comment[40];
+	char comment[48];
 
 	comment[0] = 0;
 
-- 
2.43.0



