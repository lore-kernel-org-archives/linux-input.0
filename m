From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 3/3] HID: google: whiskers: mask out extra flags in EC event_type
Date: Mon, 7 Oct 2019 15:48:32 -0700
Message-ID: <CA+ASDXPKqVX6QJLB4OvNTGgfJrrEvKYcwzspYAQaicFpymJigQ@mail.gmail.com>
References: <20191005101629.146710-1-ikjn@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191005101629.146710-1-ikjn@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ikjoon Jang <ikjn@chromium.org>
Cc: linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, Enrico Granata <egranata@google.com>, Ting Shen <phoenixshen@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>
List-Id: linux-input@vger.kernel.org

On Sat, Oct 5, 2019 at 3:16 AM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Whiskers needs to get notifications from EC for getting current base
> attached state. EC sends extra bits in event_type field that receiver
> should mask out.

Notably, this patch was never actually landed upstream:

https://lore.kernel.org/patchwork/patch/1019477/
[PATCH] mfd: cros_ec: Add support for MKBP more event flags

and therefore, this EC_CMD_GET_NEXT_EVENT v2 handling is not yet truly
relevant. (i.e., no upstream-proper users should hit this bug yet.)
But that's also a reminder that we need a patch like this for *every*
cros_ec client driver that's using the event_type field. Other
unpatched drivers include
drivers/media/platform/cros-ec-cec/cros-ec-cec.c,
drivers/platform/chrome/cros_ec_chardev.c, and possibly others.

So I wonder: why don't we
(a) *really* try to upstream the above patch and
(b) fix it so that event_data.event_type *always* masks out
EC_MKBP_EVENT_TYPE_MASK
?

(We could still handle the EC_MKBP_HAS_MORE_EVENTS bit within
cros_ec.c, but there's no need for every other driver to have to know
anything about it.)

Of course, this is another reminder that we should *really* try to get
our cros_ec patches landed properly in upstream, because otherwise we
have a different set of bugs and features landing in various
downstream and mostly-upstream kernels.

Brian

...
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -96,8 +96,9 @@ static int cbas_ec_notify(struct notifier_block *nb,
>         struct cros_ec_device *ec = _notify;
>         unsigned long flags;
>         bool base_present;
> +       const u8 event_type = ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
>
> -       if (ec->event_data.event_type == EC_MKBP_EVENT_SWITCH) {
> +       if (event_type == EC_MKBP_EVENT_SWITCH) {
>                 base_present = cbas_parse_base_state(
>                                         &ec->event_data.data.switches);
>                 dev_dbg(cbas_ec.dev,
