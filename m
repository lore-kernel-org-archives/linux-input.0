From: Hans de Goede <hdegoede@redhat.com>
Subject: New FocalTech FT6236 touchscreen driver is a duplicate with the
 existing edt-ft5x06.c driver
Date: Sat, 19 Dec 2015 21:04:34 +0100
Message-ID: <5675B852.5060308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44767 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445AbbLSUEh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Dec 2015 15:04:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Sean Cross <xobs@kosagi.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.or>
Cc: Bertrik Sikken <bertrik@sikken.nl>

Hi All,

While looking into getting a focaltech touchscreen on a tablet working I noticed
that we've 2 overlapping drivers, the ft6236.c and the edt-ft5x06.c driver both
support the exact same i2c touchscreen protocol. In the latter the code for the
"M09" variant offers identical functionality to the ft6236.c code.

Since the edt-ft5x06.c code seems more complete wrt advanced features and has
been around much longer, I would like to suggest to add the ft6236.c compatible
and i2c-ids to the edt-ft5x06.c driver and to drop the duplicate ft6236.c driver.

I've tested both drivers on a Chuwi_V7_CW0825 tablet with a ft5302fe4 touchscreen
controller (not 100% sure on the model I may be mixing up touchscreen models here,
but it definitely is a focaltech controller), and both drivers work identically.

Regards,

Hans
