From: "Vishwanathrao Badarkhe, Manish" <manishv.b@ti.com>
Subject: [PATCH 0/2] Add dT support for tps6507x touchscreen.
Date: Sat, 23 Mar 2013 18:29:29 +0530
Message-ID: <1364043571-9210-1-git-send-email-manishv.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-doc@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rob@landley.net, rob.herring@calxeda.com, grant.likely@secretlab.ca, manishv.b@ti.com
List-Id: linux-input@vger.kernel.org

Patch set adds DT support for tps6507x based touchscreen
Also, add DT data for tps6507x touchscreen in da850-evm by 
providing touchscreen node inside tps6507x mfd device.

This patch series applies on top of v3.9-rc2 of linus tree and
depends on [1].  

[1]davinci: Add device tree data for tps6507x
   http://www.spinics.net/lists/linux-doc/msg09473.html
 
Tested on da850-evm board.

Vishwanathrao Badarkhe, Manish (2):
  tps6507x-ts: Add DT support
  ARM: davinci: da850: add tps6507x touchscreen DT data

 Documentation/devicetree/bindings/mfd/tps6507x.txt |   22 ++++
 arch/arm/boot/dts/da850-evm.dts                    |    9 ++
 drivers/input/touchscreen/tps6507x-ts.c            |  104 ++++++++++++++------
 3 files changed, 105 insertions(+), 30 deletions(-)

-- 
1.7.4.1

