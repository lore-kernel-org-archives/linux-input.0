From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: How to indicate hover touch when exact distance unknown?
Date: Tue, 23 Sep 2014 17:27:12 -0700
Message-ID: <20140924002712.GB16747@core.coreip.homeip.net>
References: <CAG_cf+dJfiqW_V1k4MfGMBNUK9Kgc4=9BPAuum7dbs6rkmAgrQ@mail.gmail.com>
 <20140923145916.GA3110@mail.corp.redhat.com>
 <20140923162811.GB40700@core.coreip.homeip.net>
 <CAG_cf+fuugk4QK_1BtWnJWzunWT4QeSus_2cuPpYH_8UCUjMOQ@mail.gmail.com>
 <5421C15C.6030302@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:39252 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbaIXA1R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Sep 2014 20:27:17 -0400
Received: by mail-pa0-f43.google.com with SMTP id kx10so7627636pab.2
        for <linux-input@vger.kernel.org>; Tue, 23 Sep 2014 17:27:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5421C15C.6030302@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Andrew de los Reyes <andrew-vger@gizmolabs.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, hdegoede@redhat.com, jikos@jikos.cz, David Herrmann <dh.herrmann@gmail.com>, peter.hutterer@who-t.net, Linux Input <linux-input@vger.kernel.org>

On Tue, Sep 23, 2014 at 08:52:12PM +0200, Henrik Rydberg wrote:
> >>> So I am not very happy with having a new
> >>> tool. In the end, it may also disturb older clients which will not know
> >>> what to do with HOVER.
> >>> And the ABS_MT_DISTANCE approach used to be fully retro-compatible
> >>> (assuming that the hovering distance is small enough for the user not to
> >>> detect it).
> >>
> >> Except that if we start getting devices that can actually tell the
> >> distance we'd need special casing 0/1 handling, no?
> 
> Logically, a hovering object which does not support real distance reporting
> would simply be present in the contact list but have ABS_MT_TOUCH = 0. However,
> I do not think all layers of the stack supports this notion.

That unfortunately does not give us indication whether device supports
hover or not: we'll know only when we see it.

-- 
Dmitry
