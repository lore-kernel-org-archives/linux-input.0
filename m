From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 0/4] of_touchscreen-helpers: Add support for inverted / swapped axis
Date: Fri, 15 Jul 2016 14:16:11 +0200
Message-ID: <1468584975-15970-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35806 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932791AbcGOMQT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jul 2016 08:16:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

Here is a v3 of my of_touchscreen-helpers patch with the changes
discussed before.

Patches 2-4 have been tested on various ARM tablets with the actual
touchscreens affected by the changes.

Regards,

Hans
