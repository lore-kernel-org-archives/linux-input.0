From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: Questions about Multi-touch Protocal
Date: Thu, 14 Jan 2010 01:35:13 +0100
Message-ID: <4B4E66C1.6040204@euromail.se>
References: <4B42D998.4050303@samsung.com> <4B432BDB.3000103@euromail.se> <4B43DE36.6000907@samsung.com> <20100113222506.GA14525@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:39656 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752369Ab0ANAfq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2010 19:35:46 -0500
In-Reply-To: <20100113222506.GA14525@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz

Peter Hutterer wrote:
[..]
> Note that ABS_MT_TOUCH_MAJOR complements ABS_PRESSURE but cannot substitute
> it. The nature of our fingures usually mean that with increasing pressure
> the touch size increases as the finger flattens. This is only useful as a
> relative indicator though, as fingers differ greatly in size.

Ok, in my book this makes the third voice for an ABS_MT_PRESSURE parameter, so
it should most likely be added. I will write a patch for it.

Cheers,
Henrik

