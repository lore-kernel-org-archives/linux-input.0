From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v3 0/4] add support for high res wheel found on some Logitech devices
Date: Fri,  7 Apr 2017 08:31:23 -0300
Message-ID: <cover.1491564565.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:48276
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933413AbdDGLbv (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Apr 2017 07:31:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>


Some Logitech mouses (MX Anyware 2, MX Master) have a wheel with two
resolutions. It initializes in low resolution mode, but can be changed to high
resolution. It also supports free wheel mode, where there's no tactile
feedback at the wheel, nor it offers resistence to movements. Such mode is
enabled/disabled by clicking at the wheel (on this wheel, the middle button
is a separate button).

Add support for it.

v3: addressed Peter's comments for EV_SW SW_RATCHET documentation

Mauro Carvalho Chehab (4):
  input: add an EV_REL event for high-res vertical wheel
  input: add a EV_SW event for ratchet switch
  hid-logitech-hidpp: add support for high res wheel
  hid-logitech-hidpp: add support for ratchet switch

 Documentation/input/event-codes.rst    |  28 ++++-
 drivers/hid/hid-logitech-hidpp.c       | 218 +++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h        |   2 +-
 include/uapi/linux/input-event-codes.h |   5 +-
 4 files changed, 248 insertions(+), 5 deletions(-)

-- 
2.9.3


