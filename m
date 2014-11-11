From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH] hid: sony: Use kernel allocated buffers for HID reports
Date: Wed, 12 Nov 2014 03:20:57 +0900
Message-ID: <54625389.4040900@marcansoft.com>
References: <1415728913-2679-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from marcansoft.com ([213.138.101.166]:47105 "EHLO
	mail.marcansoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbaKKS1T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2014 13:27:19 -0500
In-Reply-To: <1415728913-2679-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dmitry.torokhov@gmail.com

On 12/11/14 03:01, Frank Praznik wrote:
> Replace stack buffers with kernel allocated buffers when sending
> and receiving HID reports to prevent issues with DMA transfers
> on certain hardware.
> 
> Output report buffers are allocated at initialization time to avoid
> excessive kmalloc and kfree calls.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
> 
>  I'm CC-ing the original bug reporter to see if he can test this patch
>  on whatever platform was giving him trouble as I can't replicate the
>  reported error on my end.

Seems to work fine with the patch. Thanks!

FWIW, this is 3.17.1-hardened (I wonder if the grsecurity patches have
anything to do with it... maybe they do something to the stack) on an
Intel 7 Series (Panther Point) PCH's EHCI controller (with a couple of
hubs along the way).

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc

