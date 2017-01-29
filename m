From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v13 5/5] mfd: Move binding document
Date: Sun, 29 Jan 2017 19:04:05 +0100
Message-ID: <f3a78c281c9568de8a09da8fec9e57557cb650eb.1485711797.git.ksenija.stanojevic@gmail.com>
References: <cover.1485711797.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1485711797.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1485711797.git.ksenija.stanojevic@gmail.com>
References: <cover.1485711797.git.ksenija.stanojevic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
List-Id: linux-input@vger.kernel.org

The bindings, which are now used in MFD, need also to be
documented in the MFD binding document.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v13:
 - none

Changes in v12:
 - none

Changes in v11:
 - none

Changes in v10:
 - none

Changes in v9:
 - format patch using -M option

Changes in v8:
 - rebase onto 4.9-rc1

Changes in v7:
 - add to the patchset

 Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)

diff --git a/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/mfd/mxs-lradc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
rename to Documentation/devicetree/bindings/mfd/mxs-lradc.txt
-- 
1.9.1
