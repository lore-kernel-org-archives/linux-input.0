From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: support for Logitech Wave
Date: Wed, 16 Jan 2008 11:07:17 -0500
Message-ID: <20080116110244.ZZRA012@mailhub.coreip.homeip.net>
References: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:37292 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbYAPQH2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jan 2008 11:07:28 -0500
Received: by wr-out-0506.google.com with SMTP id c49so53371wra.1
        for <linux-input@vger.kernel.org>; Wed, 16 Jan 2008 08:07:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Timo Aaltonen <tjaalton@cc.hut.fi>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>

Hi Timo,

On Tue, Jan 15, 2008 at 03:49:14PM +0200, Timo Aaltonen wrote:
>
> 	Hi
>
>   I've got a Logitech Wave keyboard, that has a number of extra keys on it, 
> and most of them fail to work with evdev. I get no output with xev or while 
> trying to cat the input device. I've been told that it's a kernel issue if 
> the device shows no events, hence this email.
>
> What should I do to get full support for all the keys on it? It's a nice 
> keyboard, so I'd like to get the most of it :)
>

Please try booting with the latest -rc kernel (currently 2.6.26-rc8) and run
evtest utility. You should see it report MSC_SCAN events when you press keys
on your keyboard. Compose list of keys and corresponding codes and send it to
Jiri Kosina so he can add proper mappings to the HID driver.

Thanks!

-- 
Dmitry
