From: ulrik.debie-os@e2big.org
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware
 ID"
Date: Sun, 14 Jan 2018 21:57:33 +0100
Message-ID: <20180114205732.GA4614@beacon.debie>
References: <dcfb84c8-4ad8-8276-5451-ee91fc84f742@canonical.com>
 <20171231082646.GC25965@kroah.com>
 <901a0a66-eb83-9dcd-658c-5b09eabcab88@canonical.com>
 <20180102070811.p7gfaq3vr55sdbd3@dtor-ws>
 <ac087ae7-54d4-d038-daa7-048c87368d17@canonical.com>
 <20180105005659.j2x56opkq74wm7v2@dtor-ws>
 <598ac534-ed9b-1377-70c5-eec7b7521755@canonical.com>
 <20180105162313.higyrbd6unumgtjb@dtor-ws>
 <20180107065201.q2xck62unijt3avr@dtor-ws>
 <20180114203958.GA3686@beacon.debie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:46663 "EHLO e2big.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752157AbeANU5o (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 14 Jan 2018 15:57:44 -0500
Content-Disposition: inline
In-Reply-To: <20180114203958.GA3686@beacon.debie>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaron Ma <aaron.ma@canonical.com>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Schmidt <yath@yath.de>, linux-input@vger.kernel.org

Hi,

On Sun, Jan 14, 2018 at 09:39:58PM +0100, ulrik.debie-os@e2big.org wrote:
> 
> Hi Dmitry, Sebastian,
> Nack for the patch..
> As Sebastian pointed out, the trackpoint detection will always report an error. (see below)
> 
> I builded your original patch and it resulted in detection as generic mouse for the trackpoint:
> 
> [    0.838143] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    0.838146] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    0.838267] mousedev: PS/2 mouse device common for all mice
> [    9.321140] psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4758]
> [    9.367095] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1096..]
> [    9.367103] psmouse serio1: synaptics: The touchpad can support a better bus than the too old PS/2 protocol. Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.
> [    9.455953] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf007a3/0x943300/0x12e800/0x410000, board id: 3157, fw id: 2405942
> [    9.455970] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
> [    9.514117] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input7
> [   11.458443] input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/serio2/input/input18
> 
> When I fixed your patch, it resulted in: (timing difference is because a dvd was inserted before)
> [    0.843661] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    0.843664] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    0.843793] mousedev: PS/2 mouse device common for all mice
> [    3.822411] psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4758]
> [    3.868196] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1096..]
> [    3.868203] psmouse serio1: synaptics: The touchpad can support a better bus than the too old PS/2 protocol. Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.
> [    3.961024] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf007a3/0x943300/0x12e800/0x410000, board id: 3157, fw id: 2405942
> [    3.961038] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
> [    4.017290] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input7
> [    4.407930] psmouse serio2: trackpoint: failed to get extended button data, assuming 3 buttons
> [    8.460022] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
> [    8.740439] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input18
> 
> functionally both versions (with/without bug) resulted in a functional trackpoint with 3 buttons.
> 
> Sebastian, with regards to your middle button question, as you can see in the output I've such hardware. (lenovo e570).

Sorry Sebastian, I was thinking Aaron had commited 
"Input: trackpoint - assume 3 buttons when buttons detection fails"
commit 293b915fd9bebf33cdc906516fb28d54649a25ac but actually Oscar
Campos did. I just realised when I reread his mails that you were
actually not pointing to the patch where Aaron suggested an 
amendment to this 3 button commit but actually to his commit
that resulted in regression for you.


> 
> Dimitrios, wasn't it your intention that this hardware would be detected as NON IBM ? Apparently it
> is IBM and still fails "Read Extended Button Status".
> 
> Kind regards,
> Ulrik
Kind regards,
Ulrik
> 
> On Sat, Jan 06, 2018 at 10:52:01PM -0800, Dmitry Torokhov wrote:
> > Date:   Sat, 6 Jan 2018 22:52:01 -0800
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > To: Aaron Ma <aaron.ma@canonical.com>
> > Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Schmidt <yath@yath.de>,
> >  linux-input@vger.kernel.org
> > Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint
> >  firmware ID"
> > X-Mailing-List: linux-input@vger.kernel.org
> > 
> > On Fri, Jan 05, 2018 at 08:23:13AM -0800, Dmitry Torokhov wrote:
> > > Hi Aaron,
> > > 
> > > On Fri, Jan 05, 2018 at 09:29:26PM +0800, Aaron Ma wrote:
> > > > Hi Dmitry:
> > > > 
> > > > Got the official info from Lenovo:
> > > > Lenovo introduced new TrackPoint compatible sticks ( ELAN/Alps/NXP
> > > > sticks) from 2016.
> > > > These new devices only support the minimum commands described in the
> > > > spec, which has been used in the current Windows driver.
> > > 
> > > What is the exact list of the commands supported by each variant?
> > > 
> > > > 
> > > > Legacy TrackPoint: 0101 – 0E01
> > > > ALPS: 0102 – FF02
> > > > ELAN:0103 – FF03
> > > > NXP: 0104 – FF04
> > > > 
> > > > 2.4.18 READ SECONDARY ID (x"E1")
> > > > This command will read the secondary device ID of the pointing device (2
> > > > bytes).  The least significant byte is sent first.  For the first byte,
> > > > the legacy TrackPoint controller from IBM will always return x"01", the
> > > > pointing stick from ALPS will always return x"02", the pointing stick
> > > > from Elan will always return x"03”, and the pointing stick from NXP will
> > > > always return 0x”04".  And a second byte which denotes a specific set of
> > > > functional specifications.  Differing ROM versions are used to denote
> > > > changes within a given functional set.
> > > 
> > > Can you/Lenovo share the updated spec?
> > > 
> > > > 
> > > > The new devices (include Legacy ID:01) will not support the sysfs like
> > > > speed.
> > > > 
> > > > So it is not right to revert the commit, it is about to add another 0x04
> > > > ID in it.
> > > > 
> > > > Old sysfs could be stayed for old legacy device ID:01 or removed.
> > > 
> > > No, because there are devices that have trackpoints properly
> > > implementing the protocol, before Lenovo started their "innovation".
> > > 
> > > Do we have any way to distinguish between properly implemented
> > > trackpoints and Lenovo "improved" ones? I played with gen3 Carbon, and
> > > while it does not error out on "speed" attribute, unlike gen5, it still
> > > has no visible effects. Additionally, the "press to select"
> > > functionality seems to be disabled, and trying to enable it via sysfs
> > > results in register content being reverted to the original "disabled"
> > > setting in a second or two. Setting to swap X and Y axes does not work
> > > either, not sure about other bits of that control register.
> > > "sensitivity" does work though, again unlike my gen5.
> > > 
> > > Thanks.
> > > 
> > > -- 
> > > Dmitry
> > 
> > Guys, could you please try the patch below? It will not solve the
> > "speed" issue on 0x01 devices, but hopefully we won't be exposing
> > non-existing controls on others.
> > 
> > Thanks!
> > 
> > -- 
> > Dmitry
> > 
> > 
> > Input: trackpoint - only expose supported controls for Elan, ALPS and NXP
> > 
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > The newer trackpoints from ALPS, Elan and NXP implement a very limited
> > subset of extended commands and controls that the original trackpoints
> > implemented, so we should not be exposing not working controls in sysfs.
> > The newer trackpoints also do not implement "Power On Reset" or "Read
> > Extended Button Status", so we should not be using these commands during
> > initialization.
> > 
> > While we are at it, let's change "unsigned char" to u8 for byte data or
> > bool for booleans and use better suited error codes instead of -1.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/mouse/trackpoint.c |  241 +++++++++++++++++++++++---------------
> >  drivers/input/mouse/trackpoint.h |   34 +++--
> >  2 files changed, 168 insertions(+), 107 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> > index 0871010f18d5..0ca80f465359 100644
> > --- a/drivers/input/mouse/trackpoint.c
> > +++ b/drivers/input/mouse/trackpoint.c
> > @@ -19,6 +19,13 @@
> >  #include "psmouse.h"
> >  #include "trackpoint.h"
> >  
> > +static const char * const trackpoint_variants[] = {
> > +	[TP_VARIANT_IBM]	= "IBM",
> > +	[TP_VARIANT_ALPS]	= "ALPS",
> > +	[TP_VARIANT_ELAN]	= "Elan",
> > +	[TP_VARIANT_NXP]	= "NXP",
> > +};
> > +
> >  /*
> >   * Power-on Reset: Resets all trackpoint parameters, including RAM values,
> >   * to defaults.
> > @@ -26,7 +33,7 @@
> >   */
> >  static int trackpoint_power_on_reset(struct ps2dev *ps2dev)
> >  {
> > -	unsigned char results[2];
> > +	u8 results[2];
> >  	int tries = 0;
> >  
> >  	/* Issue POR command, and repeat up to once if 0xFC00 received */
> > @@ -38,7 +45,7 @@ static int trackpoint_power_on_reset(struct ps2dev *ps2dev)
> >  
> >  	/* Check for success response -- 0xAA00 */
> >  	if (results[0] != 0xAA || results[1] != 0x00)
> > -		return -1;
> > +		return -ENODEV;
> >  
> >  	return 0;
> >  }
> > @@ -46,8 +53,7 @@ static int trackpoint_power_on_reset(struct ps2dev *ps2dev)
> >  /*
> >   * Device IO: read, write and toggle bit
> >   */
> > -static int trackpoint_read(struct ps2dev *ps2dev,
> > -			   unsigned char loc, unsigned char *results)
> > +static int trackpoint_read(struct ps2dev *ps2dev, u8 loc, u8 *results)
> >  {
> >  	if (ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, TP_COMMAND)) ||
> >  	    ps2_command(ps2dev, results, MAKE_PS2_CMD(0, 1, loc))) {
> > @@ -57,8 +63,7 @@ static int trackpoint_read(struct ps2dev *ps2dev,
> >  	return 0;
> >  }
> >  
> > -static int trackpoint_write(struct ps2dev *ps2dev,
> > -			    unsigned char loc, unsigned char val)
> > +static int trackpoint_write(struct ps2dev *ps2dev, u8 loc, u8 val)
> >  {
> >  	if (ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, TP_COMMAND)) ||
> >  	    ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, TP_WRITE_MEM)) ||
> > @@ -70,8 +75,7 @@ static int trackpoint_write(struct ps2dev *ps2dev,
> >  	return 0;
> >  }
> >  
> > -static int trackpoint_toggle_bit(struct ps2dev *ps2dev,
> > -				 unsigned char loc, unsigned char mask)
> > +static int trackpoint_toggle_bit(struct ps2dev *ps2dev, u8 loc, u8 mask)
> >  {
> >  	/* Bad things will happen if the loc param isn't in this range */
> >  	if (loc < 0x20 || loc >= 0x2F)
> > @@ -87,11 +91,11 @@ static int trackpoint_toggle_bit(struct ps2dev *ps2dev,
> >  	return 0;
> >  }
> >  
> > -static int trackpoint_update_bit(struct ps2dev *ps2dev, unsigned char loc,
> > -				 unsigned char mask, unsigned char value)
> > +static int trackpoint_update_bit(struct ps2dev *ps2dev,
> > +				 u8 loc, u8 mask, u8 value)
> >  {
> >  	int retval = 0;
> > -	unsigned char data;
> > +	u8 data;
> >  
> >  	trackpoint_read(ps2dev, loc, &data);
> >  	if (((data & mask) == mask) != !!value)
> > @@ -105,17 +109,18 @@ static int trackpoint_update_bit(struct ps2dev *ps2dev, unsigned char loc,
> >   */
> >  struct trackpoint_attr_data {
> >  	size_t field_offset;
> > -	unsigned char command;
> > -	unsigned char mask;
> > -	unsigned char inverted;
> > -	unsigned char power_on_default;
> > +	u8 command;
> > +	u8 mask;
> > +	bool inverted;
> > +	u8 power_on_default;
> >  };
> >  
> > -static ssize_t trackpoint_show_int_attr(struct psmouse *psmouse, void *data, char *buf)
> > +static ssize_t trackpoint_show_int_attr(struct psmouse *psmouse,
> > +					void *data, char *buf)
> >  {
> >  	struct trackpoint_data *tp = psmouse->private;
> >  	struct trackpoint_attr_data *attr = data;
> > -	unsigned char value = *(unsigned char *)((char *)tp + attr->field_offset);
> > +	u8 value = *(u8 *)((void *)tp + attr->field_offset);
> >  
> >  	if (attr->inverted)
> >  		value = !value;
> > @@ -128,8 +133,8 @@ static ssize_t trackpoint_set_int_attr(struct psmouse *psmouse, void *data,
> >  {
> >  	struct trackpoint_data *tp = psmouse->private;
> >  	struct trackpoint_attr_data *attr = data;
> > -	unsigned char *field = (unsigned char *)((char *)tp + attr->field_offset);
> > -	unsigned char value;
> > +	u8 *field = (void *)tp + attr->field_offset;
> > +	u8 value;
> >  	int err;
> >  
> >  	err = kstrtou8(buf, 10, &value);
> > @@ -157,17 +162,14 @@ static ssize_t trackpoint_set_bit_attr(struct psmouse *psmouse, void *data,
> >  {
> >  	struct trackpoint_data *tp = psmouse->private;
> >  	struct trackpoint_attr_data *attr = data;
> > -	unsigned char *field = (unsigned char *)((char *)tp + attr->field_offset);
> > -	unsigned int value;
> > +	bool *field = (void *)tp + attr->field_offset;
> > +	bool value;
> >  	int err;
> >  
> > -	err = kstrtouint(buf, 10, &value);
> > +	err = kstrtobool(buf, &value);
> >  	if (err)
> >  		return err;
> >  
> > -	if (value > 1)
> > -		return -EINVAL;
> > -
> >  	if (attr->inverted)
> >  		value = !value;
> >  
> > @@ -193,30 +195,6 @@ PSMOUSE_DEFINE_ATTR(_name, S_IWUSR | S_IRUGO,				\
> >  		    &trackpoint_attr_##_name,				\
> >  		    trackpoint_show_int_attr, trackpoint_set_bit_attr)
> >  
> > -#define TRACKPOINT_UPDATE_BIT(_psmouse, _tp, _name)			\
> > -do {									\
> > -	struct trackpoint_attr_data *_attr = &trackpoint_attr_##_name;	\
> > -									\
> > -	trackpoint_update_bit(&_psmouse->ps2dev,			\
> > -			_attr->command, _attr->mask, _tp->_name);	\
> > -} while (0)
> > -
> > -#define TRACKPOINT_UPDATE(_power_on, _psmouse, _tp, _name)		\
> > -do {									\
> > -	if (!_power_on ||						\
> > -	    _tp->_name != trackpoint_attr_##_name.power_on_default) {	\
> > -		if (!trackpoint_attr_##_name.mask)			\
> > -			trackpoint_write(&_psmouse->ps2dev,		\
> > -				 trackpoint_attr_##_name.command,	\
> > -				 _tp->_name);				\
> > -		else							\
> > -			TRACKPOINT_UPDATE_BIT(_psmouse, _tp, _name);	\
> > -	}								\
> > -} while (0)
> > -
> > -#define TRACKPOINT_SET_POWER_ON_DEFAULT(_tp, _name)				\
> > -	(_tp->_name = trackpoint_attr_##_name.power_on_default)
> > -
> >  TRACKPOINT_INT_ATTR(sensitivity, TP_SENS, TP_DEF_SENS);
> >  TRACKPOINT_INT_ATTR(speed, TP_SPEED, TP_DEF_SPEED);
> >  TRACKPOINT_INT_ATTR(inertia, TP_INERTIA, TP_DEF_INERTIA);
> > @@ -229,13 +207,33 @@ TRACKPOINT_INT_ATTR(ztime, TP_Z_TIME, TP_DEF_Z_TIME);
> >  TRACKPOINT_INT_ATTR(jenks, TP_JENKS_CURV, TP_DEF_JENKS_CURV);
> >  TRACKPOINT_INT_ATTR(drift_time, TP_DRIFT_TIME, TP_DEF_DRIFT_TIME);
> >  
> > -TRACKPOINT_BIT_ATTR(press_to_select, TP_TOGGLE_PTSON, TP_MASK_PTSON, 0,
> > +TRACKPOINT_BIT_ATTR(press_to_select, TP_TOGGLE_PTSON, TP_MASK_PTSON, false,
> >  		    TP_DEF_PTSON);
> > -TRACKPOINT_BIT_ATTR(skipback, TP_TOGGLE_SKIPBACK, TP_MASK_SKIPBACK, 0,
> > +TRACKPOINT_BIT_ATTR(skipback, TP_TOGGLE_SKIPBACK, TP_MASK_SKIPBACK, false,
> >  		    TP_DEF_SKIPBACK);
> > -TRACKPOINT_BIT_ATTR(ext_dev, TP_TOGGLE_EXT_DEV, TP_MASK_EXT_DEV, 1,
> > +TRACKPOINT_BIT_ATTR(ext_dev, TP_TOGGLE_EXT_DEV, TP_MASK_EXT_DEV, true,
> >  		    TP_DEF_EXT_DEV);
> >  
> > +static bool trackpoint_is_attr_available(struct psmouse *psmouse,
> > +					 struct attribute *attr)
> > +{
> > +	struct trackpoint_data *tp = psmouse->private;
> > +
> > +	return tp->variant_id == TP_VARIANT_IBM ||
> > +		attr == &psmouse_attr_sensitivity.dattr.attr ||
> > +		attr == &psmouse_attr_press_to_select.dattr.attr;
> > +}
> > +
> > +static umode_t trackpoint_is_attr_visible(struct kobject *kobj,
> > +					  struct attribute *attr, int n)
> > +{
> > +	struct device *dev = container_of(kobj, struct device, kobj);
> > +	struct serio *serio = to_serio_port(dev);
> > +	struct psmouse *psmouse = serio_get_drvdata(serio);
> > +
> > +	return trackpoint_is_attr_available(psmouse, attr) ? attr->mode : 0;
> > +}
> > +
> >  static struct attribute *trackpoint_attrs[] = {
> >  	&psmouse_attr_sensitivity.dattr.attr,
> >  	&psmouse_attr_speed.dattr.attr,
> > @@ -255,24 +253,56 @@ static struct attribute *trackpoint_attrs[] = {
> >  };
> >  
> >  static struct attribute_group trackpoint_attr_group = {
> > -	.attrs = trackpoint_attrs,
> > +	.is_visible	= trackpoint_is_attr_visible,
> > +	.attrs		= trackpoint_attrs,
> >  };
> >  
> > -static int trackpoint_start_protocol(struct psmouse *psmouse, unsigned char *firmware_id)
> > -{
> > -	unsigned char param[2] = { 0 };
> > +#define TRACKPOINT_UPDATE(_power_on, _psmouse, _tp, _name)		\
> > +do {									\
> > +	struct trackpoint_attr_data *_attr = &trackpoint_attr_##_name;	\
> > +									\
> > +	if ((!_power_on || _tp->_name != _attr->power_on_default) &&	\
> > +	    trackpoint_is_attr_available(_psmouse,			\
> > +				&psmouse_attr_##_name.dattr.attr)) {	\
> > +		if (!_attr->mask)					\
> > +			trackpoint_write(&_psmouse->ps2dev,		\
> > +					 _attr->command, _tp->_name);	\
> > +		else							\
> > +			trackpoint_update_bit(&_psmouse->ps2dev,	\
> > +					_attr->command, _attr->mask,	\
> > +					_tp->_name);			\
> > +	}								\
> > +} while (0)
> >  
> > -	if (ps2_command(&psmouse->ps2dev, param, MAKE_PS2_CMD(0, 2, TP_READ_ID)))
> > -		return -1;
> > +#define TRACKPOINT_SET_POWER_ON_DEFAULT(_tp, _name)			\
> > +do {									\
> > +	_tp->_name = trackpoint_attr_##_name.power_on_default;		\
> > +} while (0)
> >  
> > -	/* add new TP ID. */
> > -	if (!(param[0] & TP_MAGIC_IDENT))
> > -		return -1;
> > +static int trackpoint_start_protocol(struct psmouse *psmouse,
> > +				     u8 *variant_id, u8 *firmware_id)
> > +{
> > +	u8 param[2] = { 0 };
> > +	int error;
> >  
> > -	if (firmware_id)
> > -		*firmware_id = param[1];
> > +	error = ps2_command(&psmouse->ps2dev,
> > +			    param, MAKE_PS2_CMD(0, 2, TP_READ_ID));
> > +	if (error)
> > +		return error;
> > +
> > +	switch (param[0]) {
> > +	case TP_VARIANT_IBM:
> > +	case TP_VARIANT_ALPS:
> > +	case TP_VARIANT_ELAN:
> > +	case TP_VARIANT_NXP:
> > +		if (variant_id)
> > +			*variant_id = param[0];
> > +		if (firmware_id)
> > +			*firmware_id = param[1];
> > +		break;
> > +	}
> >  
> > -	return 0;
> > +	return -ENODEV;
> 
> always report error .. not good.
> 
> >  }
> >  
> >  /*
> > @@ -285,7 +315,7 @@ static int trackpoint_sync(struct psmouse *psmouse, bool in_power_on_state)
> >  {
> >  	struct trackpoint_data *tp = psmouse->private;
> >  
> > -	if (!in_power_on_state) {
> > +	if (!in_power_on_state && tp->variant_id == TP_VARIANT_IBM) {
> >  		/*
> >  		 * Disable features that may make device unusable
> >  		 * with this driver.
> > @@ -347,7 +377,8 @@ static void trackpoint_defaults(struct trackpoint_data *tp)
> >  
> >  static void trackpoint_disconnect(struct psmouse *psmouse)
> >  {
> > -	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj, &trackpoint_attr_group);
> > +	device_remove_group(&psmouse->ps2dev.serio->dev,
> > +			    &trackpoint_attr_group);
> >  
> >  	kfree(psmouse->private);
> >  	psmouse->private = NULL;
> > @@ -355,14 +386,20 @@ static void trackpoint_disconnect(struct psmouse *psmouse)
> >  
> >  static int trackpoint_reconnect(struct psmouse *psmouse)
> >  {
> > -	int reset_fail;
> > +	struct trackpoint_data *tp = psmouse->private;
> > +	int error;
> > +	bool was_reset;
> >  
> > -	if (trackpoint_start_protocol(psmouse, NULL))
> > -		return -1;
> > +	error = trackpoint_start_protocol(psmouse, NULL, NULL);
> > +	if (error)
> > +		return error;
> >  
> > -	reset_fail = trackpoint_power_on_reset(&psmouse->ps2dev);
> > -	if (trackpoint_sync(psmouse, !reset_fail))
> > -		return -1;
> > +	was_reset = tp->variant_id == TP_VARIANT_IBM &&
> > +		    trackpoint_power_on_reset(&psmouse->ps2dev) == 0;
> > +
> > +	error = trackpoint_sync(psmouse, was_reset);
> > +	if (error)
> > +		return error;
> >  
> >  	return 0;
> >  }
> > @@ -370,46 +407,62 @@ static int trackpoint_reconnect(struct psmouse *psmouse)
> >  int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
> >  {
> >  	struct ps2dev *ps2dev = &psmouse->ps2dev;
> > -	unsigned char firmware_id;
> > -	unsigned char button_info;
> > +	struct trackpoint_data *tp;
> > +	u8 variant_id;
> > +	u8 firmware_id;
> > +	u8 button_info;
> >  	int error;
> >  
> > -	if (trackpoint_start_protocol(psmouse, &firmware_id))
> > -		return -1;
> > +	error = trackpoint_start_protocol(psmouse, &variant_id, &firmware_id);
> > +	if (error)
> > +		return error;
> >  
> >  	if (!set_properties)
> >  		return 0;
> >  
> > -	if (trackpoint_read(ps2dev, TP_EXT_BTN, &button_info)) {
> > -		psmouse_warn(psmouse, "failed to get extended button data, assuming 3 buttons\n");
> > -		button_info = 0x33;
> > -	}
> > -
> > -	psmouse->private = kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);
> > -	if (!psmouse->private)
> > +	tp = kzalloc(sizeof(*tp), GFP_KERNEL);
> > +	if (!tp)
> >  		return -ENOMEM;
> >  
> > -	psmouse->vendor = "IBM";
> > +	trackpoint_defaults(tp);
> > +	tp->variant_id = variant_id;
> > +	tp->firmware_id = firmware_id;
> > +
> > +	psmouse->private = tp;
> > +
> > +	psmouse->vendor = trackpoint_variants[variant_id];
> >  	psmouse->name = "TrackPoint";
> >  
> >  	psmouse->reconnect = trackpoint_reconnect;
> >  	psmouse->disconnect = trackpoint_disconnect;
> >  
> > +	if (variant_id != TP_VARIANT_IBM) {
> > +		/* Newer variants do not support extended button query. */
> > +		button_info = 0x33;
> > +	} else {
> > +		error = trackpoint_read(ps2dev, TP_EXT_BTN, &button_info);
> > +		if (error) {
> > +			psmouse_warn(psmouse,
> > +				     "failed to get extended button data, assuming 3 buttons\n");
> > +			button_info = 0x33;
> > +		}
> > +	}
> > +
> >  	if ((button_info & 0x0f) >= 3)
> > -		__set_bit(BTN_MIDDLE, psmouse->dev->keybit);
> > +		input_set_capability(psmouse->dev, EV_KEY, BTN_MIDDLE);
> >  
> >  	__set_bit(INPUT_PROP_POINTER, psmouse->dev->propbit);
> >  	__set_bit(INPUT_PROP_POINTING_STICK, psmouse->dev->propbit);
> >  
> > -	trackpoint_defaults(psmouse->private);
> > -
> > -	error = trackpoint_power_on_reset(ps2dev);
> > -
> > -	/* Write defaults to TP only if reset fails. */
> > -	if (error)
> > +	if (variant_id != TP_VARIANT_IBM ||
> > +	    trackpoint_power_on_reset(ps2dev) != 0) {
> > +		/*
> > +		 * Write defaults to TP if we did not reset the trackpoint.
> > +		 */
> >  		trackpoint_sync(psmouse, false);
> > +	}
> >  
> > -	error = sysfs_create_group(&ps2dev->serio->dev.kobj, &trackpoint_attr_group);
> > +	error = device_add_group(&ps2dev->serio->dev, &trackpoint_attr_group);
> >  	if (error) {
> >  		psmouse_err(psmouse,
> >  			    "failed to create sysfs attributes, error: %d\n",
> > @@ -420,8 +473,8 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
> >  	}
> >  
> >  	psmouse_info(psmouse,
> > -		     "IBM TrackPoint firmware: 0x%02x, buttons: %d/%d\n",
> > -		     firmware_id,
> > +		     "%s TrackPoint firmware: 0x%02x, buttons: %d/%d\n",
> > +		     psmouse->vendor, firmware_id,
> >  		     (button_info & 0xf0) >> 4, button_info & 0x0f);
> >  
> >  	return 0;
> > diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
> > index 88055755f82e..10a039148234 100644
> > --- a/drivers/input/mouse/trackpoint.h
> > +++ b/drivers/input/mouse/trackpoint.h
> > @@ -21,10 +21,16 @@
> >  #define TP_COMMAND		0xE2	/* Commands start with this */
> >  
> >  #define TP_READ_ID		0xE1	/* Sent for device identification */
> > -#define TP_MAGIC_IDENT		0x03	/* Sent after a TP_READ_ID followed */
> > -					/* by the firmware ID */
> > -					/* Firmware ID includes 0x1, 0x2, 0x3 */
> >  
> > +/*
> > + * Valid first byte responses to the "Read Secondary ID" (0xE1) command.
> > + * 0x01 was the original IBM trackpoint, others implement very limited
> > + * subset of trackpoint features.
> > + */
> > +#define TP_VARIANT_IBM		0x01
> > +#define TP_VARIANT_ALPS		0x02
> > +#define TP_VARIANT_ELAN		0x03
> > +#define TP_VARIANT_NXP		0x04
> >  
> >  /*
> >   * Commands
> > @@ -136,18 +142,20 @@
> >  
> >  #define MAKE_PS2_CMD(params, results, cmd) ((params<<12) | (results<<8) | (cmd))
> >  
> > -struct trackpoint_data
> > -{
> > -	unsigned char sensitivity, speed, inertia, reach;
> > -	unsigned char draghys, mindrag;
> > -	unsigned char thresh, upthresh;
> > -	unsigned char ztime, jenks;
> > -	unsigned char drift_time;
> > +struct trackpoint_data {
> > +	u8 variant_id;
> > +	u8 firmware_id;
> > +
> > +	u8 sensitivity, speed, inertia, reach;
> > +	u8 draghys, mindrag;
> > +	u8 thresh, upthresh;
> > +	u8 ztime, jenks;
> > +	u8 drift_time;
> >  
> >  	/* toggles */
> > -	unsigned char press_to_select;
> > -	unsigned char skipback;
> > -	unsigned char ext_dev;
> > +	bool press_to_select;
> > +	bool skipback;
> > +	bool ext_dev;
> >  };
> >  
> >  #ifdef CONFIG_MOUSE_PS2_TRACKPOINT
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
