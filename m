From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH v5 0/3] Syscon support for iProc touchscreen driver
Date: Thu, 24 Mar 2016 11:17:12 +0530
Message-ID: <1458798435-20222-1-git-send-email-raveendra.padasalagi@broadcom.com>
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
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Anup Patel <anup.patel@broadcom.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, Jonathan Richardson <jonathar@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Kumar Gala <galak@codeaurora.org>
List-Id: linux-input@vger.kernel.org

This patchset is based on v4.5-rc3 tag and its tested on
Broadcom Cygnus SoC.

The patches can be fetched from iproc-tsc-v5 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v4:
 - Fixed odd_ptr_err.cocci script warning

Changes since v3:
 - Renamed touchscreen node "tsc" to "touchscreen" in dt binding document
 - Added support for syscon only based register access in touch screen
   driver and removed "regs" based register access. Updated dt binding
   document to reflect the changes.
 - Removed "brcm,iproc-touchscreen-syscon" compatible string support in
   dt binding document and touchscreen driver implementation.

Changes since v2:
 - Omitted '0x' in "tsc node" definition in dt documentation file
 - Omitted '0x' in "ts_adc_syscon" definition in dt documentation file
 - Added "brcm,iproc-ts-adc-syscon" compatible string in "ts_adc_syscon"
   node. Updated dt documentation file to reflect this change.

Changes since v1:
 - Enhanced touchscreen driver to handle syscon based register access if
   "brcm,iproc-touchscreen-syscon" compatible string is provided in dt
 - Normal register access is handled through readl and writel API's if
   "brcm,iproc-touchscreen" compatible string is provided.
 - Updated touchscreen dt node document to reflect the new changes.
 - Updated change logs in each patchset to reflect the new changes

Raveendra Padasalagi (3):
  input: cygnus-update touchscreen dt node document
  input: syscon support in bcm_iproc_tsc driver
  ARM: dts: use syscon in cygnus touchscreen dt node

 .../input/touchscreen/brcm,iproc-touchscreen.txt   | 21 ++++--
 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 11 ++-
 drivers/input/touchscreen/bcm_iproc_tsc.c          | 79 ++++++++++++----------
 3 files changed, 69 insertions(+), 42 deletions(-)

-- 
1.9.1
