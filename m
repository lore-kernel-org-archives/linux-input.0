From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 11/33] docs: input/event-codes: convert it to ReST format
Date: Sun, 2 Apr 2017 11:16:35 +1000
Message-ID: <20170402011635.GC5349@jelly>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <828662d0c5d9fa24a8ccc21f573bf2039a3cb95c.1491069870.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <828662d0c5d9fa24a8ccc21f573bf2039a3cb95c.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

On Sat, Apr 01, 2017 at 03:15:54PM -0300, Mauro Carvalho Chehab wrote:
> This file require minimum adjustments to be a valid ReST file.
> Do it, in order to be able to parse it with Sphinx.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

there's a  conflict markerleft in this file, see below

Cheers,
   Peter

> @@ -195,14 +229,37 @@ Upon resume, if the switch state is the same as before suspend, then the input
>  subsystem will filter out the duplicate switch state reports. The driver does
>  not need to keep the state of the switch at any time.
>  
> +<<<<<<< HEAD:Documentation/input/event-codes.txt
>  EV_MSC:
>  ----------
> +=======
> +A few EV_SW codes have special meanings:
> +
> +* SW_RATCHET:
> +
> +  - Some mouses have a special switch at their wheel that allows to change
> +    from free wheel mode to ratchet mode.
> +
> +    When such switch is ratchet mode (ON state), the wheel will offer some
> +    resistance for movements movement. It will also provide a tactile
> +    feedback when scrolled.
> +
> +    When pressed while in ratchet mode, the wheel will switch to free wheel
> +    mode (OFF state). In this mode, it will offer no resistance to wheel
> +    movements nor any tactile feedback. Pressing again returns to ratchet
> +    mode.
> +
> +EV_MSC
> +------
> +
> +>>>>>>> 0b994c20db5f... docs: input/event-codes: convert it to ReST format:Documentation/input/event-codes.rst
>  EV_MSC events are used for input and output events that do not fall under other
>  categories.
>  
>  A few EV_MSC codes have special meaning:
>  
>  * MSC_TIMESTAMP:
> +
>    - Used to report the number of microseconds since the last reset. This event
>      should be coded as an uint32 value, which is allowed to wrap around with
>      no special consequence. It is assumed that the time difference between two
> @@ -211,39 +268,46 @@ A few EV_MSC codes have special meaning:
>      unknown.  If the device does not provide this information, the driver must
>      not provide it to user space.
>  
> -EV_LED:
> -----------
> +EV_LED
> +------
> +
>  EV_LED events are used for input and output to set and query the state of
>  various LEDs on devices.
>  
> -EV_REP:
> -----------
> +EV_REP
> +------
> +
>  EV_REP events are used for specifying autorepeating events.
>  
> -EV_SND:
> -----------
> +EV_SND
> +------
> +
>  EV_SND events are used for sending sound commands to simple sound output
>  devices.
>  
> -EV_FF:
> -----------
> +EV_FF
> +-----
> +
>  EV_FF events are used to initialize a force feedback capable device and to cause
>  such device to feedback.
>  
> -EV_PWR:
> -----------
> +EV_PWR
> +------
> +
>  EV_PWR events are a special type of event used specifically for power
>  management. Its usage is not well defined. To be addressed later.
>  
> -Device properties:
> +Device properties
>  =================
> +
>  Normally, userspace sets up an input device based on the data it emits,
>  i.e., the event types. In the case of two devices emitting the same event
>  types, additional information can be provided in the form of device
>  properties.
>  
> -INPUT_PROP_DIRECT + INPUT_PROP_POINTER:
> +INPUT_PROP_DIRECT + INPUT_PROP_POINTER
>  --------------------------------------
> +
>  The INPUT_PROP_DIRECT property indicates that device coordinates should be
>  directly mapped to screen coordinates (not taking into account trivial
>  transformations, such as scaling, flipping and rotating). Non-direct input
> @@ -260,8 +324,9 @@ If neither INPUT_PROP_DIRECT or INPUT_PROP_POINTER are set, the property is
>  considered undefined and the device type should be deduced in the
>  traditional way, using emitted event types.
>  
> -INPUT_PROP_BUTTONPAD:
> +INPUT_PROP_BUTTONPAD
>  --------------------
> +
>  For touchpads where the button is placed beneath the surface, such that
>  pressing down on the pad causes a button click, this property should be
>  set. Common in clickpad notebooks and macbooks from 2009 and onwards.
> @@ -270,8 +335,9 @@ Originally, the buttonpad property was coded into the bcm5974 driver
>  version field under the name integrated button. For backwards
>  compatibility, both methods need to be checked in userspace.
>  
> -INPUT_PROP_SEMI_MT:
> +INPUT_PROP_SEMI_MT
>  ------------------
> +
>  Some touchpads, most common between 2008 and 2011, can detect the presence
>  of multiple contacts without resolving the individual positions; only the
>  number of contacts and a rectangular shape is known. For such
> @@ -285,9 +351,10 @@ gestures can normally be extracted from it.
>  If INPUT_PROP_SEMI_MT is not set, the device is assumed to be a true MT
>  device.
>  
> -INPUT_PROP_TOPBUTTONPAD:
> +INPUT_PROP_TOPBUTTONPAD
>  -----------------------
> -Some laptops, most notably the Lenovo *40 series provide a trackstick
> +
> +Some laptops, most notably the Lenovo 40 series provide a trackstick
>  device but do not have physical buttons associated with the trackstick
>  device. Instead, the top area of the touchpad is marked to show
>  visual/haptic areas for left, middle, right buttons intended to be used
> @@ -299,26 +366,30 @@ The kernel does not provide button emulation for such devices but treats
>  them as any other INPUT_PROP_BUTTONPAD device.
>  
>  INPUT_PROP_ACCELEROMETER
> --------------------------
> +------------------------
> +
>  Directional axes on this device (absolute and/or relative x, y, z) represent
>  accelerometer data. All other axes retain their meaning. A device must not mix
>  regular directional axes and accelerometer axes on the same event node.
>  
> -Guidelines:
> +Guidelines
>  ==========
> +
>  The guidelines below ensure proper single-touch and multi-finger functionality.
>  For multi-touch functionality, see the multi-touch-protocol.txt document for
>  more information.
>  
> -Mice:
> -----------
> +Mice
> +----
> +
>  REL_{X,Y} must be reported when the mouse moves. BTN_LEFT must be used to report
>  the primary button press. BTN_{MIDDLE,RIGHT,4,5,etc.} should be used to report
>  further buttons of the device. REL_WHEEL and REL_HWHEEL should be used to report
>  scroll wheel events where available.
>  
> -Touchscreens:
> -----------
> +Touchscreens
> +------------
> +
>  ABS_{X,Y} must be reported with the location of the touch. BTN_TOUCH must be
>  used to report when a touch is active on the screen.
>  BTN_{MOUSE,LEFT,MIDDLE,RIGHT} must not be reported as the result of touch
> @@ -326,8 +397,9 @@ contact. BTN_TOOL_<name> events should be reported where possible.
>  
>  For new hardware, INPUT_PROP_DIRECT should be set.
>  
> -Trackpads:
> -----------
> +Trackpads
> +---------
> +
>  Legacy trackpads that only provide relative position information must report
>  events like mice described above.
>  
> @@ -338,8 +410,9 @@ be used to report the number of touches active on the trackpad.
>  
>  For new hardware, INPUT_PROP_POINTER should be set.
>  
> -Tablets:
> -----------
> +Tablets
> +-------
> +
>  BTN_TOOL_<name> events must be reported when a stylus or other tool is active on
>  the tablet. ABS_{X,Y} must be reported with the location of the tool. BTN_TOUCH
>  should be used to report when the tool is in contact with the tablet.
> -- 
> 2.9.3
> 
> 
