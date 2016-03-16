From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Handling of non-positional data through evdev
Date: Wed, 16 Mar 2016 16:10:32 +0100
Message-ID: <1458141032.29084.0.camel@hadess.net>
References: <CAEc3jaB2KOUoymz3BL6Bc7_vv3bTHadBqGM9YLHyt_GeVkOtng@mail.gmail.com>
	 <1458082753.4785.27.camel@hadess.net>
	 <CAEc3jaA_EnhbNChXAStdqDik9YMfWYXzfHQbOgEb=TXmuNR_5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:41341 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966633AbcCPPKr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 11:10:47 -0400
In-Reply-To: <CAEc3jaA_EnhbNChXAStdqDik9YMfWYXzfHQbOgEb=TXmuNR_5w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Tue, 2016-03-15 at 17:17 -0700, Roderick Colenbrander wrote:
> Hi Bastien,
> 
> Thanks for providing this suggestion. I can see this approach work
> for
> situations like screen rotation on tablets. The device I'm involved
> with is an input device, which needs a high poll rate for
> acceleration
> / velocity and needs to be paired with the button / axes data. Evdev
> would be most appropriate.

So more like a Wiimote than a builtin sensor. What will consume events
in user-space? A specialised application?
