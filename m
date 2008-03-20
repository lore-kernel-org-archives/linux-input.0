From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH] Fix pxa27x keypad KPC macros
Date: Thu, 20 Mar 2008 15:02:17 +0800
Message-ID: <f17812d70803200002p7f806969jb303ce175daebc8@mail.gmail.com>
References: <20080219102511.GA6396@caravaggio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:48983 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbYCTHCS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Mar 2008 03:02:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so878690wah.23
        for <linux-input@vger.kernel.org>; Thu, 20 Mar 2008 00:02:17 -0700 (PDT)
In-Reply-To: <20080219102511.GA6396@caravaggio>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@openedhand.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Eric Miao <eric.miao@marvell.com>

Yes, indeed. Sorry I'm replying this late as I just come across.


On Tue, Feb 19, 2008 at 6:25 PM, Samuel Ortiz <sameo@openedhand.com> wrote:
> Hi Dmitry,
>
>  On the pxa27x keypad driver, we want to mask (key_number - 1), not
>  key_number.
>  The current implementation works fine for all values but the maximum
>  one, i.e. 8.
>
>  This patch is against your input git tree.
>
>  Signed-off-by: Samuel Ortiz <sameo@openedhand.com>
>  ---
>   drivers/input/keyboard/pxa27x_keypad.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
>  Index: linux-2.6-input/drivers/input/keyboard/pxa27x_keypad.c
>  ===================================================================
>  --- linux-2.6-input.orig/drivers/input/keyboard/pxa27x_keypad.c 2008-02-19 11:10:04.000000000 +0100
>  +++ linux-2.6-input/drivers/input/keyboard/pxa27x_keypad.c      2008-02-19 11:11:00.000000000 +0100
>  @@ -50,9 +50,9 @@
>   #define KPKDI           0x0048
>
>   /* bit definitions */
>  -#define KPC_MKRN(n)    ((((n) & 0x7) - 1) << 26) /* matrix key row number */
>  -#define KPC_MKCN(n)    ((((n) & 0x7) - 1) << 23) /* matrix key column number */
>  -#define KPC_DKN(n)     ((((n) & 0x7) - 1) << 6)  /* direct key number */
>  +#define KPC_MKRN(n)    ((((n) - 1) & 0x7) << 26) /* matrix key row number */
>  +#define KPC_MKCN(n)    ((((n) - 1) & 0x7) << 23) /* matrix key column number */
>  +#define KPC_DKN(n)     ((((n) - 1) & 0x7) << 6)  /* direct key number */
>
>   #define KPC_AS          (0x1 << 30)  /* Automatic Scan bit */
>   #define KPC_ASACT       (0x1 << 29)  /* Automatic Scan on Activity */
>
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-input" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Cheers
- eric
