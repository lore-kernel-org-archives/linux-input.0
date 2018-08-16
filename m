From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 0/2] Rumble support for Xbox One S controller
Date: Wed, 15 Aug 2018 19:44:08 -0700
Message-ID: <20180816024410.29218-1-andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Juha Kuikka <juha.kuikka@gmail.com>
List-Id: linux-input@vger.kernel.org

Everyone:

This is v2 of the patches adding support for rumble for Xbox One S
controller connected over Bluetooth. Hopefully all of the changes are
pretty straightforward and self-explanatory.

Feedback is wellcome!

Changes since [v1]:

    - code converting the driver to use struct ms_data is split into a
      separate patch

    - CONFIG_MICROSOFT_FF removed

    - explicit PID comparison replaced with MS_QUIRK_FF

    - ms_init_ff() converted to be a no-op for devices that don't have FF

    - all FF cleanup actions moved into ms_remove_ff()

    - struct xb1s_ff_report declared to be packed, magic 4 replaced
      with MAGNITUDE_NUM, output_report_dmabuf converted to be void *
      to avoid the need to typecast it.

Thanks,
Andrey Smirnov

[v1] lkml.kernel.org/r/20180810001714.14659-1-andrew.smirnov@gmail.com

Andrey Smirnov (2):
  hid: microsoft: Convert private data to be a proper struct
  hid: microsoft: Add rumble support for Xbox One S controller

 drivers/hid/hid-ids.h       |   1 +
 drivers/hid/hid-microsoft.c | 142 ++++++++++++++++++++++++++++++++++--
 2 files changed, 138 insertions(+), 5 deletions(-)

-- 
2.17.1
