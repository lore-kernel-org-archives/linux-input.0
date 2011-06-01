From: simon@mungewell.org
Subject: Byte swapping u16 data in HID report
Date: Wed, 1 Jun 2011 01:32:15 -0400
Message-ID: <80b32cfd7dc9e8afee2c4d9e21d1a7e3.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:34345 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab1FAFcQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jun 2011 01:32:16 -0400
Received: from localhost ([127.0.0.1] helo=host171.canaca.com)
	by host171.canaca.com with esmtpa (Exim 4.69)
	(envelope-from <simon@mungewell.org>)
	id 1QRe2R-0003Is-BZ
	for linux-input@vger.kernel.org; Wed, 01 Jun 2011 01:32:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
I'm looking into fixing the Sixaxis controller (hid-sony.c) so that the
accelerometers and gyro data are reported via a joystick axis.

I have patched the HID descriptor so that the values are seen, however
they are reported high byte first (0x2FF -> 0x02, 0xFF) which appears to
be contrary to the HID spec.
--
5.8 Format of Multibyte Numeric Values
Multibyte numeric values in reports are represented in little-endian
format, with the least significant byte at the lowest address.
--

I'm working on the assumption that the data can be 'fixed' before it is
parsed. Would intercepting 'hid_get_report()' be a good place and how can
I locate the actual data bytes to do a 'bswap16()'.

I'm thinking something like:
--
	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
		hdev->hid_get_report = sixaxis_hid_get_report;
	}
--

Any suggestions/comments?
Simon.



