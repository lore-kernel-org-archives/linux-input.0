From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND] input/wm97xx: make missing platform data non-fatal
Date: Thu, 19 Jan 2017 09:10:44 +0000
Message-ID: <20170119091044.GD27100@localhost.localdomain>
References: <20170119084353.4250-1-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:57881 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751325AbdASJ1w (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 04:27:52 -0500
Content-Disposition: inline
In-Reply-To: <20170119084353.4250-1-manuel.lauss@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>

On Thu, Jan 19, 2017 at 09:43:53AM +0100, Manuel Lauss wrote:
> Commit 6480af4915d6 ("power_supply: wm97xx_battery: use
> power_supply_get_drvdata") made wm97xx platform data mandatory,
> although it's still optional.
> 
> This patch fixes an oops during driver probe on one
> of my MIPS boards with a wm9712.  Touchscreen continues
> to work fine, and I don't have any battery hooked up
> to it either, so I'm not missing any functionality.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: patches@opensource.wolfsonmicro.com
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
