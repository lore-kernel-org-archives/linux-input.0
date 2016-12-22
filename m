From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] patches for Innomedia INNEX GENESIS/ATARI adapter
Date: Thu, 22 Dec 2016 22:00:10 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612222153560.19203@cbobk.fhfr.pm>
References: <20161216213130.19303-1-tk@the-tk.com> <alpine.LSU.2.20.1612191144240.19203@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.20.1612191144240.19203@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Kramkowski <tk@the-tk.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 19 Dec 2016, Jiri Kosina wrote:

> > This is a couple of patches which fix issues with the (1292:4745)
> > Innomedia INNEX GENESIS/ATARI controller USB adapter. I've personally
> > tested these patches against the master of the hid tree.
> > 
> > Patch 2 depends on patch 1.
> > 
> > I wasn't sure if adding a new config symbol meant I needed to add it to
> > some default config so I left that alone.
> > 
> > Hopefully I didn't screw anything up.
> 
> All looks good, except I'd probably squash both the patches into one 'add 
> adapter support', as I don't really see a value with separating this into 
> two patches. If you agree, I can do that myself and apply.

We've discussed with Tomasz off-list, and it looks like that there likely 
is a better and more general way to fix it; this seems to have actually 
been caused by 6da7066906e977d4 ("HID: ignore absolute values which don't 
fit between logical min and max"), as it turns out that this check should 
be applied only in case Null state is set (refer to HID specification 
1.11, section 6.2.2.5, p.31), bko#68621.

Tomasz comitted to look into this after coming back from christmas/new 
year vacation. I'm putting the innomedia branch on hold for now.

-- 
Jiri Kosina
SUSE Labs
