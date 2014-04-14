From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 0/2] input/serio: Add a firmware_id sysfs attribute
Date: Mon, 14 Apr 2014 12:30:17 +0200
Message-ID: <1397471419-31224-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15448 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504AbaDNK4a (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 06:56:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

Hi All,

Here is v3 of my serio firmware_id sysfs attribute patch-set

Changes in v2:
-Add a helper function to avoid copy/pasting the code for building
 the firmware_id string from pnp_ids

Changes in v3:
-Prefix the firmware_id string for 8042-pnp devices which "PNP: " so that
 it will be easy to differentiate pnp-ids from ie devicetree ids in the future

Regards,

Hans
