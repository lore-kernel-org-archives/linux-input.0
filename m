From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] amba_kmi_write() timeleft reaches -1 rather than 0
Date: Sun, 1 Feb 2009 17:07:31 -0800
Message-ID: <20090201170714.ZZRA012@mailhub.coreip.homeip.net>
References: <49845346.2050006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:17241 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbZBBBIU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Feb 2009 20:08:20 -0500
Received: by qw-out-2122.google.com with SMTP id 3so752114qwe.37
        for <linux-input@vger.kernel.org>; Sun, 01 Feb 2009 17:08:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <49845346.2050006@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-input@vger.kernel.org

On Sat, Jan 31, 2009 at 02:33:58PM +0100, Roel Kluin wrote:
> With a postfix decrement timeleft reaches -1 rather than 0,
> but after the loop it is tested to have become 0.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Applied, thank you Roel.

-- 
Dmitry
