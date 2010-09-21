From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [BUG] object: is not initialized, yet kobject_put() is being
 called
Date: Tue, 21 Sep 2010 17:53:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009211752520.26813@pobox.suse.cz>
References: <20100812115657.GA1611@arch.tripp.de> <alpine.LNX.2.00.1008121401580.2702@pobox.suse.cz> <alpine.LNX.2.00.1008121457060.2702@pobox.suse.cz> <20100812130411.GA1626@arch.tripp.de> <4C63F285.8070801@signal11.us> <20100812164035.GB6761@fritha.org>
 <20100920181100.GA12295@fancy-poultry.org> <alpine.LNX.2.00.1009211653510.26813@pobox.suse.cz> <20100921150900.GA6801@fritha.org> <alpine.LNX.2.00.1009211714400.26813@pobox.suse.cz> <20100921152728.GA13464@fritha.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100921152728.GA13464-iEI8Y0CNJBYdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heinz Diehl <htd-iEI8Y0CNJBYdnm+yROfE0A@public.gmane.org>
Cc: Heinz Diehl <htd-HjJ2MNWy62to6+H+lsi3Gti2O/JbrIOy@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Markus Trippelsdorf <markus-xp2qqqlHh3xzoYq+O6RWwA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 21 Sep 2010, Heinz Diehl wrote:

> > strace -f would likely be more helpful.
> 
> Oops, yes, of course. Output is attached.

Looks like the /dev/usb/hiddev* nodes are not being created at all. Could 
you please attach output of dmesg and ls -l /dev/usb

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
