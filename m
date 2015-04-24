From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/7] alps: Improve coordinates reported when 2fg are down on semi-mt models
Date: Fri, 24 Apr 2015 16:48:49 +0200
Message-ID: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54037 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754959AbbDXOtA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Apr 2015 10:49:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

Hi Dmitry,

This patch-set improves the coordinates reported when 2 fingers are down
on semi-mt alps models, leading to a much smoother 2fg scrolling experience.

This is somewhat the result of a libinput discussion here:
https://bugs.freedesktop.org/show_bug.cgi?id=89683

This has been tested on a laptop with a Rushmore touchpad, I'll ask the
reporter of the above bug to test this on his laptop with a Dolphin touchpad,
note that switching the Dolphin over to the standard process_bitmap should be
fine, as I've tried the other way around and that works too. In hindsight
there should have never been 2 different process_bitmap functions to begin
with.

Regards,

Hans
