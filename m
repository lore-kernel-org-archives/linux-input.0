From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v5 0/2] Documentation and Sample for hidraw
Date: Tue, 22 Mar 2011 11:44:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103221143560.19969@pobox.suse.cz>
References: <1297829209-10511-1-git-send-email-alan@signal11.us> <1300580985-10726-1-git-send-email-alan@signal11.us> <20110321131732.8e8906a8.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20110321131732.8e8906a8.rdunlap@xenotime.net>
Sender: linux-doc-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Alan Ott <alan@signal11.us>, Jonathan Corbet <corbet@lwn.net>, Antonio Ospite <ospite@studenti.unina.it>, Jason Wessel <jason.wessel@windriver.com>, Andrew Morton <akpm@linux-foundation.org>, Stefani Seibold <stefani@seibold.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 21 Mar 2011, Randy Dunlap wrote:

> > Sorry I've been slack in getting v5 of this patch out. Because
> > it's been so long, I'll recap what happened last time:
> > 
> >  * Jon Corbet suggested that the example programs be moved into samples/ .
> >  * Randy Dunlap indicated his acked-by when this was done.
> > 
> > These patches add hidraw.txt to a new Documentation/hid/ directory.
> > 
> > It creates an example program which is now in samples/ with a Kconfig item.
> > 
> > The existing hiddev.txt has been moved from Documentation/usb/ to
> > Documentation/hid/
> 
> Jiri,
> 
> I suppose that you will merge these patches?
> or did you want me to do it?

Yeah, I am taking it through hid.git tree. Thanks!

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
