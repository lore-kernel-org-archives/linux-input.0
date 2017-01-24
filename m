From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/wm97xx: make missing platform data non-fatal
Date: Tue, 24 Jan 2017 10:13:51 -0800
Message-ID: <20170124181351.GC27969@dtor-ws>
References: <20170105154322.28943-1-manuel.lauss@gmail.com>
 <87tw8rcpt1.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33174 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdAXSNy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Jan 2017 13:13:54 -0500
Received: by mail-pf0-f194.google.com with SMTP id e4so12544802pfg.0
        for <linux-input@vger.kernel.org>; Tue, 24 Jan 2017 10:13:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87tw8rcpt1.fsf@belgarion.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, linux-input@vger.kernel.org

On Sun, Jan 22, 2017 at 12:11:22PM +0100, Robert Jarzmik wrote:
> Manuel Lauss <manuel.lauss@gmail.com> writes:
> 
> > Commit 6480af4915d6 ("power_supply: wm97xx_battery: use
> > power_supply_get_drvdata") made wm97xx platform data mandatory,
> > although it's still optional.
> >
> > This patch fixes an oops during driver probe on one
> > of my MIPS boards with a wm9712.
> >
> > Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> I can't remember if I replied to this one ... so
> 
> Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Applied, thank you.

In the future it is helpful to cc me directly on the patch instead of
sending it to the list only so there is less chance it gets missed.

Thanks.

-- 
Dmitry
