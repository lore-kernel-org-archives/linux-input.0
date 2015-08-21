From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v3 1/1] cap11xx: add runtime PM support
Date: Thu, 20 Aug 2015 19:07:28 -0700
Message-ID: <CAKzfze-3j6dgSBn6r4ajJLbdU2BHVnCF3Uxdjd-=eMdZt0DAmA@mail.gmail.com>
References: <1439947289-10750-1-git-send-email-mranostay@gmail.com>
	<1439947289-10750-2-git-send-email-mranostay@gmail.com>
	<20150821003743.GA24710@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:33603 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbbHUCHa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 22:07:30 -0400
Received: by lalv9 with SMTP id v9so33177715lal.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 19:07:28 -0700 (PDT)
In-Reply-To: <20150821003743.GA24710@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Aug 20, 2015 at 5:37 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Matt,
>
> On Tue, Aug 18, 2015 at 06:21:29PM -0700, Matt Ranostay wrote:
>>
>> +static int cap11xx_i2c_remove(struct i2c_client *i2c_client)
>> +{
>> +     struct cap11xx_priv *priv = i2c_get_clientdata(i2c_client);
>> +
>> +     cap11xx_set_sleep(priv, true);
>> +     pm_runtime_disable(&i2c_client->dev);
>> +     pm_runtime_set_suspended(&i2c_client->dev);
>
> As I mentioned in my previous review:

Ok that makes sense. What would be the correct way to do this with
that in mind?

>
>> This violates ordering: the leds and input device are still open and
>> may get requests while you are putting the device to sleep.
>
> Thanks.
>
> --
> Dmitry
