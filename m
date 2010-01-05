From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: Questions about Multi-touch Protocal
Date: Tue, 05 Jan 2010 13:55:59 +0100
Message-ID: <4B4336DF.4060704@euromail.se>
References: <4B42D998.4050303@samsung.com>  <4B432BDB.3000103@euromail.se> <1262695333.8529.8.camel@pancake>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:39206 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754084Ab0AEM5u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jan 2010 07:57:50 -0500
In-Reply-To: <1262695333.8529.8.camel@pancake>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz

Florian Echtler wrote:
[..]
> Very interesting writeup, thanks a lot. Is there any currently any
> hardware which is available to end-users and does support these
> features? AFAIR most capacitive touchscreens don't have high enough
> resolution to actually detect, e.g., twisting. If there's a commercial
> option, I'd like to hear about it..

The post-2008 MacBooks all have a touchpad (bcm5974) which is capable of
detecting finger twisting. A patch to enable the MT protocol in the bcm5974
driver is on it's way into the 2.6.33 kernel.

