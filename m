From: Joe Perches <joe@perches.com>
Subject: [PATCH 0/8] treewide: correct misuses of strscpy/strlcpy
Date: Thu,  4 Jul 2019 16:57:40 -0700
Message-ID: <cover.1562283944.git.joe@perches.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org, linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-nfs@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

These are all likely copy/paste defects where the field size of the
'copied to' array is incorrect.

Each patch in this series is independent.

Joe Perches (8):
  Input: synaptics: Fix misuse of strlcpy
  leds: as3645a: Fix misuse of strlcpy
  media: m2m-deinterlace: Fix misuse of strscpy
  media: go7007: Fix misuse of strscpy
  net: ethernet: sun4i-emac: Fix misuse of strlcpy
  net: nixge: Fix misuse of strlcpy
  tty: hvcs: Fix odd use of strlcpy
  nfsd: Fix misuse of strlcpy

 drivers/input/mouse/synaptics.c             | 2 +-
 drivers/leds/leds-as3645a.c                 | 2 +-
 drivers/media/platform/m2m-deinterlace.c    | 2 +-
 drivers/media/usb/go7007/snd-go7007.c       | 2 +-
 drivers/net/ethernet/allwinner/sun4i-emac.c | 4 ++--
 drivers/net/ethernet/ni/nixge.c             | 2 +-
 drivers/tty/hvc/hvcs.c                      | 4 ++--
 fs/nfsd/nfs4idmap.c                         | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.15.0
