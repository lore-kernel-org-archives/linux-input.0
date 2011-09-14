From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 2/2] input: samsung-keypad: Add device tree support
Date: Wed, 14 Sep 2011 23:39:03 +0530
Message-ID: <CAJuYYwRP2DGge1aHz-CWMnUrdz686s6X5Fp=LvRkM35VQS1XYw@mail.gmail.com>
References: <1315916779-21793-1-git-send-email-thomas.abraham@linaro.org>
	<1315916779-21793-2-git-send-email-thomas.abraham@linaro.org>
	<1315916779-21793-3-git-send-email-thomas.abraham@linaro.org>
	<20110914161144.GF3134@ponder.secretlab.ca>
	<CAJuYYwSNaVCnHFTMtW0RZLGLaS+iKBibWYwn5mqNT-0EW31yAQ@mail.gmail.com>
	<20110914171318.GA24425@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f52.google.com ([74.125.83.52]:48302 "EHLO
	mail-gw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757095Ab1INSJE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Sep 2011 14:09:04 -0400
In-Reply-To: <20110914171318.GA24425@ponder.secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com

Hi Grant,

On 14 September 2011 22:43, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Wed, Sep 14, 2011 at 10:19:22PM +0530, Thomas Abraham wrote:
>> Hi Grant,
>>
>> On 14 September 2011 21:41, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>> > On Tue, Sep 13, 2011 at 05:56:19PM +0530, Thomas Abraham wrote:
>> >> Add device tree based discovery support for Samsung's keypad cont=
roller.
>> >>
>> >> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
>> >> Cc: Donghwa Lee <dh09.lee@samsung.com>
>> >> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> >> ---
>> >> =A0.../devicetree/bindings/input/samsung-keypad.txt =A0 | =A0 88 =
++++++++++
>> >> =A0drivers/input/keyboard/samsung-keypad.c =A0 =A0 =A0 =A0 =A0 =A0=
| =A0177 ++++++++++++++++++--
>> >> =A02 files changed, 253 insertions(+), 12 deletions(-)
>> >> =A0create mode 100644 Documentation/devicetree/bindings/input/sam=
sung-keypad.txt
>> >>

[...]

>> >> +- Keys represented as child nodes: Each key connected to the key=
pad
>> >> + =A0controller is represented as a child node to the keypad cont=
roller
>> >> + =A0device node and should include the following properties.
>> >> + =A0- keypad,row: the row number to which the key is connected.
>> >> + =A0- keypad,column: the column number to which the key is conne=
cted.
>> >> + =A0- keypad,key-code: the key-code to be reported when the key =
is pressed
>> >> + =A0 =A0and released.
>> >
>> > What defines the meanings of the key codes?
>>
>> The key-code could be any value which the system would want the keyp=
ad
>> driver to report when that key is pressed.
>
> Are they linux keycodes? =A0If so, then this property name can
> probably be linux,code. =A0There is already precedence for that
> usage in Documentation/devicetree/bindings/gpio/gpio-keys.txt. =A0(I
> would personally prefer "linux,key-code", but sometimes it is better
> to go with existing precidence) You could also use linux,input-type a=
s
> specified in that binding.

Ok. For linux, "keypad,key-code" would mean linux keycodes. The
property name 'keypad,key-code' was chosen since it can be reused on
non-linux platforms as well. I did have a look at
Documentation/devicetree/bindings/gpio/gpio-keys.txt while doing this,
but preferred using 'keypad,key-code' since it would be generic. Given
a choice, I would like to retain this.

>
>>
>> >
>> >> +
>> >> +Optional Properties specific to linux:
>> >> +- linux,keypad-no-autorepeat: do no enable autorepeat feature.
>> >> +- linux,keypad-wakeup: use any event on keypad as wakeup event.
>> >
>> > Is this really a linux-specific feature?
>>
>> Yes, it is a property defined by the linux subsystems. A non-linux
>> system might not have such features.
>
> I was specifically referring to the wakeup property, but okay, I can
> see the argument that it is linux-specific because it is usage-policy
> related.
>
> g.

Thanks for your review.

Regards,
Thomas.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
