From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input+S3: extra keycodes forgotten after suspend
Date: Mon, 19 May 2008 11:50:47 -0400
Message-ID: <20080519114827.ZZRA012@mailhub.coreip.homeip.net>
References: <200805162225.44284.bonbons@linux-vserver.org> <20080516163318.ZZRA012@mailhub.coreip.homeip.net> <200805162300.06027.bonbons@linux-vserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:60646 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbYESPvT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 May 2008 11:51:19 -0400
Received: by py-out-1112.google.com with SMTP id u52so1944978pyb.10
        for <linux-input@vger.kernel.org>; Mon, 19 May 2008 08:51:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200805162300.06027.bonbons@linux-vserver.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno Pr?mont <bonbons@linux-vserver.org>
Cc: Linux Input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>

Hi Bruno,

On Fri, May 16, 2008 at 11:00:04PM +0200, Bruno Pr?mont wrote:
> [  252.668456] PM: Finishing wakeup.
> [  252.668456] Restarting tasks ... done.
> [  252.745418] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input7

Ok, so for some reason it could not resume and here it re-detected the
keyboard creating the new input device thus resetting the keymap. The
question is why it had to re-detect. Could you please do

	echo 1 > /sys/modules/i8042/parameters/debug

before suspending and send me full dmesg please?

-- 
Dmitry
