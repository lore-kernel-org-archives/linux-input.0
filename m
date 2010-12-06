From: Valentine Barshak <vbarshak@mvista.com>
Subject: [PATCH 0/2] USB: HID: Fix race between disconnect and hiddev_ioctl
Date: Mon, 6 Dec 2010 17:45:19 +0300
Message-ID: <20101206144519.GA8438@mvista.com>
Reply-To: Valentine Barshak <vbarshak@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 93.100.122.208.pool.sknt.ru ([93.100.122.208]:41914 "EHLO
	localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750709Ab0LFOlM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Dec 2010 09:41:12 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

If a USB HID device is disconneceted, the hiddev_ioctl could try
to access invalid hiddev->hid pointer.

The following two patches attempt to fix race condition between
disconnect and hiddev_ioctl and make hiddev_ioctl always return
-ENODEV on a disconnected device.
