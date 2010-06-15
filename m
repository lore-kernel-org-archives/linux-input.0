From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RFC 0/3] WM97xx AC97 GPIO support
Date: Tue, 15 Jun 2010 17:55:44 +0200
Message-ID: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63423 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab0FOPzz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jun 2010 11:55:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: alsa-devel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, Manuel Lauss <manuel.lauss@googlemail.com>

Here's 3 patches which implement simple AC97 GPIO support to the WM97xx touch
drivers and the Alchemy (au1x) AC97 ASoC implementation.

Tested on Au1200 hardware with a WM9712 codec:  According to Mark Brown the
WM9712 only sets GPIOs when data is sent through slot 12, which prompted me
to implement this.

Thanks,
       Manuel Lauss


Manuel Lauss (3):
  sound: ac97: Add GPIO manipulation hooks
  input: wm97xx: set GPIOs with AC97 GPIO busops if implemented
  sound: asoc: au1x: implement AC97 GPIO access

 drivers/input/touchscreen/wm97xx-core.c |    5 +++-
 include/sound/ac97_codec.h              |    2 +
 sound/soc/au1x/psc-ac97.c               |   39 +++++++++++++++++++++++++++++-
 sound/soc/au1x/psc.h                    |    2 +
 4 files changed, 45 insertions(+), 3 deletions(-)

