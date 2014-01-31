From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 0/6] HID: Add a stable method for retrieving the client MAC address of a HID device
Date: Fri, 31 Jan 2014 12:32:47 -0500
Message-ID: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:34862 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbaAaRdB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 12:33:01 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Currently there is no reliable way for a device module or hidraw application to
retrieve the client MAC address of the associated wireless device.  This series
of patches adds a stable way of retrieving this information.

The first patch adds a new client_addr member to the hid_device struct.  This
member, when populated, will be guaranteed to contain the client hardware
address of a connected wireless device.

The second patch modifies HIDP to populate the client_addr member of the 
hid_device struct with the client MAC address of the connected wireless device.

The third patch adds support for setting the client_addr value in a uhid
device.

The final patches add support for retrieving the client_addr value as a string
in the hidraw interface via a new ioctl called HIDIOCGRAWCLIENTADDR.  The
hidraw documentation and example program are also updated.
