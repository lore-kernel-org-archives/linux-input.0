From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 0/4] of_touchscreen-helpers: Add support for inverted / swapp
Date: Fri, 15 Jul 2016 15:48:07 +0200
Message-ID: <1468590491-10269-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42125 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758AbcGONsP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jul 2016 09:48:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

Here is a v4 of my of_touchscreen-helpers patch with the changes
discussed before, as well as adding the extra NULL parameter to
the touchscreen_parse_properties call in the new(ish) ad7879.c and
cyttsp_core.c drivers.

Patches 2-4 have been tested on various ARM tablets with the actual
touchscreens affected by the changes.

Regards,

Hans
