From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 1/5] atkbd: Fix key release for Fn keys on Samsung series 5
 ultra 540UC
Date: Mon, 29 Jul 2013 07:04:32 -0300
Message-ID: <20130729070432.726becc3@samsung.com>
References: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
 <20130729044909.GA8539@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]:29017 "EHLO
	usmailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab3G2KEh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jul 2013 06:04:37 -0400
Received: from uscpsbgm2.samsung.com
 (u115.gpu85.samsung.co.kr [203.254.195.115]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MQO00GXBZZPCA10@usmailout3.samsung.com> for
 linux-input@vger.kernel.org; Mon, 29 Jul 2013 06:04:37 -0400 (EDT)
In-reply-to: <20130729044909.GA8539@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Em Sun, 28 Jul 2013 21:49:09 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> escreveu:

> Hi Mauro,
> 
> 
> On Mon, Jul 29, 2013 at 12:59:35AM -0300, Mauro Carvalho Chehab wrote:
> > Samsung series 5 ultra notebooks don't produce release events for certain
> > keys (Fn+F1, Fn+F11, Fn+F12 and Fn Lock). Add those keys at the release
> > fixup table.
> > 
> 
> As I mentioned, the force release should be handled by udev instead of
> adding kernel driver quirk.

Ah, OK. I'll drop both patches 1 and 2 on a next patchset.

-- 

Cheers,
Mauro
