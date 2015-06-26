From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v1 0/7] input: cyapa: instruction of cyapa patches.patch
Date: Fri, 26 Jun 2015 01:37:26 +0000
Message-ID: <CY1PR06MB18179B077AE07045821D9EB3D1AD0@CY1PR06MB1817.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0133.outbound.protection.outlook.com ([207.46.100.133]:22194
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751195AbbFZDLW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2015 23:11:22 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "rydberg@euromail.se" <rydberg@euromail.se>
Cc: "bleung@google.com" <bleung@google.com>, "jmmahler@gmail.com" <jmmahler@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Dmitry, Jmmahler, All,

Is there any review points or comments on the v1 patches?

Thanks in advance,
Dudley



V1 patches mainly have following updates compared with V0 patches:
1) This patch series is generated base on code base linux-next 20150612,
   so fix the patch v0 6/7 failed to apply on linux-next 20150611 issue.
1) Fix spelling errors, space and black line format errors in patch v1 1/7.
2) Add detail description of the new interrupt and proximity interfaces in
   patch v1 5/7.


This patch series is mainly aimed to add new gen6 trackpad devices support,
and also new function to report proximity data/vent for Gen5 and Gen6 trackpad
devices.


Dudley Du (7):
  input: cyapa: change strings of gen5 to pip in the name when they are
    shared
  input: cyapa: add gen6 device module support in driver
  input: cyapa: add proximity function support for gen5 and gen6 modules
  input: cyapa: fully support runtime suspend power management
  input: cyapa: add proximity and interrupt sysfs interfaces support
  input: cyapa: add of match device support and description document
  input: cyapa: add CYAP0002 Gen6 device for ACPI configuration

 .../devicetree/bindings/input/cypress,cyapa.txt    |   44 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/input/mouse/Makefile                       |    2 +-
 drivers/input/mouse/cyapa.c                        |  266 ++++-
 drivers/input/mouse/cyapa.h                        |  161 ++-
 drivers/input/mouse/cyapa_gen3.c                   |   11 +-
 drivers/input/mouse/cyapa_gen5.c                   | 1254 +++++++++++---------
 drivers/input/mouse/cyapa_gen6.c                   |  760 ++++++++++++
 8 files changed, 1854 insertions(+), 645 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.txt
 create mode 100644 drivers/input/mouse/cyapa_gen6.c


History patch series modifications list:
V0 patches mainly have following updates:
1) Add Gen6 trackpad device support;
2) Add report proximity data function support for Gen5 and Gen6 devices;
3) Fully support runtime suspend/resume power management;
4) Add of_match_table mechanism support.

--
1.9.1


This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
