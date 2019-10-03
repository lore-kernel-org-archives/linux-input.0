From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: add input_get_poll_interval()
Date: Thu, 3 Oct 2019 14:34:59 -0400
Message-ID: <CAO-hwJ+v1jJJ=APP__84SPrFdR+Te8nAxR6DirD8a9US_Bm4wQ@mail.gmail.com>
References: <20191002215812.GA135681@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002215812.GA135681@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Wed, Oct 2, 2019 at 5:58 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Some drivers need to be able to know the current polling interval for
> devices working in polling mode, let's allow them fetching it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Not sure if you really need my input on this one, but, sure, looks good to =
me:
Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/input/input-poller.c | 9 +++++++++
>  include/linux/input.h        | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/input/input-poller.c b/drivers/input/input-poller.c
> index 1b3d28964bb2..7d6b4e8879f1 100644
> --- a/drivers/input/input-poller.c
> +++ b/drivers/input/input-poller.c
> @@ -123,6 +123,15 @@ void input_set_max_poll_interval(struct input_dev *d=
ev, unsigned int interval)
>  }
>  EXPORT_SYMBOL(input_set_max_poll_interval);
>
> +int input_get_poll_interval(struct input_dev *dev)
> +{
> +       if (!dev->poller)
> +               return -EINVAL;
> +
> +       return dev->poller->poll_interval;
> +}
> +EXPORT_SYMBOL(input_get_poll_interval);
> +
>  /* SYSFS interface */
>
>  static ssize_t input_dev_get_poll_interval(struct device *dev,
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 31da4feaa1d8..a420324b7882 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -387,6 +387,7 @@ int input_setup_polling(struct input_dev *dev,
>  void input_set_poll_interval(struct input_dev *dev, unsigned int interva=
l);
>  void input_set_min_poll_interval(struct input_dev *dev, unsigned int int=
erval);
>  void input_set_max_poll_interval(struct input_dev *dev, unsigned int int=
erval);
> +int input_get_poll_interval(struct input_dev *dev);
>
>  int __must_check input_register_handler(struct input_handler *);
>  void input_unregister_handler(struct input_handler *);
> --
> 2.23.0.444.g18eeb5a265-goog
>
>
> --
> Dmitry
