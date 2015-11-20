From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 0/7] Various touchscreens: Support axis inversion / swapping / extra gpios
Date: Fri, 20 Nov 2015 14:24:45 +0100
Message-ID: <1448025892-20899-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46268 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162006AbbKTNZB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2015 08:25:01 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Sander Vermin <sander@vermin.nl>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

Hi Dimtry and Maxime,

Brown paper-bag release of this series fixing 2 issues which I missed
during initial testing. First the original coverletter again:

This patch-set extends the of_touchscreen.c helpers to (optionally) also
deal with axis inversion / swapping, and patches a bunch of drivers to use
this new functionality.

One of the modified drivers is the pixcir_i2c_ts driver. Sander Vermin
has been helping me with getting this driver to work on a tablet I own.
This patch-set includes a v2 of Sander's "Input: pixcir_i2c_ts: add wake
and enable gpios" patch. v1 also included axis inversion / swapping support,
which I've redone using the new helpers in a separate patch in this set.

Dmitry can you pickup patches 1-5 please ?
Maxime can you pickup patches 6-7 please ? Merging them seperately
should not be an issue without patches 1-5 the touchscreen will not work
but there will be no other breakage, so no regressions.

Changes in v2:
-[touchscreen: icn8318: Use parse_properties and apply_prop_to_x_y helpers]
 Call input_set_capability() before calling touchscreen_parse_properties()
-[touchscreen: pixcir_ts: Add support for axis inversion / swapping]
 Add a fix which actually makes this patch compile, which accidentally ended
 up in a later commit in my tree


Thanks & Regards,

Hans
