From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v1 20/31] docs: hid: convert to ReST
Date: Thu, 13 Jun 2019 06:52:33 -0300
Message-ID: <20190613065233.2facb58b@coco.lan>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
        <f21a936a8a7ea5fdbcca16c91ec49265cd258acf.1560364494.git.mchehab+samsung@kernel.org>
        <CAO-hwJKo4GLJu=pfVQe=-aBj5HOng2L4KYDepNwLPSkL9v+EWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJKo4GLJu=pfVQe=-aBj5HOng2L4KYDepNwLPSkL9v+EWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, lkml <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Em Thu, 13 Jun 2019 10:08:34 +0200
Benjamin Tissoires <benjamin.tissoires@redhat.com> escreveu:

> On Wed, Jun 12, 2019 at 8:39 PM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > Rename the HID documentation files to ReST, add an
> > index for them and adjust in order to produce a nice html
> > output via the Sphinx build system.
> >
> > While here, fix the sysfs example from hid-sensor.txt, that
> > has a lot of "?" instead of the proper UTF-8 characters that
> > are produced by the tree command.
> >
> > At its new index.rst, let's add a :orphan: while this is not linked to
> > the main index.rst file, in order to avoid build warnings.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > --- =20
>=20
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>=20
> Do you need to take this patch through the doc tree or should we carry
> it in the HID one?

Each patch in this series is pretty much independent. So, feel
free to apply it via the HID tree.=20

>=20
> Cheers,
> Benjamin
>=20
> >  .../hid/{hid-alps.txt =3D> hid-alps.rst}        |  85 ++-
> >  .../hid/{hid-sensor.txt =3D> hid-sensor.rst}    | 192 +++----
> >  .../{hid-transport.txt =3D> hid-transport.rst}  |  82 ++-
> >  Documentation/hid/{hiddev.txt =3D> hiddev.rst}  | 154 ++++--
> >  Documentation/hid/{hidraw.txt =3D> hidraw.rst}  |  53 +-
> >  Documentation/hid/index.rst                   |  18 +
> >  Documentation/hid/intel-ish-hid.rst           | 485 ++++++++++++++++++
> >  Documentation/hid/intel-ish-hid.txt           | 454 ----------------
> >  Documentation/hid/{uhid.txt =3D> uhid.rst}      |  46 +-
> >  Documentation/input/input.rst                 |   2 +-
> >  MAINTAINERS                                   |   2 +-
> >  11 files changed, 897 insertions(+), 676 deletions(-)
> >  rename Documentation/hid/{hid-alps.txt =3D> hid-alps.rst} (64%)
> >  rename Documentation/hid/{hid-sensor.txt =3D> hid-sensor.rst} (61%)
> >  rename Documentation/hid/{hid-transport.txt =3D> hid-transport.rst} (9=
3%)
> >  rename Documentation/hid/{hiddev.txt =3D> hiddev.rst} (77%)
> >  rename Documentation/hid/{hidraw.txt =3D> hidraw.rst} (89%)
> >  create mode 100644 Documentation/hid/index.rst
> >  create mode 100644 Documentation/hid/intel-ish-hid.rst
> >  delete mode 100644 Documentation/hid/intel-ish-hid.txt
> >  rename Documentation/hid/{uhid.txt =3D> uhid.rst} (94%)
> >
> > diff --git a/Documentation/hid/hid-alps.txt b/Documentation/hid/hid-alp=
s.rst
> > similarity index 64%
> > rename from Documentation/hid/hid-alps.txt
> > rename to Documentation/hid/hid-alps.rst
> > index 6b02a2447c77..e2f4c4c11e3f 100644
> > --- a/Documentation/hid/hid-alps.txt
> > +++ b/Documentation/hid/hid-alps.rst
> > @@ -1,19 +1,26 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >  ALPS HID Touchpad Protocol
> > -----------------------
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >
> >  Introduction
> >  ------------
> >  Currently ALPS HID driver supports U1 Touchpad device.
> >
> > -U1 devuce basic information.
> > +U1 device basic information.
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D
> >  Vender ID      0x044E
> >  Product ID     0x120B
> >  Version ID     0x0121
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D
> >
> >
> >  HID Descriptor
> > -------------
> > +--------------
> > +
> > +=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >  Byte   Field                   Value   Notes
> > +=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >  0      wHIDDescLength          001E    Length of HID Descriptor : 30 b=
ytes
> >  2      bcdVersion              0100    Compliant with Version 1.00
> >  4      wReportDescLength       00B2    Report Descriptor is 178 Bytes =
(0x00B2)
> > @@ -28,32 +35,42 @@ Byte        Field                   Value   Notes
> >  22     wProductID              120B    Product ID 0x120B
> >  24     wVersionID              0121    Version 01.21
> >  26     RESERVED                0000    RESERVED
> > +=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >
> >
> >  Report ID
> > -------------
> > -ReportID-1     (Input Reports) (HIDUsage-Mouse) for TP&SP
> > -ReportID-2     (Input Reports) (HIDUsage-keyboard) for TP
> > -ReportID-3     (Input Reports) (Vendor Usage: Max 10 finger data) for =
TP
> > -ReportID-4     (Input Reports) (Vendor Usage: ON bit data) for GP
> > -ReportID-5     (Feature Reports)       Feature Reports
> > -ReportID-6     (Input Reports) (Vendor Usage: StickPointer data) for SP
> > -ReportID-7     (Feature Reports)       Flash update (Bootloader)
> > +---------
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +ReportID-1     (Input Reports)    (HIDUsage-Mouse) for TP&SP
> > +ReportID-2     (Input Reports)    (HIDUsage-keyboard) for TP
> > +ReportID-3     (Input Reports)    (Vendor Usage: Max 10 finger data) f=
or TP
> > +ReportID-4     (Input Reports)    (Vendor Usage: ON bit data) for GP
> > +ReportID-5     (Feature Reports)  Feature Reports
> > +ReportID-6     (Input Reports)    (Vendor Usage: StickPointer data) fo=
r SP
> > +ReportID-7     (Feature Reports)  Flash update (Bootloader)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> >  Data pattern
> >  ------------
> > +
> > +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D  =
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  Case1  ReportID_1      TP/SP   Relative/Relative
> >  Case2  ReportID_3      TP      Absolute
> >         ReportID_6      SP      Absolute
> > +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D  =
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> >  Command Read/Write
> >  ------------------
> >  To read/write to RAM, need to send a commands to the device.
> > +
> >  The command format is as below.
> >
> >  DataByte(SET_REPORT)
> > +
> > +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >  Byte1  Command Byte
> >  Byte2  Address - Byte 0 (LSB)
> >  Byte3  Address - Byte 1
> > @@ -61,13 +78,19 @@ Byte4       Address - Byte 2
> >  Byte5  Address - Byte 3 (MSB)
> >  Byte6  Value Byte
> >  Byte7  Checksum
> > +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> >  Command Byte is read=3D0xD1/write=3D0xD2 .
> > +
> >  Address is read/write RAM address.
> > +
> >  Value Byte is writing data when you send the write commands.
> > +
> >  When you read RAM, there is no meaning.
> >
> >  DataByte(GET_REPORT)
> > +
> > +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >  Byte1  Response Byte
> >  Byte2  Address - Byte 0 (LSB)
> >  Byte3  Address - Byte 1
> > @@ -75,6 +98,7 @@ Byte4 Address - Byte 2
> >  Byte5  Address - Byte 3 (MSB)
> >  Byte6  Value Byte
> >  Byte7  Checksum
> > +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> >  Read value is stored in Value Byte.
> >
> > @@ -82,7 +106,11 @@ Read value is stored in Value Byte.
> >  Packet Format
> >  Touchpad data byte
> >  ------------------
> > -       b7      b6      b5      b4      b3      b2      b1      b0
> > +
> > +
> > +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D
> > +-      b7      b6      b5      b4      b3      b2      b1      b0
> > +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D
> >  1      0       0       SW6     SW5     SW4     SW3     SW2     SW1
> >  2      0       0       0       Fcv     Fn3     Fn2     Fn1     Fn0
> >  3      Xa0_7   Xa0_6   Xa0_5   Xa0_4   Xa0_3   Xa0_2   Xa0_1   Xa0_0
> > @@ -114,17 +142,25 @@ Touchpad data byte
> >  25     Ya4_7   Ya4_6   Ya4_5   Ya4_4   Ya4_3   Ya4_2   Ya4_1   Ya4_0
> >  26     Ya4_15  Ya4_14  Ya4_13  Ya4_12  Ya4_11  Ya4_10  Ya4_9   Ya4_8
> >  27     LFB4    Zs4_6   Zs4_5   Zs4_4   Zs4_3   Zs4_2   Zs4_1   Zs4_0
> > +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D
> >
> >
> > -SW1-SW6:       SW ON/OFF status
> > -Xan_15-0(16bit):X Absolute data of the "n"th finger
> > -Yan_15-0(16bit):Y Absolute data of the "n"th finger
> > -Zsn_6-0(7bit): Operation area of the "n"th finger
> > +SW1-SW6:
> > +       SW ON/OFF status
> > +Xan_15-0(16bit):
> > +       X Absolute data of the "n"th finger
> > +Yan_15-0(16bit):
> > +       Y Absolute data of the "n"th finger
> > +Zsn_6-0(7bit):
> > +       Operation area of the "n"th finger
> >
> >
> >  StickPointer data byte
> > -------------------
> > -       b7      b6      b5      b4      b3      b2      b1      b0
> > +----------------------
> > +
> > +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D
> > +-      b7      b6      b5      b4      b3      b2      b1      b0
> > +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D
> >  Byte1  1       1       1       0       1       SW3     SW2     SW1
> >  Byte2  X7      X6      X5      X4      X3      X2      X1      X0
> >  Byte3  X15     X14     X13     X12     X11     X10     X9      X8
> > @@ -132,8 +168,13 @@ Byte4      Y7      Y6      Y5      Y4      Y3     =
 Y2      Y1      Y0
> >  Byte5  Y15     Y14     Y13     Y12     Y11     Y10     Y9      Y8
> >  Byte6  Z7      Z6      Z5      Z4      Z3      Z2      Z1      Z0
> >  Byte7  T&P     Z14     Z13     Z12     Z11     Z10     Z9      Z8
> > +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D
> >
> > -SW1-SW3:       SW ON/OFF status
> > -Xn_15-0(16bit):X Absolute data
> > -Yn_15-0(16bit):Y Absolute data
> > -Zn_14-0(15bit):Z
> > +SW1-SW3:
> > +       SW ON/OFF status
> > +Xn_15-0(16bit):
> > +       X Absolute data
> > +Yn_15-0(16bit):
> > +       Y Absolute data
> > +Zn_14-0(15bit):
> > +       Z
> > diff --git a/Documentation/hid/hid-sensor.txt b/Documentation/hid/hid-s=
ensor.rst
> > similarity index 61%
> > rename from Documentation/hid/hid-sensor.txt
> > rename to Documentation/hid/hid-sensor.rst
> > index b287752a31cd..758972e34971 100644
> > --- a/Documentation/hid/hid-sensor.txt
> > +++ b/Documentation/hid/hid-sensor.rst
> > @@ -1,6 +1,6 @@
> > -
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  HID Sensors Framework
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  HID sensor framework provides necessary interfaces to implement sensor=
 drivers,
> >  which are connected to a sensor hub. The sensor hub is a HID device an=
d it provides
> >  a report descriptor conforming to HID 1.12 sensor usage tables.
> > @@ -15,22 +15,22 @@ the drivers themselves."
> >  This specification describes many usage IDs, which describe the type o=
f sensor
> >  and also the individual data fields. Each sensor can have variable num=
ber of
> >  data fields. The length and order is specified in the report descripto=
r. For
> > -example a part of report descriptor can look like:
> > +example a part of report descriptor can look like::
> >
> > -   INPUT(1)[INPUT]
> > - ..
> > -    Field(2)
> > -      Physical(0020.0073)
> > -      Usage(1)
> > -        0020.045f
> > -      Logical Minimum(-32767)
> > -      Logical Maximum(32767)
> > -      Report Size(8)
> > -      Report Count(1)
> > -      Report Offset(16)
> > -      Flags(Variable Absolute)
> > -..
> > -..
> > +     INPUT(1)[INPUT]
> > +   ..
> > +      Field(2)
> > +        Physical(0020.0073)
> > +        Usage(1)
> > +          0020.045f
> > +        Logical Minimum(-32767)
> > +        Logical Maximum(32767)
> > +        Report Size(8)
> > +        Report Count(1)
> > +        Report Offset(16)
> > +        Flags(Variable Absolute)
> > +  ..
> > +  ..
> >
> >  The report is indicating "sensor page (0x20)" contains an acceleromete=
r-3D (0x73).
> >  This accelerometer-3D has some fields. Here for example field 2 is mot=
ion intensity
> > @@ -40,13 +40,14 @@ data will use this format.
> >
> >
> >  Implementation
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  This specification defines many different types of sensors with differ=
ent sets of
> >  data fields. It is difficult to have a common input event to user spac=
e applications,
> >  for different sensors. For example an accelerometer can send X,Y and Z=
 data, whereas
> >  an ambient light sensor can send illumination data.
> >  So the implementation has two parts:
> > +
> >  - Core hid driver
> >  - Individual sensor processing part (sensor drivers)
> >
> > @@ -55,8 +56,11 @@ Core driver
> >  The core driver registers (hid-sensor-hub) registers as a HID driver. =
It parses
> >  report descriptors and identifies all the sensors present. It adds an =
MFD device
> >  with name HID-SENSOR-xxxx (where xxxx is usage id from the specificati=
on).
> > -For example
> > +
> > +For example:
> > +
> >  HID-SENSOR-200073 is registered for an Accelerometer 3D driver.
> > +
> >  So if any driver with this name is inserted, then the probe routine fo=
r that
> >  function will be called. So an accelerometer processing driver can reg=
ister
> >  with this name and will be probed if there is an accelerometer-3D dete=
cted.
> > @@ -66,7 +70,8 @@ drivers to register and get events for that usage id.=
 Also it provides parsing
> >  functions, which get and set each input/feature/output report.
> >
> >  Individual sensor processing part (sensor drivers)
> > ------------
> > +--------------------------------------------------
> > +
> >  The processing driver will use an interface provided by the core drive=
r to parse
> >  the report and get the indexes of the fields and also can get events. =
This driver
> >  can use IIO interface to use the standard ABI defined for a type of se=
nsor.
> > @@ -75,31 +80,34 @@ can use IIO interface to use the standard ABI defin=
ed for a type of sensor.
> >  Core driver Interface
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -Callback structure:
> > -Each processing driver can use this structure to set some callbacks.
> > +Callback structure::
> > +
> > +  Each processing driver can use this structure to set some callbacks.
> >         int (*suspend)(..): Callback when HID suspend is received
> >         int (*resume)(..): Callback when HID resume is received
> >         int (*capture_sample)(..): Capture a sample for one of its data=
 fields
> >         int (*send_event)(..): One complete event is received which can=
 have
> >                                 multiple data fields.
> >
> > -Registration functions:
> > -int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
> > +Registration functions::
> > +
> > +  int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
> >                         u32 usage_id,
> >                         struct hid_sensor_hub_callbacks *usage_callback=
):
> >
> >  Registers callbacks for an usage id. The callback functions are not al=
lowed
> > -to sleep.
> > +to sleep::
> >
> >
> > -int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
> > +  int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
> >                         u32 usage_id):
> >
> >  Removes callbacks for an usage id.
> >
> >
> > -Parsing function:
> > -int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *=
hsdev,
> > +Parsing function::
> > +
> > +  int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device=
 *hsdev,
> >                         u8 type,
> >                         u32 usage_id, u32 attr_usage_id,
> >                         struct hid_sensor_hub_attribute_info *info);
> > @@ -110,26 +118,27 @@ so that fields can be set or get individually.
> >  These indexes avoid searching every time and getting field index to ge=
t or set.
> >
> >
> > -Set Feature report
> > -int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 re=
port_id,
> > +Set Feature report::
> > +
> > +  int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 =
report_id,
> >                         u32 field_index, s32 value);
> >
> >  This interface is used to set a value for a field in feature report. F=
or example
> >  if there is a field report_interval, which is parsed by a call to
> > -sensor_hub_input_get_attribute_info before, then it can directly set t=
hat individual
> > -field.
> > +sensor_hub_input_get_attribute_info before, then it can directly set t=
hat
> > +individual field::
> >
> >
> > -int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 re=
port_id,
> > +  int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 =
report_id,
> >                         u32 field_index, s32 *value);
> >
> >  This interface is used to get a value for a field in input report. For=
 example
> >  if there is a field report_interval, which is parsed by a call to
> > -sensor_hub_input_get_attribute_info before, then it can directly get t=
hat individual
> > -field value.
> > +sensor_hub_input_get_attribute_info before, then it can directly get t=
hat
> > +individual field value::
> >
> >
> > -int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *=
hsdev,
> > +  int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device=
 *hsdev,
> >                         u32 usage_id,
> >                         u32 attr_usage_id, u32 report_id);
> >
> > @@ -143,6 +152,8 @@ registered callback function to process the sample.
> >  ----------
> >
> >  HID Custom and generic Sensors
> > +------------------------------
> > +
> >
> >  HID Sensor specification defines two special sensor usage types. Since=
 they
> >  don't represent a standard sensor, it is not possible to define using =
Linux IIO
> > @@ -158,66 +169,73 @@ keyboard attached/detached or lid open/close.
> >  To allow application to utilize these sensors, here they are exported =
uses sysfs
> >  attribute groups, attributes and misc device interface.
> >
> > -An example of this representation on sysfs:
> > -/sys/devices/pci0000:00/INT33C2:00/i2c-0/i2c-INT33D1:00/0018:8086:09FA=
.0001/HID-SENSOR-2000e1.6.auto$ tree -R
> > -.
> > -????????? enable_sensor
> > -????????? feature-0-200316
> > -??????? ????????? feature-0-200316-maximum
> > -??????? ????????? feature-0-200316-minimum
> > -??????? ????????? feature-0-200316-name
> > -??????? ????????? feature-0-200316-size
> > -??????? ????????? feature-0-200316-unit-expo
> > -??????? ????????? feature-0-200316-units
> > -??????? ????????? feature-0-200316-value
> > -????????? feature-1-200201
> > -??????? ????????? feature-1-200201-maximum
> > -??????? ????????? feature-1-200201-minimum
> > -??????? ????????? feature-1-200201-name
> > -??????? ????????? feature-1-200201-size
> > -??????? ????????? feature-1-200201-unit-expo
> > -??????? ????????? feature-1-200201-units
> > -??????? ????????? feature-1-200201-value
> > -????????? input-0-200201
> > -??????? ????????? input-0-200201-maximum
> > -??????? ????????? input-0-200201-minimum
> > -??????? ????????? input-0-200201-name
> > -??????? ????????? input-0-200201-size
> > -??????? ????????? input-0-200201-unit-expo
> > -??????? ????????? input-0-200201-units
> > -??????? ????????? input-0-200201-value
> > -????????? input-1-200202
> > -??????? ????????? input-1-200202-maximum
> > -??????? ????????? input-1-200202-minimum
> > -??????? ????????? input-1-200202-name
> > -??????? ????????? input-1-200202-size
> > -??????? ????????? input-1-200202-unit-expo
> > -??????? ????????? input-1-200202-units
> > -??????? ????????? input-1-200202-value
> > +An example of this representation on sysfs::
> > +
> > +  /sys/devices/pci0000:00/INT33C2:00/i2c-0/i2c-INT33D1:00/0018:8086:09=
FA.0001/HID-SENSOR-2000e1.6.auto$ tree -R
> > +  .
> > +  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80  enable_sensor
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-0-200316
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-0-200316-maximum
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-0-200316-minimum
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-0-200316-name
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-0-200316-size
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-0-200316-unit-expo
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-0-200316-units
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-0-200316-value
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-1-200201
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-1-200201-maximum
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-1-200201-minimum
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-1-200201-name
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-1-200201-size
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-1-200201-unit-expo
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-1-200201-units
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feat=
ure-1-200201-value
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-0-200201
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-0-200201-maximum
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-0-200201-minimum
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-0-200201-name
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-0-200201-size
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-0-200201-unit-expo
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-0-200201-units
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-0-200201-value
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-1-200202
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-1-200202-maximum
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-1-200202-minimum
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-1-200202-name
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-1-200202-size
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-1-200202-unit-expo
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-1-200202-units
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 inpu=
t-1-200202-value
> >
> >  Here there is a custom sensors with four fields, two feature and two i=
nputs.
> >  Each field is represented by a set of attributes. All fields except th=
e "value"
> >  are read only. The value field is a RW field.
> > -Example
> > -/sys/bus/platform/devices/HID-SENSOR-2000e1.6.auto/feature-0-200316$ g=
rep -r . *
> > -feature-0-200316-maximum:6
> > -feature-0-200316-minimum:0
> > -feature-0-200316-name:property-reporting-state
> > -feature-0-200316-size:1
> > -feature-0-200316-unit-expo:0
> > -feature-0-200316-units:25
> > -feature-0-200316-value:1
> > +
> > +Example::
> > +
> > +  /sys/bus/platform/devices/HID-SENSOR-2000e1.6.auto/feature-0-200316$=
 grep -r . *
> > +  feature-0-200316-maximum:6
> > +  feature-0-200316-minimum:0
> > +  feature-0-200316-name:property-reporting-state
> > +  feature-0-200316-size:1
> > +  feature-0-200316-unit-expo:0
> > +  feature-0-200316-units:25
> > +  feature-0-200316-value:1
> >
> >  How to enable such sensor?
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> >  By default sensor can be power gated. To enable sysfs attribute "enabl=
e" can be
> > -used.
> > -$ echo 1 > enable_sensor
> > +used::
> > +
> > +       $ echo 1 > enable_sensor
> >
> >  Once enabled and powered on, sensor can report value using HID reports.
> > -These reports are pushed using misc device interface in a FIFO order.
> > -/dev$ tree | grep HID-SENSOR-2000e1.6.auto
> > -??????? ????????? 10:53 -> ../HID-SENSOR-2000e1.6.auto
> > -????????? HID-SENSOR-2000e1.6.auto
> > +These reports are pushed using misc device interface in a FIFO order::
> > +
> > +       /dev$ tree | grep HID-SENSOR-2000e1.6.auto
> > +       =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80=
 10:53 -> ../HID-SENSOR-2000e1.6.auto
> > +       =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80  HID-SENSOR-2000e1.6.au=
to
> >
> >  Each reports can be of variable length preceded by a header. This head=
er
> >  consist of a 32 bit usage id, 64 bit time stamp and 32 bit length fiel=
d of raw
> > diff --git a/Documentation/hid/hid-transport.txt b/Documentation/hid/hi=
d-transport.rst
> > similarity index 93%
> > rename from Documentation/hid/hid-transport.txt
> > rename to Documentation/hid/hid-transport.rst
> > index 3dcba9fd4a3a..6f3aaa86ce7b 100644
> > --- a/Documentation/hid/hid-transport.txt
> > +++ b/Documentation/hid/hid-transport.rst
> > @@ -1,5 +1,6 @@
> > -                          HID I/O Transport Drivers
> > -                         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +HID I/O Transport Drivers
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> >  The HID subsystem is independent of the underlying transport driver. I=
nitially,
> >  only USB was supported, but other specifications adopted the HID desig=
n and
> > @@ -16,6 +17,8 @@ transport and device setup/management. HID core is re=
sponsible of
> >  report-parsing, report interpretation and the user-space API. Device s=
pecifics
> >  and quirks are handled by all layers depending on the quirk.
> >
> > +::
> > +
> >   +-----------+  +-----------+            +-----------+  +-----------+
> >   | Device #1 |  | Device #i |            | Device #j |  | Device #k |
> >   +-----------+  +-----------+            +-----------+  +-----------+
> > @@ -42,8 +45,9 @@ and quirks are handled by all layers depending on the=
 quirk.
> >   +----------------+  +-----------+  +------------------+  +-----------=
-------+
> >
> >  Example Drivers:
> > -  I/O: USB, I2C, Bluetooth-l2cap
> > -  Transport: USB-HID, I2C-HID, BT-HIDP
> > +
> > +  - I/O: USB, I2C, Bluetooth-l2cap
> > +  - Transport: USB-HID, I2C-HID, BT-HIDP
> >
> >  Everything below "HID Core" is simplified in this graph as it is only =
of
> >  interest to HID device drivers. Transport drivers do not need to know =
the
> > @@ -183,7 +187,7 @@ Other ctrl-channel requests are supported by USB-HI=
D but are not available
> >  -------------------
> >
> >  Transport drivers normally use the following procedure to register a n=
ew device
> > -with HID core:
> > +with HID core::
> >
> >         struct hid_device *hid;
> >         int ret;
> > @@ -215,7 +219,7 @@ Once hid_add_device() is entered, HID core might us=
e the callbacks provided in
> >  "custom_ll_driver". Note that fields like "country" can be ignored by =
underlying
> >  transport-drivers if not supported.
> >
> > -To unregister a device, use:
> > +To unregister a device, use::
> >
> >         hid_destroy_device(hid);
> >
> > @@ -226,73 +230,110 @@ driver callbacks.
> >  -----------------------------
> >
> >  The available HID callbacks are:
> > - - int (*start) (struct hid_device *hdev)
> > +
> > +   ::
> > +
> > +      int (*start) (struct hid_device *hdev)
> > +
> >     Called from HID device drivers once they want to use the device. Tr=
ansport
> >     drivers can choose to setup their device in this callback. However,=
 normally
> >     devices are already set up before transport drivers register them t=
o HID core
> >     so this is mostly only used by USB-HID.
> >
> > - - void (*stop) (struct hid_device *hdev)
> > +   ::
> > +
> > +      void (*stop) (struct hid_device *hdev)
> > +
> >     Called from HID device drivers once they are done with a device. Tr=
ansport
> >     drivers can free any buffers and deinitialize the device. But note =
that =20
> >     ->start() might be called again if another HID device driver is loa=
ded on the =20
> >     device.
> > +
> >     Transport drivers are free to ignore it and deinitialize devices af=
ter they
> >     destroyed them via hid_destroy_device().
> >
> > - - int (*open) (struct hid_device *hdev)
> > +   ::
> > +
> > +      int (*open) (struct hid_device *hdev)
> > +
> >     Called from HID device drivers once they are interested in data rep=
orts.
> >     Usually, while user-space didn't open any input API/etc., device dr=
ivers are
> >     not interested in device data and transport drivers can put devices=
 asleep.
> >     However, once ->open() is called, transport drivers must be ready f=
or I/O. =20
> >     ->open() calls are nested for each client that opens the HID device=
. =20
> >
> > - - void (*close) (struct hid_device *hdev)
> > +   ::
> > +
> > +      void (*close) (struct hid_device *hdev)
> > +
> >     Called from HID device drivers after ->open() was called but they a=
re no
> >     longer interested in device reports. (Usually if user-space closed =
any input
> >     devices of the driver).
> > +
> >     Transport drivers can put devices asleep and terminate any I/O of a=
ll =20
> >     ->open() calls have been followed by a ->close() call. However, ->s=
tart() may =20
> >     be called again if the device driver is interested in input reports=
 again.
> >
> > - - int (*parse) (struct hid_device *hdev)
> > +   ::
> > +
> > +      int (*parse) (struct hid_device *hdev)
> > +
> >     Called once during device setup after ->start() has been called. Tr=
ansport
> >     drivers must read the HID report-descriptor from the device and tel=
l HID core
> >     about it via hid_parse_report().
> >
> > - - int (*power) (struct hid_device *hdev, int level)
> > +   ::
> > +
> > +      int (*power) (struct hid_device *hdev, int level)
> > +
> >     Called by HID core to give PM hints to transport drivers. Usually t=
his is
> >     analogical to the ->open() and ->close() hints and redundant.
> >
> > - - void (*request) (struct hid_device *hdev, struct hid_report *report,
> > -                    int reqtype)
> > +   ::
> > +
> > +      void (*request) (struct hid_device *hdev, struct hid_report *rep=
ort,
> > +                      int reqtype)
> > +
> >     Send an HID request on the ctrl channel. "report" contains the repo=
rt that
> >     should be sent and "reqtype" the request type. Request-type can be
> >     HID_REQ_SET_REPORT or HID_REQ_GET_REPORT.
> > +
> >     This callback is optional. If not provided, HID core will assemble =
a raw
> >     report following the HID specs and send it via the ->raw_request() =
callback.
> >     The transport driver is free to implement this asynchronously.
> >
> > - - int (*wait) (struct hid_device *hdev)
> > +   ::
> > +
> > +      int (*wait) (struct hid_device *hdev)
> > +
> >     Used by HID core before calling ->request() again. A transport driv=
er can use
> >     it to wait for any pending requests to complete if only one request=
 is
> >     allowed at a time.
> >
> > - - int (*raw_request) (struct hid_device *hdev, unsigned char reportnu=
m,
> > -                       __u8 *buf, size_t count, unsigned char rtype,
> > -                       int reqtype)
> > +   ::
> > +
> > +      int (*raw_request) (struct hid_device *hdev, unsigned char repor=
tnum,
> > +                          __u8 *buf, size_t count, unsigned char rtype,
> > +                          int reqtype)
> > +
> >     Same as ->request() but provides the report as raw buffer. This req=
uest shall
> >     be synchronous. A transport driver must not use ->wait() to complet=
e such
> >     requests. This request is mandatory and hid core will reject the de=
vice if
> >     it is missing.
> >
> > - - int (*output_report) (struct hid_device *hdev, __u8 *buf, size_t le=
n)
> > +   ::
> > +
> > +      int (*output_report) (struct hid_device *hdev, __u8 *buf, size_t=
 len)
> > +
> >     Send raw output report via intr channel. Used by some HID device dr=
ivers
> >     which require high throughput for outgoing requests on the intr cha=
nnel. This
> >     must not cause SET_REPORT calls! This must be implemented as asynch=
ronous
> >     output report on the intr channel!
> >
> > - - int (*idle) (struct hid_device *hdev, int report, int idle, int req=
type)
> > +   ::
> > +
> > +      int (*idle) (struct hid_device *hdev, int report, int idle, int =
reqtype)
> > +
> >     Perform SET/GET_IDLE request. Only used by USB-HID, do not implemen=
t!
> >
> >  2.3) Data Path
> > @@ -314,4 +355,5 @@ transport driver and not passed to hid_input_report=
().
> >  Acknowledgements to SET_REPORT requests are not of interest to HID cor=
e.
> >
> >  ----------------------------------------------------
> > +
> >  Written 2013, David Herrmann <dh.herrmann@gmail.com>
> > diff --git a/Documentation/hid/hiddev.txt b/Documentation/hid/hiddev.rst
> > similarity index 77%
> > rename from Documentation/hid/hiddev.txt
> > rename to Documentation/hid/hiddev.rst
> > index 638448707aa2..209e6ba4e019 100644
> > --- a/Documentation/hid/hiddev.txt
> > +++ b/Documentation/hid/hiddev.rst
> > @@ -1,6 +1,9 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  Care and feeding of your Human Interface Devices
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -INTRODUCTION
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  In addition to the normal input type HID devices, USB also uses the
> >  human interface device protocols for things that are not really human
> > @@ -16,38 +19,40 @@ normalised event interface - see Documentation/inpu=
t/input.rst
> >  * the hiddev interface, which provides fairly raw HID events
> >
> >  The data flow for a HID event produced by a device is something like
> > -the following :
> > +the following::
> >
> >   usb.c ---> hid-core.c  ----> hid-input.c ----> [keyboard/mouse/joysti=
ck/event]
> >                           |
> >                           | =20
> > -                          --> hiddev.c ----> POWER / MONITOR CONTROL =
=20
> > +                          --> hiddev.c ----> POWER / MONITOR CONTROL
> >
> >  In addition, other subsystems (apart from USB) can potentially feed
> >  events into the input subsystem, but these have no effect on the hid
> >  device interface.
> >
> > -USING THE HID DEVICE INTERFACE
> > +Using the HID Device Interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> >  The hiddev interface is a char interface using the normal USB major,
> >  with the minor numbers starting at 96 and finishing at 111. Therefore,
> > -you need the following commands:
> > -mknod /dev/usb/hiddev0 c 180 96
> > -mknod /dev/usb/hiddev1 c 180 97
> > -mknod /dev/usb/hiddev2 c 180 98
> > -mknod /dev/usb/hiddev3 c 180 99
> > -mknod /dev/usb/hiddev4 c 180 100
> > -mknod /dev/usb/hiddev5 c 180 101
> > -mknod /dev/usb/hiddev6 c 180 102
> > -mknod /dev/usb/hiddev7 c 180 103
> > -mknod /dev/usb/hiddev8 c 180 104
> > -mknod /dev/usb/hiddev9 c 180 105
> > -mknod /dev/usb/hiddev10 c 180 106
> > -mknod /dev/usb/hiddev11 c 180 107
> > -mknod /dev/usb/hiddev12 c 180 108
> > -mknod /dev/usb/hiddev13 c 180 109
> > -mknod /dev/usb/hiddev14 c 180 110
> > -mknod /dev/usb/hiddev15 c 180 111
> > +you need the following commands::
> > +
> > +       mknod /dev/usb/hiddev0 c 180 96
> > +       mknod /dev/usb/hiddev1 c 180 97
> > +       mknod /dev/usb/hiddev2 c 180 98
> > +       mknod /dev/usb/hiddev3 c 180 99
> > +       mknod /dev/usb/hiddev4 c 180 100
> > +       mknod /dev/usb/hiddev5 c 180 101
> > +       mknod /dev/usb/hiddev6 c 180 102
> > +       mknod /dev/usb/hiddev7 c 180 103
> > +       mknod /dev/usb/hiddev8 c 180 104
> > +       mknod /dev/usb/hiddev9 c 180 105
> > +       mknod /dev/usb/hiddev10 c 180 106
> > +       mknod /dev/usb/hiddev11 c 180 107
> > +       mknod /dev/usb/hiddev12 c 180 108
> > +       mknod /dev/usb/hiddev13 c 180 109
> > +       mknod /dev/usb/hiddev14 c 180 110
> > +       mknod /dev/usb/hiddev15 c 180 111
> >
> >  So you point your hiddev compliant user-space program at the correct
> >  interface for your device, and it all just works.
> > @@ -56,7 +61,9 @@ Assuming that you have a hiddev compliant user-space =
program, of
> >  course. If you need to write one, read on.
> >
> >
> > -THE HIDDEV API
> > +The HIDDEV API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> >  This description should be read in conjunction with the HID
> >  specification, freely available from http://www.usb.org, and
> >  conveniently linked of http://www.linux-usb.org.
> > @@ -69,12 +76,14 @@ each of which can have one or more "usages".  In th=
e hid-core,
> >  each one of these usages has a single signed 32 bit value.
> >
> >  read():
> > +-------
> > +
> >  This is the event interface.  When the HID device's state changes,
> >  it performs an interrupt transfer containing a report which contains
> >  the changed value.  The hid-core.c module parses the report, and
> >  returns to hiddev.c the individual usages that have changed within
> >  the report.  In its basic mode, the hiddev will make these individual
> > -usage changes available to the reader using a struct hiddev_event:
> > +usage changes available to the reader using a struct hiddev_event::
> >
> >         struct hiddev_event {
> >             unsigned hid;
> > @@ -90,13 +99,19 @@ behavior of the read() function can be modified usi=
ng the HIDIOCSFLAG
> >  ioctl() described below.
> >
> >
> > -ioctl():
> > -This is the control interface. There are a number of controls:
> > +ioctl():
> > +--------
> >
> > -HIDIOCGVERSION - int (read)
> > -Gets the version code out of the hiddev driver.
> > +This is the control interface. There are a number of controls:
> > +
> > +HIDIOCGVERSION
> > +  - int (read)
> > +
> > + Gets the version code out of the hiddev driver.
> > +
> > +HIDIOCAPPLICATION
> > +  - (none)
> >
> > -HIDIOCAPPLICATION - (none)
> >  This ioctl call returns the HID application usage associated with the
> >  hid device. The third argument to ioctl() specifies which application
> >  index to get. This is useful when the device has more than one
> > @@ -104,25 +119,33 @@ application collection. If the index is invalid (=
greater or equal to
> >  the number of application collections this device has) the ioctl
> >  returns -1. You can find out beforehand how many application
> >  collections the device has from the num_applications field from the
> > -hiddev_devinfo structure.
> > +hiddev_devinfo structure.
> > +
> > +HIDIOCGCOLLECTIONINFO
> > +  - struct hiddev_collection_info (read/write)
> >
> > -HIDIOCGCOLLECTIONINFO - struct hiddev_collection_info (read/write)
> >  This returns a superset of the information above, providing not only
> >  application collections, but all the collections the device has.  It
> >  also returns the level the collection lives in the hierarchy.
> > -The user passes in a hiddev_collection_info struct with the index
> > -field set to the index that should be returned.  The ioctl fills in
> > -the other fields.  If the index is larger than the last collection
> > +The user passes in a hiddev_collection_info struct with the index
> > +field set to the index that should be returned.  The ioctl fills in
> > +the other fields.  If the index is larger than the last collection
> >  index, the ioctl returns -1 and sets errno to -EINVAL.
> >
> > -HIDIOCGDEVINFO - struct hiddev_devinfo (read)
> > +HIDIOCGDEVINFO
> > +  - struct hiddev_devinfo (read)
> > +
> >  Gets a hiddev_devinfo structure which describes the device.
> >
> > -HIDIOCGSTRING - struct hiddev_string_descriptor (read/write)
> > +HIDIOCGSTRING
> > +  - struct hiddev_string_descriptor (read/write)
> > +
> >  Gets a string descriptor from the device. The caller must fill in the
> >  "index" field to indicate which descriptor should be returned.
> >
> > -HIDIOCINITREPORT - (none)
> > +HIDIOCINITREPORT
> > +  - (none)
> > +
> >  Instructs the kernel to retrieve all input and feature report values
> >  from the device. At this point, all the usage structures will contain
> >  current values for the device, and will maintain it as the device
> > @@ -130,21 +153,29 @@ changes.  Note that the use of this ioctl is unne=
cessary in general,
> >  since later kernels automatically initialize the reports from the
> >  device at attach time.
> >
> > -HIDIOCGNAME - string (variable length)
> > +HIDIOCGNAME
> > +  - string (variable length)
> > +
> >  Gets the device name
> >
> > -HIDIOCGREPORT - struct hiddev_report_info (write)
> > +HIDIOCGREPORT
> > +  - struct hiddev_report_info (write)
> > +
> >  Instructs the kernel to get a feature or input report from the device,
> >  in order to selectively update the usage structures (in contrast to
> >  INITREPORT).
> >
> > -HIDIOCSREPORT - struct hiddev_report_info (write)
> > +HIDIOCSREPORT
> > +  - struct hiddev_report_info (write)
> > +
> >  Instructs the kernel to send a report to the device. This report can
> >  be filled in by the user through HIDIOCSUSAGE calls (below) to fill in
> >  individual usage values in the report before sending the report in full
> > -to the device.
> > +to the device.
> > +
> > +HIDIOCGREPORTINFO
> > +  - struct hiddev_report_info (read/write)
> >
> > -HIDIOCGREPORTINFO - struct hiddev_report_info (read/write)
> >  Fills in a hiddev_report_info structure for the user. The report is
> >  looked up by type (input, output or feature) and id, so these fields
> >  must be filled in by the user. The ID can be absolute -- the actual
> > @@ -154,52 +185,67 @@ report_id) for the next report after report_id. W=
ithout a-priori
> >  information about report ids, the right way to use this ioctl is to
> >  use the relative IDs above to enumerate the valid IDs. The ioctl
> >  returns non-zero when there is no more next ID. The real report ID is
> > -filled into the returned hiddev_report_info structure.
> > +filled into the returned hiddev_report_info structure.
> > +
> > +HIDIOCGFIELDINFO
> > +  - struct hiddev_field_info (read/write)
> >
> > -HIDIOCGFIELDINFO - struct hiddev_field_info (read/write)
> >  Returns the field information associated with a report in a
> >  hiddev_field_info structure. The user must fill in report_id and
> >  report_type in this structure, as above. The field_index should also
> >  be filled in, which should be a number from 0 and maxfield-1, as
> > -returned from a previous HIDIOCGREPORTINFO call.
> > +returned from a previous HIDIOCGREPORTINFO call.
> > +
> > +HIDIOCGUCODE
> > +  - struct hiddev_usage_ref (read/write)
> >
> > -HIDIOCGUCODE - struct hiddev_usage_ref (read/write)
> >  Returns the usage_code in a hiddev_usage_ref structure, given that
> >  given its report type, report id, field index, and index within the
> >  field have already been filled into the structure.
> >
> > -HIDIOCGUSAGE - struct hiddev_usage_ref (read/write)
> > +HIDIOCGUSAGE
> > +  - struct hiddev_usage_ref (read/write)
> > +
> >  Returns the value of a usage in a hiddev_usage_ref structure. The
> >  usage to be retrieved can be specified as above, or the user can
> >  choose to fill in the report_type field and specify the report_id as
> >  HID_REPORT_ID_UNKNOWN. In this case, the hiddev_usage_ref will be
> >  filled in with the report and field information associated with this
> > -usage if it is found.
> > +usage if it is found.
> > +
> > +HIDIOCSUSAGE
> > +  - struct hiddev_usage_ref (write)
> >
> > -HIDIOCSUSAGE - struct hiddev_usage_ref (write)
> >  Sets the value of a usage in an output report.  The user fills in
> >  the hiddev_usage_ref structure as above, but additionally fills in
> >  the value field.
> >
> > -HIDIOGCOLLECTIONINDEX - struct hiddev_usage_ref (write)
> > +HIDIOGCOLLECTIONINDEX
> > +  - struct hiddev_usage_ref (write)
> > +
> >  Returns the collection index associated with this usage.  This
> >  indicates where in the collection hierarchy this usage sits.
> >
> > -HIDIOCGFLAG - int (read)
> > -HIDIOCSFLAG - int (write)
> > +HIDIOCGFLAG
> > +  - int (read)
> > +HIDIOCSFLAG
> > +  - int (write)
> > +
> >  These operations respectively inspect and replace the mode flags
> >  that influence the read() call above.  The flags are as follows:
> >
> > -    HIDDEV_FLAG_UREF - read() calls will now return
> > +    HIDDEV_FLAG_UREF
> > +      - read() calls will now return
> >          struct hiddev_usage_ref instead of struct hiddev_event.
> >          This is a larger structure, but in situations where the
> >          device has more than one usage in its reports with the
> >          same usage code, this mode serves to resolve such
> >          ambiguity.
> >
> > -    HIDDEV_FLAG_REPORT - This flag can only be used in conjunction
> > +    HIDDEV_FLAG_REPORT
> > +      - This flag can only be used in conjunction
> >          with HIDDEV_FLAG_UREF.  With this flag set, when the device
> >          sends a report, a struct hiddev_usage_ref will be returned
> > -        to read() filled in with the report_type and report_id, but
> > +        to read() filled in with the report_type and report_id, but
> >          with field_index set to FIELD_INDEX_NONE.  This serves as
> >          additional notification when the device has sent a report.
> > diff --git a/Documentation/hid/hidraw.txt b/Documentation/hid/hidraw.rst
> > similarity index 89%
> > rename from Documentation/hid/hidraw.txt
> > rename to Documentation/hid/hidraw.rst
> > index c8436e354f44..4a4a0ba1f362 100644
> > --- a/Documentation/hid/hidraw.txt
> > +++ b/Documentation/hid/hidraw.rst
> > @@ -1,5 +1,6 @@
> > -      HIDRAW - Raw Access to USB and Bluetooth Human Interface Devices
> > -     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +HIDRAW - Raw Access to USB and Bluetooth Human Interface Devices
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  The hidraw driver provides a raw interface to USB and Bluetooth Human
> >  Interface Devices (HIDs).  It differs from hiddev in that reports sent=
 and
> > @@ -31,6 +32,7 @@ directly under /dev (eg: /dev/hidraw0).  As this loca=
tion is distribution-
> >  and udev rule-dependent, applications should use libudev to locate hid=
raw
> >  devices attached to the system.  There is a tutorial on libudev with a
> >  working example at:
> > +
> >         http://www.signal11.us/oss/udev/
> >
> >  The HIDRAW API
> > @@ -51,7 +53,7 @@ byte.  For devices which do not use numbered reports,=
 the report data
> >  will begin at the first byte.
> >
> >  write()
> > ---------
> > +-------
> >  The write() function will write a report to the device. For USB device=
s, if
> >  the device has an INTERRUPT OUT endpoint, the report will be sent on t=
hat
> >  endpoint. If it does not, the report will be sent over the control end=
point,
> > @@ -62,38 +64,52 @@ number.  If the device does not use numbered report=
s, the first byte should
> >  be set to 0. The report data itself should begin at the second byte.
> >
> >  ioctl()
> > ---------
> > +-------
> >  Hidraw supports the following ioctls:
> >
> > -HIDIOCGRDESCSIZE: Get Report Descriptor Size
> > +HIDIOCGRDESCSIZE:
> > +       Get Report Descriptor Size
> > +
> >  This ioctl will get the size of the device's report descriptor.
> >
> > -HIDIOCGRDESC: Get Report Descriptor
> > +HIDIOCGRDESC:
> > +       Get Report Descriptor
> > +
> >  This ioctl returns the device's report descriptor using a
> >  hidraw_report_descriptor struct.  Make sure to set the size field of t=
he
> >  hidraw_report_descriptor struct to the size returned from HIDIOCGRDESC=
SIZE.
> >
> > -HIDIOCGRAWINFO: Get Raw Info
> > +HIDIOCGRAWINFO:
> > +       Get Raw Info
> > +
> >  This ioctl will return a hidraw_devinfo struct containing the bus type=
, the
> >  vendor ID (VID), and product ID (PID) of the device. The bus type can =
be one
> > -of:
> > -       BUS_USB
> > -       BUS_HIL
> > -       BUS_BLUETOOTH
> > -       BUS_VIRTUAL
> > +of::
> > +
> > +       - BUS_USB
> > +       - BUS_HIL
> > +       - BUS_BLUETOOTH
> > +       - BUS_VIRTUAL
> > +
> >  which are defined in uapi/linux/input.h.
> >
> > -HIDIOCGRAWNAME(len): Get Raw Name
> > +HIDIOCGRAWNAME(len):
> > +       Get Raw Name
> > +
> >  This ioctl returns a string containing the vendor and product strings =
of
> >  the device.  The returned string is Unicode, UTF-8 encoded.
> >
> > -HIDIOCGRAWPHYS(len): Get Physical Address
> > +HIDIOCGRAWPHYS(len):
> > +       Get Physical Address
> > +
> >  This ioctl returns a string representing the physical address of the d=
evice.
> >  For USB devices, the string contains the physical path to the device (=
the
> >  USB controller, hubs, ports, etc).  For Bluetooth devices, the string
> >  contains the hardware (MAC) address of the device.
> >
> > -HIDIOCSFEATURE(len): Send a Feature Report
> > +HIDIOCSFEATURE(len):
> > +       Send a Feature Report
> > +
> >  This ioctl will send a feature report to the device.  Per the HID
> >  specification, feature reports are always sent using the control endpo=
int.
> >  Set the first byte of the supplied buffer to the report number.  For d=
evices
> > @@ -101,7 +117,9 @@ which do not use numbered reports, set the first by=
te to 0. The report data
> >  begins in the second byte. Make sure to set len accordingly, to one mo=
re
> >  than the length of the report (to account for the report number).
> >
> > -HIDIOCGFEATURE(len): Get a Feature Report
> > +HIDIOCGFEATURE(len):
> > +       Get a Feature Report
> > +
> >  This ioctl will request a feature report from the device using the con=
trol
> >  endpoint.  The first byte of the supplied buffer should be set to the =
report
> >  number of the requested report.  For devices which do not use numbered
> > @@ -109,11 +127,12 @@ reports, set the first byte to 0.  The report wil=
l be returned starting at
> >  the first byte of the buffer (ie: the report number is not returned).
> >
> >  Example
> > ----------
> > +-------
> >  In samples/, find hid-example.c, which shows examples of read(), write=
(),
> >  and all the ioctls for hidraw.  The code may be used by anyone for any
> >  purpose, and can serve as a starting point for developing applications=
 using
> >  hidraw.
> >
> >  Document by:
> > +
> >         Alan Ott <alan@signal11.us>, Signal 11 Software
> > diff --git a/Documentation/hid/index.rst b/Documentation/hid/index.rst
> > new file mode 100644
> > index 000000000000..af4324902622
> > --- /dev/null
> > +++ b/Documentation/hid/index.rst
> > @@ -0,0 +1,18 @@
> > +:orphan:
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +Human Interface Devices (HID)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   hiddev
> > +   hidraw
> > +   hid-sensor
> > +   hid-transport
> > +
> > +   uhid
> > +
> > +   hid-alps
> > +   intel-ish-hid
> > diff --git a/Documentation/hid/intel-ish-hid.rst b/Documentation/hid/in=
tel-ish-hid.rst
> > new file mode 100644
> > index 000000000000..cccbf4be17d7
> > --- /dev/null
> > +++ b/Documentation/hid/intel-ish-hid.rst
> > @@ -0,0 +1,485 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Intel Integrated Sensor Hub (ISH)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +A sensor hub enables the ability to offload sensor polling and algorit=
hm
> > +processing to a dedicated low power co-processor. This allows the core
> > +processor to go into low power modes more often, resulting in the incr=
eased
> > +battery life.
> > +
> > +There are many vendors providing external sensor hubs confirming to HID
> > +Sensor usage tables, and used in several tablets, 2 in 1 convertible l=
aptops
> > +and embedded products. Linux had this support since Linux 3.9.
> > +
> > +Intel=C2=AE introduced integrated sensor hubs as a part of the SoC sta=
rting from
> > +Cherry Trail and now supported on multiple generations of CPU packages=
. There
> > +are many commercial devices already shipped with Integrated Sensor Hub=
s (ISH).
> > +These ISH also comply to HID sensor specification, but the  difference=
 is the
> > +transport protocol used for communication. The current external sensor=
 hubs
> > +mainly use HID over i2C or USB. But ISH doesn't use either i2c or USB.
> > +
> > +1. Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Using a analogy with a usbhid implementation, the ISH follows a simila=
r model
> > +for a very high speed communication::
> > +
> > +       -----------------               ----------------------
> > +       |    USB HID    |       -->     |    ISH HID         |
> > +       -----------------               ----------------------
> > +       -----------------               ----------------------
> > +       |  USB protocol |       -->     |    ISH Transport   |
> > +       -----------------               ----------------------
> > +       -----------------               ----------------------
> > +       |  EHCI/XHCI    |       -->     |    ISH IPC         |
> > +       -----------------               ----------------------
> > +             PCI                                PCI
> > +       -----------------               ----------------------
> > +        |Host controller|      -->     |    ISH processor   |
> > +       -----------------               ----------------------
> > +            USB Link
> > +       -----------------               ----------------------
> > +       | USB End points|       -->     |    ISH Clients     |
> > +       -----------------               ----------------------
> > +
> > +Like USB protocol provides a method for device enumeration, link manag=
ement
> > +and user data encapsulation, the ISH also provides similar services. B=
ut it is
> > +very light weight tailored to manage and communicate with ISH client
> > +applications implemented in the firmware.
> > +
> > +The ISH allows multiple sensor management applications executing in the
> > +firmware. Like USB endpoints the messaging can be to/from a client. As=
 part of
> > +enumeration process, these clients are identified. These clients can b=
e simple
> > +HID sensor applications, sensor calibration application or senor firmw=
are
> > +update application.
> > +
> > +The implementation model is similar, like USB bus, ISH transport is al=
so
> > +implemented as a bus. Each client application executing in the ISH pro=
cessor
> > +is registered as a device on this bus. The driver, which binds each de=
vice
> > +(ISH HID driver) identifies the device type and registers with the hid=
 core.
> > +
> > +2. ISH Implementation: Block Diagram
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +::
> > +
> > +        ---------------------------
> > +       |  User Space Applications  |
> > +        ---------------------------
> > +
> > +  ----------------IIO ABI----------------
> > +        --------------------------
> > +       |  IIO Sensor Drivers     |
> > +        --------------------------
> > +        --------------------------
> > +       |        IIO core         |
> > +        --------------------------
> > +        --------------------------
> > +       |   HID Sensor Hub MFD    |
> > +        --------------------------
> > +        --------------------------
> > +       |       HID Core          |
> > +        --------------------------
> > +        --------------------------
> > +       |   HID over ISH Client   |
> > +        --------------------------
> > +        --------------------------
> > +       |   ISH Transport (ISHTP) |
> > +        --------------------------
> > +        --------------------------
> > +       |      IPC Drivers        |
> > +        --------------------------
> > +  OS
> > +  ---------------- PCI -----------------
> > +  Hardware + Firmware
> > +        ----------------------------
> > +       | ISH Hardware/Firmware(FW) |
> > +        ----------------------------
> > +
> > +3. High level processing in above blocks
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +3.1 Hardware Interface
> > +----------------------
> > +
> > +The ISH is exposed as "Non-VGA unclassified PCI device" to the host. T=
he PCI
> > +product and vendor IDs are changed from different generations of proce=
ssors. So
> > +the source code which enumerate drivers needs to update from generatio=
n to
> > +generation.
> > +
> > +3.2 Inter Processor Communication (IPC) driver
> > +----------------------------------------------
> > +
> > +Location: drivers/hid/intel-ish-hid/ipc
> > +
> > +The IPC message used memory mapped I/O. The registers are defined in
> > +hw-ish-regs.h.
> > +
> > +3.2.1 IPC/FW message types
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +There are two types of messages, one for management of link and other =
messages
> > +are to and from transport layers.
> > +
> > +TX and RX of Transport messages
> > +...............................
> > +
> > +A set of memory mapped register offers support of multi byte messages =
TX and
> > +RX (E.g.IPC_REG_ISH2HOST_MSG, IPC_REG_HOST2ISH_MSG). The IPC layer mai=
ntains
> > +internal queues to sequence messages and send them in order to the FW.
> > +Optionally the caller can register handler to get notification of comp=
letion.
> > +A door bell mechanism is used in messaging to trigger processing in ho=
st and
> > +client firmware side. When ISH interrupt handler is called, the ISH2HO=
ST
> > +doorbell register is used by host drivers to determine that the interr=
upt
> > +is for ISH.
> > +
> > +Each side has 32 32-bit message registers and a 32-bit doorbell. Doorb=
ell
> > +register has the following format:
> > +Bits 0..6: fragment length (7 bits are used)
> > +Bits 10..13: encapsulated protocol
> > +Bits 16..19: management command (for IPC management protocol)
> > +Bit 31: doorbell trigger (signal H/W interrupt to the other side)
> > +Other bits are reserved, should be 0.
> > +
> > +3.2.2 Transport layer interface
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +To abstract HW level IPC communication, a set of callbacks are registe=
red.
> > +The transport layer uses them to send and receive messages.
> > +Refer to  struct ishtp_hw_ops for callbacks.
> > +
> > +3.3 ISH Transport layer
> > +-----------------------
> > +
> > +Location: drivers/hid/intel-ish-hid/ishtp/
> > +
> > +3.3.1 A Generic Transport Layer
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +The transport layer is a bi-directional protocol, which defines:
> > +- Set of commands to start, stop, connect, disconnect and flow control
> > +(ishtp/hbm.h) for details
> > +- A flow control mechanism to avoid buffer overflows
> > +
> > +This protocol resembles bus messages described in the following docume=
nt:
> > +http://www.intel.com/content/dam/www/public/us/en/documents/technical-\
> > +specifications/dcmi-hi-1-0-spec.pdf "Chapter 7: Bus Message Layer"
> > +
> > +3.3.2 Connection and Flow Control Mechanism
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Each FW client and a protocol is identified by an UUID. In order to co=
mmunicate
> > +to a FW client, a connection must be established using connect request=
 and
> > +response bus messages. If successful, a pair (host_client_id and fw_cl=
ient_id)
> > +will identify the connection.
> > +
> > +Once connection is established, peers send each other flow control bus=
 messages
> > +independently. Every peer may send a message only if it has received a
> > +flow-control credit before. Once it sent a message, it may not send an=
other one
> > +before receiving the next flow control credit.
> > +Either side can send disconnect request bus message to end communicati=
on. Also
> > +the link will be dropped if major FW reset occurs.
> > +
> > +3.3.3 Peer to Peer data transfer
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Peer to Peer data transfer can happen with or without using DMA. Depen=
ding on
> > +the sensor bandwidth requirement DMA can be enabled by using module pa=
rameter
> > +ishtp_use_dma under intel_ishtp.
> > +
> > +Each side (host and FW) manages its DMA transfer memory independently.=
 When an
> > +ISHTP client from either host or FW side wants to send something, it d=
ecides
> > +whether to send over IPC or over DMA; for each transfer the decision is
> > +independent. The sending side sends DMA_XFER message when the message =
is in
> > +the respective host buffer (TX when host client sends, RX when FW clie=
nt
> > +sends). The recipient of DMA message responds with DMA_XFER_ACK, indic=
ating
> > +the sender that the memory region for that message may be reused.
> > +
> > +DMA initialization is started with host sending DMA_ALLOC_NOTIFY bus m=
essage
> > +(that includes RX buffer) and FW responds with DMA_ALLOC_NOTIFY_ACK.
> > +Additionally to DMA address communication, this sequence checks capabi=
lities:
> > +if thw host doesn't support DMA, then it won't send DMA allocation, so=
 FW can't
> > +send DMA; if FW doesn't support DMA then it won't respond with
> > +DMA_ALLOC_NOTIFY_ACK, in which case host will not use DMA transfers.
> > +Here ISH acts as busmaster DMA controller. Hence when host sends DMA_X=
FER,
> > +it's request to do host->ISH DMA transfer; when FW sends DMA_XFER, it =
means
> > +that it already did DMA and the message resides at host. Thus, DMA_XFER
> > +and DMA_XFER_ACK act as ownership indicators.
> > +
> > +At initial state all outgoing memory belongs to the sender (TX to host=
, RX to
> > +FW), DMA_XFER transfers ownership on the region that contains ISHTP me=
ssage to
> > +the receiving side, DMA_XFER_ACK returns ownership to the sender. A se=
nder
> > +needs not wait for previous DMA_XFER to be ack'ed, and may send anothe=
r message
> > +as long as remaining continuous memory in its ownership is enough.
> > +In principle, multiple DMA_XFER and DMA_XFER_ACK messages may be sent =
at once
> > +(up to IPC MTU), thus allowing for interrupt throttling.
> > +Currently, ISH FW decides to send over DMA if ISHTP message is more th=
an 3 IPC
> > +fragments and via IPC otherwise.
> > +
> > +3.3.4 Ring Buffers
> > +^^^^^^^^^^^^^^^^^^
> > +
> > +When a client initiate a connection, a ring or RX and TX buffers are a=
llocated.
> > +The size of ring can be specified by the client. HID client set 16 and=
 32 for
> > +TX and RX buffers respectively. On send request from client, the data =
to be
> > +sent is copied to one of the send ring buffer and scheduled to be sent=
 using
> > +bus message protocol. These buffers are required because the FW may ha=
ve not
> > +have processed the last message and may not have enough flow control c=
redits
> > +to send. Same thing holds true on receive side and flow control is req=
uired.
> > +
> > +3.3.5 Host Enumeration
> > +^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +The host enumeration bus command allow discovery of clients present in=
 the FW.
> > +There can be multiple sensor clients and clients for calibration funct=
ion.
> > +
> > +To ease in implantation and allow independent driver handle each client
> > +this transport layer takes advantage of Linux Bus driver model. Each
> > +client is registered as device on the the transport bus (ishtp bus).
> > +
> > +Enumeration sequence of messages:
> > +
> > +- Host sends HOST_START_REQ_CMD, indicating that host ISHTP layer is u=
p.
> > +- FW responds with HOST_START_RES_CMD
> > +- Host sends HOST_ENUM_REQ_CMD (enumerate FW clients)
> > +- FW responds with HOST_ENUM_RES_CMD that includes bitmap of available=
 FW
> > +  client IDs
> > +- For each FW ID found in that bitmap host sends
> > +  HOST_CLIENT_PROPERTIES_REQ_CMD
> > +- FW responds with HOST_CLIENT_PROPERTIES_RES_CMD. Properties include =
UUID,
> > +  max ISHTP message size, etc.
> > +- Once host received properties for that last discovered client, it co=
nsiders
> > +  ISHTP device fully functional (and allocates DMA buffers)
> > +
> > +3.4 HID over ISH Client
> > +-----------------------
> > +
> > +Location: drivers/hid/intel-ish-hid
> > +
> > +The ISHTP client driver is responsible for:
> > +
> > +- enumerate HID devices under FW ISH client
> > +- Get Report descriptor
> > +- Register with HID core as a LL driver
> > +- Process Get/Set feature request
> > +- Get input reports
> > +
> > +3.5 HID Sensor Hub MFD and IIO sensor drivers
> > +---------------------------------------------
> > +
> > +The functionality in these drivers is the same as an external sensor h=
ub.
> > +Refer to
> > +Documentation/hid/hid-sensor.rst for HID sensor
> > +Documentation/ABI/testing/sysfs-bus-iio for IIO ABIs to user space
> > +
> > +3.6 End to End HID transport Sequence Diagram
> > +---------------------------------------------
> > +
> > +::
> > +
> > +  HID-ISH-CLN                    ISHTP                    IPC         =
                    HW
> > +          |                        |                       |          =
                     |
> > +          |                        |                       |-----WAKE =
UP------------------>|
> > +          |                        |                       |          =
                     |
> > +          |                        |                       |-----HOST =
READY--------------->|
> > +          |                        |                       |          =
                     |
> > +          |                        |                       |<----MNG_R=
ESET_NOTIFY_ACK----- |
> > +          |                        |                       |          =
                     |
> > +          |                        |<----ISHTP_START------ |          =
                     |
> > +          |                        |                       |          =
                     |
> > +          |                        |<-----------------HOST_START_RES_C=
MD-------------------|
> > +          |                        |                       |          =
                     |
> > +          |                        |------------------QUERY_SUBSCRIBER=
-------------------->|
> > +          |                        |                       |          =
                     |
> > +          |                        |------------------HOST_ENUM_REQ_CM=
D------------------->|
> > +          |                        |                       |          =
                     |
> > +          |                        |<-----------------HOST_ENUM_RES_CM=
D--------------------|
> > +          |                        |                       |          =
                     |
> > +          |                        |------------------HOST_CLIENT_PROP=
ERTIES_REQ_CMD------>|
> > +          |                        |                       |          =
                     |
> > +          |                        |<-----------------HOST_CLIENT_PROP=
ERTIES_RES_CMD-------|
> > +          |       Create new device on in ishtp bus        |          =
                     |
> > +          |                        |                       |          =
                     |
> > +          |                        |------------------HOST_CLIENT_PROP=
ERTIES_REQ_CMD------>|
> > +          |                        |                       |          =
                     |
> > +          |                        |<-----------------HOST_CLIENT_PROP=
ERTIES_RES_CMD-------|
> > +          |       Create new device on in ishtp bus        |          =
                     |
> > +          |                        |                       |          =
                     |
> > +          |                        |--Repeat HOST_CLIENT_PROPERTIES_RE=
Q_CMD-till last one--|
> > +          |                        |                       |          =
                     |
> > +       probed()
> > +          |----ishtp_cl_connect--->|----------------- CLIENT_CONNECT_R=
EQ_CMD-------------->|
> > +          |                        |                       |          =
                     |
> > +          |                        |<----------------CLIENT_CONNECT_RE=
S_CMD----------------|
> > +          |                        |                       |          =
                     |
> > +          |register event callback |                       |          =
                     |
> > +          |                        |                       |          =
                     |
> > +          |ishtp_cl_send(
> > +          HOSTIF_DM_ENUM_DEVICES)  |----------fill ishtp_msg_hdr struc=
t write to HW-----  >|
> > +          |                        |                       |          =
                     |
> > +          |                        |                       |<-----IRQ(=
IPC_PROTOCOL_ISHTP---|
> > +          |                        |                       |          =
                     |
> > +          |<--ENUM_DEVICE RSP------|                       |          =
                     |
> > +          |                        |                       |          =
                     |
> > +  for each enumerated device
> > +          |ishtp_cl_send(
> > +          HOSTIF_GET_HID_DESCRIPTOR|----------fill ishtp_msg_hdr struc=
t write to HW-----  >|
> > +          |                        |                       |          =
                     |
> > +          ...Response
> > +          |                        |                       |          =
                     |
> > +  for each enumerated device
> > +          |ishtp_cl_send(
> > +       HOSTIF_GET_REPORT_DESCRIPTOR|--------------fill ishtp_msg_hdr s=
truct write to HW-- >|
> > +          |                        |                       |          =
                     |
> > +          |                        |                       |          =
                     |
> > +   hid_allocate_device
> > +          |                        |                       |          =
                     |
> > +   hid_add_device                  |                       |          =
                     |
> > +          |                        |                       |          =
                     |
> > +
> > +
> > +3.7 ISH Debugging
> > +-----------------
> > +
> > +To debug ISH, event tracing mechanism is used. To enable debug logs
> > +echo 1 > /sys/kernel/debug/tracing/events/intel_ish/enable
> > +cat sys/kernel/debug/tracing/trace
> > +
> > +3.8 ISH IIO sysfs Example on Lenovo thinkpad Yoga 260
> > +-----------------------------------------------------
> > +
> > +::
> > +
> > +  root@otcpl-ThinkPad-Yoga-260:~# tree -l /sys/bus/iio/devices/
> > +  /sys/bus/iio/devices/
> > +  =E2=94=9C=E2=94=80=E2=94=80 iio:device0 -> ../../../devices/0044:808=
6:22D8.0001/HID-SENSOR-200073.9.auto/iio:device0
> > +  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 buffer
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 enable
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 length
> > +  =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 watermark
> > +  ...
> > +  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_hysteresis
> > +  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_offset
> > +  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_sampling_frequency
> > +  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_scale
> > +  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_raw
> > +  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_raw
> > +  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_z_raw
> > +  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 name
> > +  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 scan_elements
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_en
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_index
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_type
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_en
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_index
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_type
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_z_en
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_z_index
> > +  =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 in_accel_z_type
> > +  ...
> > +  =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 devices
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 buffer
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 enable
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 length
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=94=E2=94=80=E2=94=80 watermark
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 dev
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_intensity_both_raw
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_intensity_hysteresis
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_intensity_offset
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_intensity_sampling_frequency
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_intensity_scale
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 name
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 scan_elements
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_intensity_both_en
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_intensity_both_index
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=94=E2=94=80=E2=94=80 in_intensity_both_type
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 trigger
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=94=E2=94=80=E2=94=80 current_trigger
> > +  ...
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 buffer
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 enable
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 length
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=94=E2=94=80=E2=94=80 watermark
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 dev
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_magn_hysteresis
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_magn_offset
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_magn_sampling_frequency
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_magn_scale
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_magn_x_raw
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_magn_y_raw
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_magn_z_raw
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_rot_from_north_magnetic_tilt_comp_raw
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_rot_hysteresis
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_rot_offset
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_rot_sampling_frequency
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_rot_scale
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 name
> > +  ...
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 scan_elements
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_magn_x_en
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_magn_x_index
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_magn_x_type
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_magn_y_en
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_magn_y_index
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_magn_y_type
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_magn_z_en
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_magn_z_index
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_magn_z_type
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_rot_from_north_magnetic_tilt_comp_en
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_rot_from_north_magnetic_tilt_comp_index
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=94=E2=94=80=E2=94=80 in_rot_from_north_magnetic_tilt_comp_type
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 trigger
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=94=E2=94=80=E2=94=80 current_trigger
> > +  ...
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 buffer
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 enable
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 length
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=94=E2=94=80=E2=94=80 watermark
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 dev
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_hysteresis
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_offset
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_sampling_frequency
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_scale
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_x_raw
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_y_raw
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_z_raw
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 name
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 scan_elements
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_x_en
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_x_index
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_x_type
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_y_en
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_y_index
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_y_type
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_z_en
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_z_index
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=94=E2=94=80=E2=94=80 in_anglvel_z_type
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 trigger
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=94=E2=94=80=E2=94=80 current_trigger
> > +  ...
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 buffer
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 enable
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 length
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=94=E2=94=80=E2=94=80 watermark
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 dev
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_hysteresis
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_offset
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_sampling_frequency
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_scale
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_x_raw
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_y_raw
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 in_anglvel_z_raw
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 name
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 scan_elements
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_x_en
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_x_index
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_x_type
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_y_en
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_y_index
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_y_type
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_z_en
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=9C=E2=94=80=E2=94=80 in_anglvel_z_index
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=94=E2=94=80=E2=94=80 in_anglvel_z_type
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=
=E2=94=80 trigger
> > +  =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=
=94=E2=94=80=E2=94=80 current_trigger
> > +  ...
> > diff --git a/Documentation/hid/intel-ish-hid.txt b/Documentation/hid/in=
tel-ish-hid.txt
> > deleted file mode 100644
> > index d48b21c71ddd..000000000000
> > --- a/Documentation/hid/intel-ish-hid.txt
> > +++ /dev/null
> > @@ -1,454 +0,0 @@
> > -Intel Integrated Sensor Hub (ISH)
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -A sensor hub enables the ability to offload sensor polling and algorit=
hm
> > -processing to a dedicated low power co-processor. This allows the core
> > -processor to go into low power modes more often, resulting in the incr=
eased
> > -battery life.
> > -
> > -There are many vendors providing external sensor hubs confirming to HID
> > -Sensor usage tables, and used in several tablets, 2 in 1 convertible l=
aptops
> > -and embedded products. Linux had this support since Linux 3.9.
> > -
> > -Intel=C2=AE introduced integrated sensor hubs as a part of the SoC sta=
rting from
> > -Cherry Trail and now supported on multiple generations of CPU packages=
. There
> > -are many commercial devices already shipped with Integrated Sensor Hub=
s (ISH).
> > -These ISH also comply to HID sensor specification, but the  difference=
 is the
> > -transport protocol used for communication. The current external sensor=
 hubs
> > -mainly use HID over i2C or USB. But ISH doesn't use either i2c or USB.
> > -
> > -1. Overview
> > -
> > -Using a analogy with a usbhid implementation, the ISH follows a simila=
r model
> > -for a very high speed communication:
> > -
> > -       -----------------               ----------------------
> > -       |    USB HID    |       -->     |    ISH HID         |
> > -       -----------------               ----------------------
> > -       -----------------               ----------------------
> > -       |  USB protocol |       -->     |    ISH Transport   |
> > -       -----------------               ----------------------
> > -       -----------------               ----------------------
> > -       |  EHCI/XHCI    |       -->     |    ISH IPC         |
> > -       -----------------               ----------------------
> > -             PCI                                PCI
> > -       -----------------               ----------------------
> > -        |Host controller|      -->     |    ISH processor   |
> > -       -----------------               ----------------------
> > -            USB Link
> > -       -----------------               ----------------------
> > -       | USB End points|       -->     |    ISH Clients     |
> > -       -----------------               ----------------------
> > -
> > -Like USB protocol provides a method for device enumeration, link manag=
ement
> > -and user data encapsulation, the ISH also provides similar services. B=
ut it is
> > -very light weight tailored to manage and communicate with ISH client
> > -applications implemented in the firmware.
> > -
> > -The ISH allows multiple sensor management applications executing in the
> > -firmware. Like USB endpoints the messaging can be to/from a client. As=
 part of
> > -enumeration process, these clients are identified. These clients can b=
e simple
> > -HID sensor applications, sensor calibration application or senor firmw=
are
> > -update application.
> > -
> > -The implementation model is similar, like USB bus, ISH transport is al=
so
> > -implemented as a bus. Each client application executing in the ISH pro=
cessor
> > -is registered as a device on this bus. The driver, which binds each de=
vice
> > -(ISH HID driver) identifies the device type and registers with the hid=
 core.
> > -
> > -2. ISH Implementation: Block Diagram
> > -
> > -        ---------------------------
> > -       |  User Space Applications  |
> > -        ---------------------------
> > -
> > -----------------IIO ABI----------------
> > -        --------------------------
> > -       |  IIO Sensor Drivers     |
> > -        --------------------------
> > -        --------------------------
> > -       |        IIO core         |
> > -        --------------------------
> > -        --------------------------
> > -       |   HID Sensor Hub MFD    |
> > -        --------------------------
> > -        --------------------------
> > -       |       HID Core          |
> > -        --------------------------
> > -        --------------------------
> > -       |   HID over ISH Client   |
> > -        --------------------------
> > -        --------------------------
> > -       |   ISH Transport (ISHTP) |
> > -        --------------------------
> > -        --------------------------
> > -       |      IPC Drivers        |
> > -        --------------------------
> > -OS
> > -----------------   PCI -----------------
> > -Hardware + Firmware
> > -        ----------------------------
> > -       | ISH Hardware/Firmware(FW) |
> > -        ----------------------------
> > -
> > -3. High level processing in above blocks
> > -
> > -3.1 Hardware Interface
> > -
> > -The ISH is exposed as "Non-VGA unclassified PCI device" to the host. T=
he PCI
> > -product and vendor IDs are changed from different generations of proce=
ssors. So
> > -the source code which enumerate drivers needs to update from generatio=
n to
> > -generation.
> > -
> > -3.2 Inter Processor Communication (IPC) driver
> > -Location: drivers/hid/intel-ish-hid/ipc
> > -
> > -The IPC message used memory mapped I/O. The registers are defined in
> > -hw-ish-regs.h.
> > -
> > -3.2.1 IPC/FW message types
> > -
> > -There are two types of messages, one for management of link and other =
messages
> > -are to and from transport layers.
> > -
> > -TX and RX of Transport messages
> > -
> > -A set of memory mapped register offers support of multi byte messages =
TX and
> > -RX (E.g.IPC_REG_ISH2HOST_MSG, IPC_REG_HOST2ISH_MSG). The IPC layer mai=
ntains
> > -internal queues to sequence messages and send them in order to the FW.
> > -Optionally the caller can register handler to get notification of comp=
letion.
> > -A door bell mechanism is used in messaging to trigger processing in ho=
st and
> > -client firmware side. When ISH interrupt handler is called, the ISH2HO=
ST
> > -doorbell register is used by host drivers to determine that the interr=
upt
> > -is for ISH.
> > -
> > -Each side has 32 32-bit message registers and a 32-bit doorbell. Doorb=
ell
> > -register has the following format:
> > -Bits 0..6: fragment length (7 bits are used)
> > -Bits 10..13: encapsulated protocol
> > -Bits 16..19: management command (for IPC management protocol)
> > -Bit 31: doorbell trigger (signal H/W interrupt to the other side)
> > -Other bits are reserved, should be 0.
> > -
> > -3.2.2 Transport layer interface
> > -
> > -To abstract HW level IPC communication, a set of callbacks are registe=
red.
> > -The transport layer uses them to send and receive messages.
> > -Refer to  struct ishtp_hw_ops for callbacks.
> > -
> > -3.3 ISH Transport layer
> > -Location: drivers/hid/intel-ish-hid/ishtp/
> > -
> > -3.3.1 A Generic Transport Layer
> > -
> > -The transport layer is a bi-directional protocol, which defines:
> > -- Set of commands to start, stop, connect, disconnect and flow control
> > -(ishtp/hbm.h) for details
> > -- A flow control mechanism to avoid buffer overflows
> > -
> > -This protocol resembles bus messages described in the following docume=
nt:
> > -http://www.intel.com/content/dam/www/public/us/en/documents/technical-\
> > -specifications/dcmi-hi-1-0-spec.pdf "Chapter 7: Bus Message Layer"
> > -
> > -3.3.2 Connection and Flow Control Mechanism
> > -
> > -Each FW client and a protocol is identified by an UUID. In order to co=
mmunicate
> > -to a FW client, a connection must be established using connect request=
 and
> > -response bus messages. If successful, a pair (host_client_id and fw_cl=
ient_id)
> > -will identify the connection.
> > -
> > -Once connection is established, peers send each other flow control bus=
 messages
> > -independently. Every peer may send a message only if it has received a
> > -flow-control credit before. Once it sent a message, it may not send an=
other one
> > -before receiving the next flow control credit.
> > -Either side can send disconnect request bus message to end communicati=
on. Also
> > -the link will be dropped if major FW reset occurs.
> > -
> > -3.3.3 Peer to Peer data transfer
> > -
> > -Peer to Peer data transfer can happen with or without using DMA. Depen=
ding on
> > -the sensor bandwidth requirement DMA can be enabled by using module pa=
rameter
> > -ishtp_use_dma under intel_ishtp.
> > -
> > -Each side (host and FW) manages its DMA transfer memory independently.=
 When an
> > -ISHTP client from either host or FW side wants to send something, it d=
ecides
> > -whether to send over IPC or over DMA; for each transfer the decision is
> > -independent. The sending side sends DMA_XFER message when the message =
is in
> > -the respective host buffer (TX when host client sends, RX when FW clie=
nt
> > -sends). The recipient of DMA message responds with DMA_XFER_ACK, indic=
ating
> > -the sender that the memory region for that message may be reused.
> > -
> > -DMA initialization is started with host sending DMA_ALLOC_NOTIFY bus m=
essage
> > -(that includes RX buffer) and FW responds with DMA_ALLOC_NOTIFY_ACK.
> > -Additionally to DMA address communication, this sequence checks capabi=
lities:
> > -if thw host doesn't support DMA, then it won't send DMA allocation, so=
 FW can't
> > -send DMA; if FW doesn't support DMA then it won't respond with
> > -DMA_ALLOC_NOTIFY_ACK, in which case host will not use DMA transfers.
> > -Here ISH acts as busmaster DMA controller. Hence when host sends DMA_X=
FER,
> > -it's request to do host->ISH DMA transfer; when FW sends DMA_XFER, it =
means
> > -that it already did DMA and the message resides at host. Thus, DMA_XFER
> > -and DMA_XFER_ACK act as ownership indicators.
> > -
> > -At initial state all outgoing memory belongs to the sender (TX to host=
, RX to
> > -FW), DMA_XFER transfers ownership on the region that contains ISHTP me=
ssage to
> > -the receiving side, DMA_XFER_ACK returns ownership to the sender. A se=
nder
> > -needs not wait for previous DMA_XFER to be ack'ed, and may send anothe=
r message
> > -as long as remaining continuous memory in its ownership is enough.
> > -In principle, multiple DMA_XFER and DMA_XFER_ACK messages may be sent =
at once
> > -(up to IPC MTU), thus allowing for interrupt throttling.
> > -Currently, ISH FW decides to send over DMA if ISHTP message is more th=
an 3 IPC
> > -fragments and via IPC otherwise.
> > -
> > -3.3.4 Ring Buffers
> > -
> > -When a client initiate a connection, a ring or RX and TX buffers are a=
llocated.
> > -The size of ring can be specified by the client. HID client set 16 and=
 32 for
> > -TX and RX buffers respectively. On send request from client, the data =
to be
> > -sent is copied to one of the send ring buffer and scheduled to be sent=
 using
> > -bus message protocol. These buffers are required because the FW may ha=
ve not
> > -have processed the last message and may not have enough flow control c=
redits
> > -to send. Same thing holds true on receive side and flow control is req=
uired.
> > -
> > -3.3.5 Host Enumeration
> > -
> > -The host enumeration bus command allow discovery of clients present in=
 the FW.
> > -There can be multiple sensor clients and clients for calibration funct=
ion.
> > -
> > -To ease in implantation and allow independent driver handle each client
> > -this transport layer takes advantage of Linux Bus driver model. Each
> > -client is registered as device on the the transport bus (ishtp bus).
> > -
> > -Enumeration sequence of messages:
> > -- Host sends HOST_START_REQ_CMD, indicating that host ISHTP layer is u=
p.
> > -- FW responds with HOST_START_RES_CMD
> > -- Host sends HOST_ENUM_REQ_CMD (enumerate FW clients)
> > -- FW responds with HOST_ENUM_RES_CMD that includes bitmap of available=
 FW
> > -client IDs
> > -- For each FW ID found in that bitmap host sends
> > -HOST_CLIENT_PROPERTIES_REQ_CMD
> > -- FW responds with HOST_CLIENT_PROPERTIES_RES_CMD. Properties include =
UUID,
> > -max ISHTP message size, etc.
> > -- Once host received properties for that last discovered client, it co=
nsiders
> > -ISHTP device fully functional (and allocates DMA buffers)
> > -
> > -3.4 HID over ISH Client
> > -Location: drivers/hid/intel-ish-hid
> > -
> > -The ISHTP client driver is responsible for:
> > -- enumerate HID devices under FW ISH client
> > -- Get Report descriptor
> > -- Register with HID core as a LL driver
> > -- Process Get/Set feature request
> > -- Get input reports
> > -
> > -3.5 HID Sensor Hub MFD and IIO sensor drivers
> > -
> > -The functionality in these drivers is the same as an external sensor h=
ub.
> > -Refer to
> > -Documentation/hid/hid-sensor.txt for HID sensor
> > -Documentation/ABI/testing/sysfs-bus-iio for IIO ABIs to user space
> > -
> > -3.6 End to End HID transport Sequence Diagram
> > -
> > -HID-ISH-CLN                    ISHTP                   IPC            =
                 HW
> > -       |                       |                       |              =
                 |
> > -       |                       |                       |-----WAKE UP--=
---------------->|
> > -       |                       |                       |              =
                 |
> > -       |                       |                       |-----HOST READ=
Y--------------->|
> > -       |                       |                       |              =
                 |
> > -       |                       |                       |<----MNG_RESET=
_NOTIFY_ACK----- |
> > -       |                       |                       |              =
                 |
> > -       |                       |<----ISHTP_START------ |              =
                 |
> > -       |                       |                       |              =
                 |
> > -       |                       |<-----------------HOST_START_RES_CMD--=
-----------------|
> > -       |                       |                       |              =
                 |
> > -       |                       |------------------QUERY_SUBSCRIBER----=
---------------->|
> > -       |                       |                       |              =
                 |
> > -       |                       |------------------HOST_ENUM_REQ_CMD---=
---------------->|
> > -       |                       |                       |              =
                 |
> > -       |                       |<-----------------HOST_ENUM_RES_CMD---=
-----------------|
> > -       |                       |                       |              =
                 |
> > -       |                       |------------------HOST_CLIENT_PROPERTI=
ES_REQ_CMD------>|
> > -       |                       |                       |              =
                 |
> > -       |                       |<-----------------HOST_CLIENT_PROPERTI=
ES_RES_CMD-------|
> > -       |       Create new device on in ishtp bus       |              =
                 |
> > -       |                       |                       |              =
                 |
> > -       |                       |------------------HOST_CLIENT_PROPERTI=
ES_REQ_CMD------>|
> > -       |                       |                       |              =
                 |
> > -       |                       |<-----------------HOST_CLIENT_PROPERTI=
ES_RES_CMD-------|
> > -       |       Create new device on in ishtp bus       |              =
                 |
> > -       |                       |                       |              =
                 |
> > -       |                       |--Repeat HOST_CLIENT_PROPERTIES_REQ_CM=
D-till last one--|
> > -       |                       |                       |              =
                 |
> > -     probed()
> > -       |----ishtp_cl_connect-->|----------------- CLIENT_CONNECT_REQ_C=
MD-------------->|
> > -       |                       |                       |              =
                 |
> > -       |                       |<----------------CLIENT_CONNECT_RES_CM=
D----------------|
> > -       |                       |                       |              =
                 |
> > -       |register event callback|                       |              =
                 |
> > -       |                       |                       |              =
                 |
> > -       |ishtp_cl_send(
> > -       HOSTIF_DM_ENUM_DEVICES) |----------fill ishtp_msg_hdr struct wr=
ite to HW-----  >|
> > -       |                       |                       |              =
                 |
> > -       |                       |                       |<-----IRQ(IPC_=
PROTOCOL_ISHTP---|
> > -       |                       |                       |              =
                 |
> > -       |<--ENUM_DEVICE RSP-----|                       |              =
                 |
> > -       |                       |                       |              =
                 |
> > -for each enumerated device
> > -       |ishtp_cl_send(
> > -       HOSTIF_GET_HID_DESCRIPTOR |----------fill ishtp_msg_hdr struct =
write to HW---  >|
> > -       |                       |                       |              =
                 |
> > -       ...Response
> > -       |                       |                       |              =
                 |
> > -for each enumerated device
> > -       |ishtp_cl_send(
> > -       HOSTIF_GET_REPORT_DESCRIPTOR |----------fill ishtp_msg_hdr stru=
ct write to HW- >|
> > -       |                       |                       |              =
                 |
> > -       |                       |                       |              =
                 |
> > - hid_allocate_device
> > -       |                       |                       |              =
                 |
> > - hid_add_device                        |                       |      =
                         |
> > -       |                       |                       |              =
                 |
> > -
> > -
> > -3.7 ISH Debugging
> > -
> > -To debug ISH, event tracing mechanism is used. To enable debug logs
> > -echo 1 > /sys/kernel/debug/tracing/events/intel_ish/enable
> > -cat sys/kernel/debug/tracing/trace
> > -
> > -3.8 ISH IIO sysfs Example on Lenovo thinkpad Yoga 260
> > -
> > -root@otcpl-ThinkPad-Yoga-260:~# tree -l /sys/bus/iio/devices/
> > -/sys/bus/iio/devices/
> > -=E2=94=9C=E2=94=80=E2=94=80 iio:device0 -> ../../../devices/0044:8086:=
22D8.0001/HID-SENSOR-200073.9.auto/iio:device0
> > -=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 buffer
> > -=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 enable
> > -=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 length
> > -=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 watermark
> > -...
> > -=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_hysteresis
> > -=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_offset
> > -=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_sampling_frequency
> > -=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_scale
> > -=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_raw
> > -=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_raw
> > -=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_z_raw
> > -=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 name
> > -=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 scan_elements
> > -=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_en
> > -=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_index
> > -=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_x_type
> > -=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_en
> > -=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_index
> > -=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_y_type
> > -=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_z_en
> > -=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_accel_z_index
> > -=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 in_accel_z_type
> > -...
> > -=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 devices
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 buffer
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 enable
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 length
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 watermark
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 dev
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_intensity_both_raw
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_intensity_hysteresis
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_intensity_offset
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_intensity_sampling_frequency
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_intensity_scale
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 name
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 scan_elements
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_intensity_both_en
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_intensity_both_index
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 in_intensity_both_type
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 trigger
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 current_trigger
> > -...
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 buffer
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 enable
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 length
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 watermark
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 dev
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_hysteresis
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_offset
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_sampling_frequency
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_scale
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_x_raw
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_y_raw
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_magn_z_raw
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_rot_from_north_magnetic_tilt_comp_raw
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_rot_hysteresis
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_rot_offset
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_rot_sampling_frequency
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_rot_scale
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 name
> > -...
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 scan_elements
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_x_en
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_x_index
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_x_type
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_y_en
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_y_index
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_y_type
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_z_en
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_z_index
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_magn_z_type
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_rot_from_north_magnetic_tilt_comp_en
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_rot_from_north_magnetic_tilt_comp_index
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 in_rot_from_north_magnetic_tilt_comp_type
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 trigger
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 current_trigger
> > -...
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 buffer
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 enable
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 length
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 watermark
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 dev
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_hysteresis
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_offset
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_sampling_frequency
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_scale
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_x_raw
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_y_raw
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_z_raw
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 name
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 scan_elements
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_x_en
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_x_index
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_x_type
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_y_en
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_y_index
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_y_type
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_z_en
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_z_index
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 in_anglvel_z_type
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 trigger
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 current_trigger
> > -...
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 buffer
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 enable
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 length
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 watermark
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 dev
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_hysteresis
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_offset
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_sampling_frequency
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_scale
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_x_raw
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_y_raw
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 in_anglvel_z_raw
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 name
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 scan_elements
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_x_en
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_x_index
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_x_type
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_y_en
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_y_index
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_y_type
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_z_en
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=
=E2=94=80=E2=94=80 in_anglvel_z_index
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 in_anglvel_z_type
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=
=94=80 trigger
> > -=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=
=E2=94=80=E2=94=80 current_trigger
> > -...
> > diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.rst
> > similarity index 94%
> > rename from Documentation/hid/uhid.txt
> > rename to Documentation/hid/uhid.rst
> > index 958fff945304..b18cb96c885f 100644
> > --- a/Documentation/hid/uhid.txt
> > +++ b/Documentation/hid/uhid.rst
> > @@ -1,5 +1,6 @@
> > -      UHID - User-space I/O driver support for HID subsystem
> > -     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +UHID - User-space I/O driver support for HID subsystem
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >
> >  UHID allows user-space to implement HID transport drivers. Please see
> >  hid-transport.txt for an introduction into HID transport drivers. This=
 document
> > @@ -22,9 +23,9 @@ If a new device is detected by your HID I/O Driver an=
d you want to register this
> >  device with the HID subsystem, then you need to open /dev/uhid once fo=
r each
> >  device you want to register. All further communication is done by read=
()'ing or
> >  write()'ing "struct uhid_event" objects. Non-blocking operations are s=
upported
> > -by setting O_NONBLOCK.
> > +by setting O_NONBLOCK::
> >
> > -struct uhid_event {
> > +  struct uhid_event {
> >          __u32 type;
> >          union {
> >                  struct uhid_create2_req create2;
> > @@ -32,7 +33,7 @@ struct uhid_event {
> >                  struct uhid_input2_req input2;
> >                  ...
> >          } u;
> > -};
> > +  };
> >
> >  The "type" field contains the ID of the event. Depending on the ID dif=
ferent
> >  payloads are sent. You must not split a single event across multiple r=
ead()'s or
> > @@ -86,31 +87,31 @@ the request was handled successfully. O_NONBLOCK do=
es not affect write() as
> >  writes are always handled immediately in a non-blocking fashion. Futur=
e requests
> >  might make use of O_NONBLOCK, though.
> >
> > -  UHID_CREATE2:
> > +UHID_CREATE2:
> >    This creates the internal HID device. No I/O is possible until you s=
end this
> >    event to the kernel. The payload is of type struct uhid_create2_req =
and
> >    contains information about your device. You can start I/O now.
> >
> > -  UHID_DESTROY:
> > +UHID_DESTROY:
> >    This destroys the internal HID device. No further I/O will be accept=
ed. There
> >    may still be pending messages that you can receive with read() but n=
o further
> >    UHID_INPUT events can be sent to the kernel.
> >    You can create a new device by sending UHID_CREATE2 again. There is =
no need to
> >    reopen the character device.
> >
> > -  UHID_INPUT2:
> > +UHID_INPUT2:
> >    You must send UHID_CREATE2 before sending input to the kernel! This =
event
> >    contains a data-payload. This is the raw data that you read from you=
r device
> >    on the interrupt channel. The kernel will parse the HID reports.
> >
> > -  UHID_GET_REPORT_REPLY:
> > +UHID_GET_REPORT_REPLY:
> >    If you receive a UHID_GET_REPORT request you must answer with this r=
equest.
> >    You  must copy the "id" field from the request into the answer. Set =
the "err"
> >    field to 0 if no error occurred or to EIO if an I/O error occurred.
> >    If "err" is 0 then you should fill the buffer of the answer with the=
 results
> >    of the GET_REPORT request and set "size" correspondingly.
> >
> > -  UHID_SET_REPORT_REPLY:
> > +UHID_SET_REPORT_REPLY:
> >    This is the SET_REPORT equivalent of UHID_GET_REPORT_REPLY. Unlike G=
ET_REPORT,
> >    SET_REPORT never returns a data buffer, therefore, it's sufficient t=
o set the
> >    "id" and "err" fields correctly.
> > @@ -120,16 +121,18 @@ read()
> >  read() will return a queued output report. No reaction is required to =
any of
> >  them but you should handle them according to your needs.
> >
> > -  UHID_START:
> > +UHID_START:
> >    This is sent when the HID device is started. Consider this as an ans=
wer to
> >    UHID_CREATE2. This is always the first event that is sent. Note that=
 this
> >    event might not be available immediately after write(UHID_CREATE2) r=
eturns.
> >    Device drivers might required delayed setups.
> >    This event contains a payload of type uhid_start_req. The "dev_flags=
" field
> >    describes special behaviors of a device. The following flags are def=
ined:
> > -      UHID_DEV_NUMBERED_FEATURE_REPORTS:
> > -      UHID_DEV_NUMBERED_OUTPUT_REPORTS:
> > -      UHID_DEV_NUMBERED_INPUT_REPORTS:
> > +
> > +      - UHID_DEV_NUMBERED_FEATURE_REPORTS
> > +      - UHID_DEV_NUMBERED_OUTPUT_REPORTS
> > +      - UHID_DEV_NUMBERED_INPUT_REPORTS
> > +
> >            Each of these flags defines whether a given report-type uses=
 numbered
> >            reports. If numbered reports are used for a type, all messag=
es from
> >            the kernel already have the report-number as prefix. Otherwi=
se, no
> > @@ -137,33 +140,35 @@ them but you should handle them according to your=
 needs.
> >            For messages sent by user-space to the kernel, you must adju=
st the
> >            prefixes according to these flags.
> >
> > -  UHID_STOP:
> > +UHID_STOP:
> >    This is sent when the HID device is stopped. Consider this as an ans=
wer to
> >    UHID_DESTROY.
> > +
> >    If you didn't destroy your device via UHID_DESTROY, but the kernel s=
ends an
> >    UHID_STOP event, this should usually be ignored. It means that the k=
ernel
> >    reloaded/changed the device driver loaded on your HID device (or som=
e other
> >    maintenance actions happened).
> > +
> >    You can usually ignored any UHID_STOP events safely.
> >
> > -  UHID_OPEN:
> > +UHID_OPEN:
> >    This is sent when the HID device is opened. That is, the data that t=
he HID
> >    device provides is read by some other process. You may ignore this e=
vent but
> >    it is useful for power-management. As long as you haven't received t=
his event
> >    there is actually no other process that reads your data so there is =
no need to
> >    send UHID_INPUT2 events to the kernel.
> >
> > -  UHID_CLOSE:
> > +UHID_CLOSE:
> >    This is sent when there are no more processes which read the HID dat=
a. It is
> >    the counterpart of UHID_OPEN and you may as well ignore this event.
> >
> > -  UHID_OUTPUT:
> > +UHID_OUTPUT:
> >    This is sent if the HID device driver wants to send raw data to the =
I/O
> >    device on the interrupt channel. You should read the payload and for=
ward it to
> >    the device. The payload is of type "struct uhid_output_req".
> >    This may be received even though you haven't received UHID_OPEN, yet.
> >
> > -  UHID_GET_REPORT:
> > +UHID_GET_REPORT:
> >    This event is sent if the kernel driver wants to perform a GET_REPOR=
T request
> >    on the control channeld as described in the HID specs. The report-ty=
pe and
> >    report-number are available in the payload.
> > @@ -177,11 +182,12 @@ them but you should handle them according to your=
 needs.
> >    timed out, the kernel will ignore the response silently. The "id" fi=
eld is
> >    never re-used, so conflicts cannot happen.
> >
> > -  UHID_SET_REPORT:
> > +UHID_SET_REPORT:
> >    This is the SET_REPORT equivalent of UHID_GET_REPORT. On receipt, yo=
u shall
> >    send a SET_REPORT request to your hid device. Once it replies, you m=
ust tell
> >    the kernel about it via UHID_SET_REPORT_REPLY.
> >    The same restrictions as for UHID_GET_REPORT apply.
> >
> >  ----------------------------------------------------
> > +
> >  Written 2012, David Herrmann <dh.herrmann@gmail.com>
> > diff --git a/Documentation/input/input.rst b/Documentation/input/input.=
rst
> > index 47f86a4bf16c..0eb61e67a7b7 100644
> > --- a/Documentation/input/input.rst
> > +++ b/Documentation/input/input.rst
> > @@ -188,7 +188,7 @@ LCDs and many other purposes.
> >
> >  The monitor and speaker controls should be easy to add to the hid/input
> >  interface, but for the UPSs and LCDs it doesn't make much sense. For t=
his,
> > -the hiddev interface was designed. See Documentation/hid/hiddev.txt
> > +the hiddev interface was designed. See Documentation/hid/hiddev.rst
> >  for more information about it.
> >
> >  The usage of the usbhid module is very simple, it takes no parameters,
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8d39979e4091..969225e6bfce 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16383,7 +16383,7 @@ M:      Benjamin Tissoires <benjamin.tissoires@=
redhat.com>
> >  L:     linux-usb@vger.kernel.org
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
> >  S:     Maintained
> > -F:     Documentation/hid/hiddev.txt
> > +F:     Documentation/hid/hiddev.rst
> >  F:     drivers/hid/usbhid/
> >
> >  USB INTEL XHCI ROLE MUX DRIVER
> > --
> > 2.21.0
> > =20



Thanks,
Mauro
