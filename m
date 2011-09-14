From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add EETI eGalax I2C capacitive multi touch driver.
Date: Tue, 13 Sep 2011 21:57:25 -0700
Message-ID: <20110914045725.GA12843@core.coreip.homeip.net>
References: <20110812203003.GA8995@polaris.bitmath.org>
 <1315482029-13761-1-git-send-email-jiejing.zhang@freescale.com>
 <20110913091515.GA5658@polaris.bitmath.org>
 <CACrgxGAxntDkvgnz7Py=-e3i0C8qx0TMdLEiek6-3FJ3+8FWnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62987 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab1INE5b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Sep 2011 00:57:31 -0400
Received: by gyg10 with SMTP id 10so1117925gyg.19
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 21:57:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACrgxGAxntDkvgnz7Py=-e3i0C8qx0TMdLEiek6-3FJ3+8FWnA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Jiejing.Zhang " <kzjeef@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org

On Wed, Sep 14, 2011 at 12:50:30PM +0800, Jiejing.Zhang  wrote:
> 
> I double check the document, I can't know the Chip 's mode before the
> the chip start report points.
> 
> So, I think change the abs_params in runtime is not a good idea.
> 
> What about this driver only deal with MT point, and ignore the
> MOUSE_MODE related code?
> 

I think this woudl be the best, as we can easily emulate ST with MT
data.

Thanks.

-- 
Dmitry
