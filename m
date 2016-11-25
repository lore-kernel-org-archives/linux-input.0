From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] HID: sensor-hub add quirk for Microsoft Surface 3
Date: Fri, 25 Nov 2016 13:59:14 +0100
Message-ID: <20161125125914.GY2119@mail.corp.redhat.com>
References: <1480068224-32224-1-git-send-email-benjamin.tissoires@redhat.com>
 <1480068224-32224-2-git-send-email-benjamin.tissoires@redhat.com>
 <1480076165.16940.21.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1480076165.16940.21.camel-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Nov 25 2016 or thereabouts, Bastien Nocera wrote:
> On Fri, 2016-11-25 at 11:03 +0100, Benjamin Tissoires wrote:
> > One more device requiring a quirk :/
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> Tested-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
> 
> > ---
> >  drivers/hid/hid-sensor-hub.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> > hub.c
> > index 50aad26..f9440b6 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -798,6 +798,9 @@ static const struct hid_device_id
> > sensor_hub_devices[] = {
> >  	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > USB_VENDOR_ID_MICROSOFT,
> >  			USB_DEVICE_ID_MS_TYPE_COVER_2),
> >  			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> > +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > USB_VENDOR_ID_MICROSOFT,
> > +			0x07bd), /* Microsoft Surface 3 TypeCover */
> 
> The sensor is not in the TypeCover though, it's in the main device.

Oops, yes, sorry. I have been traumatised by the type cover apparently
:)

Benjamin

> 
> > +			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> >  	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > USB_VENDOR_ID_STM_0,
> >  			USB_DEVICE_ID_STM_HID_SENSOR),
> >  			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
