From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 3/4] Input: gpio_keys - Allow suppression of input
 events for wakeup button presses
Date: Mon, 30 Oct 2017 13:48:09 -0700
Message-ID: <20171030204809.mciyapkfqlihg3jd@dtor-ws>
References: <20171030174050.30375-1-hdegoede@redhat.com>
 <20171030174050.30375-3-hdegoede@redhat.com>
 <20171030181706.huwka5foqxparsiq@dtor-ws>
 <b6016f99-a313-164b-9e45-8611982d03a1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:52156 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbdJ3UsN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Oct 2017 16:48:13 -0400
Received: by mail-io0-f194.google.com with SMTP id b186so30270563iof.8
        for <linux-input@vger.kernel.org>; Mon, 30 Oct 2017 13:48:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b6016f99-a313-164b-9e45-8611982d03a1@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Mon, Oct 30, 2017 at 09:08:21PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 30-10-17 19:17, Dmitry Torokhov wrote:
> > On Mon, Oct 30, 2017 at 06:40:49PM +0100, Hans de Goede wrote:
> > > In some cases it is undesirable for a wakeup button to send input events
> > > to userspace if pressed to wakeup the system (if pressed during suspend).
> > > 
> > > A typical example of this is the power-button on laptops / tablets,
> > > sending a KEY_POWER event to userspace when woken up with the power-button
> > > will cause userspace to immediately suspend the system again which is
> > > undesirable.
> > > 
> > > For power-buttons attached to a PMIC, or handled by e.g. ACPI, not sending
> > > an input event in this case is take care of by the PMIC / ACPI hardware /
> > > code. But in the case of a GPIO button we need to explicitly suppress the
> > > sending of the input event.
> > > 
> > > This commit supports this by adding a suppress_evdev_events_on_wakeup bool
> > > to struct gpio_keys_button, which platform code can set to suppress the
> > > input events for presses of wakeup keys during suspend.
> > 
> > I think this is [your] userspace issue.
> 
> It would have been nice if you started discussing this when I posted v1
> quite some time ago.

The original commits IIRC were about poor quality of buttons on these
x86 tablets and the apparent need for debounce on resume path. Or did I
mix them up with something else.

> 
> > What if I press the button
> > rapidly several times?
> 
> Why would anyone do that ?  But to answer the question it depends on

Because they can?

> the timing, if you keep pressing it long enough for the resume to complete
> then the first press after that will cause it to suspend again.
> 
> > I know Android actually _wants_ to see KEY_POWER
> > at resume, or its opportunistic suspend will kick in right away.
> 
> Hmm, that is weird, because I believe that android x86 does work
> on regular PCs and they do not do that.

The commit 0f107573da417c7f5c6d3a0160ebacc3adb019c4 was done
specifically so that Pixel C would resume if power button was pressed
and immediately released. I.e. before there was inconsistency with
driver behavior, depending on how long the button was pressed.

I am not sure about android x86 frankly.

> 
> > I think
> > ChromeOS is OK with getting KEY_POWER on resume as well.
> > 
> > I'd say you need to have a small timeout before you start suspending
> > again.
> 
> The problem with that is that it is going to be inherently racy.

Racy in what way?

> 
> More in general Bay Trail / Cherry Trail devices using gpio_key
> for their power-button are the only "PC" devices sending a
> KEY_POWER after wake-up, Bay / Cherry Trail devices which
> have their power button hooked-up differently such as the Asus
> Transformer series do not do this.
> 
> So both for consistency and because a timeout is racy I believe
> that having the power button not send KEY_POWER after resume is
> the proper solution here.
> 
> Note that I've made this configurable and that soc_button_array
> is the only driver getting this enabled, making the power-button
> behavior on PC like devices consistent, without impacting any
> other devices.

I'd rather we did not make assumption in the kernel about behavior of
userspace we happen to run on. The "PC like" devices change all the
time, and one could even say that failure to deliver events by ACPI
drivers on resume is a bug.

Please teach userspace how to handle events coming during resume phase
and what to do about them, and be done with it. One option is to say (in
whatever implements your power policy) "we want to ignore next KEY_POWER
event for the next NNN msec". You will need it ianyway if you decide to
put your userspace onto, let's say, ASUS Flip (an ARM device using
gpio-keys for power button and volume up/down buttons on the side of the
case).

Thanks.

-- 
Dmitry
