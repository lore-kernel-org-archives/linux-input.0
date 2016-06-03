From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 0/7] Input: synaptics-rmi4: Reimplement functionality from hid-rmi
Date: Fri, 3 Jun 2016 11:38:47 -0700
Message-ID: <1464979127-2327-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

The majority of this patch is reimplementing some of the functionality
which was initially implemented in hid-rmi and reimplements it in the
core. When hid-rmi is converted into a transport for rmi_core the
functionality of existing touchpads should not change.

Several of these patches address the feedback in the message:
https://lkml.org/lkml/2016/4/12/434

Andrew Duggan (7):
  Input: synaptics-rmi4: Increment the refcount of the transport dev's
    of_node
  Input: synaptics-rmi4: Add parameters for dribble packets and palm
    detect gesture
  Input: synaptics-rmi4: Add dribble and palm gesture parameters to
    devicetree
  Input: synaptics-rmi4: Add support for controlling dribble packets in
    F12
  Input: synaptics-rmi4: Remove pointer to rmi_function in f12_data
  Input: synaptics-rmi4: Remove unneeded variable
  Input: synaptics-rmi4: Handle incomplete input data

 .../bindings/input/rmi4/rmi_2d_sensor.txt          |  5 ++
 drivers/input/rmi4/rmi_2d_sensor.c                 | 14 ++++
 drivers/input/rmi4/rmi_2d_sensor.h                 |  2 +
 drivers/input/rmi4/rmi_bus.c                       |  5 +-
 drivers/input/rmi4/rmi_f01.c                       |  6 +-
 drivers/input/rmi4/rmi_f11.c                       | 95 +++++++++++++++------
 drivers/input/rmi4/rmi_f12.c                       | 98 ++++++++++++++++++++--
 drivers/input/rmi4/rmi_f30.c                       |  4 +
 include/linux/rmi.h                                | 21 +++--
 9 files changed, 205 insertions(+), 45 deletions(-)

-- 
2.5.0
