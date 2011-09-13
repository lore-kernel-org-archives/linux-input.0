From: JJ Ding <jj_ding@emc.com.tw>
Subject: =?UTF-8?q?=5BPATCH=200/2=5D=20Better=20support=20old=20elantech=20v2=20hardware?=
Date: Tue, 13 Sep 2011 14:15:47 +0800
Message-ID: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:38687 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab1IMGNX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 02:13:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Richard=20Sch=C3=BCtz?= <r.schtz@t-online.de>, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, JJ Ding <jj_ding@emc.com.tw>

Hi everyone,

Thanks to Richard Sch=C3=BCtz's bug report, I did some more research on=
 elantech
v2 hardware. I asked our Windows driver team and firmware team about th=
e
_ancient histroy_ of the dark old days ;-) These two patches are the re=
sults.

Hopefully with these 2 we can support v2 hardware as good as Windows do=
es.

I can only get two old v2 (fw: 0x020800, 0x040201) to test. Those who h=
ave a elantech v2
hardware please do test, thank you very much.

Note:
These 2 patches are on top of my previous v5 series.

JJ Ding (2):
  Input: elantech - better support all those v2 variants
  Input: elantech - remove module parameter force_elantech

 drivers/input/mouse/elantech.c |   58 +++++++++++++++++++++++++++++---=
-------
 drivers/input/mouse/elantech.h |    1 +
 2 files changed, 44 insertions(+), 15 deletions(-)

--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
