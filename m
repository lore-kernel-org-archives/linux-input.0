From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] devicetree: i2c-hid: Add reset property
Date: Mon, 06 Nov 2017 08:10:51 -0800
Message-ID: <06A94585-C766-46A9-89CB-44597FE70565@gmail.com>
References: <1509418996-25348-1-git-send-email-hl@rock-chips.com> <1509418996-25348-2-git-send-email-hl@rock-chips.com> <20171101220208.gixv6anohp5q4kh2@rob-hp-laptop> <20171106090630.GF9728@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:47568 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753299AbdKFQLA (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Nov 2017 11:11:00 -0500
In-Reply-To: <20171106090630.GF9728@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Rob Herring <robh@kernel.org>
Cc: Lin Huang <hl@rock-chips.com>, jikos@kernel.org, jani.nikula@intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, briannorris@chromium.org, devicetree@vger.kernel.org

On November 6, 2017 1:06:30 AM PST, Benjamin Tissoires <benjamin=2Etissoire=
s@redhat=2Ecom> wrote:
>Hi Rob,
>
>On Nov 01 2017 or thereabouts, Rob Herring wrote:
>> On Tue, Oct 31, 2017 at 11:03:16AM +0800, Lin Huang wrote:
>> > Document a "reset" and "assert-reset-us", it can be used for
>> > driver control reset property=2E And reuse post-power-on-delay-ms
>> > for deassert reset delay=2E
>>=20
>> "dt-bindings: input: " for the subject please=2E
>>=20
>> >=20
>> > Signed-off-by: Lin Huang <hl@rock-chips=2Ecom>
>> > ---
>> >  Documentation/devicetree/bindings/input/hid-over-i2c=2Etxt | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >=20
>> > diff --git
>a/Documentation/devicetree/bindings/input/hid-over-i2c=2Etxt
>b/Documentation/devicetree/bindings/input/hid-over-i2c=2Etxt
>> > index 28e8bd8=2E=2E6ab0eed 100644
>> > --- a/Documentation/devicetree/bindings/input/hid-over-i2c=2Etxt
>> > +++ b/Documentation/devicetree/bindings/input/hid-over-i2c=2Etxt
>> > @@ -31,7 +31,9 @@ device-specific compatible properties, which
>should be used in addition to the
>> > =20
>> >  - vdd-supply: phandle of the regulator that provides the supply
>voltage=2E
>> >  - post-power-on-delay-ms: time required by the device after
>enabling its regulators
>> > -  before it is ready for communication=2E Must be used with
>'vdd-supply'=2E
>> > +  or deassert reset pin before it is ready for communication=2E
>> > +- reset: phandle of the gpio that provides for hid reset pin=2E
>>=20
>> The kernel api takes "reset", but the property is "reset-gpios"=2E
>
>In the same way the generic regulator interface handles vdd-supply, is
>there any generic OF handling of reset lines? As far as I can tell,
>there are 97 references of reset-gpios in my tree, and I wonder if all
>the matching drivers need to rewrite the same code to set the reset
>line
>on power on/off=2E
>
>I am worried because here, 1/2 writes "arbitrary" 0 and 1 to the gpios,
>and nothing prevent a manufacturer to invert the required voltages on
>the reset lines, meaning there will be a need for a new OF property=2E

1and 0 are logical high and low here=2E Gpiod API takes care of converting=
 to the proper polarity=2E


Thanks=2E

--=20
Dmitry
