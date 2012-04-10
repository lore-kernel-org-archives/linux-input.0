From: Josenivaldo Benito Junior <jrbenito@benito.qsl.br>
Subject: [PATCH 0/3] RESEND Aureal special HID driver
Date: Tue, 10 Apr 2012 19:29:03 -0300
Message-ID: <1334096946-18788-1-git-send-email-jrbenito@benito.qsl.br>
References: <alpine.LNX.2.00.1204090207090.24006@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1204090207090.24006@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Franco Catrin <fcatrin@gmail.com>, Josenivaldo Benito Junior <jrbenito@benito.qsl.br>
List-Id: linux-input@vger.kernel.org

This patch is a RESEND of hid-aureal patch with Jiri=C2=B4s suggestions=
 applied.
It applies over linux-next-20120410 tag of linux-next tree.

Hid-aureal special HID driver is intend to correct a bogus HID descrito=
r=20
reported by Aureal IR based remote controllers.

Josenivaldo Benito Junior (3):
  Aureal Remote Control Device Driver
  HID: hid-core: Adding hid-aureal special driver
  HID: hid-aureal: Removing excessive dmesg information

 drivers/hid/Kconfig      |    6 +++++
 drivers/hid/Makefile     |    1 +
 drivers/hid/hid-aureal.c |   54 ++++++++++++++++++++++++++++++++++++++=
++++++++
 drivers/hid/hid-core.c   |    1 +
 drivers/hid/hid-ids.h    |    3 ++
 5 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-aureal.c

--=20
1.7.5.4
