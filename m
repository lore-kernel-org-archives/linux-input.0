From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] input: sh_keysc: 8x8 MODE_6 fix
Date: Thu, 16 Jun 2011 09:57:57 +0900
Message-ID: <BANLkTim+W2zvHY9jTOPM=iFPrB4tB0vmNQ@mail.gmail.com>
References: <20110615143340.21798.61858.sendpatchset@t400s>
	<20110615231211.GC28947@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58754 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab1FPA55 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2011 20:57:57 -0400
In-Reply-To: <20110615231211.GC28947@verge.net.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org

On Thu, Jun 16, 2011 at 8:12 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jun 15, 2011 at 11:33:40PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> The MODE_6 support in sh_keysc.c is incorrect without
>> this patch. According to the data sheet for G4, AP4 and
>> AG5 KEYSC MODE_6 is 8x8 keys. Bump up MAXKEYS to 64 too.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Reviewed-by: Simon Horman <horms@verge.net.au>

Thanks!

> Do we also need to update the platform data for ag5evm
> which is currently using SH_KEYSC_MODE_6 but with 49
> entries in its keysc_platdata.keycodes ?

Yes, eventually we need to update the board support code as well.
Chances are that existing out-of-tree board support code is broken. So
we need updated platform data together with a pinmux configuration
that matches the board schematics. Tested on real hardware using
evtest.

Cheers,

/ magnus
