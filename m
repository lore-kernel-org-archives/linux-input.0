From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 0/4] mxs-lradc: Split driver into MFD
Date: Wed, 24 Aug 2016 19:30:22 -0300
Message-ID: <CAOMZO5AM4_51ahmaC5+XKP1GJg1Ltm=nmB2_Ou8_Hk0zOMSh=A@mail.gmail.com>
References: <cover.1471524593.git.ksenija.stanojevic@gmail.com> <770097944.403326.225ddbfe-fd96-4f9b-a2b9-e0173af882ba.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <770097944.403326.225ddbfe-fd96-4f9b-a2b9-e0173af882ba.open-xchange-7tX72C7vayboQLBSYMtkGA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Harald Geyer <harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Stefan,

On Tue, Aug 23, 2016 at 5:18 PM, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
> Hi,
>
> [add Fabio's NXP address]
>
>> Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> hat am 18. August 2016 um
>> 15:44 geschrieben:
>>
>>
>> Split existing driver mxs-lradc into MFD with touchscreen and
>> IIO part.
>>
>> Tested on I.MX28.
>
> i tested the patch 1 and 2 successful on a i.MX23 board.
>
> Tested-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>

Series looks good. I can't test the touchscreen at the moment because
I don't have access to my mx28evk display, but as it was tested on
mx23 and mx28 we are fine then.

Thanks
