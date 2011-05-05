From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] ads7846: Make buffers in struct ser_req and struct
 ads7845_ser_req DMA save
Date: Thu, 5 May 2011 09:15:19 -0700
Message-ID: <20110505161519.GG27251@core.coreip.homeip.net>
References: <1304578268-24887-1-git-send-email-alexander.stein@systec-electronic.com>
 <4DC26896.5090800@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39016 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab1EEQPZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 May 2011 12:15:25 -0400
Received: by pzk9 with SMTP id 9so1031201pzk.19
        for <linux-input@vger.kernel.org>; Thu, 05 May 2011 09:15:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DC26896.5090800@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, May 05, 2011 at 10:06:30AM +0100, Jonathan Cameron wrote:
> On 05/05/11 07:51, Alexander Stein wrote:
> > req.sample needs its own cacheline otherwise accessing req.msg fetches
> > it in again.
> > 
> > Note: This effect doesn't occur if the underlying SPI driver doesn't use
> > DMA at all.
> I would say the comment is a bit obvious, but then you are fixing a bug
> because it was wrong - so fair call.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Both applied, thanks Alexander and Jonathan.

-- 
Dmitry
