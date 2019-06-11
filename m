From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH -next] HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices
Date: Tue, 11 Jun 2019 12:48:09 +0200
Message-ID: <CAO-hwJJYWGjp=gNs7X5fsg0tf18hpVA0cn63LxAme+LQnp+wrQ@mail.gmail.com>
References: <20190525140908.2804-1-yuehaibing@huawei.com> <50800f5e-867d-ded9-235c-b9c2db1c41ef@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50800f5e-867d-ded9-235c-b9c2db1c41ef@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuehaibing <yuehaibing@huawei.com>
Cc: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, jkosina@suse.cz, lkml <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 11, 2019 at 5:01 AM Yuehaibing <yuehaibing@huawei.com> wrote:
>
> Hi all,
>
> Friendly ping...

Applied to for-5.3/logitech

Thanks!

Cheers,
Benjamin

>
> On 2019/5/25 22:09, YueHaibing wrote:
> > We should return 'retval' as the correct return value
> > instead of always zero.
> >
> > Fixes: 74808f9115ce ("HID: logitech-dj: add support for non unifying receivers")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/hid/hid-logitech-dj.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> > index 41baa4dbbfcc..7f8db602eec0 100644
> > --- a/drivers/hid/hid-logitech-dj.c
> > +++ b/drivers/hid/hid-logitech-dj.c
> > @@ -1133,7 +1133,7 @@ static int logi_dj_recv_query_hidpp_devices(struct dj_receiver_dev *djrcv_dev)
> >                                   HID_REQ_SET_REPORT);
> >
> >       kfree(hidpp_report);
> > -     return 0;
> > +     return retval;
> >  }
> >
> >  static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
> >
>
