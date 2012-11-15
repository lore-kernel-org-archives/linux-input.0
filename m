From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v4 00/14] Win 8 support for digitizers
Date: Thu, 15 Nov 2012 12:11:13 +0100
Message-ID: <CAN+gG=F-U1R2UqnUmLAs5FjxDCNQhcrvs5UMSPeNaWVYKrJUBA@mail.gmail.com>
References: <1352908766-4492-1-git-send-email-benjamin.tissoires@gmail.com>
	<20121114200141.GA15074@polaris.bitmath.org>
	<alpine.LNX.2.00.1211151033070.15877@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:46835 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993226Ab2KOLLP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Nov 2012 06:11:15 -0500
In-Reply-To: <alpine.LNX.2.00.1211151033070.15877@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 15, 2012 at 10:33 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 14 Nov 2012, Henrik Rydberg wrote:
>
>> > * patches 1-9 has already been reviewed and are ready for inclusion I would say.
>> > * Jiri, I kept your ack on patch 4 even if I changed the place of the comment in hid.h
>> > * patch 10 is half new as it is splitted from a patch of the v3
>> > * patch 11 has been changed according to Henrik's comments
>> > * patches 12-13 have been splitted since v3 to introduce QUIRK_HOVERING and setup WIN 8
>> > devices in a better way.
>> > * patch 14 has been copied from the v3 as Dmitry wanted to use a MSC event for the timestamp.
>>
>> Everything but the last patch looks good now, me thinks. Thanks!

Hi Henrik,

Thanks for the review!

>
> I have now applied everything (with all the gathered Acks/Reviewed-by
> incorporated) but the patch #14.
>

Hi Jiri,

many thanks for applying it. Patch #14 is less critical, so we can
take more time to include it.

Cheers,
Benjamin

> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
