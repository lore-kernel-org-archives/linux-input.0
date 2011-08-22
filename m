From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 3/4] Input: ad714x - use DMA-safe buffers for spi_write()
Date: Sun, 21 Aug 2011 17:46:01 -0700
Message-ID: <bc519a02-c798-4023-9328-05e63c80753b@email.android.com>
References: <1313957345-22608-1-git-send-email-dmitry.torokhov@gmail.com> <1313957345-22608-3-git-send-email-dmitry.torokhov@gmail.com> <CAMjpGUf1bwv8sfN-5Yr4NJ3LACb202CcnjgnskUSMZ15wUt-8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:60759 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab1HVAq1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Aug 2011 20:46:27 -0400
Received: by yie30 with SMTP id 30so3253621yie.19
        for <linux-input@vger.kernel.org>; Sun, 21 Aug 2011 17:46:27 -0700 (PDT)
In-Reply-To: <CAMjpGUf1bwv8sfN-5Yr4NJ3LACb202CcnjgnskUSMZ15wUt-8w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, linux-input@vger.kernel.org



ike Frysinger <vapier.adi@gmail.com> wrote:

>On Sun, Aug 21, 2011 at 16:09, Dmitry Torokhov wrote:
>> spi_write() requires use of DMA-safe (cacheline aligned) buffers.
>> Also use the same buffers when reading data since to avoid extra
>> locking and potential memory allocation in spi_write_then_read().
>
>seems like there's a whole lot of style changes unrelated to spi and
>dma ... more so than the actual dma/spi change.

Hmm, I tried to control myself so (aside of return -> error) renames there shouldn't be many style changes... The diff looks big because we are passing ad714x instead of ad714x->dev to the read/write methods. 

-- 
Dmitry
