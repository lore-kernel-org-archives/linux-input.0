From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/3] Input-gameport: Replace some printk() calls by
 pr_info() in joydump_connect()
Date: Sun, 25 Sep 2016 00:31:29 -0700
Message-ID: <1474788689.2238.3.camel@perches.com>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
         <f486d64d-0759-9cd6-1e4e-df723acb6fea@users.sourceforge.net>
         <1474733610.23838.2.camel@perches.com>
         <814f7993-de4b-05d8-845e-3f0230122061@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <814f7993-de4b-05d8-845e-3f0230122061@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

On Sun, 2016-09-25 at 09:15 +0200, SF Markus Elfring wrote:
> 1. Add a definition for the macros "MY_LOG_PREFIX" and "pr_fmt" so that
>    their information can be used for consistent message output.
> 
> 
> 2. Prefer usage of the macro "pr_info" over the interface "printk"
>    in this function.
> 
> 
> 3. Reduce number of output function calls.
> 
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> 
> 
> v2: Yesterday a software development discussion pointed weaknesses out around
>     the previous update steps "3" and "4".
>     Now I propose this update variant in the hope that my second approach
>     for this software module will work as desired and can be accepted
>     a bit easier.

No thank you.

This is not a good change as it messes with dmesg timestamps.

Simpler to read and more straightforward is multiple
individual function calls.
