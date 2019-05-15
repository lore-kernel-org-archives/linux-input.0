From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 0/5] Add of_device_link_add() functions
Date: Wed, 15 May 2019 15:11:49 +0200
Message-ID: <20190515131154.18373-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, hadess@hadess.net, frowand.list@gmail.com, m.felsch@pengutronix.de, agx@sigxcpu.org, arnd@arndb.de
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-input@vger.kernel.org

It may happen that we need to ensure the order of suspend/resume
calls between two devices without obvious link.
It is for example the case on some boards where both panel and touchscreen
are sharing the same reset line. In this case we need to control which
device is going in resume first to do only one reset.
An other example is make sure that GPU is suspend before composition
hardware block to avoid pending drawing requests.

To not let everybody creating relationship between devices for free
of_device_links_add() has to be called by each driver and not in the core.

version 2:
- only keep of_device_links_add() and use 
  DL_FLAG_PM_RUNTIME and DL_FLAG_AUTOREMOVE_CONSUMER flags to follow Rafael
  advices
- reword function description
- try to use a more explicit property name
- rebase on v5.1

Benjamin Gaignard (5):
  of/device: Add of_device_link_add function
  Input: edt-ft5x06: Document suspend-dependencies property
  input: edt-ft5x06 - Call of_device_links_add() to create links
  Input: goodix: Document suspend-dependencies property
  input: goodix - Call of_device_links_add() to create links

 .../bindings/input/touchscreen/edt-ft5x06.txt      |  2 ++
 .../bindings/input/touchscreen/goodix.txt          |  2 ++
 drivers/input/touchscreen/edt-ft5x06.c             |  2 ++
 drivers/input/touchscreen/goodix.c                 |  3 ++
 drivers/of/device.c                                | 37 ++++++++++++++++++++++
 include/linux/of_device.h                          |  7 ++++
 6 files changed, 53 insertions(+)

-- 
2.15.0
