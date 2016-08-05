From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] input: touchscreen: Remove duplicate ft6236 driver
Date: Fri,  5 Aug 2016 09:24:30 +0200
Message-ID: <1470381871-4086-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34394 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbcHEHYg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Aug 2016 03:24:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>

<resend with Noralf's email address fixed>

Hi All,

December 19th 2015 I noticed that a new ft6236 driver had been added to
the kernel, and that it was in essence just a re-implementation of the
M09 protocol from the edt-ft5x06 driver, IOW it contains 100% duplicate
code. I asked the submitter and authors of the new ft6236 driver to test
there devices with the edt-ft5x06 driver instead, but I got no reply.

January 26th 2016 I asked the submitter and authors of the new ft6236
driver to test with the edt-ft5x06 driver again, but again got no reply.

Note: this is likely due to my having made an error in Noralf's email
address with those 2 mails (sorry), so it would be good to give Noralf
some time to reply now before applying this.

Given the lack of response from the submitter / authors of the ft6236
driver I believe it is best to just remove it. I've double checked and
the edt-ft5x06 driver is 100% compatible both wrt wire protocol usage,
as wrt to the reset gpio usage (and the gpio name in dt).

Regards,

Hans
