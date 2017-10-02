From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] Quirks cleanup and hid-generic niceness
Date: Mon, 2 Oct 2017 22:23:28 +0200
Message-ID: <CAN+gG=ESSNFQugn7W-XvPrqyzt1eDcEcde4_9S4Pc0t=rHmtPw@mail.gmail.com>
References: <20171002201850.13175-1-kernel-team@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171002201850.13175-1-kernel-team-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Niels Skou Olsen <nolsen-qGsLMUQfN6MAvxtiuMwx3w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 2, 2017 at 10:18 PM, Fedora Kernel Team
<kernel-team-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org> wrote:

Ouch, I happen to be in a git tree of the Fedora kernel, so git
send-email decided to rewrite the 'from:' field.
I'll add this to my check list before sending :/

Cheers,
Benjamin

> From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
> Hi,
>
> This is the series I was talking about earlier[1].
>
> Basically, Jiri, I'd like to see 1-3 applied in for-next at your earliest
> convenience, and we can discuss about 4/4 without any rush.
>
> I have this in my local tree since June, but I made some late minute
> changes before sending, though the tests showed they are fine (I wouldn't
> mind a second pair of eyes on it).
>
> I am pretty sure we can optimize the things more, but for now this should be
> just fine and just convert the quirks mechanism in hid-core.
> For instance, there is a second call of hid_lookup_quirk() in usbhid/hid-core.c
> that I am not sure about the absolute need.
>
> Niels, please have a look at this and tell me if you are OK to rebase your
> series on top of it.
>
> Cheers,
> Benjamin
>
>
> [1] https://patchwork.kernel.org/patch/9980443/
>
> Benjamin Tissoires (4):
>   HID: core: move the dynamic quirks handling in core
>   HID: quirks: move the list of special devices into a quirk
>   HID: core: move the list of ignored devices in hid-quirks.c
>   HID: core: remove the absolute need of hid_have_special_driver[]
>
>  drivers/hid/Makefile            |    2 +-
>  drivers/hid/hid-core.c          |  925 ++---------------------------
>  drivers/hid/hid-generic.c       |   68 ++-
>  drivers/hid/hid-quirks.c        | 1242 +++++++++++++++++++++++++++++++++++++++
>  drivers/hid/usbhid/Makefile     |    2 +-
>  drivers/hid/usbhid/hid-core.c   |   10 +-
>  drivers/hid/usbhid/hid-quirks.c |  401 -------------
>  include/linux/hid.h             |   21 +-
>  net/bluetooth/hidp/core.c       |    2 +-
>  9 files changed, 1388 insertions(+), 1285 deletions(-)
>  create mode 100644 drivers/hid/hid-quirks.c
>  delete mode 100644 drivers/hid/usbhid/hid-quirks.c
>
> --
> 2.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
