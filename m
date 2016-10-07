From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: melfas_mip4 - add maintainer information
Date: Fri, 7 Oct 2016 16:29:40 -0700
Message-ID: <20161007232940.GC8473@dtor-ws>
References: <1475736483-5150-1-git-send-email-jeesw@melfas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35770 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932284AbcJGX3o (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 19:29:44 -0400
Received: by mail-pa0-f65.google.com with SMTP id qn10so3325932pac.2
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2016 16:29:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1475736483-5150-1-git-send-email-jeesw@melfas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sangwon Jee <jeesw@melfas.com>
Cc: linux-input@vger.kernel.org

On Thu, Oct 06, 2016 at 03:48:03PM +0900, Sangwon Jee wrote:
> Add maintainer information.
> 
> Signed-off-by: Sangwon Jee <jeesw@melfas.com>

Applied, thank you.

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 630151f..f88e97e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7155,6 +7155,13 @@ F:	Documentation/scsi/megaraid.txt
>  F:	drivers/scsi/megaraid.*
>  F:	drivers/scsi/megaraid/
>  
> +MELFAS MIP4 TOUCHSCREEN DRIVER
> +M:	Sangwon Jee <jeesw@melfas.com>
> +W:	http://www.melfas.com
> +S:	Supported
> +F:	drivers/input/touchscreen/melfas_mip4*
> +F:	Documentation/devicetree/bindings/input/touchscreen/melfas_mip4*

Tightened match just in case.

> +
>  MELLANOX ETHERNET DRIVER (mlx4_en)
>  M: 	Eugenia Emantayev <eugenia@mellanox.com>
>  L:	netdev@vger.kernel.org
> -- 
> 1.9.1
> 

-- 
Dmitry
