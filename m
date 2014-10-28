From: Ping Cheng <pinglinux@gmail.com>
Subject: Fwd: [PATCH] HID: input: Fix TransducerSerialNumber implementation
Date: Tue, 28 Oct 2014 12:33:49 -0700
Message-ID: <CAF8JNhLO_muLa=6oB31JF6NZn1uquVS+heeSqzKPSyCqB31csA@mail.gmail.com>
References: <6B3C86448604A642A31AAD3F8C07EA7724F0B8CD@Exchange1.wacom.com>
	<1411495768-5956-1-git-send-email-killertofu@gmail.com>
	<CAF8JNhKYmBpgp4yRvQbxuaAPSk5dG3YW7qqZnrBAB22bRXPEJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:34998 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbaJ1Tdv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2014 15:33:51 -0400
Received: by mail-la0-f45.google.com with SMTP id gm9so1295738lab.18
        for <linux-input@vger.kernel.org>; Tue, 28 Oct 2014 12:33:50 -0700 (PDT)
In-Reply-To: <CAF8JNhKYmBpgp4yRvQbxuaAPSk5dG3YW7qqZnrBAB22bRXPEJg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

On Tue, Sep 23, 2014 at 11:09 AM, Jason Gerecke <killertofu@gmail.com> wrote:
>
> The commit which introduced TransducerSerialNumber (368c966) is missing
> two crucial implementation details. Firstly, the commit does not set the
> type/code/bit/max fields as expected later down the code which can cause
> the driver to crash when a tablet with this usage is connected. Secondly,
> the call to 'set_bit' causes MSC_PULSELED to be sent instead of the
> expected MSC_SERIAL. This commit addreses both issues.
>
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>


Reviewed-by: Ping Cheng <pingc@wacom.com>

Thank you, Jason, for the fix.

Ping

> ---
>  drivers/hid/hid-input.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 2619f7f..cb1b3fa 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -689,7 +689,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>                         break;
>
>                 case 0x5b: /* TransducerSerialNumber */
> -                       set_bit(MSC_SERIAL, input->mscbit);
> +                       usage->type = EV_MSC;
> +                       usage->code = MSC_SERIAL;
> +                       bit = input->mscbit;
> +                       max = MSC_MAX;
>                         break;
>
>                 default:  goto unknown;
> --
> 2.1.0
>
