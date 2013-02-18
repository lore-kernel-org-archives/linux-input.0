From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/3] HID: sensor-hub: don't limit the driver only to USB
 bus
Date: Mon, 18 Feb 2013 13:33:20 +0200
Message-ID: <20130218113320.GA2338@intel.com>
References: <1360578679-7029-1-git-send-email-mika.westerberg@linux.intel.com>
 <1360578679-7029-3-git-send-email-mika.westerberg@linux.intel.com>
 <51220A68.9030608@ahsoftware.de>
 <20130218111217.GL20771@intel.com>
 <51220F12.2060908@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51220F12.2060908@ahsoftware.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, srinivas.pandruvada@intel.com
List-Id: linux-input@vger.kernel.org

On Mon, Feb 18, 2013 at 12:22:58PM +0100, Alexander Holler wrote:
> Am 18.02.2013 12:12, schrieb Mika Westerberg:
> >On Mon, Feb 18, 2013 at 12:03:04PM +0100, Alexander Holler wrote:
> >>Am 11.02.2013 11:31, schrieb Mika Westerberg:
> >>>We now have two transport mediums: USB and I2C, where sensor hubs can
> >>>exists. So instead of constraining the driver to only these two we let it
> >>>to match any HID bus as long as the group is HID_GROUP_SENSOR_HUB.
> >>>
> >>>Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>>---
> >>>  drivers/hid/hid-sensor-hub.c |    3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>>diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> >>>index 2643bce9..c01f10d 100644
> >>>--- a/drivers/hid/hid-sensor-hub.c
> >>>+++ b/drivers/hid/hid-sensor-hub.c
> >>>@@ -603,7 +603,8 @@ static void sensor_hub_remove(struct hid_device *hdev)
> >>>  }
> >>>
> >>>  static const struct hid_device_id sensor_hub_devices[] = {
> >>>-	{ HID_DEVICE(BUS_USB, HID_GROUP_SENSOR_HUB, HID_ANY_ID, HID_ANY_ID) },
> >>>+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
> >>>+		     HID_ANY_ID) },
> >>>  	{ }
> >>>  };
> >>>  MODULE_DEVICE_TABLE(hid, sensor_hub_devices);
> >>>
> >>
> >>Hmm, what happens with Bluetooth sensor-hubs? Is the driver now able
> >>to handle them too?
> >
> >It should, yes.
> 
> If so, I think patch 1/3 should be modified accordingly.

Do you know if such devices exists currently? If not, I'm not sure if it
makes sense to do that now.
