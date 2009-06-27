From: =?utf-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
Subject: [PATCH 0/2] Winbond IR driver
Date: Sat, 27 Jun 2009 07:18:30 +0200
Message-ID: <1246079912-17619-1-git-send-email-david@hardeman.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, =?utf-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
List-Id: linux-input@vger.kernel.org

The following two patches reintroduce the acpi .shutdown method
which was removed prior to the release of 2.6.30 and then adds
a driver for the IR functionality of the Winbond WPCD376I=20
SuperI/O chip found on some Intel motherboards.

acpi shutdown was removed in commit
c0ce093f5b8bc3262c51bd0b5900424a67909831

David H=C3=A4rdeman (2):
  ACPI: reintroduce acpi_device_ops .shutdown method
  Add a driver for the Winbond WPCD376I IR functionality.

 MAINTAINERS                      |    6 +
 drivers/acpi/scan.c              |   12 +
 drivers/input/misc/Kconfig       |   15 +
 drivers/input/misc/Makefile      |    1 +
 drivers/input/misc/winbond-cir.c | 1693 ++++++++++++++++++++++++++++++=
++++++++
 include/acpi/acpi_bus.h          |    2 +
 6 files changed, 1729 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/winbond-cir.c

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
