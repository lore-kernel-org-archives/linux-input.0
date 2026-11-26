Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665132;
	b=mAYHLtTpQ/w0dgq+CDZJhsKJp+P9bvpOq/20wAKMJbRcXA/Y0DT8IBcqIdE3L1ApGyBw
	 jUir1vEDPs/Mzj/65iZhV5oLsWeRbbNfUxmR+aximcjAsqufBVH9+6tjHxpnaao6SCUmB
	 vBQHJXGmGT++aKZJqEkQKorK2AJjwIv+jXEyN42B5PE6M0anIUivq4gt0AbITi8NUcNA/
	 4G1VtTz9I2+VLW6cb4nXb4CZ5nbVQjMiYxeO0nW+R6xrbX648eh+G85q4A1eZA0NAJ777
	 j4W6dvxOMXfoC4i8spPYFUbpHQKRu8MS9/aAXM9NqMmp9Fu9ibdiFWxq5cglUupFfYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665132;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C43d4cAYRrWesFZvMlHucUphYTNYi2rj92+Xt/2XUlk=;
	b=WQ8R9U5hEXr6Xi73jAfwKiZVMYcpoBWkx5VvJMS8AEHAsDG7DT00E3+Vm8OhGuixEEHf
	 L8WzD8NL5Tp/I2mJS/iqDanihAu42HqPd/imhgGmvxujWMYTBTf2OPSvuAxcjPp4nrak5
	 UAZjhrELG9Dufea5idjMiiraVvg49cJ8Op/J9B/cgJpraWf5xDJfJ6SdAqaLbBOXl54WD
	 OdNaom+psr9l21kc76ILrkyq1tDcGsfkPyFLZlhU6QXDpeFxJ3GVdnlQvRX4eYVTJfZzy
	 6QKVF//kpfoLbzwidfDjkFpMt7ksFNb4jg7egIjH2B2EGuwpGzdUXNpkZzssEtuAeuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=gSy7rGcW;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219E8606A31C;
	Thu, 26 Nov 2026 03:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 219E8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=gSy7rGcW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=gSy7rGcW8w+YL8LM69PlBGlt7QCEAWfHoM5g34zos6FEAkRPw1/C80zy1Ii8NYOaI8xFNb08HDqOv
	 ZH03jEkBep6wtJbmAvIdXv9UmUI+b/Ak2f5VQh6rVxWjglNFj1DrWAG2ci6QaQWLDCvn3iqJv0pFoi
	 aEwNoULWHjikS6kk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46b07ace7236-f7b03;
	Thu, 26 Nov 2026 11:52:08 +0800 (CST)
X-RM-TRANSID:2ee46b07ace7236-f7b03
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHD-W7400297 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96b07ace6580-5be3e;
	Thu, 26 Nov 2026 11:52:08 +0800 (CST)
X-RM-TRANSID:2ee96b07ace6580-5be3e
From: Aibing Chen <chenaibing@cmss.chinamobile.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: cobra - use scnprintf() for the device physical path
Date: Thu, 26 Nov 2026 11:52:06 +0800
Message-ID: <20261126035206.1062-1-chenaibing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

cobra_connect() composes the physical path of each port as "%s/input%d"
from gameport->phys into a 32 byte array.  gameport->phys can hold up to
31 characters, so the composed string reaches 39 bytes and does not fit.
The path is informational only and truncating it is acceptable, but the
call site does not say so.

Building with W=1, where -Wformat-truncation is enabled, the file does not
build at all today; COMPILE_TEST configurations additionally turn the
warning into an error through CONFIG_WERROR:

  drivers/input/joystick/cobra.c:184:29: error: '/input' directive output
    may be truncated writing 6 bytes into a region of size between 1 and
    32 [-Werror=format-truncation=]
  note: 'snprintf' output between 8 and 39 bytes into a destination of
    size 32

Use scnprintf(), the helper that expresses a bounded, truncation tolerant
write, so that the file builds warning free and the intent is visible at
the call site.

No functional change.

Signed-off-by: Aibing Chen <chenaibing@cmss.chinamobile.com>
---
 drivers/input/joystick/cobra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/cobra.c b/drivers/input/joystick/cobra.c
index ffa6d49c8..52331a947 100644
--- a/drivers/input/joystick/cobra.c
+++ b/drivers/input/joystick/cobra.c
@@ -180,8 +180,8 @@ static int cobra_connect(struct gameport *gameport, struct gameport_driver *drv)
 			goto fail3;
 		}
 
-		snprintf(cobra->phys[i], sizeof(cobra->phys[i]),
-			 "%s/input%d", gameport->phys, i);
+		scnprintf(cobra->phys[i], sizeof(cobra->phys[i]),
+			  "%s/input%d", gameport->phys, i);
 
 		input_dev->name = "Creative Labs Blaster GamePad Cobra";
 		input_dev->phys = cobra->phys[i];


