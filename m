From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: logitech-dj: Fix check of logi_dj_recv_query_paired_devices()
Date: Mon, 5 Aug 2019 11:27:12 +0200
Message-ID: <CAO-hwJLstTVmr7+sTXYAjO8H4K00emBdUhRgU1FWD6TpBOSUrg@mail.gmail.com>
References: <20190725145719.8344-1-yuehaibing@huawei.com> <20190731105927.GA5092@dell5510>
 <20190731110629.GB5092@dell5510> <3e9bda5b-68dc-15b9-ca79-2e73567ea0a5@redhat.com>
 <nycvar.YFH.7.76.1908051051080.5899@cbobk.fhfr.pm> <7988688e-8020-3d03-63cd-d844c01e5bf6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7988688e-8020-3d03-63cd-d844c01e5bf6@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Petr Vorel <pvorel@suse.cz>, YueHaibing <yuehaibing@huawei.com>, lkml <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi all,

On Mon, Aug 5, 2019 at 10:55 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Jiri,
>
> On 05-08-19 10:51, Jiri Kosina wrote:
> > On Wed, 31 Jul 2019, Hans de Goede wrote:
> >
> >>>>> In delayedwork_callback(), logi_dj_recv_query_paired_devices
> >>>>> may return positive value while success now, so check it
> >>>>> correctly.
> >>>
> >>>>> Fixes: dbcbabf7da92 ("HID: logitech-dj: fix return value of
> >>>>> Fixes: logi_dj_recv_query_hidpp_devices")
> >>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> >>> OK, not only it didn't fix problems with logitech mouse (see below),
> >>> but removing mouses USB dongle effectively crashes kernel, so this one
> >>> probably
> >>> shouldn't be applied :).
> >>>
> >>> [  330.721629] logitech-djreceiver: probe of 0003:046D:C52F.0013 failed with
> >>> error 7
> >>> [  331.462335] hid 0003:046D:C52F.0013: delayedwork_callback:
> >>> logi_dj_recv_query_paired_devices error: 7
> >>
> >> Please test my patch titled: "HID: logitech-dj: Really fix return value of
> >> logi_dj_recv_query_hidpp_devices"
> >> which should fix this.
> >
> > Hans, have I been CCed on that patch? I don't seem to see it in in inbox.
>
> I have "Jiri Kosina <jikos@kernel.org>" in the To: for the patch in the
> copy in my Inbox (I always Cc myself).
>
> Anyways, you can grab it here:
>
> https://patchwork.kernel.org/patch/11064087/
>
> It has gathered 2 Tested-by-s and 2 Reviewed-by-s since posting, so
> assuming you like it too, this is ready for merging.
>

Sorry for being silent on the mailing list.

I have been 2 weeks on PTO, and when I came back, my server that shown
a few corruptions here and there was completely broken.
I spent the last week trying to revive it until I realized that I have
a bad memory chip on it, which introduced random errors.

Anyway, I think Hans' patch should go in, but I am not fully
operational given that my test box is still recovering :(

Cheers,
Benjamin
