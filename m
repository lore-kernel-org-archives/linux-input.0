From: Roel Kluin <roel.kluin@gmail.com>
Subject: HID: is scancode correctly reported after key status change in hidinput_hid_event()?
Date: Sat, 09 Jan 2010 16:05:40 +0100
Message-ID: <4B489B44.50101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:9718 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab0AIPBj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Jan 2010 10:01:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

vi drivers/hid/hid-input.c +634 and not in hidinput_hid_event()

 	/* report the usage code as scancode if the key status has changed */
	if (usage->type == EV_KEY && !!test_bit(usage->code, input->key) != value)
 		input_event(input, EV_MSC, MSC_SCAN, usage->hid);

Only if value is 1 or 0 the input_event() can occur, but value doesn't
seem to be intended to be used as a boolean. are we really doing the
correct test here?

Roel
