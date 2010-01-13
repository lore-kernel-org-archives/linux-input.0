From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: Questions about Multi-touch Protocal
Date: Wed, 13 Jan 2010 21:21:37 +0100
Message-ID: <4B4E2B51.8010506@euromail.se>
References: <4B42D998.4050303@samsung.com> <4B432BDB.3000103@euromail.se> <4B43DE36.6000907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:39458 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756312Ab0AMUWR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2010 15:22:17 -0500
In-Reply-To: <4B43DE36.6000907@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz

Joonyoung Shim wrote:
[..]

> 
> The ABS_MT_TOUCH_MAJOR needs for several things as you explain, but i
> think it isn't essential event for multi-touch such ABS_PRESSURE.
> If we can get only the coodinates of each fingers, is it full enough for
> minimum supporting of multi-touch?

Yes, it will be fine, one can drop ABS_MT_TOUCH_MAJOR for minimal support of the
MT protocol. I will change the documentation accordingly.

Henrik

