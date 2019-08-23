From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [Resubmit] Read battery voltage from Logitech Gaming mice
Date: Fri, 23 Aug 2019 10:25:46 +0200
Message-ID: <CAO-hwJKQcTpmk8cVf-YmKu2awXv_53=qfpy2yfmy2rgMu_DEug@mail.gmail.com>
References: <20190822201849.28924-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822201849.28924-1-pedro@pedrovanzella.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pedro Vanzella <pedro@pedrovanzella.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Pedro,

On Thu, Aug 22, 2019 at 10:19 PM Pedro Vanzella <pedro@pedrovanzella.com> wrote:
>
> Resumitting this after having rebased it against the latest changes.

thanks for resubmitting. Sorry I wasn't able to provide feedback on
the last revision

>
> The gaming line of Logitech devices doesn't use the old hidpp20
> feature for battery level reporting. Instead, they report the
> current voltage of the battery, in millivolts.
>
> This patch set handles this case by adding a quirk to the
> devices we know to have this new feature, in both wired
> and wireless mode.

So the quirk is in the end a bad idea after all. I had some chats with
Filipe that made me realize this.
Re-reading our previous exchanges also made me understood why I wasn't
happy with the initial submission: for every request the code was
checking both features 0x1000 and 0x1001 when we can remember this
once and for all during hidpp_initialize_battery().

So I think we should remove the useless quirk in the end (bad idea
from me, I concede), and instead during hidpp_initialize_battery() set
the correct HIDPP_CAPABILITY_*.
Not entirely sure if we should try to call 0x1000, or 0x1001 or if we
should rely on the 0x0001 feature to know which feature is available,
but this should be implementation detail.

>
> This version of the patch set is better split, as well as adding the
> quirk to make sure we don't needlessly probe every device connected.

It is for sure easy to review, but doesn't make much sense in the end.
I think we should squash all the patches together as you are just
adding one feature in the driver, and it is a little bit disturbing to
first add the quirk that has no use, then set up the structs when they
are not used, and so on, so forth.

Cheers,
Benjamin

>
>
