From: Xiaolong Chen <xiaolong.chen@gmail.com>
Subject: Re: Fwd: [RFC] [PATCH] Input: ADP5588 - Support gpio function on
	unused pin
Date: Tue, 27 Jul 2010 13:31:47 +0800
Message-ID: <AANLkTi=qHUknGZdoj75Nr9gCKe-TRPMf3cgtsHejSrOc@mail.gmail.com>
References: <4c459b70.0aee8c0a.1c29.3e9e@mx.google.com>
	<4C4DADA7.9000201@gmail.com>
	<20100726173844.GC14609@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64651 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab0G0Fbr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jul 2010 01:31:47 -0400
Received: by iwn7 with SMTP id 7so3452594iwn.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 22:31:47 -0700 (PDT)
In-Reply-To: <20100726173844.GC14609@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael <Michael.Hennerich@analog.com>, david-b@pacbell.net, Michael Hennerich <hennerich@blackfin.uclinux.org>, linux-input@vger.kernel.org, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>, Xiaolong CHEN <a21785@motorola.com>

Hi, Dmitry

Look through the update, it's fine.

Thanks,
Xiaolong

On Tue, Jul 27, 2010 at 1:38 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Xiaolong,
>
> On Mon, Jul 26, 2010 at 11:45:43PM +0800, Xiaolong Chen wrote:
>> =A0Hi, Dmitry
>>
>> Following your comments, add the CONFIG_GPIOLIB and update the
>> patch based on the linux-next. If there is any comments and
>> suggestion, please feel free let me know.
>>
>> I think we need to protect the code you are adding with #ifdef
>> CONFIG_GPIOLIBi and provide the stubs in case gpiolib is not
>> available. This will also force splitting the gpio hanlding code
>> into separate functions so that it is easier to read. Please see
>> how it is done in ad7879 driver.
>> Done.
>>
>> Also if would be great if you generated the patch against the
>> version of the driver that is ither in linux-next or in the 'next'
>> branch of my tree as there a few changes clashing with yours.
>> Done.
>>
>
> I have applied the patch with minor changes to my 'next' branch on
> kernel.org. Would you mind taking a look there to make sure it is all=
 in
> order?
>
> Thanks.
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
