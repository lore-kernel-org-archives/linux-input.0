From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 0/2] input: add MAX8997-haptic driver
Date: Wed, 07 Mar 2012 17:02:49 +0900
Message-ID: <4F571629.8010203@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:65123 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab2CGIC6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Mar 2012 03:02:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com

MAX8997 has several features in a single chip,
This patchset supports unimplemented haptic driver of MAX8997.

v2
- code clean and remove unnecessary code according to comment of Dmitry
Torokhov

Donggeun Kim (2):
  mfd: add platform data for MAX8997 haptic driver
  input: add driver support for MAX8997-haptic

 drivers/input/misc/Kconfig          |   12 ++
 drivers/input/misc/Makefile         |    1 +
 drivers/input/misc/max8997_haptic.c |  371
+++++++++++++++++++++++++++++++++++
 include/linux/mfd/max8997.h         |   53 +++++-
 4 files changed, 436 insertions(+), 1 deletions(-)
 create mode 100644 drivers/input/misc/max8997_haptic.c
