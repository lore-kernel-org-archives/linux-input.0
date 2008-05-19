From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: uinput problem
Date: Mon, 19 May 2008 13:20:49 -0400
Message-ID: <20080519131815.ZZRA012@mailhub.coreip.homeip.net>
References: <482DB441.7020205@twam.info> <20080519115457.ZZRA012@mailhub.coreip.homeip.net> <4831AD1F.2000606@twam.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:45729 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbYESRU6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 May 2008 13:20:58 -0400
Received: by py-out-1112.google.com with SMTP id u52so1997398pyb.10
        for <linux-input@vger.kernel.org>; Mon, 19 May 2008 10:20:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4831AD1F.2000606@twam.info>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias M??ller <Tobias_Mueller@twam.info>
Cc: linux-input@vger.kernel.org

On Mon, May 19, 2008 at 06:38:55PM +0200, Tobias M??ller wrote:
> Hi Dmitry!
>
> Dmitry Torokhov wrote:
>> Are you working in the console or in X?
> In X. I tried it in the console and it seems to work. Problem occurs only within X.
>

In this case I would recommend contacting X guys. You see that your
uinput program works and the in-kernel consode driver works as well.
Does xev reports the events you expect?

-- 
Dmitry
