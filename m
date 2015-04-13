From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Hidden dependency of i2c-hid on GPIOLIB
Date: Tue, 14 Apr 2015 00:55:20 +0200
Message-ID: <2014782.heKI7XOhuD@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33119 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbDMWzX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2015 18:55:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

my touchpad stopped working because of a485923efbb8 ("HID: i2c-hid:
Add support for ACPI GPIO interrupts"). It turned out that I need
CONFIG_GPIOLIB. I think this dependency should be made explicit or the
driver should not depend on it.

Regards,
Gabriele
