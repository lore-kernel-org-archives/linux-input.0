From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v3 3/5] MAINTAINERS: add Atmel PTC entries
Date: Fri, 20 Oct 2017 15:31:19 +0200
Message-ID: <20171020133121.7992-4-ludovic.desroches@microchip.com>
References: <20171020133121.7992-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171020133121.7992-1-ludovic.desroches@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, dmitry.torokhov@gmail.com, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add entries for the Atmel PTC Subsystem.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0630482e701b..e1bf4c9d7696 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2371,6 +2371,13 @@ F:	Documentation/devicetree/bindings/input/atmel,maxtouch.txt
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
 F:	include/linux/platform_data/atmel_mxt_ts.h
 
+ATMEL PTC SUBSYSTEM DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+L:	linux-input@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/input/atmel,ptc.txt
+F:	drivers/input/misc/atmel_ptc.c
+
 ATMEL NAND DRIVER
 M:	Wenyou Yang <wenyou.yang@atmel.com>
 M:	Josh Wu <rainyfeeling@outlook.com>
-- 
2.12.2
