From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/3] Logitech G920 fixes
Date: Fri, 11 Oct 2019 16:53:24 +0200
Message-ID: <CAO-hwJ+=pDmvPbLVO8mViygJof7O1YeX3KO951nqN4dNaKz83g@mail.gmail.com>
References: <20191007051240.4410-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191007051240.4410-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, Sam Bazely <sambazley@fastmail.com>, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Austin Palmer <austinp@valvesoftware.com>, lkml <linux-kernel@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

Finally, someone who takes care of the G920!
Note that when I sent my first initial version that Hans reused, I
surely broke it (looking at your patch 3/3), but no one cared to test
it :(

On Mon, Oct 7, 2019 at 7:13 AM Andrey Smirnov <andrew.smirnov@gmail.com> wr=
ote:
>
> Everyone:
>
> This series contains patches to fix a couple of regressions in G920
> wheel support by hid-logitech-hidpp driver. Without the patches the
> wheel remains stuck in autocentering mode ("resisting" any attempt to
> trun) as well as missing support for any FF action.

So, you are talking about regressions, and for that I would like to be
able to push the patches to stable.

However, I would need more information:
- patch 3/3 seems simple enough to go in stable, and is clearly a
regression from the recent series. Can you put it in first and add
stable@vger.kernel.org in a CC field (and possibly with a Fixes tag as
well)?
- I am not sure which patch fixes the wheel remains stuck in
autocentering mode. Is it patch 2/3?
- was the "wheel remains stuck in autocentering mode" bug present from
on of the recent patch or was it always there since we introduced
support in hid-logitech-hidpp, but the game would need to unlock the
wheel first?

So all in all, can you:
- drop the first patch and push it in a later series
- re-order the patches: 3/3 then 2/3
- tell me when the wheel is not stuck when the series is applied
(after 3/3 or 2/3), and make a note in the commit message with that
information
- take into account my comments in the first patch you submitted (that
I just sent).

Cheers,
Benjamin


>
> Thanks,
> Andrey Smirnov
>
> Andrey Smirnov (3):
>   HID: logitech-hidpp: use devres to manage FF private data
>   HID: logitech-hidpp: split g920_get_config()
>   HID: logitech-hidpp: add G920 device validation quirk
>
>  drivers/hid/hid-logitech-hidpp.c | 193 +++++++++++++++++++------------
>  1 file changed, 120 insertions(+), 73 deletions(-)
>
> --
> 2.21.0
>
