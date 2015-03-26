From: Oliver Neukum <oneukum@suse.de>
Subject: proposal for deletion of drivers/hid/hid-ids.h
Date: Thu, 26 Mar 2015 12:44:48 +0100
Message-ID: <1427370288.2075.19.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36021 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbbCZLpY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Mar 2015 07:45:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, pavel@ucw.cz

Hi,

I would like to kill drivers/hid/hid-ids.h and replace it
with numerical IDs in the files using it.

There are two reasons for that.

1. It is a layering violation. There should not be a private
data base for USB IDs in HID.

2. It serves no purpose and adds work. Anyone who adds a quirk
or a special case for devices needs to operate on the numbers,
as those are what he gets from the descriptors. Looking up or
adding a symbolic name for a device is just more work without
a benefit. These numbers have no intrinsic meaning beyond
being unique and it rarely matters (and should not matter)
for which vendor a particular fix is intended.

In the rare cases it does matter when it does matter searching
the official list of USB IDs is less work.

So let's kill this utterly useless step of indirection.

	Regards
		Oliver


