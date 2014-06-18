From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: bad handling of HID input reports for a Delcom foot pedal
Date: Wed, 18 Jun 2014 14:13:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1406181411590.2303@pobox.suse.cz>
References: <CAN+gG=GbD-NjJUcSjYfp3rqnG9hHwmxT0ReEYFFDf88v_aS5qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42742 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966020AbaFRMN0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jun 2014 08:13:26 -0400
In-Reply-To: <CAN+gG=GbD-NjJUcSjYfp3rqnG9hHwmxT0ReEYFFDf88v_aS5qw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, bmills@alumni.cmu.edu

On Mon, 19 May 2014, Benjamin Tissoires wrote:

> Hi Jiri,
> 
> Please have a look at: https://bugzilla.kernel.org/show_bug.cgi?id=76461
> 
> To me, this device sends garbage and should not send the modifiers
> both in a Var input and in an Array input.
> 
> I can fix it either by amending the report descriptor of the device
> (one byte to change) or by changing hid-input.c for it to send the
> events in the array processing no matter what was the previous state
> (see below).
> 
> I don't know which one to pick because this seems to be a corner case,
> so fixing hid-input might not be the place, but I am afraid of
> removing part of the reports coming from the device (what if the
> modifiers are actually used for something in the report).
> 
> Any thoughts on it?
> 
> For the record, fixing hid-input would just remove the test in hid_input_field:
> 
>                 if (value[n] >= min && value[n] <= max
> -                       && field->usage[value[n] - min].hid
> -                       && search(field->value, value[n], count))
> +                       && field->usage[value[n] - min].hid)
>                                 hid_process_event(hid, field,
> &field->usage[value[n] - min], 1, interrupt);
>         }
> 
> (Sorry, gmail, whitespace damaged and everything)

So if modifying the report descriptor is not the option (which is what I 
understood from Bryan's mail), I have to say I don't really like this 
change in hid_input_field(), as it's really rather "non obvious".

How about just creating a device specific input event quirk for this?

-- 
Jiri Kosina
SUSE Labs
