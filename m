From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: sony: Add touchpad support for Sony's NSG-MR5U and
 NSG-MR7U remotes
Date: Wed, 1 Feb 2017 09:56:53 +0100
Message-ID: <20170201085653.GF31658@mail.corp.redhat.com>
References: <20170128023942.GA11682@gmail.com>
 <20170130095618.GA26482@mail.corp.redhat.com>
 <20170131000243.GA3725@gmail.com>
 <20170201085358.GE31658@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170201085358.GE31658@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Todd K <tsopdump@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Feb 01 2017 or thereabouts, Benjamin Tissoires wrote:
> On Jan 30 2017 or thereabouts, Todd K wrote:
> > On Mon, Jan 30, 2017 at 10:56:18AM +0100, Benjamin Tissoires wrote:
> > > Hi,
> > > 
> > > On Jan 27 2017 or thereabouts, Todd Kelner wrote:
> > > > Sony's NSG-MR5U and NSG-MR7U remote controls have a full keyboard and a
> > > > touchpad.  The keyboard is already supported by the existing Linux kernel
> > > > and drivers but the touchpad is not recognized.  This patch adds the code
> > > > needed to bring full functionality to the touchpad.
> > > > 
> > > > Note that these remotes use the vendor code for SMK even though they are
> > > > Sony branded.
> > > > 
> > > 
> > > Thanks for the patch. There are some changes I'd like to be in before we
> > > merge it. Please see inline.
> > > 
> > > > Signed-off-by: Todd Kelner <tsopdump@gmail.com>
> > > > ---
> > > >  drivers/hid/hid-core.c |   2 +
> > > >  drivers/hid/hid-ids.h  |   2 +
> > > >  drivers/hid/hid-sony.c | 124 +++++++++++++++++++++++++++++++++++++++++++++----
> > > >  3 files changed, 118 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > > index cff060b..4dfef41 100644
> > > > --- a/drivers/hid/hid-core.c
> > > > +++ b/drivers/hid/hid-core.c
> > > > @@ -2054,6 +2054,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
> > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
> > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_SKYCABLE, USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER) },
> > > >  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_PS3_BDREMOTE) },
> > > > +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE) },
> > > > +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE) },
> > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_BUZZ_CONTROLLER) },
> > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER) },
> > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },
> > > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > > index 54bd22d..864ec34 100644
> > > > --- a/drivers/hid/hid-ids.h
> > > > +++ b/drivers/hid/hid-ids.h
> > > > @@ -904,6 +904,8 @@
> > > >  
> > > >  #define USB_VENDOR_ID_SMK		0x0609
> > > >  #define USB_DEVICE_ID_SMK_PS3_BDREMOTE	0x0306
> > > > +#define USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE	0x0368
> > > > +#define USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE	0x0369
> > > >  
> > > >  #define USB_VENDOR_ID_SONY			0x054c
> > > >  #define USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE	0x024b
> > > > diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> > > > index f405b07..e6a8ef2 100644
> > > > --- a/drivers/hid/hid-sony.c
> > > > +++ b/drivers/hid/hid-sony.c
> > > > @@ -54,6 +54,8 @@
> > > >  #define NAVIGATION_CONTROLLER_BT  BIT(10)
> > > >  #define SINO_LITE_CONTROLLER      BIT(11)
> > > >  #define FUTUREMAX_DANCE_MAT       BIT(12)
> > > > +#define NSG_MR5U_REMOTE_BT        BIT(13)
> > > > +#define NSG_MR7U_REMOTE_BT        BIT(14)
> > > >  
> > > >  #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
> > > >  #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
> > > > @@ -70,8 +72,11 @@
> > > >  				MOTION_CONTROLLER)
> > > >  #define SONY_BT_DEVICE (SIXAXIS_CONTROLLER_BT | DUALSHOCK4_CONTROLLER_BT |\
> > > >  			MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER_BT)
> > > > +#define NSG_MRXU_REMOTE (NSG_MR5U_REMOTE_BT | NSG_MR7U_REMOTE_BT)
> > > >  
> > > >  #define MAX_LEDS 4
> > > > +#define NSG_MRXU_MAX_X 1667
> > > > +#define NSG_MRXU_MAX_Y 1868
> > > >  
> > > >  /*
> > > >   * The Sixaxis reports both digital and analog values for each button on the
> > > > @@ -1063,7 +1068,7 @@ struct motion_output_report_02 {
> > > >  #define DS4_INPUT_REPORT_BATTERY_OFFSET  30
> > > >  #define DS4_INPUT_REPORT_TOUCHPAD_OFFSET 33
> > > >  
> > > > -#define DS4_TOUCHPAD_SUFFIX " Touchpad"
> > > > +#define TOUCHPAD_SUFFIX " Touchpad"
> > > >  
> > > >  static DEFINE_SPINLOCK(sony_dev_list_lock);
> > > >  static LIST_HEAD(sony_device_list);
> > > > @@ -1240,6 +1245,10 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
> > > >  		hid_info(hdev, "Using modified Dualshock 4 Bluetooth report descriptor\n");
> > > >  		rdesc = dualshock4_bt_rdesc;
> > > >  		*rsize = sizeof(dualshock4_bt_rdesc);
> > > > +	} else if (sc->quirks & NSG_MRXU_REMOTE && *rsize == 359 &&
> > > > +			rdesc[358] == 0x00) {
> > > > +		hid_info(hdev, "Removing trailing 0x00 from NSG_MRxU report descriptor\n");
> > > > +		(*rsize)--;
> > > 
> > > I think this is generic for bluetooth HID devices (at least all I have
> > > seen) and should probably be fixed in the hidp implementation directly,
> > > not for each device
> > > 
> > I wasn't sure if this might cause a problem.  If it is a common
> > occurrence and doesn't cause problems, I'll remove this part of the code.
> > 
> > > >  	}
> > > >  
> > > >  	if (sc->quirks & SIXAXIS_CONTROLLER)
> > > > @@ -1383,6 +1392,70 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
> > > >  	}
> > > >  }
> > > >  
> > > > +static void nsg_mrxu_parse_report(struct sony_sc *sc, u8 *rd, int size)
> > > > +{
> > > > +	int n, offset;
> > > > +	u8 active;
> > > > +
> > > > +	/*
> > > > +	 * The NSG-MRxU multi-touch trackpad data starts at offset 1 and
> > > > +	 *   the touch-related data starts at offset 2.
> > > > +	 * Bit 0 is set when touchpad button is pressed.
> > > > +	 * Bit 3 is set when a touch is active and the drag (Fn) key is pressed.
> > > > +	 * This drag key is mapped to BTN_LEFT.
> > > > +	 * Bit 4 is set when only the first touch point is active.
> > > > +	 * Bit 6 is set when only the second touch point is active.
> > > > +	 * Bits 5 and 7 are set when both touch points are active.
> > > > +	 * The next 3 bytes are two 12 bit X/Y coordinates for the first touch.
> > > > +	 * The bytes at offset 7-9 are the second touch X/Y coordinates.
> > > > +	 */
> > > 
> > > Well, it seems weird that the PS would implement a specific raw protocol
> > > for these remotes. Any chances you can not rely on the report
> > > descriptors and use more generic HID processing? (otherwise, any change
> > > in the protocol would require a new implementation, while HID should
> > > mask that).
> > > 
> > Sony is using a vendor-specific usage page for its touchpad so that is
> > one of the main reasons why the touchpad isn't natively supported in
> > Linux.  There's a similar touchpad on Sony's Dualshock 4 controller and
> > support for it was recently added to hid-sony.c so I was following that
> > as an example.  If there's a better way to do this, I'm willing to give
> > it a shot if you can point me in the right direction.
> 
> Oh, OK. Then in that case you are following the correct path.
> 
> > 
> > > > +	offset = 1;
> > > > +
> > > > +	input_report_key(sc->touchpad, BTN_LEFT, rd[offset] & 0x0F);
> > > > +	active = (rd[offset] >> 4);
> > > > +
> > > > +	offset++;
> > > > +
> > > > +	for (n = 0; n < 2; n++) {
> > > > +		u16 x, y;
> > > > +		u8 contactx, contacty;
> > > > +		unsigned int rel_axis;
> > > > +
> > > > +		x = rd[offset] | ((rd[offset+1] & 0x0F) << 8);
> > > > +		y = ((rd[offset+1] & 0xF0) >> 4) | (rd[offset+2] << 4);
> > > > +
> > > > +		input_mt_slot(sc->touchpad, n);
> > > > +		input_mt_report_slot_state(sc->touchpad, MT_TOOL_FINGER, active & 0x03);
> > > > +
> > > > +		if (active & 0x03) {
> > > > +			contactx = rd[offset+3] & 0x0F;
> > > > +			contacty = rd[offset+3] >> 4;
> > > > +			input_report_abs(sc->touchpad, ABS_MT_TOUCH_MAJOR,
> > > > +				max(contactx, contacty));
> > > > +			input_report_abs(sc->touchpad, ABS_MT_TOUCH_MINOR,
> > > > +				max(contactx, contacty));
> > > > +			input_report_abs(sc->touchpad, ABS_MT_ORIENTATION,
> > > > +				(bool) (contactx > contacty));
> > > > +			input_report_abs(sc->touchpad, ABS_MT_POSITION_X, x);
> > > > +			input_report_abs(sc->touchpad, ABS_MT_POSITION_Y,
> > > > +				NSG_MRXU_MAX_Y - y);
> > > > +			if (n == 0)
> > > > +				rel_axis = REL_X;
> > > > +			else
> > > > +				rel_axis = REL_Y;
> > > > +
> > > > +			input_report_rel(sc->touchpad, rel_axis, rd[offset+4]);
> > > > +		}
> > > > +
> > > > +		offset += 5;
> > > > +                active >>= 2;
> > > > +	}
> > > > +
> > > > +	input_mt_sync_frame(sc->touchpad);
> > > > +
> > > > +	input_sync(sc->touchpad);
> > > > +}
> > > > +
> > > >  static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
> > > >  		u8 *rd, int size)
> > > >  {
> > > > @@ -1459,6 +1532,10 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
> > > >  		}
> > > >  
> > > >  		dualshock4_parse_report(sc, rd, size);
> > > > +
> > > > +	} else if (sc->quirks & NSG_MRXU_REMOTE && rd[0] == 0x02) {
> > > > +		nsg_mrxu_parse_report(sc, rd, size);
> > > > +		return 1;
> > > >  	}
> > > >  
> > > >  	if (sc->defer_initialization) {
> > > > @@ -1529,30 +1606,37 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
> > > >  	sc->touchpad->id.product = sc->hdev->product;
> > > >  	sc->touchpad->id.version = sc->hdev->version;
> > > >  
> > > > -	/* Append a suffix to the controller name as there are various
> > > > -	 * DS4 compatible non-Sony devices with different names.
> > > > -	 */
> > > > -	name_sz = strlen(sc->hdev->name) + sizeof(DS4_TOUCHPAD_SUFFIX);
> > > > +	/* Append a suffix to the controller name to make it more unique */
> > > > +	name_sz = strlen(sc->hdev->name) + sizeof(TOUCHPAD_SUFFIX);
> > > >  	name = kzalloc(name_sz, GFP_KERNEL);
> > > >  	if (!name) {
> > > >  		ret = -ENOMEM;
> > > >  		goto err;
> > > >  	}
> > > > -	snprintf(name, name_sz, "%s" DS4_TOUCHPAD_SUFFIX, sc->hdev->name);
> > > > +	snprintf(name, name_sz, "%s" TOUCHPAD_SUFFIX, sc->hdev->name);
> > > >  	sc->touchpad->name = name;
> > > >  
> > > > -	ret = input_mt_init_slots(sc->touchpad, touch_count, 0);
> > > > -	if (ret < 0)
> > > > -		goto err;
> > > > -
> > > >  	/* We map the button underneath the touchpad to BTN_LEFT. */
> > > >  	__set_bit(EV_KEY, sc->touchpad->evbit);
> > > >  	__set_bit(BTN_LEFT, sc->touchpad->keybit);
> > > > +	__clear_bit(BTN_MIDDLE, sc->touchpad->keybit);
> > > > +	__clear_bit(BTN_RIGHT, sc->touchpad->keybit);
> > > >  	__set_bit(INPUT_PROP_BUTTONPAD, sc->touchpad->propbit);
> > > >  
> > > > +	if (sc->quirks & NSG_MRXU_REMOTE) {
> > > > +		__set_bit(EV_REL, sc->touchpad->evbit);
> > > > +		input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MAJOR, 0, 15, 0, 0);
> > > > +		input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MINOR, 0, 15, 0, 0);
> > > > +		input_set_abs_params(sc->touchpad, ABS_MT_ORIENTATION, 0, 1, 0, 0);
> > > > +	}
> > > > +
> > > >  	input_set_abs_params(sc->touchpad, ABS_MT_POSITION_X, 0, w, 0, 0);
> > > >  	input_set_abs_params(sc->touchpad, ABS_MT_POSITION_Y, 0, h, 0, 0);
> > > >  
> > > > +	ret = input_mt_init_slots(sc->touchpad, touch_count, INPUT_MT_POINTER);
> > > > +	if (ret < 0)
> > > > +		goto err;
> > > > +
> > > 
> > > Ideally, I'd prefer see this fix for the multitouch protocol in a
> > > separate patch (moving input_mt_init_slot after the initialization of MT
> > > axes).
> > > 
> > OK, I'll put this back where it was originally and submit a separate
> > patch to move it so it follows the set bit calls.
> > 
> > > >  	ret = input_register_device(sc->touchpad);
> > > >  	if (ret < 0)
> > > >  		goto err;
> > > > @@ -2586,6 +2670,20 @@ static int sony_input_configured(struct hid_device *hdev,
> > > >  		}
> > > >  
> > > >  		sony_init_output_report(sc, dualshock4_send_output_report);
> > > > +	} else if (sc->quirks & NSG_MRXU_REMOTE) {
> > > > +		/*
> > > > + 		 * The NSG-MRxU touchpad supports 2 touches and has a
> > > > + 		 * resolution of 1667x1868
> > > > + 		 */
> > > > +		ret = sony_register_touchpad(sc, 2,
> > > > +			NSG_MRXU_MAX_X, NSG_MRXU_MAX_Y);
> > > 
> > > Isn't the resolution part of the report descriptors?
> > > 
> > The resolution doesn't appear to be listed in the descriptor.  All it 
> > lists are the logical min/max, i.e. -2047 to +2047 for both axes.
> 
> If the device is following a custom protocol, it makes sense. So no
> worries there.
> 
> > 
> > > > +		if (ret) {
> > > > +			hid_err(sc->hdev,
> > > > +			"Unable to initialize multi-touch slots: %d\n",
> > > > +			ret);
> > > > +			goto err_stop;
> > > > +		}
> > > > +
> > > >  	} else if (sc->quirks & MOTION_CONTROLLER) {
> > > >  		sony_init_output_report(sc, motion_send_output_report);
> > > >  	} else {
> > > > @@ -2830,6 +2928,12 @@ static const struct hid_device_id sony_devices[] = {
> > > >  	/* Nyko Core Controller for PS3 */
> > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE, USB_DEVICE_ID_SINO_LITE_CONTROLLER),
> > > >  		.driver_data = SIXAXIS_CONTROLLER_USB | SINO_LITE_CONTROLLER },
> > > > +	/* SMK-Link NSG-MR5U Remote Control */
> > > > +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE),
> > > > +		.driver_data = NSG_MR5U_REMOTE_BT },
> > > > +	/* SMK-Link NSG-MR7U Remote Control */
> > > > +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE),
> > > > +		.driver_data = NSG_MR7U_REMOTE_BT },
> > > >  	{ }
> > > >  };
> > > >  MODULE_DEVICE_TABLE(hid, sony_devices);
> > > > -- 
> > > > 2.7.4
> > > > 
> > > 
> > > Cheers,
> > > Benjamin
> > > 
> > Thanks for reviewing the patch and sending feedback on it.
> > 
> > If you can let me know how/if the touchpad can be handled in a more
> > generic fashion, I'll update my code before sending a new patch.
> > 
> 
> I don't think you'll be able to fix this without tinkering too much for
> no gain. Please just resubmit with the few other comments, and that
> should be good.

Actually, don't forget to put Jiri in CC of all your emails, and also
linux-input@vger.kernel.org. That's a requirement to be included in the
upstream kernel.

Cheers,
Benjamin

> > Thanks again,
> > Todd
