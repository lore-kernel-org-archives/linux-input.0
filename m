From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: + input-add-tsc2007-based-touchscreen-driver-update.patch added to -mm tree
Date: Sat, 20 Dec 2008 02:50:14 -0800
Message-ID: <200812200250.15419.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:54254 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbYLTKug (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Dec 2008 05:50:36 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Cc: akpm@linux-foundation.org, Jean Delvare <khali@linux-fr.org>, David Brownell <david-b@pacbell.net>, felipe.balbi@nokia.com, Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, mm-commits@vger.kernel.org

Hi Kwangwoo,

On Thursday 18 December 2008 18:09:44 Kwangwoo Lee wrote:
> Hi Dmitry,
>
> I'm waiting for your comments. Let me know your thought about this
> patch, please.
>

I think to be completely safe we need hrtimer_cancel() right after free_irq(). 
I added it and applied to my 'next' branch.

Thank you.

-- 
Dmitry

