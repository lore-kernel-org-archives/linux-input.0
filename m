From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH 0/3] Syscon support for iProc touchscreen driver
Date: Tue,  9 Feb 2016 14:27:54 +0530
Message-ID: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
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
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, Jonathan Richardson <jonathar@broadcom.com>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Kumar Gala <galak@codeaurora.org>
List-Id: linux-input@vger.kernel.org

This patchset is based on v4.5-rc3 tag and its tested on
Broadcom Cygnus SoC.

The patches can be fetched from iproc-tsc-v1 branch of
https://github.com/Broadcom/arm64-linux.git

Raveendra Padasalagi (3):
  input: cygnus-update touchscreen dt node document
  input: syscon support in bcm_iproc_tsc driver
  ARM: dts: use syscon in cygnus touchscreen dt node

 .../input/touchscreen/brcm,iproc-touchscreen.txt   |  18 ++-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   9 +-
 drivers/input/touchscreen/bcm_iproc_tsc.c          | 122 +++++++++++++++------
 3 files changed, 112 insertions(+), 37 deletions(-)

-- 
1.9.1
