From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 0/5] ASoC/arizona: Ensure pin searches use widget name prefix
Date: Mon, 28 Nov 2016 17:32:25 +0000
Message-ID: <1480354350-24978-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:52884 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752564AbcK1RdG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 12:33:06 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: broonie@kernel.org, cw00.choi@samsung.com, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org

The name of a codec pin can have an optional prefix string, which is
defined by the audio machine driver. The snd_soc_dapm_x_pin functions
take the fully-specified name including the prefix and so the existing
code would fail to find the pin if the audio machine driver had added
a prefix.

This patch chain adds new helper functions that take a non-prefixed name
for a specific ASoC component and internally add that component's prefix.
The other patches update the arizona drivers to use these new functions.

Richard Fitzgerald (5):
  ASoC: core: Add component pin control functions
  ASoC: arizona: Use component pin control functions
  regulator: arizona-micsupp: Use SoC component pin control functions
  extcon: arizona: Use SoC component pin control functions
  Input: arizona-haptics - Use SoC component pin control functions

 drivers/extcon/extcon-arizona.c      |   8 +-
 drivers/input/misc/arizona-haptics.c |  13 ++-
 drivers/regulator/arizona-micsupp.c  |   6 +-
 include/sound/soc.h                  |  25 +++++
 sound/soc/codecs/arizona.c           |  13 ++-
 sound/soc/codecs/cs47l24.c           |   2 +-
 sound/soc/codecs/wm5102.c            |   2 +-
 sound/soc/codecs/wm5110.c            |   2 +-
 sound/soc/codecs/wm8998.c            |   2 +-
 sound/soc/soc-utils.c                | 199 +++++++++++++++++++++++++++++++++++
 10 files changed, 254 insertions(+), 18 deletions(-)

-- 
1.9.1

