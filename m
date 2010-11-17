From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] Input: hgpk - Fix powersave mode
Date: Wed, 17 Nov 2010 09:43:04 -0800
Message-ID: <20101117174304.GA6148@core.coreip.homeip.net>
References: <20101113192221.E7FBC9D401B@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63748 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758512Ab0KQRnQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Nov 2010 12:43:16 -0500
Received: by pwj1 with SMTP id 1so273848pwj.19
        for <linux-input@vger.kernel.org>; Wed, 17 Nov 2010 09:43:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101113192221.E7FBC9D401B@zog.reactivated.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, pgf@laptop.org

On Sat, Nov 13, 2010 at 07:22:21PM +0000, Daniel Drake wrote:
> From: Paul Fox <pgf@laptop.org>
> 
> Recent testing of this codepath showed that it wasn't working,
> perhaps due to changes within the input layer. This fixes it.
> 

I applied the first 3 patches but never gotten the 4th one...

-- 
Dmitry
