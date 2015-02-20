From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/7] input: Add keycodes used by Lenovo Carbon X1 2014
Date: Fri, 20 Feb 2015 10:40:00 -0800
Message-ID: <20150220184000.GB20060@dtor-glaptop>
References: <1424443473.22910.17.camel@hadess.net>
 <CAN+gG=HxwAA=f2a-vS6-voCRNQO-2pwnK64qz0L_b6-R2bScvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAN+gG=HxwAA=f2a-vS6-voCRNQO-2pwnK64qz0L_b6-R2bScvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Fri, Feb 20, 2015 at 10:04:04AM -0500, Benjamin Tissoires wrote:
> On Fri, Feb 20, 2015 at 9:44 AM, Bastien Nocera <hadess@hadess.net> wrote:
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  include/uapi/linux/input.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> > index b0a8130..affe40e 100644
> > --- a/include/uapi/linux/input.h
> > +++ b/include/uapi/linux/input.h
> > @@ -740,6 +740,16 @@ struct input_keymap_entry {
> >  #define KEY_BRIGHTNESS_MIN             0x250   /* Set Brightness to Minimum */
> >  #define KEY_BRIGHTNESS_MAX             0x251   /* Set Brightness to Maximum */
> >
> > +#define KEY_CLIPPING_TOOL              0x252   /* Screenshot clipping tool */

Do we have users for this?

> > +#define KEY_CLOUD                      0x253   /* Cloud Settings */

Just no. What is cloud settings? Use KEY_VENDOR if you must for this vendor
"added value" junk they come up on keyboards year after year. It used to be
WWW, not cloud, I bet in 2016 someone will come up with "IoT"-dedicated key.

> > +#define KEY_CAMERA_GESTURES            0x254   /* Toggle Camera gestures */
> > +#define KEY_NEW_TAB                    0x255   /* Open a new tab */
> > +#define KEY_MICUP                      0x256   /* Microphone Up */
> > +#define KEY_MICDOWN                    0x257   /* Microphone Down */
> > +#define KEY_MICCANCEL_MODE             0x258   /* Toggle Microphone cancellation mode */
> > +#define KEY_CAMERA_ZOOM_MODE           0x259   /* Toggle camera zoom mode */
> > +#define KEY_ROTATE_DISPLAY             0x25a   /* Rotate screen by 90 degrees */
> > +
> 
> This one should be acked by Dmitry (in CC)
> 

Some of these (like microphone volume up/down) are generic and reasonable, but
I need to know if there will be any users for these newly defined keys.

Thanks.

-- 
Dmitry
