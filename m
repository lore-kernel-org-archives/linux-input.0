From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/5] Add of_ functions for device_link_add()
Date: Wed, 24 Apr 2019 12:19:08 +0200
Message-ID: <20190424101913.1534-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, hadess@hadess.net, frowand.list@gmail.com, m.felsch@pengutronix.de, agx@sigxcpu.org, yannick.fertre@st.com, arnd@arndb.de
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-input@vger.kernel.org

It could happen that we need to control suspend/resume ordering between
devices without obvious consumer/supplier link. For example when touchscreens
and DSI panels share the same reset line, in this case we need to be sure 
of pm_runtime operations ordering between those two devices to correctly
perform reset.
DSI panel and touchscreen aren't sharing any heriachical relationship (unlike
I2C client and I2C bus or regulator client and regulator provider) so we need
to describe this in device-tree.

This series introduce of_device_links_{add,remove} and devm_of_device_links_add()
helpers to find and parse 'links-add' property in a device-tree node.
It allows to create and remove links between consumer and suppliers from 
device-tree data so consumers will be suspend before their suppliers and resume 
after them.

Benjamin Gaignard (3):
  of/device: Add of_ functions for device_link_{add,remove}
  Input: edt-ft5x06: Document links-add property
  Input: goodix: Document links-add property

Yannick FertrÃ© (2):
  input: edt-ft5x06 - Call devm_of_device_links_add() to create links
  input: goodix - Call devm_of_device_links_add() to create links

 .../bindings/input/touchscreen/edt-ft5x06.txt      |   2 +
 .../bindings/input/touchscreen/goodix.txt          |   2 +
 drivers/input/touchscreen/edt-ft5x06.c             |   2 +
 drivers/input/touchscreen/goodix.c                 |   3 +
 drivers/of/device.c                                | 103 +++++++++++++++++++++
 include/linux/of_device.h                          |  20 ++++
 6 files changed, 132 insertions(+)

-- 
2.15.0
