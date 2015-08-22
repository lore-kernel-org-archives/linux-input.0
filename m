From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v3 1/1] cap11xx: add runtime PM support
Date: Fri, 21 Aug 2015 22:57:23 -0700
Message-ID: <0DBBBD46-159E-436E-914D-5E5D5C88A9B7@gmail.com>
References: <1439947289-10750-1-git-send-email-mranostay@gmail.com> <1439947289-10750-2-git-send-email-mranostay@gmail.com> <20150821003743.GA24710@localhost> <CAKzfze-3j6dgSBn6r4ajJLbdU2BHVnCF3Uxdjd-=eMdZt0DAmA@mail.gmail.com> <20150821163557.GE26302@localhost>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:32827 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbbHVF52 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Aug 2015 01:57:28 -0400
Received: by pdrh1 with SMTP id h1so34266332pdr.0
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2015 22:57:28 -0700 (PDT)
In-Reply-To: <20150821163557.GE26302@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Ah of course would have to be allocated before the leds and input device register. 

Sent from my iPhone

> On Aug 21, 2015, at 09:35, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
>> On Thu, Aug 20, 2015 at 07:07:28PM -0700, Matt Ranostay wrote:
>> On Thu, Aug 20, 2015 at 5:37 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>> Hi Matt,
>>> 
>>>> On Tue, Aug 18, 2015 at 06:21:29PM -0700, Matt Ranostay wrote:
>>>> 
>>>> +static int cap11xx_i2c_remove(struct i2c_client *i2c_client)
>>>> +{
>>>> +     struct cap11xx_priv *priv = i2c_get_clientdata(i2c_client);
>>>> +
>>>> +     cap11xx_set_sleep(priv, true);
>>>> +     pm_runtime_disable(&i2c_client->dev);
>>>> +     pm_runtime_set_suspended(&i2c_client->dev);
>>> 
>>> As I mentioned in my previous review:
>> 
>> Ok that makes sense. What would be the correct way to do this with
>> that in mind?
> 
> Maybe try installing a custom devm actioni (devm_add_action)? You want
> to ensure that the device is put to sleep only after unregistering input
> and LED devices.
> 
> Thanks.
> 
> -- 
> Dmitry
