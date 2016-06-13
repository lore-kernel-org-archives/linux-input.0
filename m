From: Daniel Jansen <djaniboe@gmail.com>
Subject: [PATCH v4 0/1] input: touchscreen: Add generic driver for Silead touchscreens
Date: Mon, 13 Jun 2016 12:46:49 +0200
Message-ID: <1465814810-7151-1-git-send-email-djaniboe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36013 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964910AbcFMKq5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2016 06:46:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Robert Dolca <robert.dolca@gmail.com>, Gregor Riepl <onitake@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Daniel Jansen <djaniboe@gmail.com>, Wessel Blokzijl <wesselb94@gmail.com>

Hi all,

We=E2=80=99re hereby submitting a driver for gsl1680 based touchscreens=
 for merging
into the upstream kernel.

The gsl1680 family of touchscreen controllers is very popular in cheap
tablets, as such there have been multiple attempts to write a driver
for it. This submission is based on Robert Dolca's work on this:
https://lkml.org/lkml/2015/8/25/738

This driver has been picked up and improved by Sigurd B=C3=B8e:
https://github.com/sigboe/gslX68X

And since seen minor improvements from: Gregor Riepl, Hans de Goede
and ourselves.

The driver as submitted today has been tested on a wide variety of ARM
based tablet using devicetree for instantiation. It has been tested
with the gsl1680, gsl3670 and gsl3675 variants of the gsl1680 controlle=
r.

Please review en merge,
Robert Wessel Blokzijl and Daniel Jansen
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
