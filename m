From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] ARM: tegra: use dt-binding header for key code
Date: Tue, 6 Aug 2013 19:42:50 +0530
Message-ID: <1375798370-2231-2-git-send-email-ldewangan@nvidia.com>
References: <1375798370-2231-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1375798370-2231-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

In place of hardcoding the key code in DTS file and comment the key code
as side notes, use the key code macro defines in the dt-bindings/input/input.h
directly.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 7c50d37..c56bf2d 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1,5 +1,6 @@
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
 #include "tegra114.dtsi"
 
 / {
@@ -1084,26 +1085,26 @@
 		home {
 			label = "Home";
 			gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
-			linux,code = <102>; /* KEY_HOME */
+			linux,code = <KEY_HOME>;
 		};
 
 		power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
-			linux,code = <116>; /* KEY_POWER */
+			linux,code = <KEY_POWER>;
 			gpio-key,wakeup;
 		};
 
 		volume_down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(R, 1) GPIO_ACTIVE_LOW>;
-			linux,code = <114>; /* KEY_VOLUMEDOWN */
+			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
 		volume_up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_LOW>;
-			linux,code = <115>; /* KEY_VOLUMEUP */
+			linux,code = <KEY_VOLUMEUP>;
 		};
 	};
 
-- 
1.7.1.1
