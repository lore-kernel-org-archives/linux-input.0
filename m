From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/3] HID: sensor-hub: don't limit the driver only to USB
 bus
Date: Tue, 12 Feb 2013 11:12:05 +0200
Message-ID: <20130212091205.GO20771@intel.com>
References: <1360578679-7029-1-git-send-email-mika.westerberg@linux.intel.com>
 <1360578679-7029-3-git-send-email-mika.westerberg@linux.intel.com>
 <4FA419E87744DF4DAECD5BCE1214B7A91E00FB81@ORSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:33179 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932131Ab3BLJIO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Feb 2013 04:08:14 -0500
Content-Disposition: inline
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A91E00FB81@ORSMSX108.amr.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Feb 11, 2013 at 03:54:05PM +0000, Pandruvada, Srinivas wrote:
> So finally we can use HID sensor hub over I2C.
> Did you try with any I2C sensor hub?

Yes, we have I2C HID sensor hub here and I tested with it. However, I'm not
that familiar how it should be used except that I can see the sensors under
/sys/bus/platform/devices/HID-SENSOR* and there are iio devices under each
platform device.
