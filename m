From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v3 0/4] Fixes for ALPS driver
Date: Sun,  2 Nov 2014 00:25:06 +0100
Message-ID: <1414884310-19842-1-git-send-email-pali.rohar@gmail.com>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35834 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbaKAXZy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Nov 2014 19:25:54 -0400
In-Reply-To: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

This patch series tries to fix problems with ALPS dualpoint devices on =
Dell
Latitude laptops which are probably caused by bugs in Dell BIOS, Dell E=
C or
in ALPS touchpad firmware itself.

Root of problems is yet unknown but at least this patch series could el=
iminate
reporting bogus data to userspace.

Reported bugs:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1258837
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1320022
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1272624
https://bugzilla.redhat.com/show_bug.cgi?id=3D1145954

Pali Roh=C3=A1r (4):
  input: alps: Do not try to parse data as 3 bytes packet when driver
    is out of sync
  input: alps: Allow 2 invalid packets without resetting device
  input: alps: For protocol V3, do not process data when last packet's
    bit7 is set
  input: alps: Fix trackstick detection

 drivers/input/mouse/alps.c |  113 +++++++++++++++++++++++++++++++-----=
--------
 1 file changed, 80 insertions(+), 33 deletions(-)

--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
