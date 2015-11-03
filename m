From: Petri Gynther <pgynther@google.com>
Subject: Re: [PATCH] HID: hid-gfrm: avoid warning for input_configured API change
Date: Tue, 3 Nov 2015 11:33:11 -0800
Message-ID: <CAGXr9JGO_dcAuTyO2vjvbBwJ7xqcEZ1kWh7WAtxaQiKsdzr1+A@mail.gmail.com>
References: <14835877.IL6ArpWV8Q@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34760 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755186AbbKCTdM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Nov 2015 14:33:12 -0500
Received: by igpw7 with SMTP id w7so75494226igp.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2015 11:33:12 -0800 (PST)
In-Reply-To: <14835877.IL6ArpWV8Q@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Nov 3, 2015 at 6:56 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The input_configured callback was recently changed to return
> an 'int', but the newly added driver uses the old API:
>
> drivers/hid/hid-gfrm.c:151:22: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
>
> This changes the driver like the other ones.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Petri Gynther <pgynther@google.com>

> Fixes: 34fc1322e7aa ("HID: hid-gfrm: Google Fiber TV Box remote controls")
> Fixes: b2c68a2f1bab ("HID: hid-input: allow input_configured callback return errors")
> ---
> Found on ARM allmodconfig with yesterday's linux-next
>
> diff --git a/drivers/hid/hid-gfrm.c b/drivers/hid/hid-gfrm.c
> index 4d7b7e7f0792..075b1c020846 100644
> --- a/drivers/hid/hid-gfrm.c
> +++ b/drivers/hid/hid-gfrm.c
> @@ -88,7 +88,7 @@ static int gfrm_raw_event(struct hid_device *hdev, struct hid_report *report,
>         return (ret < 0) ? ret : -1;
>  }
>
> -static void gfrm_input_configured(struct hid_device *hid, struct hid_input *hidinput)
> +static int gfrm_input_configured(struct hid_device *hid, struct hid_input *hidinput)
>  {
>         /*
>          * Enable software autorepeat with:
> @@ -96,6 +96,7 @@ static void gfrm_input_configured(struct hid_device *hid, struct hid_input *hidi
>          * - repeat period: 100 msec
>          */
>         input_enable_softrepeat(hidinput->input, 400, 100);
> +       return 0;
>  }
>
>  static int gfrm_probe(struct hid_device *hdev, const struct hid_device_id *id)
>
