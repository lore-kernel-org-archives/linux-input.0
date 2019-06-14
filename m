From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Regression post "HID: core: move Usage Page concatenation to Main item"
Date: Fri, 14 Jun 2019 15:32:11 +0200
Message-ID: <CAO-hwJ+QfEVAkq9j6CoB9Pr3ooVEHGWNn+STyCd5kYgnuGQDEw@mail.gmail.com>
References: <CAEXycp+Y-x7N_Yr==Xy_CT5K_a1DZYc85w1OUV+cKC5ZN+KB1g@mail.gmail.com>
 <CAEXycpKJvSsyDQjeCC4YqmtN5tpmO15g8D-_3mrunY-NL1w4Qw@mail.gmail.com>
 <1ed66b4e9090b802259aa0fce5da1e22bcaeaafc.camel@suse.de> <65865f56882af2baf8389458c5e6f05096f36818.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <65865f56882af2baf8389458c5e6f05096f36818.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: =?UTF-8?Q?Jean=2DBaptiste_Th=C3=A9ou?= <jb@essential.com>, Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 14, 2019 at 2:29 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Fri, 2019-06-14 at 10:52 +0200, Nicolas Saenz Julienne wrote:
> > On Fri, 2019-06-14 at 09:02 +0900, Jean-Baptiste Théou wrote:
> > > Sorry - Please find the public link:
> > >
> > >
> >
> https://android.googlesource.com/platform/cts/+/master/tests/tests/hardware/res/raw/asus_gamepad_register.json
> > > Best regards
> > >
> > > On Fri, Jun 14, 2019 at 9:01 AM Jean-Baptiste Théou <jb@essential.com>
> > > wrote:
> > > > Hi,
> > > >
> > > > This patch (58e75155009cc800005629955d3482f36a1e0eec) is triggering a
> > > > regression with the following descriptor (report not working as
> > > > expected)
> > > >
> > > >
> >
> https://partner-android.googlesource.com/platform/cts/+/refs/heads/q-fs-release/tests/tests/hardware/res/raw/asus_gamepad_register.json
> > > > Didn't see anything obviously wrong with this gamepad descriptor, so
> > > > not sure what's trigger the regression.
> > > >
> > > > Thanks a lot
> > > >
> > > > Best regards
> >
> > Added Benjamin to the mail thread.
> >
> > For the record here's the report descritor, I have the feeling the issue is
> > related to the Usage Page being defined in the middle of the Usage
> > ennumeration.
> >
> > 0x05, 0x01,         /*  Usage Page (Desktop),               */
> > 0x09, 0x05,         /*  Usage (Gamepad),                    */
> > 0xA1, 0x01,         /*  Collection (Application),           */
> > 0x85, 0x01,         /*      Report ID (1),                  */
> > 0x05, 0x09,         /*      Usage Page (Button),            */
> > 0x0A, 0x01, 0x00,   /*      Usage (01h),                    */
> > 0x0A, 0x02, 0x00,   /*      Usage (02h),                    */
> > 0x0A, 0x04, 0x00,   /*      Usage (04h),                    */
> > 0x0A, 0x05, 0x00,   /*      Usage (05h),                    */
> > 0x0A, 0x07, 0x00,   /*      Usage (07h),                    */
> > 0x0A, 0x08, 0x00,   /*      Usage (08h),                    */
> > 0x0A, 0x0E, 0x00,   /*      Usage (0Eh),                    */
> > 0x0A, 0x0F, 0x00,   /*      Usage (0Fh),                    */
> > 0x0A, 0x0D, 0x00,   /*      Usage (0Dh),                    */
> > 0x05, 0x0C,         /*      Usage Page (Consumer),          */
> > 0x0A, 0x24, 0x02,   /*      Usage (AC Back),                */
> > 0x0A, 0x23, 0x02,   /*      Usage (AC Home),                */
> > 0x15, 0x00,         /*      Logical Minimum (0),            */
> > 0x25, 0x01,         /*      Logical Maximum (1),            */
> > 0x75, 0x01,         /*      Report Size (1),                */
> > 0x95, 0x0B,         /*      Report Count (11),              */
> > 0x81, 0x02,         /*      Input (Variable),               */
> > 0x75, 0x01,         /*      Report Size (1),                */
> > 0x95, 0x01,         /*      Report Count (1),               */
> > 0x81, 0x03,         /*      Input (Constant, Variable),     */
> > 0x05, 0x01,         /*      Usage Page (Desktop),           */
> > 0x75, 0x04,         /*      Report Size (4),                */
> > 0x95, 0x01,         /*      Report Count (1),               */
> > 0x25, 0x07,         /*      Logical Maximum (7),            */
> > 0x46, 0x3B, 0x01,   /*      Physical Maximum (315),         */
> > 0x66, 0x14, 0x00,   /*      Unit (Degrees),                 */
> > 0x09, 0x39,         /*      Usage (Hat Switch),             */
> > 0x81, 0x42,         /*      Input (Variable, Null State),   */
> > 0x66, 0x00, 0x00,   /*      Unit,                           */
> > 0x09, 0x01,         /*      Usage (Pointer),                */
> > 0xA1, 0x00,         /*      Collection (Physical),          */
> > 0x09, 0x30,         /*          Usage (X),                  */
> > 0x09, 0x31,         /*          Usage (Y),                  */
> > 0x09, 0x32,         /*          Usage (Z),                  */
> > 0x09, 0x35,         /*          Usage (Rz),                 */
> > 0x05, 0x02,         /*          Usage Page (Simulation),    */
> > 0x09, 0xC5,         /*          Usage (C5h),                */
> > 0x09, 0xC4,         /*          Usage (C4h),                */
> > 0x15, 0x00,         /*          Logical Minimum (0),        */
> > 0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
> > 0x35, 0x00,         /*          Physical Minimum (0),       */
> > 0x46, 0xFF, 0x00,   /*          Physical Maximum (255),     */
> > 0x75, 0x08,         /*          Report Size (8),            */
> > 0x95, 0x06,         /*          Report Count (6),           */
> > 0x81, 0x02,         /*          Input (Variable),           */
>
> Well as it was stated in 57e75155009 ("HID: core: move Usage Page concatenation
> to Main item"):
>
> The spec is not pretty clear as 5.2.2.7 states "Any usage that follows
> is interpreted as a Usage ID and concatenated with the Usage Page".
> While 5.2.2.8 states "When the parser encounters a main item it
> concatenates the last declared Usage Page with a Usage to form a
> complete usage value." Being somewhat contradictory it was decided to
> match Window's implementation, which follows 5.2.2.8.
>
> This breaks the Report above as X, Y, Z and Rz will be concatenanted with the
> 'Simulation' Usage Page as opposed to the 'Desktop' one.
>
> Based on the USB IDs can't find much information on this Gamepad, is it a real
> one? If so I guess the solution would be to fix the report descriptor in a
> custom driver. Otherwise I'd suggest fixing the descriptors directly on the
> test suite.

And most of all, how does the joypad behave on Windows?

If no quirks is used in Windows, then maybe wee are not doing the
right thing, but AFAICT, the patch was added to mimic Windows :/

Cheers,
Benjamin

>
> Regards,
> Nicolas
>
> > 0xC0,               /*      End Collection,                 */
> > 0x85, 0x02,         /*      Report ID (2),                  */
> > 0x05, 0x08,         /*      Usage Page (LED),               */
> > 0x0A, 0x01, 0x00,   /*      Usage (01h),                    */
> > 0x0A, 0x02, 0x00,   /*      Usage (02h),                    */
> > 0x0A, 0x03, 0x00,   /*      Usage (03h),                    */
> > 0x0A, 0x04, 0x00,   /*      Usage (04h),                    */
> > 0x15, 0x00,         /*      Logical Minimum (0),            */
> > 0x25, 0x01,         /*      Logical Maximum (1),            */
> > 0x75, 0x01,         /*      Report Size (1),                */
> > 0x95, 0x04,         /*      Report Count (4),               */
> > 0x91, 0x02,         /*      Output (Variable),              */
> > 0x75, 0x04,         /*      Report Size (4),                */
> > 0x95, 0x01,         /*      Report Count (1),               */
> > 0x91, 0x03,         /*      Output (Constant, Variable),    */
> > 0xC0,               /*  End Collection,                     */
> > 0x05, 0x0C,         /*  Usage Page (Consumer),              */
> > 0x09, 0x01,         /*  Usage (Consumer Control),           */
> > 0xA1, 0x01,         /*  Collection (Application),           */
> > 0x85, 0x03,         /*      Report ID (3),                  */
> > 0x05, 0x01,         /*      Usage Page (Desktop),           */
> > 0x09, 0x06,         /*      Usage (Keyboard),               */
> > 0xA1, 0x02,         /*      Collection (Logical),           */
> > 0x05, 0x06,         /*          Usage Page (Device),        */
> > 0x09, 0x20,         /*          Usage (20h),                */
> > 0x15, 0x00,         /*          Logical Minimum (0),        */
> > 0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
> > 0x75, 0x08,         /*          Report Size (8),            */
> > 0x95, 0x01,         /*          Report Count (1),           */
> > 0x81, 0x02,         /*          Input (Variable),           */
> > 0x06, 0xBC, 0xFF,   /*          Usage Page (FFBCh),         */
> > 0x0A, 0xAD, 0xBD,   /*          Usage (BDADh),              */
> > 0x75, 0x08,         /*          Report Size (8),            */
> > 0x95, 0x06,         /*          Report Count (6),           */
> > 0x81, 0x02,         /*          Input (Variable),           */
> > 0xC0,               /*      End Collection,                 */
> > 0xC0                /*  End Collection                      */
> >
>
