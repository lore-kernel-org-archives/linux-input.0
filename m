From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH try #3] Blackfin BF54x Input Keypad controller driver
Date: Fri, 12 Oct 2007 16:09:10 +0100
Message-ID: <600D5CB4DFD93545BF61FF01473D11AC0F1960A2@limkexm2.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-class: urn:content-classes:message
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: bryan.wu@analog.com, linux-input@atrey.karlin.mff.cuni.cz, Linux Kernel <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-input@vger.kernel.org


Hi Dmitry,

>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>Sent: Donnerstag, 11. Oktober 2007 21:58
>To: Hennerich, Michael
>Cc: bryan.wu@analog.com; linux-input@atrey.karlin.mff.cuni.cz; Linux
>Kernel; uclinux-dist-devel@blackfin.uclinux.org
>Subject: Re: [PATCH try #3] Blackfin BF54x Input Keypad controller
driver
>
>Hi Michael,
>
>On 10/11/07, Hennerich, Michael <Michael.Hennerich@analog.com> wrote:
>> >From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>> >Sent: Donnerstag, 11. Oktober 2007 19:27
>> >To: bryan.wu@analog.com
>> >Cc: Michael Hennerich; linux-input@atrey.karlin.mff.cuni.cz; Linux
>> Kernel;
>> >uclinux-dist-devel@blackfin.uclinux.org
>> >Subject: Re: [PATCH try #3] Blackfin BF54x Input Keypad controller
>> driver
>> >
>> >On Thursday 11 October 2007, Bryan Wu wrote:
>> >> From: Michael Hennerich <michael.hennerich@analog.com>
>> >> Date: Fri, 12 Oct 2007 00:20:19 +0800
>> >> Subject: [PATCH] Blackfin BF54x Input Keypad controller driver
>> >>
>> >> [try #2] Changelog:
>> >>  - Coding style issue fixes
>> >>  - using a temp variable for bf54x_kpad->input
>> >>  - Other updates according to Dmitry's review
>> >>
>> >> [try #3] Changelog:
>> >>  - Coding style cleanups
>> >>  - Use local copy of keymap
>> >>  - Remove empty PM functions
>> >>  - Use input_set_drvdata() since input->private is going away
>> >
>> >
>> >This looks very good, thank youvery much. I have only 1 more
suggestion
>> >(and I can make the changes locally, you don't need to resubmit) -
>> >since it is highly unlikely that we will have a keycode > 65535 do
you
>> >think we could change keymap to unsigned short. It would save you a
>> >couple of bytes. I am also going to change "input->cdev.dev =3D
>> &pdev->dev;"
>> >to "input_dev->dev.parent =3D &pdev->dev;". Please let me know if =
you
are
>> >OK with it.
>>
>> Hi Dmitry,
>>
>> Thanks for your excellent feedback and support.
>>
>> We do a pretty similar thing like the omap keypad driver.
>> Our keycodes do not exceed KEY_MAX but we encode the ROW and COL into
>> the keycode matrix, in order simplify things in a "normal use case"?
.
>> What we store is u32, 16-bit for the keycode and the upper for
private
>> use. My understanding is that we then have to set input->keycodesize
>> also being u32.
>>
>> Otherwise the generic input layer might get screwed up?!
>>
>> Am I wrong here, or do I miss something?
>> Either this is a valid use case or I was inspired by a bad example.
>>
>
>Thank you very much for alerting me of omap case, I missed it.
>
>Drivers that use complex values in their keymap tables should not use
>input->keycode, keycodesize and keycodemax. These fields are only used
>by input core if the driver relies on default implementation of
>getkeycode() and setkeycode() for manipulations with its keymap. But
>this will not work in your case (nor with omap) because your keymap
>table does not contain "pure" input keycodes.
>
>Well, I guess the easiest is just not set these fields (and remove the
>per-device map allocationand copying) and say that the driver does not
>support altering keymaps. After all, like you said, it is an embedded
>platform and it is unlikely that users will want to alter keymaps.
>
>However, if you think that this is a nice feature, then you either
>need to rethink how you handle your keymap of implement custom
>getkeycode and setkeycode methods in your driver. The coice is yours,
>I will gladly accept either version of drver.

Well it's a nice feature -=20

I changed following:

- Change keymapsize to u16
- Copy privately used LUT behind keycodemax in keycode table.
This is more cache friendly when doing the tablewalk, and goes totally
unnoticed be the input device layer.=20
- Change Input_dev->cdev.dev to input_dev->dev.parent

Bryan is going to send you an updated patch soon.

Thanks and best regards,
Michael

>
>--
>Dmitry
