From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: patch staging-htc-dream-touchscreen-driver-for-staging.patch
	added to gregkh-2.6 tree
Date: Mon, 27 Jul 2009 17:29:17 -0700
Message-ID: <d6200be20907271729l4cf2f519occ8ebc1024e5140a@mail.gmail.com>
References: <20090720105340.GF19341@elf.ucw.cz> <1248710770577@kroah.org>
	 <d6200be20907271545l4edc4480v22f6dec4cd3d5dc9@mail.gmail.com>
	 <20090727225545.GC7142@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:50049 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbZG1A3R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2009 20:29:17 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1857865qwh.37
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2009 17:29:17 -0700 (PDT)
In-Reply-To: <20090727225545.GC7142@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: gregkh@suse.de, greg@kroah.com, swetland@google.com, linux-input@vger.kernel.org

On Mon, Jul 27, 2009 at 3:55 PM, Pavel Machek<pavel@ucw.cz> wrote:
> On Mon 2009-07-27 15:45:48, Arve Hj?nnev?g wrote:
>> On Mon, Jul 27, 2009 at 9:06 AM, <gregkh@suse.de> wrote:
>> ...
>> > This is original version from Arve, fixed only to compile; I do ha=
ve
>> > cleaner version, but I broken something inside, and this will pres=
erve
>> > authorship better. I originally tried to push the driver directly =
to
>> > input/touchscreen, but the driver has some issues with interrupt
>> > handling that are more difficult to fix than I expected at first.
>> >
>>
>> While it would be nice to use the threaded interrupt support, I don'=
t
>> see why that change cannot be postponed until the the threaded
>> interrupt code supports this class of devices where the interrupt
>> needs to be masked before the thread can run.
>
> That's up to linux-input people, I guess. But...
>
> From the discussion, it seems that the driver has more issues. I have
> quite long list.
>
> 1) either it needs to switch to threaded interrupt supports, or all
> the races need to be fixed.
>
> [Comments I remember here is:]
>
> (
>> > + =A0 =A0 =A0 =A0 =A0 ts->input_dev->name, ts->use_irq ? "interrup=
t" :
> "polling");
>> > +
>> > + =A0 return 0;
>> > +
>> > + err_input_register_device_failed:
>> > + =A0 input_free_device(ts->input_dev);
>> > +
>>
>> Don't see canceling timer nor shutting off WQ here. Also, maybe
>> implement open() and close() so we don't reschedule WQ while polling=
?_
> )

Unless you changed something there should be no failure path after
starting the timer or enabling the interrupt.

synaptics_ts_remove is missing a flush_work call though.

>
> 2) it uses non-standard multitouch support. Either multitouch needs t=
o
> be disabled for merge, or it needs to switch to standard config.
>

I have a patch that adds support for the new protocol, but it does not
yet remove the old hack.

> 3) poll mode should probably be removed.
>
> 4) minor stuff, like properly filling identification fields
> (vendor/device/product) etc.
>
> Yes, ideally it should be 3 or 4 patches and it is out of staging and
> in the kernel proper. But as I already got patches for people trying
> to help with cleaning, I believe staging is right place for
> it.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
>



--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
