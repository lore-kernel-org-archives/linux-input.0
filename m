From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 0/3] Logitech G920 fixes
Date: Fri, 11 Oct 2019 11:19:07 -0700
Message-ID: <CAHQ1cqHU2DmKzAtcDCPLtUXwkzhyCynki3GKOwgULnN0ya6POg@mail.gmail.com>
References: <20191007051240.4410-1-andrew.smirnov@gmail.com> <CAO-hwJ+=pDmvPbLVO8mViygJof7O1YeX3KO951nqN4dNaKz83g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJ+=pDmvPbLVO8mViygJof7O1YeX3KO951nqN4dNaKz83g@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, Sam Bazely <sambazley@fastmail.com>, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Austin Palmer <austinp@valvesoftware.com>, lkml <linux-kernel@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 11, 2019 at 7:53 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi,
>
> Finally, someone who takes care of the G920!
> Note that when I sent my first initial version that Hans reused, I
> surely broke it (looking at your patch 3/3), but no one cared to test
> it :(
>
> On Mon, Oct 7, 2019 at 7:13 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >
> > Everyone:
> >
> > This series contains patches to fix a couple of regressions in G920
> > wheel support by hid-logitech-hidpp driver. Without the patches the
> > wheel remains stuck in autocentering mode ("resisting" any attempt to
> > trun) as well as missing support for any FF action.
>
> So, you are talking about regressions, and for that I would like to be
> able to push the patches to stable.
>
> However, I would need more information:
> - patch 3/3 seems simple enough to go in stable, and is clearly a
> regression from the recent series. Can you put it in first and add
> stable@vger.kernel.org in a CC field (and possibly with a Fixes tag as
> well)?

It patch 3/3 on purpose because applying it by itself, without fix in
2/3 in place would lead to a segfault and a non working wheel. Maybe
that FF for-next fix you pointed out can prevent that from happening,
but as is the series is pretty atomic and can't be divided.

Patch 3/3 already has stable in CC and Fixes tag.

> - I am not sure which patch fixes the wheel remains stuck in
> autocentering mode. Is it patch 2/3?

There's no specific patch that does that. There were two G920
regressions in the driver and both need to be fixed for wheel to be
configured properly. The specific code that releases the wheel is in
g920_ff_set_autocenter().

> - was the "wheel remains stuck in autocentering mode" bug present from
> on of the recent patch or was it always there since we introduced
> support in hid-logitech-hidpp, but the game would need to unlock the
> wheel first?

The wheel worked as expected prior to

fe3ee1ec007b ("HID: logitech-hidpp: allow non HID++ devices to be
handled by this module")
91cf9a98ae41 ("HID: logitech-hidpp: make .probe usbhid capable")

It's not the game that needs to unlock the wheel, but the driver itself.

Thanks,
Andrey Smirnov
