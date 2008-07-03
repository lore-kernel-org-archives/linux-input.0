From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 001/002] linux-input:  bcm5974-0.31: fixed resource
 leak, removed work struct, device data struct introduced
Date: Thu, 3 Jul 2008 08:09:56 -0700
Message-ID: <20080703080956.723a116b.randy.dunlap@oracle.com>
References: <1214653629.10495.11.camel@alnilam>
	<20080701155925.a4c00a8e.akpm@linux-foundation.org>
	<1214984799.11086.6.camel@alnilam>
	<20080702005355.8da89ef7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080702005355.8da89ef7.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Henrik Rydberg <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robfitz-lqAI2a470fI@public.gmane.org, jikos-wDf7oJUeT2I@public.gmane.org, vojtech-AlSwsSmVLrQ@public.gmane.org, dmonakhov-GEFAQzZX7r8dnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 2 Jul 2008 00:53:55 -0700 Andrew Morton wrote:

> On Wed, 02 Jul 2008 09:46:39 +0200 Henrik Rydberg <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org> wrote:
> 
> > On Tue, 2008-07-01 at 15:59 -0700, Andrew Morton wrote:
> > > > Subject: [PATCH 001/002] linux-input:  bcm5974-0.31: fixed resource leak, removed work struct, device data struct introduced
> > > 
> > > hm, I wonder where [002/002] went.
> > 
> > Thank you very much for your comments, I will return shortly with a new
> > version. I did not fully grasp, from reading
> > Documentation/SubmitPatches, how the numbering in the subject should
> > work; when I submit my new version in reply to your mail, should I
> > submit a complete patch against the vanilla kernel, with number 001/003?
> > 
> 
> no....
> 
> The sequence numbering is only used when you're sending two or more

related, dependent,

> patches at the same time.  It is used so that the recipient can work
> out what order they are to be applied in (they can get reordered in
> flight) and so that the recipient can verify that none were missed.
> 
> So for a single patch, don't include it at all.

For multiple unrelated patches, sequence numbering could even be confusing
to recipients.  Could make them think that they missed some patch(es)
when they didn't.


> Also, it is better to prepare 2.6.27 patches against linux-next, as
> that is the candidate 2.6.27 tree.  But in the case of a brand new
> driver it doesn't matter a lot.  Unless you're using some interface
> which we've gone and changed, but that's fairly uncommon.


---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
