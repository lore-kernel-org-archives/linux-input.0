From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 04/13] Input: add motion-tracking ABS_* bits and docs
Date: Fri, 15 Nov 2013 11:11:35 +0100
Message-ID: <20131115111135.1548dc0a4effdad8f672ff24@studenti.unina.it>
References: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
	<1383336984-26601-5-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:42504 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466Ab3KOKLl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Nov 2013 05:11:41 -0500
In-Reply-To: <1383336984-26601-5-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Fri,  1 Nov 2013 21:16:15 +0100
David Herrmann <dh.herrmann@gmail.com> wrote:

> Motion sensors are getting quite common in mobile devices. To avoid
> returning accelerometer data via ABS_X/Y/Z and irritating the Xorg
> mouse-driver, this adds separate ABS_* bits for that.
> 
> This is needed if gaming devices want to report their normal data plus
> accelerometer/gyro data. Usually, ABS_X/Y are already used by analog
> sticks, so need separate definitions, anyway.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Hi, what's the status of this patch?
I cannot see it in Dmitry's repository, David maybe you have another
repository I can pull from? 

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
