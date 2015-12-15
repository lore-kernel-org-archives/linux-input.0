From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: don't push static constants on stack for %*ph
Date: Mon, 14 Dec 2015 23:31:43 -0800
Message-ID: <CAKdAkRQN_LnnL=OCbzeMS-X+kFz3kiTJGxBw1KC6R=jEt8YVfw@mail.gmail.com>
References: <1378291309-13869-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1449755217.30729.99.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33551 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbbLOHbo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2015 02:31:44 -0500
Received: by mail-ob0-f170.google.com with SMTP id sd4so359337obb.0
        for <linux-input@vger.kernel.org>; Mon, 14 Dec 2015 23:31:44 -0800 (PST)
In-Reply-To: <1449755217.30729.99.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Dec 10, 2015 at 5:46 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, 2013-09-04 at 13:41 +0300, Andy Shevchenko wrote:
>> There is no need to pass constants via stack. The width may be
>> explicitly
>> specified in the format.
>
> Dmitry, any comments on this?

My personal preference is to have length as a parameter instead of
encoding in format string as it allows using symbolic constants and
expressions (even though in these particular cases we use numeric
constants). The code is not in critical paths so we can live with
extra arguments.

Thanks.

>
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/input/mouse/hgpk.c               | 7 +++----
>>  drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++--
>>  2 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
>> index 62be888..27909a1 100644
>> --- a/drivers/input/mouse/hgpk.c
>> +++ b/drivers/input/mouse/hgpk.c
>> @@ -333,9 +333,8 @@ static bool hgpk_is_byte_valid(struct psmouse
>> *psmouse, unsigned char *packet)
>>       }
>>
>>       if (!valid)
>> -             psmouse_dbg(psmouse,
>> -                         "bad data, mode %d (%d) %*ph\n",
>> -                         priv->mode, pktcnt, 6, psmouse->packet);
>> +             psmouse_dbg(psmouse, "bad data, mode %d (%d)
>> %6ph\n",
>> +                         priv->mode, pktcnt, psmouse->packet);
>>
>>       return valid;
>>  }
>> @@ -1027,7 +1026,7 @@ static enum hgpk_model_t hgpk_get_model(struct
>> psmouse *psmouse)
>>               return -EIO;
>>       }
>>
>> -     psmouse_dbg(psmouse, "ID: %*ph\n", 3, param);
>> +     psmouse_dbg(psmouse, "ID: %3ph\n", param);
>>
>>       /* HGPK signature: 0x67, 0x00, 0x<model> */
>>       if (param[0] != 0x67 || param[1] != 0x00)
>> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
>> b/drivers/input/touchscreen/atmel_mxt_ts.c
>> index 59aa240..dd44ebf 100644
>> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> @@ -331,8 +331,8 @@ static bool mxt_object_writable(unsigned int
>> type)
>>  static void mxt_dump_message(struct device *dev,
>>                            struct mxt_message *message)
>>  {
>> -     dev_dbg(dev, "reportid: %u\tmessage: %*ph\n",
>> -             message->reportid, 7, message->message);
>> +     dev_dbg(dev, "reportid: %u\tmessage: %7ph\n",
>> +             message->reportid, message->message);
>>  }
>>
>>  static int mxt_check_bootloader(struct i2c_client *client,
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
>



-- 
Dmitry
