From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: goodix: Add support for capacitive home button
 found on some x86 tablets
Date: Tue, 20 Jun 2017 11:02:40 +0200
Message-ID: <27aec991-0674-9fb1-51f9-f34ddd6bc294@redhat.com>
References: <1725443.Vzhj3lzWjD@z12> <1497911523.2559.4.camel@hadess.net>
 <20170620025146.GD21379@dtor-ws> <1497947798.2559.10.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbdFTJCs (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 05:02:48 -0400
In-Reply-To: <1497947798.2559.10.camel@hadess.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Sergei A. Trusov" <sergei.a.trusov@ya.ru>, russianneuromancer@ya.ru, linux-input@vger.kernel.org

Hi,

On 20-06-17 10:36, Bastien Nocera wrote:
> On Mon, 2017-06-19 at 19:51 -0700, Dmitry Torokhov wrote:
>>> General question though, should we not only export and advertise
>>> the
>>> button if it exists on the device?
>>
>> Yes, this is preferred behavior.
> 
> So we'll want a dmi match table for the devices that need this feature,
> and only export the button for those.

Note Dmitry said that this is preferred behavior, not something which
we MUST do. And TBH I don't think that using a DMI table is a good idea,
the capacitive home-button is not only found on the HP stream 7 but also
on various cheap tablets, of which there tend to be a lot, so the DMI
table is going to be use. And the cheap tablets often have useful
model strings such as e.g. "Default String" making DMI matching a
nasty problem.

So IMHO it is better to just always report the presence of the
home button, in practice I don't think userspace is going to have
any problems with this.

Regards,

Hans
