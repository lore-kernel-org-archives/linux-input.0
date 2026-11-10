Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275796;
	b=2gB/fERyLxFtPY0ZlIiRKZA3CPCi+3HJU+8MMVgOCrC+fUuEnZG/luadMRshcIfhtMgy
	 NpOJTU2qdpCNzbo/Z3317jAWKHcEo1pVcJX36i3/GA/AuG6b5TO/LLjr4F66a+nDahsMt
	 YNL9tkPUGHy/zCovxa+KZO6op75x5WV9wjbIQsOADVfRPMkcGZE4IVVYy94QPSMV9S8Y5
	 6YuZBBqb6TTJMTe9FQQuAZnQBO70e1ZrmNPx3p2fYd2rHbvaCq/W59wEIjiIQzt3Q1fZs
	 3H+hgAw0Zj403vIGqf8455pXLrNJlqMW+zrl4KEmFR0YEccwk+HUSsEWl4+j03teUIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275796;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=y9g0+FWAkEii2LxI1Ms1cBFNUWBMR8wGiqD3Z1aURg8=;
	b=4IEQ37su2J5DauE6mC7+ymtztj4WGc2q3yK1o66FyISfkx3m907NTVvbIXNQkBQ6Hh3f
	 It7WHI/6809YsHe6+btC5pWDFJDtBUxTXLbj+pS5SU0+42uGfEy54X5Yya9Eo/U656v0z
	 Zz+iZxIzBJkchviSzGCstT1eHhEIDM7VvRYEbySgOhungxXDWpme2jhnRLMahuVRvpNZP
	 vBjasxdgPOyMItQ6wSOvImPyEioBSNqaPBhljgGP+8W19Zj51OahT0RenuM/GJfZimoDJ
	 rnACRwDmQb9BqgYjdF81+gRW40vrruam1NJrbxCNmgAqQnAiDjRCpZDMpYdpOcJ5kEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rB1iyXXy;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C41606A31C;
	Tue, 10 Nov 2026 01:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3C41606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rB1iyXXy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=rB1iyXXyaZgh2UvBVqJTzRFp7+I1k/+1uM63YzDCump6oZ+OW1mp3ooWsV90628yBlJmD93YhO/y/
	 BQXakveYdh+mKV0yZqHVSrbS0bUEGEmQE0JVNnPZdsO3u8mouO0HAoNUmtZfh/daTW2M2tb0B/QRxZ
	 8EHcq5lUuoLsPoRM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af279cd208-c6760;
	Tue, 10 Nov 2026 09:56:30 +0800 (CST)
X-RM-TRANSID:2ee56af279cd208-c6760
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af279cc1f3-a1e53;
	Tue, 10 Nov 2026 09:56:30 +0800 (CST)
X-RM-TRANSID:2ee86af279cc1f3-a1e53
From: xujiahao <xujiahao@cmss.chinamobile.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	xujiahao <xujiahao@cmss.chinamobile.com>
Subject: [PATCH v3] Input: sidewinder - use scnprintf() for the port names
Date: Tue, 10 Nov 2026 09:48:42 +0800
Message-ID: <20261110014842.884394-1-xujiahao@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109010548.438699-1-xujiahao@cmss.chinamobile.com>
References: <20261109010548.438699-1-xujiahao@cmss.chinamobile.com>
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
from gameport->phys into a 32-byte array, and sw_3dp_id() builds
" [PnP %d.%02d id %s rev %s]" into the 40-byte comment buffer of
sw_connect().  GCC reports that both formats can overflow their buffers
in a W=1 build:

  drivers/input/joystick/sidewinder.c:538:58: warning: '%s' directive output may be truncated writing up to 8 bytes into a region of size between 5 and 21 [-Wformat-truncation=]
  drivers/input/joystick/sidewinder.c:727:29: warning: '/input' directive output may be truncated writing 6 bytes into a region of size between 1 and 32 [-Wformat-truncation=]

The values seen in practice fit these buffers, and a truncated name is
harmless, so keep the sizes as they are and switch to scnprintf() to
make the truncation explicit instead of letting the compiler warn about
a possible one.

Link: https://lore.kernel.org/all/20261106033300.3439313-1-xujiahao@cmss.chinamobile.com/
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611091814.ChpgVgpE-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202611100328.QAelfSpD-lkp@intel.com/
Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
v3:
 - The PnP id computation is untouched again.  v2 moved the (int) cast
   behind the division, which made it a 64-bit division and broke 32-bit
   builds (ld: undefined reference to __aeabi_uldivmod / __udivdi3 /
   __umoddi3), as reported by the kernel test robot.  Only the snprintf()
   calls change now.
---
 drivers/input/joystick/sidewinder.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
index 7f37d18c8..78dc70964 100644
--- a/drivers/input/joystick/sidewinder.c
+++ b/drivers/input/joystick/sidewinder.c
@@ -535,12 +535,12 @@ static void sw_3dp_id(unsigned char *buf, char *comment, size_t size)
 
 	pnp[7] = rev[8] = 0;
 
-	snprintf(comment, size, " [PnP %d.%02d id %s rev %s]",
-		(int) ((sw_get_bits(buf, 8, 6, 1) << 6) |		/* Two 6-bit values */
+	scnprintf(comment, size, " [PnP %d.%02d id %s rev %s]",
+		  (int)((sw_get_bits(buf, 8, 6, 1) << 6) |	/* Two 6-bit values */
 			sw_get_bits(buf, 16, 6, 1)) / 100,
-		(int) ((sw_get_bits(buf, 8, 6, 1) << 6) |
+		  (int)((sw_get_bits(buf, 8, 6, 1) << 6) |
 			sw_get_bits(buf, 16, 6, 1)) % 100,
-		 pnp, rev);
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



