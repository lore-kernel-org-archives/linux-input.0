From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v2 0/8] Input: synaptics-rmi4: Reimplement functionality from hid-rmi
Date: Fri, 24 Jun 2016 17:17:31 -0700
Message-ID: <1466813851-15691-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:60543 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbcFYARr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2016 20:17:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>

The majority of this patch is reimplementing some of the functionality
which was initially implemented in hid-rmi and reimplements it in the
core. When hid-rmi is converted into a transport for rmi_core the
functionality of existing touchpads should not change.

Several of these patches address the feedback in the message:
https://lkml.org/lkml/2016/4/12/434

I decided to go ahead and do a respin of this patch series. It includes
changes to the device tree parameters and additional feedback from the
first series. I also split out using the RMI_F11_REL_BYTES define from
patch 7 into its own patch.

Andrew Duggan (8):
  Input: synaptics-rmi4: Increment the refcount of the transport dev's
    of_node
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

 .../bindings/input/rmi4/rmi_2d_sensor.txt          |  4 +
 drivers/input/rmi4/rmi_2d_sensor.c                 | 11 +++
 drivers/input/rmi4/rmi_2d_sensor.h                 |  2 +
 drivers/input/rmi4/rmi_bus.c                       |  5 +-
 drivers/input/rmi4/rmi_f01.c                       |  6 +-
 drivers/input/rmi4/rmi_f11.c                       | 95 +++++++++++++++------
 drivers/input/rmi4/rmi_f12.c                       | 98 ++++++++++++++++++++--
 drivers/input/rmi4/rmi_f30.c                       |  4 +
 include/linux/rmi.h                                | 21 +++--
 9 files changed, 201 insertions(+), 45 deletions(-)

-- 
2.5.0

