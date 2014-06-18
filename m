From: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 08/10] mfd: cros_ec: cleanup: Remove EC wrapper functions
Date: Tue, 17 Jun 2014 22:05:14 -0700
Message-ID: <CAPnjgZ22q3-+YGPP3=GeYgk6fxCaaOJV5RZbViiKPgga_bRtGg@mail.gmail.com>
References: <1402954800-28215-1-git-send-email-dianders@chromium.org>
	<1402954800-28215-9-git-send-email-dianders@chromium.org>
	<CAPnjgZ3GhvHog5Pb3_DxYSWF0t4mgR=7HBe2KrfKcsJ=zwmFhQ@mail.gmail.com>
	<CAD=FV=Ue9OBkXtii4aKrCbKPd--7ZRN_G0pw2ZtX89mcz_hfzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=Ue9OBkXtii4aKrCbKPd--7ZRN_G0pw2ZtX89mcz_hfzQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Vincent Palatin <vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lk <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Doug,

On 17 June 2014 21:27, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> Simon,
>
> On Tue, Jun 17, 2014 at 8:42 PM, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>>> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
>>> index 4083796..dc37b6b 100644
>>> --- a/drivers/input/keyboard/cros_ec_keyb.c
>>> +++ b/drivers/input/keyboard/cros_ec_keyb.c
>>> @@ -191,8 +191,18 @@ static void cros_ec_keyb_close(struct input_dev *dev)
>>>
>>>  static int cros_ec_keyb_get_state(struct cros_ec_keyb *ckdev, uint8_t *kb_state)
>>>  {
>>> -       return ckdev->ec->command_recv(ckdev->ec, EC_CMD_MKBP_STATE,
>>> -                                         kb_state, ckdev->cols);
>>> +       int ret;
>>> +       struct cros_ec_command msg = {
>>> +               .version = 0,
>>> +               .command = EC_CMD_MKBP_STATE,
>>> +               .outdata = NULL,
>>> +               .outsize = 0,
>>> +               .indata = kb_state,
>>> +               .insize = ckdev->cols,
>>> +       };
>>> +
>>> +       ret = ckdev->ec->cmd_xfer(ckdev->ec, &msg);
>>
>> Do we need ret?
>
> No.  If you wish I will spin without it.  Let me know.
>
> Note that locally this code includes a comment between the above and the return:
>   /* FIXME: This assumes msg.result == EC_RES_SUCCESS */

It's not important to me, and you've explained the other question.

Reviewed-by: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
