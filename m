From: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/5] Add ChromeOS Embedded Controller support
Date: Wed, 12 Dec 2012 13:33:43 -0800
Message-ID: <1355348028-19017-1-git-send-email-sjg@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>, Vincent Palatin <vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Luigi Semenzato <semenzato-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Kliegman <kliegs-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Che-Liang Chiou <clchiou-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

(get_maintainer.pl has produced an enormous list - I hope you are all
interested.)

The ChromeOS Embedded Controller (EC) is an Open Source EC implementation
used on ARM and Intel Chromebooks. Current implementations use a Cortex-M3
connected on a bus (such as I2C, SPI, LPC) to the AP. A separate interrupt
line is used to indicate when the EC needs service.

Functions performed by the EC vary by platform, but typically include
battery charging, keyboard scanning and power sequencing.

This series includes support for the EC message protocol, and implements
a matrix keyboard handler for Linux using the protocol. The EC performs
key scanning and passes scan data in response to AP requests. This is
used on the Samsung ARM Chromebook. No driver is available for LPC at
present.

This series can in principle operate on any hardware, but for it to actually
work on the Samsung ARM Chromebook, it needs patches which are currently in
progress to mainline: Exynos FDT interrupt support and I2C bus arbitration.

The driver is device-tree-enabled and a suitable binding is included in
this series. Example device tree nodes are included in the examples,
but no device tree patch for exynos5250-snow is provided at this stage, since
we must wait for the above-mentioned patches to land to avoid errors from
dtc. This can be added with a follow-on patch when that work is complete.


Simon Glass (5):
  mfd: Add ChromeOS EC messages header
  mfd: Add ChromeOS EC implementation
  mfd: Add ChromeOS EC I2C driver
  mfd: Add ChromeOS EC SPI driver
  Input: Add ChromeOS EC keyboard driver

 .../devicetree/bindings/input/cros-ec-keyb.txt     |   77 ++
 Documentation/devicetree/bindings/mfd/cros-ec.txt  |   56 +
 drivers/input/keyboard/Kconfig                     |   10 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/cros_ec_keyb.c              |  413 ++++++
 drivers/mfd/Kconfig                                |   28 +
 drivers/mfd/Makefile                               |    3 +
 drivers/mfd/cros_ec.c                              |  219 ++++
 drivers/mfd/cros_ec_i2c.c                          |  262 ++++
 drivers/mfd/cros_ec_spi.c                          |  412 ++++++
 include/linux/mfd/cros_ec.h                        |  190 +++
 include/linux/mfd/cros_ec_commands.h               | 1369 ++++++++++++++++++++
 12 files changed, 3040 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/cros-ec-keyb.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/cros-ec.txt
 create mode 100644 drivers/input/keyboard/cros_ec_keyb.c
 create mode 100644 drivers/mfd/cros_ec.c
 create mode 100644 drivers/mfd/cros_ec_i2c.c
 create mode 100644 drivers/mfd/cros_ec_spi.c
 create mode 100644 include/linux/mfd/cros_ec.h
 create mode 100644 include/linux/mfd/cros_ec_commands.h

-- 
1.7.7.3
