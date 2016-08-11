From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/4] input: touchscreen: Add generic touchscreen
 softbutton handling code
Date: Thu, 11 Aug 2016 11:21:44 +0200
Message-ID: <d95d5b9a-51c2-d45d-62dc-a9e52177a97c@redhat.com>
References: <1469978590-14081-1-git-send-email-hdegoede@redhat.com>
 <1469978590-14081-2-git-send-email-hdegoede@redhat.com>
 <20160801165430.GA30345@rob-hp-laptop> <20160801174154.GA3231@dtor-ws>
 <58cfd727-bb46-3ea8-85b9-8c17fbed72c5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55074 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbcHKJVu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Aug 2016 05:21:50 -0400
In-Reply-To: <58cfd727-bb46-3ea8-85b9-8c17fbed72c5@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>



On 02-08-16 10:33, Hans de Goede wrote:
> Hi,
>
> On 01-08-16 19:41, Dmitry Torokhov wrote:
>> On Mon, Aug 01, 2016 at 11:54:30AM -0500, Rob Herring wrote:
>>> On Sun, Jul 31, 2016 at 05:23:07PM +0200, Hans de Goede wrote:
>>>> Some touchscreens extend over the display they cover and have a number
>>>> of capacative softbuttons outside of the display the cover.
>>>>
>>>> With some hardware these softbuttons simply report touches with
>>>> coordinates outside of the normal coordinate space for touches on the
>>>> display.
>>>>
>>>> This commit adds a devicetree binding for describing such buttons in
>>>> devicetree and a bunch of helper functions to easily add support for
>>>> these to existing touchscreen drivers.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>  .../bindings/input/touchscreen/softbuttons.txt     |  58 +++++++++
>>>>  drivers/input/touchscreen/Makefile                 |   2 +-
>>>>  drivers/input/touchscreen/softbuttons.c            | 145 +++++++++++++++++++++
>>>>  include/linux/input/touchscreen.h                  |   9 ++
>>>>  4 files changed, 213 insertions(+), 1 deletion(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
>>>>  create mode 100644 drivers/input/touchscreen/softbuttons.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
>>>> new file mode 100644
>>>> index 0000000..3eb6f4c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
>>>> @@ -0,0 +1,58 @@
>>>> +General Touchscreen Softbutton Properties:
>>>> +
>>>> +Some touchscreens extend over the display they cover and have a number
>>>> +of capacative softbuttons outside of the display the cover.
>>>> +
>>>> +Some of these softbuttons simply report touches with coordinates outside of
>>>> +the normal coordinate space for touches on the display. This binding is for
>>>> +describing such buttons in devicetree.
>>>> +
>>>> +Each softkey is represented as a sub-node of the touchscreen node.
>>>> +
>>>> +Required subnode-properties:
>>>> + - label            : Descriptive name of the key.
>>>> + - linux,code            : Keycode to emit.
>>>> + - softbutton-min-x        : X start of the area the softbutton area covers
>>>> + - softbutton-max-x        : X end of the area the softbutton area covers
>>>> + - softbutton-min-y        : Y start of the area the softbutton area covers
>>>> + - softbutton-max-y        : Y end of the area the softbutton area covers
>>>
>>> This generally looks fine to me, but I am wondering one thing. If the
>>> buttons are located at the origin of an axis, can we handle that case? I
>>> don't think you can unless you assume softbutton-max-? is 0 for the
>>> touchscreen. To put it another way, you have a gap from 1024 to 1084
>>> which you can't express for buttons at the origin unless you do negative
>>> numbers.
>>
>> I do not this this should be done in kernel: I do not see nay difference
>> in softbuttons or sliders or circular controls or... They are not
>> controller-specific and I think are better handled in userspace. We do
>> that for Synaptics touchpads with softbuttons, we can do that for other
>> controllers.
>>
>> Also, what is or stance when there is no bezel and we sill want to have
>> the softbutons (i.e. all Nexus phones and tablets)?
>
> Maybe softbuttons is not the best name (I googled and it seemed to match),
> so first lets make clear what I'm talking about here, I wrote this patch-set
> for this tablet:
>
> https://content.hwigroup.net/images/products_xl/157078/dserve-dsrv-9703c.jpg
>
> I decided to make it generic, since it seemed to me that there will likely
> be other hardware which is similar (but uses a different touch screen
> controller) out there, so keeping this generic seemed best.
>
> Now back to the kernelspace vs userspace solution question, if you look at
> the picture you will see 3 clearly marked buttons on the front of the tablet,
> outside of the display: menu, home and back. These are not buttons which get
> generated / drawn on the display when you touch the bottom of the screen, these
> are separate single-purpose buttons which happen to report presses via the
> touchscreen controller then via a separate hw mechanism.
>
> If these buttons used a separate capacative button controller as used in
> e.g. capacitive numpads, say something like this:
>
> http://www.ebay.com/itm/2PCS-TTP223-Capacitive-Touch-Switch-Button-Self-Lock-Module-for-Arduino-/131662428748
>
> Then there would be no question that this belongs in the kernel. I do not
> see how these are any different really. These cannot be runtime re-configured,
> they are separate dedicated buttons which happens to report presses via
> the touchscreen controllers.
>
> There also is the question of hardware description, no matter where we
> put support for this, we need some place were we describe the presence
> of these buttons to the software bits which end up dealing with them.
>
> And we already have a mechanism for describing "fixed" hardware for a
> certain model machine / board in the form of devicetree. To me putting
> the hardware description for this anywhere but in devicetree makes
> no sense because then we start scattering the description of a single
> device-type over multiple places which seems like a bad idea.
>
> And once we decided to put the description in devicetree, then dealing
> with this in the kernel becomes the logical thing to do.
>
> Regards,
>
> Hans
>
>
> p.s.
>
> One other example of buttons like these are those on the nexus one:
>
> http://www.informatica.com.do/7BZ-PortalImageUpload/image/2010151059110.google-nexus-one-01.jpg
>
> Note I'm not saying this binding will work for those, I've no idea how
> they are hooked up, but they are the same in that they are really
> 4 dedicated separate buttons which happen to be part of the main digitizer.

Dmitry, ping? Any reaction to the above ?

Regards,

Hans


p.s.

I've been thinking a bit more about this, trying to envision a reasonable
user-space solution and I do not really see any. IMHO this really belongs
in the kernel, and it is not a lot of code, the basic softbutton core is
quite small, and the actually needed touchscreen driver changer are
only a couple of line, so it is not like doing this in the kernel is
a hassle, where as doing this in userspace will be a hassle.
