From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: i reaches -1
Date: Sun, 1 Feb 2009 17:06:45 -0800
Message-ID: <20090201170626.ZZRA012@mailhub.coreip.homeip.net>
References: <4984271C.1080908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:17177 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbZBBBHh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Feb 2009 20:07:37 -0500
Received: by qw-out-2122.google.com with SMTP id 3so752007qwe.37
        for <linux-input@vger.kernel.org>; Sun, 01 Feb 2009 17:07:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4984271C.1080908@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-input@vger.kernel.org

On Sat, Jan 31, 2009 at 11:25:32AM +0100, Roel Kluin wrote:
> With a postfix decrement i reaches -1 rather than 0,
> but after the loop it is tested whether it has become 0.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Applied, thank you Roel.

-- 
Dmitry
