From: Bryan Mills <bmills@alumni.cmu.edu>
Subject: Re: bad handling of HID input reports for a Delcom foot pedal
Date: Sun, 6 Jul 2014 16:52:09 -0400
Message-ID: <CAKvz5rrBbgbo16uANTpOgk8VbZ58LyR007m6KqUyue2J2OeqJA@mail.gmail.com>
References: <CAN+gG=GbD-NjJUcSjYfp3rqnG9hHwmxT0ReEYFFDf88v_aS5qw@mail.gmail.com>
 <alpine.LNX.2.00.1406181411590.2303@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:56657 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbaGFUwu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Jul 2014 16:52:50 -0400
Received: by mail-qg0-f48.google.com with SMTP id q108so3060749qgd.35
        for <linux-input@vger.kernel.org>; Sun, 06 Jul 2014 13:52:49 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1406181411590.2303@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Wed, Jun 18, 2014 at 8:13 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 19 May 2014, Benjamin Tissoires wrote:
> > Hi Jiri,
> >
> > Please have a look at: https://bugzilla.kernel.org/show_bug.cgi?id=76461
> >
> > To me, this device sends garbage and should not send the modifiers
> > both in a Var input and in an Array input.
> >
> > I can fix it either by amending the report descriptor of the device
> > (one byte to change) or by changing hid-input.c for it to send the
> > events in the array processing no matter what was the previous state
> > (see below).
> >
> > I don't know which one to pick because this seems to be a corner case,
> > so fixing hid-input might not be the place, but I am afraid of
> > removing part of the reports coming from the device (what if the
> > modifiers are actually used for something in the report).
> >
> > Any thoughts on it?
> >
> > For the record, fixing hid-input would just remove the test in hid_input_field:
> >
> >                 if (value[n] >= min && value[n] <= max
> > -                       && field->usage[value[n] - min].hid
> > -                       && search(field->value, value[n], count))
> > +                       && field->usage[value[n] - min].hid)
> >                                 hid_process_event(hid, field,
> > &field->usage[value[n] - min], 1, interrupt);
> >         }
> >
> > (Sorry, gmail, whitespace damaged and everything)
>
> So if modifying the report descriptor is not the option (which is what I
> understood from Bryan's mail), I have to say I don't really like this
> change in hid_input_field(), as it's really rather "non obvious".
>
> How about just creating a device specific input event quirk for this?
>
> --
> Jiri Kosina
> SUSE Labs

A device-specific quirk would be fine.

But what's wrong with simply removing the "search" test?  It's a no-op
for non-quirky devices (which don't send redundant keycodes) and a bug
for quirky ones (which should take the union of redundant keycodes
instead of dropping them).

Removing the test produces simpler code and handles the quirky devices
correctly without the need to check for them explicitly.
