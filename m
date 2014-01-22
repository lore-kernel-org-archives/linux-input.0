From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v3] ims-pcu: Add commands supported by the new version of
 the FW
Date: Wed, 22 Jan 2014 08:58:07 -0800
Message-ID: <CAHQ1cqGns9s=5wKwP9syG28oRWB90QvaSHNTYX_p=LF2SBw00w@mail.gmail.com>
References: <1390396825-10255-1-git-send-email-andrew.smirnov@gmail.com>
	<20140122164750.GA5080@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:56705 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbaAVQ6H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jan 2014 11:58:07 -0500
In-Reply-To: <20140122164750.GA5080@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Sorry for the noise, had an old copy of the file in my out of the tree
build set-up when I was doing the testing. I will post updated version
shortly.

Thanks,

On Wed, Jan 22, 2014 at 8:47 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Jan 22, 2014 at 05:20:25AM -0800, Andrey Smirnov wrote:
>> +static int ims_pcu_write_ofn_config(struct ims_pcu *pcu, u8 addr, u8 data)
>> +{
>> +     u8 buffer[] = { addr, data };
>> +     int error;
>> +     u16 result;
>> +
>> +     error = ims_pcu_execute_command(pcu, OFN_SET_CONFIG,
>> +                                     &buffer, sizeof(buffer));
>> +     if (error)
>> +             return error;
>> +
>> +     result = (s16)get_unaligned_le16(pcu->cmd_buf + OFN_REG_RESULT_OFFSET);
>> +     if ((result < 0)
>
> I am fairly certain this does not even compile, but even if it did,
> result is declared u16 so even if you do the cast above the comparison
> will always be false.
>
> Thanks.
>
> --
> Dmitry
