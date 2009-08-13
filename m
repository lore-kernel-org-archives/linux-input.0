From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [patch 2/2] Add a driver for the Winbond WPCD376I Consumer IR
 hardware
Date: Thu, 13 Aug 2009 19:58:43 +0200
Message-ID: <20090813175843.GA11922@hardeman.nu>
References: <20090809095645.198777507@hardeman.nu>
 <20090809095744.090206173@hardeman.nu>
 <20090813072905.56FB4526EC9@mailhub.coreip.homeip.net>
 <d92044dd553973571c2dd5cb18a925f9.squirrel@www.hardeman.nu>
 <20090813162726.DBD9A526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:46851 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbZHMR6q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2009 13:58:46 -0400
Content-Disposition: inline
In-Reply-To: <20090813162726.DBD9A526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, akpm@linux-foundation.org

On Thu, Aug 13, 2009 at 08:56:37AM -0700, Dmitry Torokhov wrote:
>On Thu, Aug 13, 2009 at 11:34:44AM +0200, David H=E4rdeman wrote:
>> The main problem right now is that getkeycode is practically useless=
 since
>> you can't blindly guess at a full range of 2^32 different scancodes =
to get
>> the complete keymap. Perhaps a index-based getkeycode would make sen=
se...
>
>The drivers that have such sparce keymaps are expected to issue
>EV_MSC/MSC_SCAN events to aid userspace in identifying the "scancodes"
>that are emitted by the device.

Ok, I've added EV_MSC/MSC_SCAN support.

>>>> +static struct device_attribute dev_attr_last_scancode =3D {
>>>> +	.attr =3D {
>>>> +		.name =3D "last_scancode",
>>>> +		.mode =3D 0444,
>>>> +	},
>>>> +	.show =3D wbcir_show_last_scancode,
>>>> +	.store =3D NULL,
>>>> +
>>>> +};
>>>
>>> Why is this needed? And if this is needed we have a nice macro
>>> for that.
>>
>> I hope I've explained it wrt. EV_IR in my other mail. It's for build=
ing
>> keymaps of unknown remotes. And it'll go away once EV_IR is supporte=
d so I
>> don't think there's much point in fiddling with it now?
>>
>
>Because once the driver is in mainline it becomes part of userspace AB=
I
>and has to stay for a looong time.

I've removed the sysfs attribute as EV_MSC/MSC_SCAN provides the same=20
functionality.

>> Thanks for the review. Are you willing to push the driver upstream t=
hrough
>> the input tree once I've implemented your suggested fixes?
>>
>
>I'd need to take a look at your EV_IR patyches and see how they will
>affect this driver. I do nt want to merge something that will stay one
>way for half a release and then will switch to completely new interfac=
e.

The EV_IR functionality is intended to be used in addition to regular=20
key up/down/repeat events. Much like EV_MSC/MSC_SCAN but more=20
descriptive and specific to IR protocols. Then advanced user-space apps=
=20
can choose whether to use the in-kernel keymap or map remote codes=20
directly to suitable events (and it allows remote keymaps to be built=20
easily in user-space).

As the future EV_IR functionality is additional to the current=20
functionality, I hope the driver still can be merged before I have EV_I=
R=20
patches ready for review. I'll post an updated patch shortly.

--=20
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
