From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] input: Add support for the Bamboo Touch trackpad
Date: Tue, 31 Aug 2010 22:16:19 -0500
Message-ID: <AANLkTi=y-tY+Z5_qOwh5-t7OVanSW15ujnQM81uzxXNz@mail.gmail.com>
References: <1282486241-8855-1-git-send-email-rydberg@euromail.se>
	<AANLkTikvQdxzRm_rWHHz=m4=fpRSTZbMJhVUji2KVmKA@mail.gmail.com>
	<4C7B7595.6060904@euromail.se>
	<AANLkTikh6r+-aeiqT7nq3Z4jL+WZK22G4zVeUwQFLfr1@mail.gmail.com>
	<20100831054437.GA14760@barra.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60396 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0IADQU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 23:16:20 -0400
Received: by gyd8 with SMTP id 8so2824889gyd.19
        for <linux-input@vger.kernel.org>; Tue, 31 Aug 2010 20:16:19 -0700 (PDT)
In-Reply-To: <20100831054437.GA14760@barra.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org

On Tue, Aug 31, 2010 at 12:44 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Mon, Aug 30, 2010 at 11:19:49AM -0500, Chris Bagwell wrote:
>> Hi Henrik,
>>
>> On Mon, Aug 30, 2010 at 4:10 AM, Henrik Rydberg <rydberg@euromail.se=
> wrote:
>> > Hi Chris,
>> >
>> >>> 1) It uses the MT slot protocol
>> >>> 2) It creates two input devices, but only one is useful
>> >>
>> >> No biggy to userspace. =A0I'm assuming for unused input device th=
at
>> >> hardware is still reporting a HID_USAGE_STYLUS and probably you c=
ould
>> >> catch that and not register that input device.
>> >
>> >
>> > The initial idea was to only use the trackpad usb endnode, but the=
 device does
>> > not work at all after boot unless the silent endnode is somehow ta=
ken into
>> > account. I am not sure what your statement refers to.
>> >
>> >>> 3) It works well with the synaptics and multitouch X drivers
>> >>> 4) It does not work well with the wacom X driver (!)
>> >>
>> >> Once we finalize input events sent, I'm sure we could get
>> >> xf86-input-wacom to play nice with this synaptic-style input even=
ts.
>> >> The harder part is to develop userspace rules to assign this "wac=
om"
>> >> input device to something other than xf86-input-wacom; especially=
 in
>> >> case were tablet has pen and touch input devices.
>> >
>> >
>> > Using udev rules, the pen device is picked up by the wacom X drive=
r and the
>> > touch device is picked up by the synaptics X driver. It does not s=
eem anything
>> > extra is needed here.
>>
>> You mean your wacom touch device are being directed to synaptics X
>> driver without modifications to udev or similar rules? =A0On my
>> unmodified Fedora box, they both go to wacom X driver.
>>
>> Not that it would be a difficult modification... I'd just need to ma=
ke
>> those and work with distributions to also align.
>
> 50-wacom.conf sorts after 50-synaptics.conf and since we apply the wa=
com
> driver to anything with Wacom in the product name, it overrides the
> synaptics setting. not a big deal at all, just renaming it to 40-waco=
m.conf
> should already do the job.
>
> Cheers,
> =A0Peter
>

Thanks for tip.  I verified its that easy.  I renamed to 40-wacom.conf
and on my Bamboo Pen&Touch, the tablet part is grabbed by
xf86-input-wacom and the touchpad part is grabbed by
xf86-input-synaptics.

Note I have the linuxwacom (out-of-tree) driver installed which makes
my Bamboo talk like the in-tree wacom Tablet PC logic.  And in this
case, I get no responses from the Bamboo touchpad and
xf86-input-synaptics combo.

I mention this because udev is reporting Tablet PC as a touchpad.  So
if we change to allow remapping Bamboo's to xf86-input-synaptics then
we either need to update Tablet PC logic to be synaptics-like in
kernel or we need an exception to allow older Tablet PC to continue to
be handled by xf86-input-wacom.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
