From: Hardiksingh Rathore <hardiksingh.k@gmail.com>
Subject: Re: [PATCH] Input: touchscreen: ad7879: Fix ERROR: foo* bar should be
 "foo *bar"
Date: Tue, 11 Dec 2018 17:19:33 +0530
Message-ID: <CALxnk1NLo9cAUXB=oxkvz7AQnxb7dqdeG9A_MA=OwgTkYfu-yg@mail.gmail.com>
References: <20181210154433.28319-1-hardiksingh.k@gmail.com> <44f0a055e4085824629285e78ac4928e15c494e3.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <44f0a055e4085824629285e78ac4928e15c494e3.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joe@perches.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, michael.hennerich@analog.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Joe,

On Tue, 11 Dec 2018 at 01:07, Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2018-12-10 at 21:14 +0530, Hardik Singh Rathore wrote:
> > Fix the coding style problem reported by checkpatch.pl.
>
> While whitespace only checkpatch cleanups are generally not
> well accepted, why do one pointer location cleanup when you
> could them all:
>
As suggested, I have sent the v2 patch for pointer location cleanups
in all other
drivers/input/touchscreen/* files.

> $ ./scripts/checkpatch.pl -f --types=pointer_location --fix-inplace drivers/input/touchscreen/*.[ch]
> $ git diff --stat -p drivers/input/touchscreen/
>
> produces:
> ---
>  drivers/input/touchscreen/ad7879.c   | 2 +-
>  drivers/input/touchscreen/ektf2127.c | 2 +-
>  drivers/input/touchscreen/gunze.c    | 4 ++--
>  drivers/input/touchscreen/inexio.c   | 4 ++--
>  drivers/input/touchscreen/mtouch.c   | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index 2aae880c8aa6..6fa714c587b4 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -289,7 +289,7 @@ static int ad7879_open(struct input_dev *input)
>         return 0;
>  }
>
> -static void ad7879_close(struct input_dev* input)
> +static void ad7879_close(struct input_dev *input)
>  {
>         struct ad7879 *ts = input_get_drvdata(input);
>
> diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
> index 0ed34ff787ce..28fa1b36f7a5 100644
> --- a/drivers/input/touchscreen/ektf2127.c
> +++ b/drivers/input/touchscreen/ektf2127.c
> @@ -51,7 +51,7 @@ struct ektf2127_ts {
>         struct touchscreen_properties prop;
>  };
>
> -static void ektf2127_parse_coordinates(const u8* buf, unsigned int touch_count,
> +static void ektf2127_parse_coordinates(const u8 *buf, unsigned int touch_count,
>                                        struct input_mt_pos *touches)
>  {
>         int index = 0;
> diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
> index 054c2537b392..56cf1a1ea3ea 100644
> --- a/drivers/input/touchscreen/gunze.c
> +++ b/drivers/input/touchscreen/gunze.c
> @@ -53,7 +53,7 @@ struct gunze {
>         char phys[32];
>  };
>
> -static void gunze_process_packet(struct gunze* gunze)
> +static void gunze_process_packet(struct gunze *gunze)
>  {
>         struct input_dev *dev = gunze->dev;
>
> @@ -72,7 +72,7 @@ static void gunze_process_packet(struct gunze* gunze)
>  static irqreturn_t gunze_interrupt(struct serio *serio,
>                 unsigned char data, unsigned int flags)
>  {
> -       struct gunze* gunze = serio_get_drvdata(serio);
> +       struct gunze *gunze = serio_get_drvdata(serio);
>
>         if (data == '\r') {
>                 gunze_process_packet(gunze);
> diff --git a/drivers/input/touchscreen/inexio.c b/drivers/input/touchscreen/inexio.c
> index b9bc56233ccc..13bd0bf580a7 100644
> --- a/drivers/input/touchscreen/inexio.c
> +++ b/drivers/input/touchscreen/inexio.c
> @@ -79,7 +79,7 @@ static void inexio_process_data(struct inexio *pinexio)
>  static irqreturn_t inexio_interrupt(struct serio *serio,
>                 unsigned char data, unsigned int flags)
>  {
> -       struct inexio* pinexio = serio_get_drvdata(serio);
> +       struct inexio *pinexio = serio_get_drvdata(serio);
>
>         pinexio->data[pinexio->idx] = data;
>
> @@ -97,7 +97,7 @@ static irqreturn_t inexio_interrupt(struct serio *serio,
>
>  static void inexio_disconnect(struct serio *serio)
>  {
> -       struct inexio* pinexio = serio_get_drvdata(serio);
> +       struct inexio *pinexio = serio_get_drvdata(serio);
>
>         input_get_device(pinexio->dev);
>         input_unregister_device(pinexio->dev);
> diff --git a/drivers/input/touchscreen/mtouch.c b/drivers/input/touchscreen/mtouch.c
> index a3707fad4d1c..8278a9058640 100644
> --- a/drivers/input/touchscreen/mtouch.c
> +++ b/drivers/input/touchscreen/mtouch.c
> @@ -90,7 +90,7 @@ static void mtouch_process_response(struct mtouch *mtouch)
>  static irqreturn_t mtouch_interrupt(struct serio *serio,
>                 unsigned char data, unsigned int flags)
>  {
> -       struct mtouch* mtouch = serio_get_drvdata(serio);
> +       struct mtouch *mtouch = serio_get_drvdata(serio);
>
>         mtouch->data[mtouch->idx] = data;
>
> @@ -110,7 +110,7 @@ static irqreturn_t mtouch_interrupt(struct serio *serio,
>
>  static void mtouch_disconnect(struct serio *serio)
>  {
> -       struct mtouch* mtouch = serio_get_drvdata(serio);
> +       struct mtouch *mtouch = serio_get_drvdata(serio);
>
>         input_get_device(mtouch->dev);
>         input_unregister_device(mtouch->dev);
>
>


-- 
Thanks,
Hardik
