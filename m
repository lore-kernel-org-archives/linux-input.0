From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH v2 0/7] Input: elantech: add support for newer hardware
Date: Wed, 24 Aug 2011 13:38:16 +0800
Message-ID: <1314164303-30382-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:32016 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab1HXFgK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Aug 2011 01:36:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>, JJ Ding <jj_ding@emc.com.tw>

Hi Lists,

This is a series of patches to add support for newer generation of ELAN
touchpad.

Patches #1~#6 are essentially fixes and cleanups that pave the way for
patch #7, which really adds code for v3 hardware.

Any comments, suggestoins are welcome.

Thank you.

Changes since v1:
- drop EC workaround patch.
- add patch #2, make ST and MT have the same range, as Dmitry suggested=
=2E
- add patch #4, remove ETP_EDGE_FUZZ_V2, as =C3=89ric suggested.
- rename all packet checking functions so they are consistent.
- some code cleanup, and don't report ABS_[XY] when fingers =3D=3D 0, a=
s Seth suggested.
- add document for v3 debounce, and now check debounce in elantech_pack=
et_check_v3.

JJ Ding (7):
  Input: elantech - correct x, y value range for v2 hardware
  Input: elantech - get rid of ETP_2FT_XXXX in elantech.h
  Input: elantech - use firmware provided x, y ranges
  Input: elantech - remove ETP_EDGE_FUZZ_V2
  Input: elantech - packet checking for v2 hardware
  Input: elantech - clean up elantech_init
  Input: elantech - add v3 hardware support

 Documentation/input/elantech.txt |  125 +++++++++++--
 drivers/input/mouse/elantech.c   |  387 ++++++++++++++++++++++++++++++=
+-------
 drivers/input/mouse/elantech.h   |   35 ++--
 3 files changed, 444 insertions(+), 103 deletions(-)

--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
