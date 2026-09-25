Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9B49482E
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377279; cv=none; b=rp8d+swpS4U7fuK3976vapECh+IjRt9AB9UwxaikkCDWPT7p19O6TfEy4hZ7Om1BXjBPGC7ksOF0AwNPn1ZtwgIHXY6tu/cTQGvjuyefq0ttnmgOAislKSMnVjnZk1eorvZ6079Vv22yG7pQcYNefIAj1PkOwLdPCLVomKtpC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377279; c=relaxed/simple;
	bh=RIy0KwrUMk7zzmVivVsxjnA+TSbk0UjyCIxON/nNzEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u67mJeBN/DFHYq9N4bSBWETZID9gbSVorAx1RyiKQVdUaAA8igEl3UxDtqX9SAshRskgUryiSHa/++iBG8q17Bqwx6YLHtp1yk6ONubECf93/7imWYDZs3ola4K1QRXsAPUek9foiLuKq6xA9BdhDMf6U3cD8ZA5gR78ZhlPqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDdiCCmm; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDdiCCmm"
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5cddebe9b2cso152738e0c.1
        for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790377276; x=1790982076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sFJAWMbuQDMPuL+kmFa3AtrXjztcOUowTHzkHn+U0Q=;
        b=RDdiCCmmP9368Ksm25aNT4BBNOW63kRQvbZP8B6Y9hX1wnQ/zQN1KbB0WIhHGOd0KS
         aAQk60zzXjKRqzFxTwyFsSwO1ykma6Lv/kXea++bKDLf31NVO56zSyBe5qYiUcvQlfDV
         U2dbuwy5YxcTxrMLWgLF5YaxPq41iZaeL09f1jaGsa70LUcexvGR61LGNTDuyo2UuNTm
         DxrQN0WLO0LOlsJ/hEOF+RFkNgamIasek1DSKZmp5mOENgGJR4/YGK54msmPNtHmqIlU
         OttAEKwnv15xSfKcpsQICBECimA7CTpT2OzDjoi4z8RWHWWA1TYn522z4QuokiJzhpdb
         dW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790377276; x=1790982076;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/sFJAWMbuQDMPuL+kmFa3AtrXjztcOUowTHzkHn+U0Q=;
        b=QLPFVH7nRGohaVvejLChHivC9Q0Tut4ILtJn975opy5f7DuFTkstMwe/olR5aDVXJI
         laDSU7z2ZdM4SIg5C4/wD55AqxZOv5cph6Tg5GgwVQhiC/YSaFEBEvledWvs5XI2PBH7
         ok9t6pSjbOQ/icEiHO0p1V0HklbSLbin4OQ7DPmzMpZS7XytxicG9AnjZTH1zA7QnuQI
         +VQ2oTmwGLTxFNKhMhyNdSMWvEgxq4RNxYl5F3W9BUydFYF1ZzUIQdGSZgeyjhnSazjm
         4TaTZsngUaRj8esBYuzyqD74rzXRrHm6fK8mj4ecgxmoyhxLJYqIafZfNHeKE3ixpv0o
         MoRQ==
X-Gm-Message-State: AFuF++nzMJ1TpnkMPVlxmBuGi9aXSDlWstjcR4NP1K6PKeplgd/92ppq
	xcx+nMJatKKaTVcmBwC2NLx4flvFwszjAHZsiLVVy3lRfIqS2+eZdHOd
X-Gm-Gg: AYBFou3o19RrgD/kzjInR9wf1efLpMKpK+DVnpF9mLhLziEf6QcvcNtCrnq7aAN667f
	oRm43fh1+71nk2UOOnJgCiNfdu+XFcZ6jT2Ois2fqk1TT4tJ8Sl9wG8GWNIhcWFVfwmjbwoHi/4
	7ERFPrDrRtakF+DxmegvpnC09YtcjywWk+Az4mKMGSD40D1D73GobDN9Eit2K72XXE2VEfPFxfR
	Y5avAiqEcRO37hEC82noOHKjWv9awzZGDd7tCywOaxfQ/P5XewarfvyDSxM3QI1RXXy1rcrXTyX
	Wj8FqjsfcvBbKvw/FQ0ONRvAN6+af9b+byt2ga7WX97kCfPr6oeGammQX8um5HWpbDao60Ss+iC
	3GQWcd/b9cOk7nPgusitpcXFeKew3/tF7AwFUJ8tiyEH9pMnWKSi3iiTCVJG33EaCJPGPv4qz9x
	HoMEk/92sspqNR7t31+/pbjVg3pB82jq8WhmGDhWV6tV4uZx+XWI0sN32qz6oXxvCR+8l+slbVs
	0K9KGBx19NeGzuoRLiVXRaYVzbMC48EOc34KharwDgZqkrIqsaSSWhc
X-Received: by 2002:a05:6122:310f:b0:5bf:8c77:e89a with SMTP id 71dfb90a1353d-5cb09217797mr4032734e0c.2.1790377276151;
        Fri, 25 Sep 2026 16:01:16 -0700 (PDT)
Received: from daniel-l440.tail54b8a9.ts.net (host179.190-30-68.telecom.net.ar. [190.30.68.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde02784b7sm562190e0c.0.2026.09.25.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:01:15 -0700 (PDT)
From: Daniel Salmun <salmundani@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>,
	Daniel Salmun <salmundani@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: synaptics - limit the T440p InterTouch quirk to LEN0036
Date: Fri, 25 Sep 2026 20:00:31 -0300
Message-ID: <20260925230039.236786-1-salmundani@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 26eb3d92c7a4 ("Input: synaptics - disable InterTouch on ThinkPad
T440p (board id 2722)") disables InterTouch for every touchpad with
board id 2722. The ThinkPad L440 (LEN2004) uses the same board id:

  psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xd001a3/0x940300/0x127c00/0x0, board id: 2722, fw id: 1484859

so it is switched to PS/2 as well, although it does not have the boot
problem that commit works around. On the L440 the SMBus adapter is
registered after psmouse probes, so the first attempt returns -EAGAIN
and the adapter notifier completes the switch about two seconds later.
It did so on all 7 boots in my logs:

  psmouse serio1: synaptics: SMbus companion is not ready yet
  psmouse serio1: synaptics: Trying to set up SMBus access
  rmi4_smbus 0-002c: registering SMbus-connected sensor

Match PNP ID LEN0036 as well, as the earlier versions of that patch
did, so that only the T440p is affected.

Disabling InterTouch on the L440 was proposed before and not merged
[1]. In PS/2 mode this touchpad reports two tracked contacts and no
contact size, orientation or palm tool type, which it does over SMBus.

[1] https://lore.kernel.org/linux-input/20230414092353.v2.1.Ieb687047a5b75c7b7ee5dd258207ef5ca9a3b728@changeid/

Fixes: 26eb3d92c7a4 ("Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daniel Salmun <salmundani@gmail.com>
---
Raphaël, your earlier versions matched LEN0036 as well. Was dropping
it in the V2 RESEND intentional, e.g. because some T440p units report
a different PNP ID?

26eb3d92c7a4 is queued for 6.18.54 and 7.2.8, so without this the L440
drops to PS/2 on those stable kernels too.

Build-tested on top of for-linus. The L440 logs above are from 6.18.48,
which does not have 26eb3d92c7a4.

 drivers/input/mouse/synaptics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a8ce89d41..6bc14c07a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1840,7 +1840,9 @@ static int synaptics_setup_intertouch(struct psmouse *psmouse,
 		}
 
 		/* Disable intertouch on known-broken board revisions */
-		if (info->board_id == 2722) {
+		if (psmouse_matches_pnp_id(psmouse,
+				(const char * const []){"LEN0036", NULL}) &&
+		    info->board_id == 2722) {
 			psmouse_info(psmouse,
 				     "Disabling intertouch for board id %u\n",
 				     info->board_id);

base-commit: 309731e95917125bbd13626a7a5600490a5bf44f
-- 
2.55.0

