From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Q: weird hidraw behaviour
Date: Tue, 24 Sep 2013 11:56:06 +0300
Message-ID: <20130924085606.GI28875@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4748 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab3IXIui (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Sep 2013 04:50:38 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Manoj Chourasia <mchourasia@nvidia.com>
Cc: linux-input@vger.kernel.org

Hi,

I noticed that after commit 212a871a393 (HID: hidraw: correctly deallocate
memory on device disconnect) hidraw doesn't close the underlying hid device
when the device node is closed last time.

For example I have a touch panel (HID over I2C) device with added debug
prints in i2c_hid_open()/i2c_hid_close():

	# od -x /dev/hidraw0
	[   41.363813] i2c_hid 1-004c: i2c_hid_power lvl:32
	[   41.368464] i2c_hid 1-004c: i2c_hid_set_power
	[   41.372831] i2c_hid 1-004c: __i2c_hid_command: cmd=54 01 00 08
	[   41.451455] i2c_hid 1-004c: i2c_hid_open
	^C

	# od -x /dev/hidraw0
	[   58.420928] i2c_hid 1-004c: i2c_hid_power lvl:32
	[   58.425577] i2c_hid 1-004c: i2c_hid_set_power
	[   58.429945] i2c_hid 1-004c: __i2c_hid_command: cmd=54 01 00 08
	[   58.525276] i2c_hid 1-004c: i2c_hid_open
	^C

i2c_hid_close() is never called. Is this intended or am I missing
something?

Thanks.
