From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] Input: ad714x - use DMA-safe buffers for spi_write()
Date: Mon, 22 Aug 2011 09:39:17 -0700
Message-ID: <201108220939.17702.dmitry.torokhov@gmail.com>
References: <1313957345-22608-1-git-send-email-dmitry.torokhov@gmail.com> <1313957345-22608-3-git-send-email-dmitry.torokhov@gmail.com> <4E5240F8.3050205@analog.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41456 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab1HVQjZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Aug 2011 12:39:25 -0400
Received: by gya6 with SMTP id 6so3695791gya.19
        for <linux-input@vger.kernel.org>; Mon, 22 Aug 2011 09:39:24 -0700 (PDT)
In-Reply-To: <4E5240F8.3050205@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Drivers <Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

On Monday, August 22, 2011 04:43:52 AM Michael Hennerich wrote:
> On 08/21/2011 10:09 PM, Dmitry Torokhov wrote:
> > spi_write() requires use of DMA-safe (cacheline aligned) buffers.
> > Also use the same buffers when reading data since to avoid extra
> > locking and potential memory allocation in spi_write_then_read().
> > 
> > Signed-off-by: Dmitry Torokhov<dtor@mail.ru>
> 
> Looks good - one piece of the original patch set got lost.

Aww, sorry about that.

> See below - patch follows.

Thank you very much, I'll fold it in your original patch - no reason
for having a known broken change in the tree if it can be corrected.

-- 
Dmitry
