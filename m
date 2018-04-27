From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/3] ASoC: Use gpio_is_valid()
Date: Fri, 27 Apr 2018 14:26:08 +0530
Message-ID: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

Replace the manual validity checks for the GPIO with the
gpio_is_valid().

Arvind Yadav (3):
  [PATCH 1/3] ASoC: tlv320dac33: Use gpio_is_valid()
  [PATCH 2/3] ASoC: tpa6130a2: Use gpio_is_valid()
  [PATCH 3/3] ASoC: samsung: Use gpio_is_valid()

 sound/soc/codecs/tlv320dac33.c     | 10 +++++-----
 sound/soc/codecs/tpa6130a2.c       |  8 ++++----
 sound/soc/samsung/s3c24xx_simtec.c | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

-- 
1.9.1
