From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 0/2] uapi/input.h: Add INPUT_PROP_TOPBUTTONPAD device property
Date: Tue, 15 Apr 2014 09:24:21 +0200
Message-ID: <1397546663-4447-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1336 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbaDOHY2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2014 03:24:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

Hi All,

I've received an updated list of pnpids from synaptics so here is an updated
version of the patch-set.

Changes in v2:
-Drop adding of pnp_id to struct serio (drop patches 2/4 and 3/4 of v1)
-Modify the synaptics patch to use firmware_id instead of pnp_id

Changes in v3:
-Update topbuttonpad pnpid list in synaptics.c

Regards,

Hans
