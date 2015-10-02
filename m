From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH RESEND v4] cap11xx: add runtime PM support
Date: Fri, 2 Oct 2015 10:11:39 -0700
Message-ID: <CAKzfze9PUPXq8q0mEqc1N3FqwVqL8EQpMCdJ3wWn6hA_rHSvqg@mail.gmail.com>
References: <1443763140-16368-1-git-send-email-mranostay@gmail.com>
	<1443763140-16368-2-git-send-email-mranostay@gmail.com>
	<560E96C8.3060507@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36411 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbJBRLl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 13:11:41 -0400
Received: by lbcao8 with SMTP id ao8so29969425lbc.3
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2015 10:11:39 -0700 (PDT)
In-Reply-To: <560E96C8.3060507@zonque.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Oct 2, 2015 at 7:38 AM, Daniel Mack <daniel@zonque.org> wrote:
> On 10/02/2015 07:19 AM, Matt Ranostay wrote:
>> Puts device into DEEP SLEEP when no LEDs are in in the on-state, and no
>> input_handlers are in use. Also uses *_autosuspend to prevent a LED
>> trigger from constantly suspending and resuming device.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>  drivers/input/keyboard/cap11xx.c | 84 +++++++++++++++++++++++++++++++---------
>>  1 file changed, 65 insertions(+), 19 deletions(-)
>>
>
> ...
>
>> +static void cap11xx_shutdown_act(void *data)
>> +{
>> +     struct i2c_client *i2c_client = data;
>> +     struct cap11xx_priv *priv = i2c_get_clientdata(i2c_client);
>> +
>> +     cap11xx_set_sleep(priv, true);
>> +     pm_runtime_disable(&i2c_client->dev);
>> +     pm_runtime_set_suspended(&i2c_client->dev);
>> +}
>> +
>>  static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>>                            const struct i2c_device_id *id)
>>  {
>> @@ -363,6 +374,14 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>>       if (IS_ERR(priv->regmap))
>>               return PTR_ERR(priv->regmap);
>>
>> +     error = devm_add_action(dev, cap11xx_shutdown_act, i2c_client);
>
> Why not implement cap11xx_i2c_driver.remove or .shutdown for this?
>
>
Because of a possible race condition if any leds are registered.

> Otherwise, this looks good to me.
>
>
> Thanks,
> Daniel
>
