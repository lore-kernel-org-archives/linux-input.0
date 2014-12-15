From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 0/2] Input: atmel_mxt_ts - Add support for T100 multi-touch
Date: Mon, 15 Dec 2014 11:39:05 +0100
Message-ID: <1418639947-28765-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Nick Dyer <nick.dyer@itdev.co.uk>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

There are different multi-touch protocols used by Atmel maXTouch touchscreen
chips. Old chips use the T9 multi-touch object type while newer chips use the
T100 multi-touch object type. The Atmel touch driver currently only supports
the former so this series add support for the later.

The series is composed of the following patches:

Nick Dyer (1):
  Input: atmel_mxt_ts - Implement support for T100 touch object

Sjoerd Simons (1):
  Input: atmel_mxt_ts - Split out touchpad initialisation logic

 drivers/input/touchscreen/atmel_mxt_ts.c | 307 +++++++++++++++++++++++++++----
 1 file changed, 270 insertions(+), 37 deletions(-)

Patch #1 adds the support for the T100 touch object and patch #2 is a
cleanup to simplify the driver's input device initialization function.

The series were tested on an Exynos 5420 Peach Pit (T9) and an Exynos
5800 Peach Pi (T100) using evtest.

Best regards,
Javier
