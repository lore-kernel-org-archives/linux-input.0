From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Tue, 21 Jul 2009 01:00:36 -0700
Message-ID: <20090721080036.GA10168@dtor-d630.eng.vmware.com>
References: <200906112103.54043.dmitry.torokhov@gmail.com> <5d5443650906120601g2e0a563eq270095d5a001d0a1@mail.gmail.com> <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com> <20090629162619.GB24533@dtor-d630.eng.vmware.com> <4A55BC78.6010206@gmail.com> <4A602D6D.1090707@teltonika.lt> <5d5443650907170132rfea7649o31bb3a84d3c7c79c@mail.gmail.com> <4A60425D.9@teltonika.lt> <5d5443650907200012o4c84b0fm4a03cfb18f7fd738@mail.gmail.com> <4A6448D0.6050002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:50309 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbZGUIAn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2009 04:00:43 -0400
Received: by wa-out-1112.google.com with SMTP id j5so458460wah.21
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2009 01:00:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A6448D0.6050002@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org

Hi Eric,

On Mon, Jul 20, 2009 at 06:37:04PM +0800, Eric Miao wrote:
> 
> >>> Did you tried assigning max_keypmap_size in platform data to
> >>> MATRIX_MAX_COLS * MATRIX_MAX_ROWS ?
> >>>
> >> Yes, this fixes crashes. But this is just workaround for bug in driver.
> >>
> > 
> > As you have access to h/w, care to submit a patch which fixes this?
> > 
> 
> Dmitry & Trilok,
> 
> How about this?  Due to the fact that we are not able to sort out the
> proper solution for a dynamic maximum of columns/rows, let's simplify
> the fix to the patch below:
> 
> 
> From 61ea1bd16a3636f526fb12619e84a75fa16b7f38 Mon Sep 17 00:00:00 2001
> From: Eric Miao <eric.y.miao@gmail.com>
> Date: Mon, 20 Jul 2009 11:31:08 +0800
> Subject: [PATCH] input: matrix keymap size fixed to maximum
> 
> Introduced KEY_IDX(), merged keymap_data into 'matrix_keypad_platform_data'.
> 

I would like to keep definitions in matrix_keymap.h useable to other
drivers so we either make KEY_IDX() work with different number of
columns or drop it. I would also like to keep keymap data separate so
drivers that don't use matrix encoding could still use it.

Overall, I don't quite understand what the problem with the current
drive is since it works fine as long as we set up max_keymap_size
properly. We could improve diagnostic by checking row and cols values
and warning users when they supply suspicious data and maybe adjust the
documentation, right?

-- 
Dmitry
