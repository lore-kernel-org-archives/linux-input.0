From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: NULL pointer dereference in i2c-hid
Date: Thu, 11 Dec 2014 16:03:07 +0200
Message-ID: <20141211140307.GE1300@lahna.fi.intel.com>
References: <31518562.V5Oyo0POsI@xps13>
 <20141211085801.GR1300@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35304 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932802AbaLKOD0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Dec 2014 09:03:26 -0500
Content-Disposition: inline
In-Reply-To: <20141211085801.GR1300@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, aduggan@synaptics.com, jkosina@suse.cz

On Thu, Dec 11, 2014 at 10:58:01AM +0200, Mika Westerberg wrote:
> On Wed, Dec 10, 2014 at 06:04:51PM +0100, Gabriele Mazzotta wrote:
> > my laptop uses a touchpad that needs hid-rmi along with i2c-hid to work.
> > i2c-hid and hid-rmi can be loaded and unloaded independelty from each
> > other, however since 34f439e4afcd ("HID: i2c-hid: add runtime PM support")
> > if I unload hid-rmi and after it I also unload i2c-hid, I get a NULL
> > pointer dereference.
> 
> I'll look into this.
> 
> I can reproduce this easily with i2c-hid + hid-multitouch following your
> directions.

Can you try the below patch? 

I think we shouldn't free buffers yet in ->stop() because we need the
command buffer sending power commands to the device. Also it seems that
->start() re-allocates buffers anyway if maximum size increases.

It shouldn't even leak memory as we release buffers at ->remove()
anyway.

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 62cec01937ea..68a8c938feea 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -705,12 +705,7 @@ static int i2c_hid_start(struct hid_device *hid)
 
 static void i2c_hid_stop(struct hid_device *hid)
 {
-	struct i2c_client *client = hid->driver_data;
-	struct i2c_hid *ihid = i2c_get_clientdata(client);
-
 	hid->claimed = 0;
-
-	i2c_hid_free_buffers(ihid);
 }
 
 static int i2c_hid_open(struct hid_device *hid)
