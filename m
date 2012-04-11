From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: Elan HID-I2C device driver
Date: Wed, 11 Apr 2012 09:25:19 -0700
Message-ID: <20120411162519.GA27562@core.coreip.homeip.net>
References: <1334061766-20577-1-git-send-email-tom_lin@emc.com.tw>
 <20120411071212.GB6894@core.coreip.homeip.net>
 <4F85583F.6050008@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F85583F.6050008@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?5p6X5b2l5L2R?= <tom_lin@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, djkurtz@chromium.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Wednesday, April 11, 2012 06:09:03 PM =E6=9E=97=E5=BD=A5=E4=BD=91 wr=
ote:
> Hi Daniel
>=20
> On 04/11/2012 03:12 PM, Dmitry Torokhov wrote:
> > Hi Tom,
> >=20
> > On Tue, Apr 10, 2012 at 08:42:46PM +0800, Tom Lin wrote:
> >> This patch adds driver for Elan I2C touchpad. These protocol of HI=
D-I2C
> >> was
> >> defined by Microsoft. The kernel driver would use the multi-touch
> >> protocol
> >> format B.
> >=20
> > If this device truly supports HID protocol shouldn't we define i2c-=
hid
> > transport, similar to usbhid?
>=20
> I merely follow defined by Microsoft.
> It was called "HID OVER I2C" by Microsoft.
> (http://msdn.microsoft.com/en-us/library/windows/hardware/hh825917(v=3D=
vs.85).
> aspx) But I agree to change from hid i2c to i2chid.
> Do you have any better opinions?

I am not sure we are talking about same thing... I do not really care
whether it is named "hid i2c" or "i2chid". What I meant if the device
really speaks HID protocol, except that the transport is not USB or
bluetooth but I2C, then instead of writing a custom driver for this
particular part we need to add a new HID transport into
drivers/hid/i2c-hid that is similar to drivers/hid/usbhid/ and reuse th=
e
rest of HID framework along with hid- multitouch.c which handles
HID-compliant multitouch devices.

I am CCing Jiri (HID maintainer) for additional input.

Thanks.

--=20
Dmitry
