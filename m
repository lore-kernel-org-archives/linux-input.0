From: Chen Zhong <chen.zhong@mediatek.com>
Subject: [PATCH v5 2/6] dt-bindings: input: Add common keyboard document
 bindings
Date: Wed, 27 Sep 2017 18:44:04 +0800
Message-ID: <1506509048-19032-3-git-send-email-chen.zhong@mediatek.com>
References: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alessandro Zummo <a.zummo@towertech.it>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Jaechul Lee <jcsing.lee@samsung.com>, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>, linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch adds the device tree binding documentation for common
keyboard.

Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 Documentation/devicetree/bindings/input/keys.txt |    8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/keys.txt

diff --git a/Documentation/devicetree/bindings/input/keys.txt b/Documentation/devicetree/bindings/input/keys.txt
new file mode 100644
index 0000000..a0ea7eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/keys.txt
@@ -0,0 +1,8 @@
+General Keys Properties:
+
+Optional properties for Keys:
+- power-off-time-sec: Duration in seconds which the key should be kept
+ 	pressed for device to power off automatically. Device with key pressed
+ 	shutdown feature can specify this property.
+- linux,keycodes: Specifies the numeric keycode values to be used for
+	reporting key presses.
\ No newline at end of file
-- 
1.7.9.5
