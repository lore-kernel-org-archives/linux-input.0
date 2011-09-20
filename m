From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [smatch stuff] hid-logitech-dj: off by one range checking
Date: Tue, 20 Sep 2011 11:06:22 +0300
Message-ID: <20110920080622.GA7611@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:33454 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab1ITIGk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 04:06:40 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Nestor,

Smatch complains about an off by one range check here.  It looks like
a bug, but I'm not sure the correct fix.

drivers/hid/hid-logitech-dj.c +278 logi_dj_recv_add_djhid_device(66)
	error: buffer overflow 'djrcv_dev->paired_dj_devices' 6 <= 6

   233          if ((dj_report->device_index < DJ_DEVICE_INDEX_MIN) ||
   234              (dj_report->device_index > DJ_DEVICE_INDEX_MAX)) {
   235                  dev_err(&djrcv_hdev->dev, "%s: invalid device index:%d\n",
   236                          __func__, dj_report->device_index);
   237                  return;
   238          }

DJ_DEVICE_INDEX_MIN is 1
DJ_DEVICE_INDEX_MAX is 6

   278          djrcv_dev->paired_dj_devices[dj_report->device_index] = dj_dev;

->paired_dj_devices[] has 6 elements so if dj_report->device_index is
6 we're one past the end of the array.

regards,
dan carpenter
