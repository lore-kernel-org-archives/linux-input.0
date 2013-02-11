From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/7] hid driver transport cleanup
Date: Mon, 11 Feb 2013 12:13:36 +0200
Message-ID: <20130211101336.GA20771@intel.com>
References: <1360334256-22127-1-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:6025 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754907Ab3BKKJp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2013 05:09:45 -0500
Content-Disposition: inline
In-Reply-To: <1360334256-22127-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 08, 2013 at 03:37:29PM +0100, Benjamin Tissoires wrote:
> so, here is the hid drivers cleanup. The aim is to remove as much as possible
> direct calls to usbhid for hid drivers. Thus, other transport layers can use
> the existing hid drivers (like I2C or uhid).

We also found out that there is a dependency to usbhid in many of the
drivers, especially in sensor-hub which caused the system crash while the
driver tried to transmit over USB even though it was behind I2C.

Your series fixes that nicely :)

You can add,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

for the whole series and in addition,

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

for the sensor-hub part (HID over I2C). I have few more patches to the
sensor-hub myself and I'm going to rebase them on top of this series.
