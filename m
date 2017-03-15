From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [PATCH 0/4] Add support for Nsiway NS2009 touchscreen controller
Date: Wed, 15 Mar 2017 23:51:36 +0800
Message-ID: <20170315155140.54518-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: devicetree@vger.kernel.org, Icenowy Zheng <icenowy@aosc.xyz>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The production batch of Lichee Pi Zero board have a Nsiway NS2009 touchscreen
controller on board, which is used for connecting resistive touch panels on
40-pin LCD connector.

This patchset adds support for it.

Patch 1 adds vendor prefix for Nsiway, and patch 2 adds device tree binding
for NS2009.

Patch 3 is the real driver of NS2009, which currently supports only polling
(as the IRQ pin is not connected on Lichee Pi Zero).

Patch 4 adds NS2009 node to Lichee Pi Zero device tree.

Icenowy Zheng (4):
  dt-bindings: add vendor prefix for Shenzhen Nsiway Techonology Co.,
    Ltd.
  dt-bindings: add binding for Nsiway NS2009 touchscreen controller
  Input: add driver for Nsiway NS2009 resistive touchscreen controller
  ARM: sun8i: v3s: add ns2009 node for Lichee Pi Zero board

 .../bindings/input/touchscreen/ns2009.txt          |  23 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts      |   9 +
 drivers/input/touchscreen/Kconfig                  |  13 ++
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/ns2009.c                 | 212 +++++++++++++++++++++
 7 files changed, 265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ns2009.txt
 create mode 100644 drivers/input/touchscreen/ns2009.c

-- 
2.12.0
