From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 2/2] input: samsung-keypad: Add device tree support
Date: Thu, 15 Sep 2011 06:37:48 +0530
Message-ID: <CAJuYYwQ0+wFqMou6SwWEDUTJkjN83gt04cysyoiLD4W4sGg1Cg@mail.gmail.com>
References: <1315916779-21793-1-git-send-email-thomas.abraham@linaro.org>
	<1315916779-21793-2-git-send-email-thomas.abraham@linaro.org>
	<1315916779-21793-3-git-send-email-thomas.abraham@linaro.org>
	<20110914161144.GF3134@ponder.secretlab.ca>
	<CAJuYYwSNaVCnHFTMtW0RZLGLaS+iKBibWYwn5mqNT-0EW31yAQ@mail.gmail.com>
	<20110914171318.GA24425@ponder.secretlab.ca>
	<CAJuYYwRP2DGge1aHz-CWMnUrdz686s6X5Fp=LvRkM35VQS1XYw@mail.gmail.com>
	<CACxGe6uh82U_uFUBCdk4anDywUre974xU8OqEpvVq7AF5Oj8KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CACxGe6uh82U_uFUBCdk4anDywUre974xU8OqEpvVq7AF5Oj8KQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com
List-Id: linux-input@vger.kernel.org

On 15 September 2011 00:40, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Wed, Sep 14, 2011 at 12:09 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> On 14 September 2011 22:43, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>>> On Wed, Sep 14, 2011 at 10:19:22PM +0530, Thomas Abraham wrote:
>>>> On 14 September 2011 21:41, Grant Likely <grant.likely@secretlab.c=
a> wrote:
>>>> > On Tue, Sep 13, 2011 at 05:56:19PM +0530, Thomas Abraham wrote:
>>>> >> +- Keys represented as child nodes: Each key connected to the k=
eypad
>>>> >> + =A0controller is represented as a child node to the keypad co=
ntroller
>>>> >> + =A0device node and should include the following properties.
>>>> >> + =A0- keypad,row: the row number to which the key is connected=
=2E
>>>> >> + =A0- keypad,column: the column number to which the key is con=
nected.
>>>> >> + =A0- keypad,key-code: the key-code to be reported when the ke=
y is pressed
>>>> >> + =A0 =A0and released.
>>>> >
>>>> > What defines the meanings of the key codes?
>>>>
>>>> The key-code could be any value which the system would want the ke=
ypad
>>>> driver to report when that key is pressed.
>>>
>>> Are they linux keycodes? =A0If so, then this property name can
>>> probably be linux,code. =A0There is already precedence for that
>>> usage in Documentation/devicetree/bindings/gpio/gpio-keys.txt. =A0(=
I
>>> would personally prefer "linux,key-code", but sometimes it is bette=
r
>>> to go with existing precidence) You could also use linux,input-type=
 as
>>> specified in that binding.
>>
>> Ok. For linux, "keypad,key-code" would mean linux keycodes. The
>> property name 'keypad,key-code' was chosen since it can be reused on
>> non-linux platforms as well. I did have a look at
>> Documentation/devicetree/bindings/gpio/gpio-keys.txt while doing thi=
s,
>> but preferred using 'keypad,key-code' since it would be generic. Giv=
en
>> a choice, I would like to retain this.
>
> This was debated a bit on the gpio-keys binding. =A0The binding *must=
*
> specify where it is getting the keycodes from. =A0For the gpio-keys
> binding, it was decided that the Linux keycodes were sufficient since
> they are exported to userspace, and therefore part of the stable
> kernel ABI (they will never change). =A0"keypad,key-code" is complete=
ly
> useless as a generic binding since it doesn't specify where the
> keycode meanings come from. =A0Besides, "linux,code" can be reused on
> non-linux platforms too, it just means that the authoritative source
> of the keycodes is the Linux kernel.
>
> g
>

Ok. I understand this now. I will change this to "linux,code" in the
next submission.

Thanks,
Thomas.
