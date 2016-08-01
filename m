From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: New FocalTech FT6236 touchscreen driver is a duplicate with the
 existing edt-ft5x06.c driver
Date: Mon, 1 Aug 2016 10:11:07 +0200
Message-ID: <73616b17-a1a1-81c6-b3ea-5709321110d6@redhat.com>
References: <5675B852.5060308@redhat.com> <56A73969.5000100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51950 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbcHAILN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Aug 2016 04:11:13 -0400
In-Reply-To: <56A73969.5000100@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Sean Cross <xobs@kosagi.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.or>
Cc: Bertrik Sikken <bertrik@sikken.nl>

Hi,

On 26-01-16 10:16, Hans de Goede wrote:
> Hi,
>
> On 19-12-15 21:04, Hans de Goede wrote:
>> Hi All,
>>
>> While looking into getting a focaltech touchscreen on a tablet working I noticed
>> that we've 2 overlapping drivers, the ft6236.c and the edt-ft5x06.c driver both
>> support the exact same i2c touchscreen protocol. In the latter the code for the
>> "M09" variant offers identical functionality to the ft6236.c code.
>>
>> Since the edt-ft5x06.c code seems more complete wrt advanced features and has
>> been around much longer, I would like to suggest to add the ft6236.c compatible
>> and i2c-ids to the edt-ft5x06.c driver and to drop the duplicate ft6236.c driver.
>>
>> I've tested both drivers on a Chuwi_V7_CW0825 tablet with a ft5302fe4 touchscreen
>> controller (not 100% sure on the model I may be mixing up touchscreen models here,
>> but it definitely is a focaltech controller), and both drivers work identically.
>
> Ping ? We really need to fix this and the sooner the better, so that we do not
> get more and more devices depending on the new duplicate ft6236.c driver.
>
> Dmitry, since non of the ft6236.c maintainers has responded / has tested there devices
> with edt-ft5x06.c, shall I just go ahead and send a patch to add the i2c-id +
> compatibles from ft6236.c to edt-ft5x06.c and remove ft6236.c ?

Given the silence of all involved here I'm going to move ahead and submit a
patch to remove the duplicate ft6236.c driver.

Regards,

Hans
