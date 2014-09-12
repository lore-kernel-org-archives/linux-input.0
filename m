From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 0/3] psmouse: Add support for detecting FocalTech PS/2
Date: Fri, 12 Sep 2014 11:08:29 +0200
Message-ID: <1410512912-11609-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58559 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbaILJIg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Sep 2014 05:08:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

Hi Dmitry,

Here is v2 of my patch-set to "deal" with focaltech touchpads. As requested
in this version I'm doing the reset from a focaltech_init function, and the
goto has been dropped.

Regards,

Hans
