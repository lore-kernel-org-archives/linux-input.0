From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: xpad - fix memory leak
Date: Wed, 1 Dec 2010 09:14:04 -0800
Message-ID: <20101201171404.GB11196@core.coreip.homeip.net>
References: <1291215874-5625-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48767 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab0LAROO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Dec 2010 12:14:14 -0500
Content-Disposition: inline
In-Reply-To: <1291215874-5625-1-git-send-email-namhyung@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 02, 2010 at 12:04:33AM +0900, Namhyung Kim wrote:
> xpad->bdata was dynamically allocated but never freed. Since it is
> used for xpad->bulk_out->transfer_buffer, set URB_FREE_BUFFER flag
> in order to get freed when usb_free_urb() called.
> 

This is also already fixed in my tree (next branch, slated for 2.6.38).

Thanks.

-- 
Dmitry
