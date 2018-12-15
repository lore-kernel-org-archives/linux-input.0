From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [rfd] saving old mice -- button glitching/debouncing
Date: Fri, 14 Dec 2018 16:19:56 -0800
Message-ID: <CAKdAkRREmAu83Q97WQa2uJbnBKySjkN2HH4DMockFFzLeT3TiA@mail.gmail.com>
References: <20181214232437.GA8310@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214232437.GA8310@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, jikos@suse.cz, Vojtech Pavlik <vojtech@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Pavel,

On Fri, Dec 14, 2018 at 3:24 PM Pavel Machek <pavel@ucw.cz> wrote:
>
>
> I believe I have hardware problem, but I'm kind of hoping software
> could help me...?
>
> Mouse wheel on my machine started glitching on my machine, generating
> double-clicks when I click it once. Which unfortunately is quite
> annoying: texts are pasted twice, two tabs are closed instead of one,
> ....
>
> Event: time 1544733054.903129, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90003
> Event: time 1544733054.903129, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> Event: time 1544733054.903129, -------------- EV_SYN ------------
>             1544733054.967251, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90003
> Event: time 1544733054.967251, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> Event: time 1544733054.967251, -------------- EV_SYN ------------
> Event: time 1544733054.975144, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90003
> Event: time 1544733054.975144, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> Event: time 1544733054.975144, -------------- EV_SYN ------------
>      : time 1544733065.127190, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90003
> Event: time 1544733065.127190, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> Event: time 1544733065.127190, -------------- EV_SYN ------------
>
> Now, I could just buy a new mouse, but it seems that most optical mice
> die like this... so maybe it would be nice to have an option to
> debounce the buttons, so that the useful life of mice is extended a
> bit?
>
> (So... I have two mice with that fault -- cheap to replace, but button
> in thinkpad X220 started doing that, too. That one will not be so
> cheap to fix :-( ).
>
> It is possible that some X versions already do something like this.
>
> Patch is obviously not ready; but:
>
> a) would it be useful to people
>
> b) would it be acceptable if done properly? (cmd line option to
> enable, avoiding duplicate/wrong events?)

I'd say if you are attached to failing hardware, solve it in
userspace. Have a utility/daemon that you run (from udev?) that:

- "grabs" input device with EVIOCGRAB
- does the debouncing/filtering/adjusting for the dirty sensor
- reinject events back into kernel with /dev/uinput

It will add some latency, but should be workable.

Thanks.

-- 
Dmitry
