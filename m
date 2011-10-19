From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] Input: atmel_mxt_ts - Use snprintf for sysfs attribute
 show method
Date: Wed, 19 Oct 2011 15:40:16 +0800
Message-ID: <CAGS+omDJM700h22zsAQZRn_9qCcUk1gJsKN0GzQxG7FkK-PRsQ@mail.gmail.com>
References: <1316115647-1244-1-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316115647-1244-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, Yufeng Shen <miletus@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

I fear the following=A0patch, and its 'Acked-by' from Nick Dyer, may
have gotten lost:

On Fri, Sep 16, 2011 at 3:40 AM, Daniel Kurtz <djkurtz@chromium.org> wr=
ote:
>
> Sysfs attribute show methods are always passed a buffer of length
> PAGE_SIZE. =A0To keep from overwriting this buffer and causing havoc,=
 use
> snprintf() to guarantee we never write more than the buffer can hold.
>
> In addition, at least for my touchscreen, the number and size of obje=
cts
> was far too big to fit in a single 4K page. =A0Therefore, this patch =
also
> trims some redundant framing text to leave more room for actual data.
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
> =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0 21 +++++++++++++++-=
-----
> =A01 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input=
/touchscreen/atmel_mxt_ts.c
> index f5d6685..a596c27 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -910,12 +910,17 @@ static ssize_t mxt_object_show(struct device *d=
ev,
> =A0 =A0 =A0 =A0for (i =3D 0; i < data->info.object_num; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0object =3D data->object_table + i;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D sprintf(buf + count,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Object=
 Table Element %d(Type %d)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D snprintf(buf + count, PAGE_S=
IZE - count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Object=
[%d] (Type %d)\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i + 1,=
 object->type);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count >=3D PAGE_SIZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PAGE_SIZE - 1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!mxt_object_readable(object->type)=
) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D sprintf(buf =
+ count, "\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D snprintf(buf=
 + count, PAGE_SIZE - count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count >=3D PAGE_SIZ=
E)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
PAGE_SIZE - 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> @@ -925,11 +930,15 @@ static ssize_t mxt_object_show(struct device *d=
ev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 error;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D sprintf(buf =
+ count,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 " =A0Byte %d: 0x%x (%d)\n", j, val, val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D snprintf(buf=
 + count, PAGE_SIZE - count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "\t[%2d]: %02x (%d)\n", j, val, val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count >=3D PAGE_SIZ=
E)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
PAGE_SIZE - 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D sprintf(buf + count, "\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D snprintf(buf + count, PAGE_S=
IZE - count, "\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count >=3D PAGE_SIZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PAGE_SIZE - 1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return count;
> --
> 1.7.3.1
>

On Thu, Oct 6, 2011 at 5:59 PM, Nick Dyer <nick.dyer@itdev.co.uk> wrote=
:
> Hi Daniel-
>
> Just to introduce myself, I'm working for Atmel in UK on the atmel_mx=
t_ts
> driver.
>
> Daniel Kurtz wrote:
>> Sysfs attribute show methods are always passed a buffer of length
>> PAGE_SIZE. =A0To keep from overwriting this buffer and causing havoc=
,
>> use snprintf() to guarantee we never write more than the buffer can
>> hold.
>>
>> In addition, at least for my touchscreen, the number and size of
>> objects was far too big to fit in a single 4K page. =A0Therefore, th=
is
>> patch also trims some redundant framing text to leave more room for
>> actual data.
>
> Yes, I'd noticed this problem as well. I was planning to address it b=
y
> splitting up the file, but your patch looks like a good solution for =
now.
>
> I've tested it successfully on several chips.
>
> Acked-by: Nick Dyer <nick.dyer@itdev.co.uk>
>
> --
> Nick Dyer
> Software Engineer, ITDev =A0Ltd
>
> Hardware and Software Development Consultancy
>
> Email: =A0 nick.dyer@itdev.co.uk
> Website: http://www.itdev.co.uk
