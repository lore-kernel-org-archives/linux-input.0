From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] input: samsung-keypad: Add device tree support
Date: Wed, 14 Sep 2011 13:10:47 -0600
Message-ID: <CACxGe6uh82U_uFUBCdk4anDywUre974xU8OqEpvVq7AF5Oj8KQ@mail.gmail.com>
References: <1315916779-21793-1-git-send-email-thomas.abraham@linaro.org>
 <1315916779-21793-2-git-send-email-thomas.abraham@linaro.org>
 <1315916779-21793-3-git-send-email-thomas.abraham@linaro.org>
 <20110914161144.GF3134@ponder.secretlab.ca> <CAJuYYwSNaVCnHFTMtW0RZLGLaS+iKBibWYwn5mqNT-0EW31yAQ@mail.gmail.com>
 <20110914171318.GA24425@ponder.secretlab.ca> <CAJuYYwRP2DGge1aHz-CWMnUrdz686s6X5Fp=LvRkM35VQS1XYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f170.google.com ([209.85.161.170]:65079 "EHLO
	mail-gx0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757306Ab1INTLI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Sep 2011 15:11:08 -0400
In-Reply-To: <CAJuYYwRP2DGge1aHz-CWMnUrdz686s6X5Fp=LvRkM35VQS1XYw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com

On Wed, Sep 14, 2011 at 12:09 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> On 14 September 2011 22:43, Grant Likely <grant.likely@secretlab.ca> =
wrote:
>> On Wed, Sep 14, 2011 at 10:19:22PM +0530, Thomas Abraham wrote:
>>> On 14 September 2011 21:41, Grant Likely <grant.likely@secretlab.ca=
> wrote:
>>> > On Tue, Sep 13, 2011 at 05:56:19PM +0530, Thomas Abraham wrote:
>>> >> +- Keys represented as child nodes: Each key connected to the ke=
ypad
>>> >> + =A0controller is represented as a child node to the keypad con=
troller
>>> >> + =A0device node and should include the following properties.
>>> >> + =A0- keypad,row: the row number to which the key is connected.
>>> >> + =A0- keypad,column: the column number to which the key is conn=
ected.
>>> >> + =A0- keypad,key-code: the key-code to be reported when the key=
 is pressed
>>> >> + =A0 =A0and released.
>>> >
>>> > What defines the meanings of the key codes?
>>>
>>> The key-code could be any value which the system would want the key=
pad
>>> driver to report when that key is pressed.
>>
>> Are they linux keycodes? =A0If so, then this property name can
>> probably be linux,code. =A0There is already precedence for that
>> usage in Documentation/devicetree/bindings/gpio/gpio-keys.txt. =A0(I
>> would personally prefer "linux,key-code", but sometimes it is better
>> to go with existing precidence) You could also use linux,input-type =
as
>> specified in that binding.
>
> Ok. For linux, "keypad,key-code" would mean linux keycodes. The
> property name 'keypad,key-code' was chosen since it can be reused on
> non-linux platforms as well. I did have a look at
> Documentation/devicetree/bindings/gpio/gpio-keys.txt while doing this=
,
> but preferred using 'keypad,key-code' since it would be generic. Give=
n
> a choice, I would like to retain this.

This was debated a bit on the gpio-keys binding.  The binding *must*
specify where it is getting the keycodes from.  For the gpio-keys
binding, it was decided that the Linux keycodes were sufficient since
they are exported to userspace, and therefore part of the stable
kernel ABI (they will never change).  "keypad,key-code" is completely
useless as a generic binding since it doesn't specify where the
keycode meanings come from.  Besides, "linux,code" can be reused on
non-linux platforms too, it just means that the authoritative source
of the keycodes is the Linux kernel.

g
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
