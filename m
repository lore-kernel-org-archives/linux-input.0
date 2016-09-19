From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v12 5/5] Input: goodix - add support for gt9157
Date: Mon, 19 Sep 2016 16:41:58 -0500
Message-ID: <20160919214158.GA25433@rob-hp-laptop>
References: <1473530257-7495-1-git-send-email-irina.tirdea@intel.com>
 <1473530257-7495-6-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33954 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbcISVmA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Sep 2016 17:42:00 -0400
Content-Disposition: inline
In-Reply-To: <1473530257-7495-6-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Sat, Sep 10, 2016 at 08:57:37PM +0300, Irina Tirdea wrote:
> Goodix touchscreen GT9157 has the same basic functionality
> as GT911 touchscreen. This is based on Goodix datasheets
> for GT911 and GT9157 and on Goodix driver gt9xx.c for
> Android (publicly available in Android kernel trees for
> various devices).
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
>  drivers/input/touchscreen/goodix.c                             | 2 ++
>  2 files changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
