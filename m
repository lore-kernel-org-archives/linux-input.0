From: "Kwangwoo Lee" <kwangwoo.lee@gmail.com>
Subject: Re: + input-add-tsc2007-based-touchscreen-driver-update.patch added to -mm tree
Date: Fri, 19 Dec 2008 11:09:44 +0900
Message-ID: <483a38b80812181809qb9ffbd9rb57f148e35644e64@mail.gmail.com>
References: <200812090014.mB90EaTa004746@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:39185 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbYLSCJr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Dec 2008 21:09:47 -0500
In-Reply-To: <200812090014.mB90EaTa004746@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@linux-foundation.org, Jean Delvare <khali@linux-fr.org>, David Brownell <david-b@pacbell.net>, felipe.balbi@nokia.com, Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, mm-commits@vger.kernel.org

Hi Dmitry,

I'm waiting for your comments. Let me know your thought about this
patch, please.

Thanks,
Kwangwoo

On Tue, Dec 9, 2008 at 9:14 AM,  <akpm@linux-foundation.org> wrote:
>
> The patch titled
>     input-add-tsc2007-based-touchscreen-driver update
> has been added to the -mm tree.  Its filename is
>     input-add-tsc2007-based-touchscreen-driver-update.patch

> ------------------------------------------------------
> Subject: input-add-tsc2007-based-touchscreen-driver update
> From: "Kwangwoo Lee" <kwangwoo.lee@gmail.com>
>
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@gmail.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Acked-by: Jean Delvare <khali@linux-fr.org>     [i2c parts]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  drivers/input/touchscreen/tsc2007.c |  110 ++++++++++----------------
>  1 file changed, 44 insertions(+), 66 deletions(-)
>
