From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Tue, 21 Jul 2009 08:58:14 -0700
Message-ID: <20090721155814.GC4352@dtor-d630.eng.vmware.com>
References: <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com> <20090629162619.GB24533@dtor-d630.eng.vmware.com> <4A55BC78.6010206@gmail.com> <4A602D6D.1090707@teltonika.lt> <5d5443650907170132rfea7649o31bb3a84d3c7c79c@mail.gmail.com> <4A60425D.9@teltonika.lt> <5d5443650907200012o4c84b0fm4a03cfb18f7fd738@mail.gmail.com> <4A6448D0.6050002@gmail.com> <20090721080036.GA10168@dtor-d630.eng.vmware.com> <4A657BC7.8090904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:19819 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616AbZGUP6Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2009 11:58:25 -0400
Received: by rv-out-0506.google.com with SMTP id f6so868366rvb.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2009 08:58:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A657BC7.8090904@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org

On Tue, Jul 21, 2009 at 04:26:47PM +0800, Eric Miao wrote:
> Dmitry Torokhov wrote:
> > Hi Eric,
> > 
> > On Mon, Jul 20, 2009 at 06:37:04PM +0800, Eric Miao wrote:
> >>>>> Did you tried assigning max_keypmap_size in platform data to
> >>>>> MATRIX_MAX_COLS * MATRIX_MAX_ROWS ?
> >>>>>
> >>>> Yes, this fixes crashes. But this is just workaround for bug in driver.
> >>>>
> >>> As you have access to h/w, care to submit a patch which fixes this?
> >>>
> >> Dmitry & Trilok,
> >>
> >> How about this?  Due to the fact that we are not able to sort out the
> >> proper solution for a dynamic maximum of columns/rows, let's simplify
> >> the fix to the patch below:
> >>
> >>
> >> From 61ea1bd16a3636f526fb12619e84a75fa16b7f38 Mon Sep 17 00:00:00 2001
> >> From: Eric Miao <eric.y.miao@gmail.com>
> >> Date: Mon, 20 Jul 2009 11:31:08 +0800
> >> Subject: [PATCH] input: matrix keymap size fixed to maximum
> >>
> >> Introduced KEY_IDX(), merged keymap_data into 'matrix_keypad_platform_data'.
> >>
> > 
> > I would like to keep definitions in matrix_keymap.h useable to other
> > drivers so we either make KEY_IDX() work with different number of
> > columns or drop it.
> 
> What about:
> 
> #define KEY_IDX(row, col)	(((row) * keypad->num_columns) + (col))
> 
> if we want to make it dynamic.
> 

I'd rather not have any references to particular data structures there,
so something like KEY_IDX(row, col, shift) or KEY_IDX(row, col, maxcol).
Would that work for you?


> > I would also like to keep keymap data separate so
> > drivers that don't use matrix encoding could still use it.
> > 
> 
> Do you mean there are possibilities that some drivers are not going to
> define any matrix keycodes, and depend on EV_MSC to know the position
> happened? That way, we may want to omit the ->keycodes[] accesses.
> 

Poorly spoken on my part. I should have said "not use entire structure
from the matrix_keymap.h" but only the keymap part.

> > Overall, I don't quite understand what the problem with the current
> > drive is since it works fine as long as we set up max_keymap_size
> > properly.
> 
> I think the root of this problem lies in the code below:
> 
>                         code = (row << 4) + col;
>                         input_event(input_dev, EV_MSC, MSC_SCAN, code);
>                         input_report_key(input_dev,
>                                          keypad->keycodes[code],
>                                          new_state[col] & (1 << row));
> 
> that 'code = (row << 4) + col;' is hardcoded to shift left by '4', and
> is then used to index into keypad->keycodes[] array, the size of which
> in turn is specified by 'max_keymap_size'. This is a bit inconsistent.

Right, I agree.

> 
> If written as (row << 4) + col, it means the max_keymap_size should be
> setup as 'max_rows * 16', instead of expected 'max_rows * max_cols'.
> 

Yes, at the moment... I guess we need to put the true dimensions instead
of max size into the keymap data, right? Then we'd be able to calculate
proper shift value.

> And there seems to be a typo in the allocation:
> 
>         keycodes = kzalloc(keymap_data->max_keymap_size *
>                                 sizeof(keypad->keycodes),
>                            GFP_KERNEL);
> 
> that, 'sizeof(keypad->keycodes)' should be written as
> 'sizeof(keypad->keycodes[0])' if I guess it correct.

It should not hurt anything (since sizeof(keypad->keycodes) is 4 bytes)
but indeed I need to fix that.

> 
> > We could improve diagnostic by checking row and cols values
> > and warning users when they supply suspicious data and maybe adjust the
> > documentation, right?
> > 
> 

-- 
Dmitry
