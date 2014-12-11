From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: NULL pointer dereference in i2c-hid
Date: Thu, 11 Dec 2014 10:58:01 +0200
Message-ID: <20141211085801.GR1300@lahna.fi.intel.com>
References: <31518562.V5Oyo0POsI@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5742 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932227AbaLKJAM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Dec 2014 04:00:12 -0500
Content-Disposition: inline
In-Reply-To: <31518562.V5Oyo0POsI@xps13>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, aduggan@synaptics.com, jkosina@suse.cz

On Wed, Dec 10, 2014 at 06:04:51PM +0100, Gabriele Mazzotta wrote:
> my laptop uses a touchpad that needs hid-rmi along with i2c-hid to work.
> i2c-hid and hid-rmi can be loaded and unloaded independelty from each
> other, however since 34f439e4afcd ("HID: i2c-hid: add runtime PM support")
> if I unload hid-rmi and after it I also unload i2c-hid, I get a NULL
> pointer dereference.

I'll look into this.

I can reproduce this easily with i2c-hid + hid-multitouch following your
directions.
