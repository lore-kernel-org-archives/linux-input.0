From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 0/1] synaptics: Add min/max quirk for ThinkPad T431s, L440, L540, Yoga and X1
Date: Thu, 17 Apr 2014 13:41:42 +0200
Message-ID: <1397734903-26088-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37360 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbaDQLlr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Apr 2014 07:41:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

Hi All,

And the quirks keep coming in <sigh> so here is a v3. Changelog:

v2:
-Add Cc: stable@vger.kernel.org

v3:
-Add a quirk for the L540
-Standardized S1 Yoga and X1 values, Yoga uses the same touchpad as the
 X240, X1 uses the same touchpad as the T440

Regards,

Hans
