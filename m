From: Sebastian =?utf-8?Q?Dalfu=C3=9F?= <sd@sedf.de>
Subject: hid: egalax 0x0eef:0x0001 no longer detected by hid-multitouch
Date: Fri, 30 Aug 2013 19:59:46 +0200
Message-ID: <20130830175946.GA17584@sedf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sedf.de ([46.38.234.219]:57168 "EHLO sedf.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855Ab3H3S1u (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Aug 2013 14:27:50 -0400
Received: from dslb-188-097-122-098.pools.arcor-ip.net ([188.97.122.98] helo=ultra.localdomain)
	by sedf.de with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <sd@sedf.de>)
	id 1VFSz8-00046s-0y
	for linux-input@vger.kernel.org; Fri, 30 Aug 2013 19:59:50 +0200
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Dear Maintainers,

In 3.6.x the egalax touch panel (Vendor: 0eef, Dev: 0001) worked=20
perfectly well with hid-multitouch, right out of the box. In 3.9 and=20
3.10 it doesn't; the panel doesn't show up in /proc/bus/input/devices .
If the module usbtouchscreen is present, 3.9/3.10 wrongly try to use=20
that one (flipped y-axis, wrong scale, get's stuck) instead of=20
hid-multitouch(worked previously perfectly well, no need for=20
calibration, quirks, configuration). If usbtouchscreen isn't present,=20
the panel isn't detected, even if hid-multitouch gets poked with approp=
riate
parameters in /sys/module/hid_multitouch/drivers/hid\:hid-multitouch/ne=
w_id .
In an desperate attempt, I manually added the device/vendor id to
hid-multitouch.c, which didn't yield any improvement. It seems that the=
 hid
subsystem doesn't even recognize that this device is indeed a hid=20
touchpanel.

Is there a way to force hid to take care of that vendor/device-id, as a
temporary workaround?

This issue is also filed in Bugzilla:=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D60816

lsusb-snippet:
https://bugzilla.kernel.org/attachment.cgi?id=3D107362

Greetings,
Sebastian Dalfu=C3=9F
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
