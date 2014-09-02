From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/2] input: Add INPUT_PROP_POINTING_STICK property
Date: Tue,  2 Sep 2014 14:43:22 +0200
Message-ID: <1409661804-10489-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31078 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbaIBMn2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Sep 2014 08:43:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

Hi,

It is useful for userspace to know that they're not dealing with a regular
mouse but rather with a pointing stick (e.g. a trackpoint) so that userspace
can e.g. automatically enable middle button scrollwheel emulation.

It is impossible to tell the difference from the evdev info without resorting
to putting a list of device / driver names in userspace, this is undesirable.

These patches add a property which allows userspace to see if a device is a
pointing stick, and set it on all the pointing stick drivers.

Note these patch apply on top of the current dtor/input.git for-linus
branch. Specifically they depend upon a2418fc4a13 (Input: elantech - add
support for trackpoint found on some v3 models).

Regards,

Hans


