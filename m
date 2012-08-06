From: Yann Cantin <yann.cantin@laposte.net>
Subject: [RFC ebeam PATCH v3 0/2]
Date: Mon,  6 Aug 2012 23:21:42 +0200
Message-ID: <1344288104-20731-1-git-send-email-yann.cantin@laposte.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

New USB input driver for eBeam devices.

Currently, only the Luidia eBeam classic projection model is supported.
Edge model and a NEC interactive video-projector support planned for the
end of the mounth. 

Patch 1 to blacklist the device for hid generic-usb.

Patch 2 is the actual driver.

Changes from previous :
- switch to div64_s64 for portable 64/64-bits divisions
- some cosmetics in device name
- unused include and def removed
- variables name changes for readability

Pending issues :
- sysfs custom files : need to pass 13 parameters for calibration :
  choice is between lots of simply-handled, or few with a big sscanf.
- is div64_s64 safe and available on all plateform ? this is the only
  use of this function i've found in all the kernel tree.

The module run fine with a 3.3.6 and a 3.5.0 kernel, both x86_32 and 64.

Thanks for your help.
