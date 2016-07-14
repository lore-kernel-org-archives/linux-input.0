From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v3 0/8] Input: synaptics-rmi4: Reimplement functionality from hid-rmi
Date: Wed, 13 Jul 2016 23:07:55 -0700
Message-ID: <1468476475-7884-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:14098 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbcGNGIE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jul 2016 02:08:04 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick@shmanahar.org>, Chris Healy <cphealy@gmail.com>

The v3 version of this patch series makes changes to patch 1 and patch 3.
Patch 1 now uses of_get_child_by_name() instead of of_find_node_by_name()
to avoid having to increment the refcount of the of_node which avoid
that hack. Patch 3 adds "force" to the device tree parameters to help to
clarify that these parameters overwrite the default value set in the
firmware configuration.

Thanks,
Andrew

Andrew Duggan (8):
  Input: synaptics-rmi4: Use of_get_child_by_name() instead of
    of_find_node_by_name()
  Input: synaptics-rmi4: Add parameters for dribble packets and palm
    detect gesture
  Input: synaptics-rmi4: Add dribble and palm gesture parameters to
    device tree
  Input: synaptics-rmi4: Add support for controlling dribble packets in
    F12
  Input: synaptics-rmi4: Remove pointer to rmi_function in f12_data
  Input: synaptics-rmi4: Remove unneeded variable
  Input: synaptics-rmi4: Handle incomplete input data
  Input: synaptics-rmi4: Use the RMI_F11_REL_BYTES define in
    rmi_f11_rel_pos_report

 .../bindings/input/rmi4/rmi_2d_sensor.txt          | 10 +++
 drivers/input/rmi4/rmi_2d_sensor.c                 | 13 +++
 drivers/input/rmi4/rmi_2d_sensor.h                 |  2 +
 drivers/input/rmi4/rmi_bus.c                       |  4 +-
 drivers/input/rmi4/rmi_f01.c                       |  6 +-
 drivers/input/rmi4/rmi_f11.c                       | 95 +++++++++++++++------
 drivers/input/rmi4/rmi_f12.c                       | 98 ++++++++++++++++++++--
 drivers/input/rmi4/rmi_f30.c                       |  4 +
 include/linux/rmi.h                                | 21 +++--
 9 files changed, 208 insertions(+), 45 deletions(-)

-- 
2.5.0

