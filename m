From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 1/4] Input: mms114 - do not clobber interrupt trigger
Date: Fri, 26 Jan 2018 13:54:57 +0900
Message-ID: <20180126045457.GP7575@gangnam.samsung>
References: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
        <CGME20180124193813epcas4p3a6c1f4b22fccd9a0ff0b7682b0b9bcff@epcas4p3.samsung.com>
        <20180124193804.155654-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22422 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbeAZEzA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Jan 2018 23:55:00 -0500
Content-disposition: inline
In-reply-to: <20180124193804.155654-2-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Shields <simon@lineageos.org>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, Jan 24, 2018 at 11:38:01AM -0800, Dmitry Torokhov wrote:
> Rely on the platform (device tree, ACPI, etc) to properly configure
> interrupt trigger/polarity instead of hardcoding the falling edge.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
Tested-by: Andi Shyti <andi.shyti@samsung.com>

Thanks,
Andi
