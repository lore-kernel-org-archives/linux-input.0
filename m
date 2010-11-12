From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add Atmel maXTouch touchscreen driver
Date: Fri, 12 Nov 2010 12:10:01 -0800
Message-ID: <20101112201001.GE1299@core.coreip.homeip.net>
References: <4CDD4BBA.5070301@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54867 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526Ab0KLUKJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 15:10:09 -0500
Received: by ywc21 with SMTP id 21so836890ywc.19
        for <linux-input@vger.kernel.org>; Fri, 12 Nov 2010 12:10:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDD4BBA.5070301@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: kyungmin.park@samsung.com, jy0922.shim@samsung.com, linux-input@vger.kernel.org

Hi Iiro,

On Fri, Nov 12, 2010 at 04:14:18PM +0200, Iiro Valkonen wrote:
> 
> Add Atmel maXTouch touchscreen driver (I2C interface).
> The MT slots protocol will be implemented later.
> 

I believe there is already a driver for this hardware in the tree
(qt602240.c). Could you tell me what additional features your driver
implements and why can't they be added to the existing driver.

Thanks.

-- 
Dmitry
