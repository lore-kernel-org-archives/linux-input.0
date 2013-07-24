From: Yann Cantin <yann.cantin@laposte.net>
Subject: [RFC ebeam PATCH 0/2] new USB eBeam input driver
Date: Thu, 25 Jul 2013 01:52:18 +0200
Message-ID: <1374709940-607-1-git-send-email-yann.cantin@laposte.net>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, rob@landley.net, gregkh@linuxfoundation.org
List-Id: linux-input@vger.kernel.org

Hi,

New USB input driver for eBeam devices.

Currently supported (tested) :
- Luidia eBeam classic projection and edge projection models
- Nec "interactive solution" NP01Wi1 & NP01Wi2 accessories.

>From basic usb point of view, all these devices are
indistinguishable : they have the same usb ids and (blank) hid
report descriptors. There's other re-branded hardware that need to be
test, but i bet on same ids.

Patch 1 to blacklist the devices for hid generic-usb.

Patch 2 is the actual driver.

Notable stuff :
- use div64_s64 for portable 64/64-bits divisions.
- 13 sysfs custom files : 9 values for the transformation matrix,
  4 for xy ranges and a calibration trigger.

The module run fine since 3.3.6 kernel, both x86_32 and 64, actually
run in production on a 3.8.13 and compile without errors on
today's linus tree.

Side note :
- This driver was first submit and discuss last year.

Thanks for your help.

