From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCHv1] staging: Synaptics RMI4 touchpad driver support
Date: Tue, 2 Nov 2010 15:14:48 +0100
Message-ID: <4CD01CD8.3090206@stericsson.com>
References: <1288699725-14405-1-git-send-email-naveen.gaddipati@stericsson.com> <20101102140337.GC9387@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101102140337.GC9387@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Greg KH wrote:

>> +Wait for the official upstream synaptics rmi4 clearpad drivers as promised over the past few months
>> +Merge any device support needed from this driver into it
>> +Delete this driver
> 
> Huh?
> 
> Why not just add this driver to the kernel tree instead?  When the
> "promised" driver then eventually shows up (who is promising it?) then
> delete the thing.

Well, Alan (on behalf of Ramesh Agarwal) sent out a very similar
patch (Titled "Synaptics TM1217 Touchscreen Controller driver")
the other day, and OTOMH that was after discussions with Synaptics
where they said they were working on a "real" driver (a rather
complex RMI4 bus driver) and we believe they will fix that sooner
or later.

So, until sooner or later happens we thought we'd keep it in staging.

If you prefer both Alan and we can probably submit our patches for
inclusion in the proper place.

A side effect may be that the Synaptics RMI4 people may have trouble
to merge their driver into input/ since they may be requested to
refactor the existing drivers to use it rather than merging new stuff,
putting some burden on their shoulders.

Yours,
Linus Walleij
