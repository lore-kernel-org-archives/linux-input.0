From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 3/4] Input: ad714x - use DMA-safe
 buffers for spi_write()
Date: Sun, 21 Aug 2011 20:17:52 -0400
Message-ID: <CAMjpGUf1bwv8sfN-5Yr4NJ3LACb202CcnjgnskUSMZ15wUt-8w@mail.gmail.com>
References: <1313957345-22608-1-git-send-email-dmitry.torokhov@gmail.com> <1313957345-22608-3-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50060 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab1HVASO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Aug 2011 20:18:14 -0400
Received: by bke11 with SMTP id 11so3306582bke.19
        for <linux-input@vger.kernel.org>; Sun, 21 Aug 2011 17:18:13 -0700 (PDT)
In-Reply-To: <1313957345-22608-3-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Sun, Aug 21, 2011 at 16:09, Dmitry Torokhov wrote:
> spi_write() requires use of DMA-safe (cacheline aligned) buffers.
> Also use the same buffers when reading data since to avoid extra
> locking and potential memory allocation in spi_write_then_read().

seems like there's a whole lot of style changes unrelated to spi and
dma ... more so than the actual dma/spi change.
-mike
