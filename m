From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Fix cleaning up KEY_STROBEs after error in
	tosakbd_probe()
Date: Fri, 21 Aug 2009 09:12:19 -0700
Message-ID: <20090821164354.1D654526EA5@mailhub.coreip.homeip.net>
References: <4A8EA9B8.2090302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:56322 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbZHUQMW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Aug 2009 12:12:22 -0400
Received: by rv-out-0506.google.com with SMTP id f6so291127rvb.1
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2009 09:12:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A8EA9B8.2090302@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, Aug 21, 2009 at 04:05:44PM +0200, Roel Kluin wrote:
> Direct to fail2 to gpio_free() the KEY_STROBEs as well as the KEY_SENSEs.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Applied, thank you Roel.

-- 
Dmitry
