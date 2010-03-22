From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH 2/2] Updated hid_blacklist, reformatted code and removed unused variable
Date: Mon, 22 Mar 2010 16:14:38 +0100
Message-ID: <201003221614.38424.erazor_de@users.sourceforge.net>
References: <1268926981.11269.3.camel@localhost> <1269269304.2236.1.camel@localhost> <alpine.LNX.2.00.1003221552360.18642@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1003221552360.18642@pobox.suse.cz>
Content-Disposition: inline
Sender: linux-doc-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stephane Chatty <chatty@enac.fr>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, wylda@volny.cz, Michael Poole <mdpoole@troilus.org>, simon.windows@gmail.com, Sean Hildebrand <silverwraithii@gmail.com>, Sid Boyce <sboyce@blueyonder.co.uk>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am Montag, 22. M=E4rz 2010 schrieb Jiri Kosina:
> On Mon, 22 Mar 2010, Stefan Achatz wrote:
> > Updated hid_blacklist[] so that generic driver keeps his hands off.
> > Reformatted code so that definition of kone_driver and kone_devices=
[]
> > have one initialization per line and closing brace is on extra line=
=2E
> > Removed an unused variable declaration.
> >
> > Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
> > ---
> >  drivers/hid/hid-core.c        |    1 +
> >  drivers/hid/hid-roccat-kone.c |   15 ++++++++++-----
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 368fbb0..dbd6fb8 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -1346,6 +1346,7 @@ static const struct hid_device_id hid_blackli=
st[] =3D
> > { { HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX,
> > USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) }, {
> > HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_T=
OUCH)
> > }, { HID_USB_DEVICE(USB_VENDOR_ID_QUANTA,
> > USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN) }, +	{
> > HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_KONE) }, =
{
> > HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMO=
TE) },
> > { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROL=
LER)
> > }, { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY,
> > USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
>
> Thanks for the fix. I only wonder how well has the driver been tested=
, as
> without this change it couldn't get to operate the device at all ... =
?
>
> Thanks,

Hi,

As most testing was done with external module compilation on different =
kernel=20
versions with generic hid compiled as internal or as module I have a sc=
ript=20
that uses the drivers sysfs bind/unbind funtionality to switch from gen=
eric=20
hid to kone driver. Thats issued via udev and was active all the time.

Have a nice day,
Stefan
