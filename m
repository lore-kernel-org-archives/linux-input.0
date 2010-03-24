From: Graham Gower <graham.gower@gmail.com>
Subject: Re: UCB1400: Passing IRQ through platform_data
Date: Wed, 24 Mar 2010 15:37:49 +1030
Message-ID: <4BA99E25.9040307@gmail.com>
References: <4BA70831.1040606@gmail.com> <4BA81BC7.9040107@gmail.com> <0D753D10438DA54287A00B02708426976368DDD236@AUSP01VMBX24.collaborationhost.net> <201003230413.34255.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36286 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab0CXFOT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Mar 2010 01:14:19 -0400
Received: by gwaa18 with SMTP id a18so1835472gwa.19
        for <linux-input@vger.kernel.org>; Tue, 23 Mar 2010 22:14:18 -0700 (PDT)
In-Reply-To: <201003230413.34255.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Marek Vasut wrote:
> Maybe I'm starting to recall how that whole thing worked. I took a look at the 
> code and my guess might be -- it takes pdata from the ac97 bus. I'm not sure 
> here, but pxa2xx-ac97 allows passing platform data through the ac97 bus, dunno 
> how are other platform's ac97 implementations. If I'm right here, you might need 
> to fix your mips-whatever-ac97 to allow passing platform data and then pass them 
> through there.
> 
> If that's the case, the earlier example was wrong and you should start digging 
> around ac97 (see git log for pxa2xx-ac97.c and find a patch that added this 
> passing of platform data there).

Thanks, that was the clue I needed. With a small fix[0], I can now pass the
platform_data successfully through the ac97 codec.

-Graham

[0] http://mailman.alsa-project.org/pipermail/alsa-devel/2010-March/026419.html
