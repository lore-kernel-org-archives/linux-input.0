From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 0/2] Add INPUT_PROP_TOPBUTTONPAD device property
Date: Mon, 14 Apr 2014 12:37:53 +0200
Message-ID: <1397471875-31400-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39048 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060AbaDNKh7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 06:37:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

Hi All,

Here is v2 of my INPUT_PROP_TOPBUTTONPAD patch-set.

Changes in v2:
-Drop adding of pnp_id to struct serio (drop patches 2/4 and 3/4 of v1)
-Modify the synaptics patch to use firmware_id instead of pnp_id

Regards,

Hans
