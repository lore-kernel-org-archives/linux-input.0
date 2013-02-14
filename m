From: simon@mungewell.org
Subject: Consistant naming for LED class USB devices?
Date: Thu, 14 Feb 2013 17:52:49 -0500
Message-ID: <9ccaf54a3643a617acf32f90e2cc3c4b.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:52875 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759548Ab3BNWwu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Feb 2013 17:52:50 -0500
Received: from localhost ([127.0.0.1] helo=mungewell.org)
	by host171.canaca.com with esmtpa (Exim 4.69)
	(envelope-from <simon@mungewell.org>)
	id 1U67fd-0003go-Bq
	for linux-input@vger.kernel.org; Thu, 14 Feb 2013 17:52:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
I'm after naming suggestions for USB devices which use the LED class.

On one gaming wheel (Steelseries SWR-S1) I was able to use the serial
number, however my other wheel (Logitech G27) does not have a unique
serial (it reports '0').

The G27 (hid-lg4ff) driver's naming changes each time the wheel is
unplugged/plugged.

It currently uses
--
snprintf(name, name_sz, "%s::RPM%d", dev_name(&hid->dev), j+1);
--
ie. "0003:046D:C294.0009::RPM1",  the '0009' will change each time.


In the absence of a serial number, is there another method I could use
which would allow multiple G27's to be connected to a system and still
allow unique (but consistant) naming?

Cheers,
Simon



