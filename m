From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] [media] v4l: xilinx: VIDEO_XILINX should depend on HAS_DMA
Date: Thu, 23 Apr 2015 20:09:05 +0200
Message-ID: <1429812547-9640-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Hyun Kwon <hyun.kwon@xilinx.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

If NO_DMA=3Dy:

    warning: (VIDEO_XILINX && VIDEO_DM365_VPFE && VIDEO_DT3155 && VIDEO=
_OMAP4) selects VIDEOBUF2_DMA_CONTIG which has unmet direct dependencie=
s (MEDIA_SUPPORT && HAS_DMA)

    media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98vb2_dc=
_mmap=E2=80=99:
    media/v4l2-core/videobuf2-dma-contig.c:207: error: implicit declara=
tion of function =E2=80=98dma_mmap_coherent=E2=80=99
    media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98vb2_dc=
_get_base_sgt=E2=80=99:
    media/v4l2-core/videobuf2-dma-contig.c:390: error: implicit declara=
tion of function =E2=80=98dma_get_sgtable=E2=80=99

VIDEO_XILINX selects VIDEOBUF2_DMA_CONTIG, which bypasses its dependenc=
y
on HAS_DMA.  Make VIDEO_XILINX depend on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/media/platform/xilinx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/xilinx/Kconfig b/drivers/media/plat=
form/xilinx/Kconfig
index d7324c726fc2a881..84bae795b70d3148 100644
--- a/drivers/media/platform/xilinx/Kconfig
+++ b/drivers/media/platform/xilinx/Kconfig
@@ -1,6 +1,6 @@
 config VIDEO_XILINX
 	tristate "Xilinx Video IP (EXPERIMENTAL)"
-	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API && OF
+	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API && OF && HAS_DMA
 	select VIDEOBUF2_DMA_CONTIG
 	---help---
 	  Driver for Xilinx Video IP Pipelines
--=20
1.9.1
