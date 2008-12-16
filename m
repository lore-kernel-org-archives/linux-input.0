From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] HID: avoid sparse warning in HID_COMPAT_LOAD_DRIVER
Date: Tue, 16 Dec 2008 19:41:13 +0000
Message-ID: <20081216194113.GF12431@fluff.org.uk>
References: <4947a48f.08b6660a.34ca.ffffa1e8@mx.google.com> <20081216155822.GD12431@fluff.org.uk> <alpine.LNX.1.10.0812161659580.21089@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756071AbYLPTlm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0812161659580.21089@jikos.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Ben Dooks <ben-linux@fluff.org>, Hannes Eder <hannes@hanneseder.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 16, 2008 at 05:01:38PM +0100, Jiri Kosina wrote:
> On Tue, 16 Dec 2008, Ben Dooks wrote:
> 
> > >  #ifdef CONFIG_HID_COMPAT
> > >  #define HID_COMPAT_LOAD_DRIVER(name)	\
> > > +/* prototype to avoid sparse warning */	\
> > > +extern void hid_compat_##name(void);	\
> > >  void hid_compat_##name(void) { }	\
> > surely this could simply be changed to 'static void 
> > hid_compat_##name(void)' if it is only being defined to be an empty 
> 
> This will cause gcc emit warnings about unused symbols.

sorry, 'static inline void' then.
 
> -- 
> Jiri Kosina
> SUSE Labs
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
