From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: avoid sparse warning in HID_COMPAT_LOAD_DRIVER
Date: Tue, 16 Dec 2008 17:01:38 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0812161659580.21089@jikos.suse.cz>
References: <4947a48f.08b6660a.34ca.ffffa1e8@mx.google.com> <20081216155822.GD12431@fluff.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:38584 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756988AbYLPQBk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2008 11:01:40 -0500
In-Reply-To: <20081216155822.GD12431@fluff.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Hannes Eder <hannes@hanneseder.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Tue, 16 Dec 2008, Ben Dooks wrote:

> >  #ifdef CONFIG_HID_COMPAT
> >  #define HID_COMPAT_LOAD_DRIVER(name)	\
> > +/* prototype to avoid sparse warning */	\
> > +extern void hid_compat_##name(void);	\
> >  void hid_compat_##name(void) { }	\
> surely this could simply be changed to 'static void 
> hid_compat_##name(void)' if it is only being defined to be an empty 

This will cause gcc emit warnings about unused symbols.

-- 
Jiri Kosina
SUSE Labs
