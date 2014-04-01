From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] Input: w90p910_ts - depend on ARCH_W90X900
Date: Tue, 1 Apr 2014 21:17:03 +0800
Message-ID: <CAKT61h__8fuJDs94akU73grWns82+mk1vmSdQw5fwd1Cx-455g@mail.gmail.com>
References: <20140401142046.14d4bb8c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:34199 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbaDANRY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Apr 2014 09:17:24 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so9889525pbb.11
        for <linux-input@vger.kernel.org>; Tue, 01 Apr 2014 06:17:23 -0700 (PDT)
In-Reply-To: <20140401142046.14d4bb8c@endymion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

---------- Forwarded message ----------
=46rom: Jean Delvare <jdelvare@suse.de>
Date: 2014-04-01 20:20 GMT+08:00
Subject: [PATCH] Input: w90p910_ts - depend on ARCH_W90X900
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
=E6=8A=84=E9=80=81=EF=BC=9A Wan ZongShun <mcuos.com@gmail.com>, Dmitry =
Torokhov
<dmitry.torokhov@gmail.com>


The w90p910_ts touchscreen driver is heavily architecture dependent,
so there is no point in letting it be built on other architectures
than it was written for.

All other W90P910/W90X900 drivers already have that dependency, so it
makes things more consistent and configuration easier.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc8.orig/drivers/input/touchscreen/Kconfig
2014-02-09 16:53:02.945634113 +0100
+++ linux-3.14-rc8/drivers/input/touchscreen/Kconfig    2014-04-01
14:10:08.936933702 +0200
@@ -867,7 +867,7 @@ config TOUCHSCREEN_TSC2007

 config TOUCHSCREEN_W90X900
        tristate "W90P910 touchscreen driver"
-       depends on HAVE_CLK
+       depends on ARCH_W90X900
        help
          Say Y here if you have a W90P910 based touchscreen.

Sure, your idea is reasonable.

Acked-by Wan Zongshun <mcuos.com@gmail.com>

--
Jean Delvare
SUSE L3 Support


--=20
Wan ZongShun.
www.mcuos.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
