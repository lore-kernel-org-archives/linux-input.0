From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC v3 0/5] hid-multitouch: a first step towards multitouch
 unification
Date: Sat, 8 Jan 2011 00:00:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101072359450.26685@pobox.suse.cz>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr> <alpine.LNX.2.00.1101072355200.26685@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1101072355200.26685@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 7 Jan 2011, Jiri Kosina wrote:

> > here is the v3.
> > 
> > all changes are coming from the mails with Henrik:
> > 
> > - restricted to new drivers only
> > - delete mt_buffer struct
> > - replace/adapt prev_valid in favor of seen_in_this_frame
> > - integrated fuzz
> > - introduce MT_QUIRKS
> > - other small fixes
> 
> Hi Bejnamin,
> 
> thanks a lot for spinning this up so nicely and quickly.
> 
> I have now applied the patchset as-is to the 'multitouch' branch in my 
> tree.

Which means -- could you please send any followup patches on top of that 
branch (i.e. on top of the v3 patchset)? It would help my workflow and 
make the merging process smoother.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
