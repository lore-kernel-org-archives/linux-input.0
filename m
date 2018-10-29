From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: moving to group maintainership model
Date: Mon, 29 Oct 2018 16:05:37 +0100
Message-ID: <CAO-hwJLVY25VXyMKWD6u22gWV3mqgu1iXT3chL3rJ8zXbVbwag@mail.gmail.com>
References: <nycvar.YFH.7.76.1810271417230.23511@cbobk.fhfr.pm> <nycvar.YFH.7.76.1810271425060.23511@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1810271425060.23511@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au
List-Id: linux-input@vger.kernel.org

On Sat, Oct 27, 2018 at 2:25 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> From: Jiri Kosina <jkosina@suse.cz>
> Date: Sat, 27 Oct 2018 14:16:13 +0200
> Subject: [PATCH] HID: moving to group maintainership model
>
> Benjamin and myself will from now on be sharing maintainership
> responsibilities for hid.git.
>
> Update maintainers to reflect that change, and also move a git
> repository to shared space at kernel.org.
>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

I guess I can answer this with:
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Jiri, would this need to go through the HID tree or some other? (I guess HID).

> ---
>
> Stephen, could you please update the hid.git URL for linux-next as below?

And thanks Stephen for updating linux-next (and yes, I have read the
linux-next inclusion topic :-P )

Cheers,
Benjamin

> Thanks.
>
> v1->v2: Update all occurences in MAINTAINERS
>
>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0c4c5003998..4715cb8d9584 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6588,9 +6588,9 @@ F:        arch/*/include/asm/suspend*.h
>
>  HID CORE LAYER
>  M:     Jiri Kosina <jikos@kernel.org>
> -R:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
> +M:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
>  L:     linux-input@vger.kernel.org
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
>  S:     Maintained
>  F:     drivers/hid/
>  F:     include/linux/hid*
> @@ -15254,9 +15254,9 @@ F:      include/linux/usb/gadget*
>
>  USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REMOTE CONTROLS, ...)
>  M:     Jiri Kosina <jikos@kernel.org>
> -R:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
> +M:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
>  L:     linux-usb@vger.kernel.org
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
>  S:     Maintained
>  F:     Documentation/hid/hiddev.txt
>  F:     drivers/hid/usbhid/
>
>
> --
> Jiri Kosina
> SUSE Labs
>
