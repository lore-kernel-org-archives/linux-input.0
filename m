From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] input/wm97xx: make missing platform data non-fatal
Date: Sun, 22 Jan 2017 12:11:22 +0100
Message-ID: <87tw8rcpt1.fsf@belgarion.home>
References: <20170105154322.28943-1-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:55118 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdAVLLZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Jan 2017 06:11:25 -0500
In-Reply-To: <20170105154322.28943-1-manuel.lauss@gmail.com> (Manuel Lauss's
        message of "Thu, 5 Jan 2017 16:43:22 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-input@vger.kernel.org

Manuel Lauss <manuel.lauss@gmail.com> writes:

> Commit 6480af4915d6 ("power_supply: wm97xx_battery: use
> power_supply_get_drvdata") made wm97xx platform data mandatory,
> although it's still optional.
>
> This patch fixes an oops during driver probe on one
> of my MIPS boards with a wm9712.
>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
I can't remember if I replied to this one ... so

Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
