From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 0/3] ARM: dts: lpc32xx: fix lpc32xx-key device node
Date: Sat, 26 Jan 2019 16:29:18 +0200
Message-ID: <20190126142921.16041-1-vz@mleia.com>
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
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sylvain Lemieux <slemieux.tyco@gmail.com>
List-Id: linux-input@vger.kernel.org

The changeset adds missing but required 'clocks' property and fixes
'interrupts' property of a keypad controller on NXP LPC32xx powered boards.

The devicetree binding documentation is updated accordingly.

Vladimir Zapolskiy (3):
  Input: lpc32xx-key - add clocks property and fix DT binding example
  ARM: dts: lpc32xx: add required clocks property to keypad device node
  ARM: dts: lpc32xx: reparent keypad controller to SIC1

 Documentation/devicetree/bindings/input/lpc32xx-key.txt | 5 ++++-
 arch/arm/boot/dts/lpc32xx.dtsi                          | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.20.1
