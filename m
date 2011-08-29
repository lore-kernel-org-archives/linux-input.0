From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH v4 0/8] Input: elantech: add support for newer hardware
Date: Mon, 29 Aug 2011 16:28:51 +0800
Message-ID: <1314606539-24722-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:38868 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1H2I07 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 04:26:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>, JJ Ding <jj_ding@emc.com.tw>

Hi Lists,

This is a series of patches to add support for newer generations of ELA=
N
touchpad.

Patches #1~#6 are essentially fixes and cleanups that pave the way for
patch #7 and patch #8, which really adds code for v3 and v4 hardware.

Any comments, suggestoins are welcome.

Note:
Please review patch #8, which adds support for the latest touchpads fro=
m ELAN.
This is a true multi-touch capable touchpad that can track up to 5 fing=
ers.
Support is implemented using MT-B protocol. I used synaptics and multit=
ouch X
driver to test this driver, both worked fine.

Thank you very much.

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

Changes since v2:
- fix v3 hardware packet checking (reported by Seth and fix by Dmitry.)

Changes since v3:
- fix a tiny style problem (useless space on end-of-line, reported by S=
eth)
- v3 hardware can track 2 fingers well, so do not set INPUT_PROP_SEMI_M=
T on v3
  (As suggested earlier by =C3=89ric.)
- add patch #8, which adds support for v4 hardware.

JJ Ding (8):
  Input: elantech - correct x, y value range for v2 hardware
  Input: elantech - get rid of ETP_2FT_* in elantech.h
  Input: elantech - use firmware provided x, y ranges
  Input: elantech - remove ETP_EDGE_FUZZ_V2
  Input: elantech - packet checking for v2 hardware
  Input: elantech - clean up elantech_init
  Input: elantech - add v3 hardware support
  Input: elantech - add v4 hardware support

 Documentation/input/elantech.txt |  295 +++++++++++++++++-
 drivers/input/mouse/elantech.c   |  614 ++++++++++++++++++++++++++++++=
++-----
 drivers/input/mouse/elantech.h   |   56 +++-
 3 files changed, 849 insertions(+), 116 deletions(-)

--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
