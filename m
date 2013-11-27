From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: uhid: fix leak for 64/32 UHID_CREATE
Date: Wed, 27 Nov 2013 10:54:13 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1311271053570.14638@pobox.suse.cz>
References: <1385449330.23855.46.camel@deadeye.wl.decadent.org.uk>  <1385470698-6036-1-git-send-email-dh.herrmann@gmail.com> <1385476197.23855.51.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1385476197.23855.51.camel@deadeye.wl.decadent.org.uk>
Sender: stable-owner@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 26 Nov 2013, Ben Hutchings wrote:

> On Tue, 2013-11-26 at 13:58 +0100, David Herrmann wrote:
> > UHID allows short writes so user-space can omit unused fields. We
> > automatically set them to 0 in the kernel. However, the 64/32 bit
> > compat-handler didn't do that in the UHID_CREATE fallback. This will
> > reveal random kernel heap data (of random size, even) to user-space.
> > 
> > Reported-by: Ben Hutchings <ben@decadent.org.uk>
> > Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> > Cc: stable@vger.kernel.org
> 
> Fixes: befde0226a59 ('HID: uhid: make creating devices work on 64/32 systems')
> 
> (that should make it clear which versions need the fix)

Thanks a lot, applied with the Fixes: annotation added.

-- 
Jiri Kosina
SUSE Labs
