From: "Dudley Du" <dudlx@outlook.com>
Subject: [PATCH v3 0/14] input: cyapa: re-architecture driver to support multi-trackpads in one driver
Date: Fri, 4 Jul 2014 18:26:12 +0800
Message-ID: <001401cf9772$618c6310$24a52930$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpfreer209.163vip.net ([61.135.158.116]:58678 "HELO
	smtp.tom.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755368AbaGDKgn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Jul 2014 06:36:43 -0400
Received: from smtp.tom.com (unknown [172.24.173.69])
	by bjzjm-tm-app3.localdomain (SMTP) with ESMTP id C565A1C2C37
	for <linux-input@vger.kernel.org>; Fri,  4 Jul 2014 18:26:13 +0800 (CST)
Content-Language: zh-cn
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Alan Stern' <stern@rowland.harvard.edu>, 'Benson Leung' <bleung@google.com>, 'Patrik Fimml' <patrikf@google.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 'Dudley Du' <dudl@cypress.com>

This patch set is made based on kernel 3.16-rc2.
It's aimed to re-architecture the cyapa driver to support
old gen3 trackpad device and new gen5 trackpad device in one
cyapa driver for easily productions support based on
customers' requirements, and add sysfs functions and interfaces
supported that required by users and customers.
Because the earlier gen3 and the latest gen5 trackpad devies using
two different chipsets, and have different protocol and interfaces.
If supported these two trackpad devices in two different drivers, then
it will be difficult to manage productions and later firmware updates.
it will cause customer don't know which one to use and update
because these two trackpad devices have been used and integrated
in same one productions at a time, so must to support these two trackpad
devices in same on driver.

Compared with previous v2 patches, v3 patches fix some spell and
alignment issues, and rename some functions for better understanding
based on review comments.

The new architecture is made of:
cyapa.c - the core of the architecture, supply interfaces and
functions to system and read trackpad devices.
cyapa_gen3.c - functions support for gen3 trackpad devices,
cyapa_gen5.c - functions support for gen5 trackpad devices.

Beside this introduction patch, it has 14 patches listed as below.
For these patches each one is patched based on previous one.

patch 1/14: re-architecture cyapa driver with core functions,
and applying the device detecting function in async thread to speed
up system boot time.

patch 2/14: add cyapa driver power management interfaces support.

patch 3/14: add cyapa driver runtime power management interfaces support.

patch 4/14: add cyapa key function interfaces in sysfs system.
Including read firmware version, get production ID, read baseline,
re-calibrate trackpad baselines and do trackpad firmware update.

patch 5/14: add read firmware image and read raw trackpad device'
sensors' raw data interface in debugfs system.

patch 6/14: add gen3 trackpad device basic functions support.

patch 7/14: add gen3 trackpad device firmware update function support.

patch 8/14: add gen3 trackpad device report baseline and do force
re-calibrate functions support.

patch 9/14: add gen3 trackpad device read firmware image function support.

patch 10/14: add gen5 trackpad device basic functions support.

patch 11/14: add gen5 trackpad device firmware update function support.

patch 12/14: add gen5 trackpad device report baseline and do force
re-calibrate functions support.

patch 13/14: add gen5 trackpad device read firmware image and report
sensors' raw data values functions support.

patch 14/14: add function to monitor LID close event to off trackpad device.

