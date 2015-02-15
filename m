From: Roman Volkov <v1ron@v1ros.org>
Subject: [PATCH v3 0/5] Device Tree support for i8042 driver
Date: Mon, 16 Feb 2015 00:11:42 +0300
Message-ID: <1424034707-15723-1-git-send-email-v1ron@v1ros.org>
References: <1423857173-16432-6-git-send-email-v1ron@v1ros.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423857173-16432-6-git-send-email-v1ron@v1ros.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roman Volkov <v1ron@v1ros.org>
List-Id: linux-input@vger.kernel.org

Yes, some embedded devices still use the i8042 controller. This patch set
enables the i8042 driver to get necessary information from Device Tree
instead of using specific headers with hardcoded addresses for each
specific machine. For example, vt8500 architecture has i8042.

 v2:
 -Changes in the documentation.
 -Errors fixed in the initialization function.
 -Redundant parameters removed from Device Tree bindings (init-reset, etc.).

 v3:
 -Reduced amount of 'ifdefs' in the i8042.c file. Initialization order
    is now the same for all architectures.

 Warning: the change in v3 is more controversial and needs more testing
 since affects all architectures which use the driver. Please give
 information regarding required steps to get this patch accepted. Would
 be great to find testers to get additional tested-by records.

Roman Volkov (5):
  i8042: intel-8042 DT documentation
  i8042: Kernel configuration handling for DT support
  i8042: Add OF match table
  i8042: Prepare i8042 driver for DT support
  i8042: Add i8042_dt.h glue for DT support

 .../devicetree/bindings/input/intel-8042.txt       |  26 ++++++
 drivers/input/serio/i8042-dt.h                     | 104 +++++++++++++++++++++
 drivers/input/serio/i8042.c                        |  56 ++++++-----
 drivers/input/serio/i8042.h                        |   3 +
 4 files changed, 168 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/intel-8042.txt
 create mode 100644 drivers/input/serio/i8042-dt.h

-- 
2.3.0
