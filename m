From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] Input: add sensable phantom driver
Date: Wed, 7 Mar 2007 08:50:04 -0800
Message-ID: <20070307165003.GA21766@suse.de>
References: <2460126662758025813@fi.muni.cz> <d120d5000703070647t223f8858i8c495dcc3e1378a2@mail.gmail.com> <45EEEAA3.50009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <45EEEAA3.50009@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, Mar 07, 2007 at 05:38:59PM +0100, Jiri Slaby wrote:
> Dmitry Torokhov napsal(a):
> >>+static int __devinit phantom_probe(struct pci_dev *pdev,
> >>+       const struct pci_device_id *pci_id)
> >>+{
> >>+       struct phantom_device *pht;
> >>+       unsigned int minor;
> >>+       int retval;
> >>+
> >>+       retval = pci_enable_device(pdev);
> >>+       if (retval)
> >>+               goto err;
> >>+
> >>+       minor = phantom_get_free();
> >>+       if (minor == PHANTOM_MAX_MINORS) {
> >>+               dev_err(&pdev->dev, "too many devices found!\n");
> >>+               retval = -EIO;
> >>+               goto err;
> >>+       }
> >>+
> >>+       phantom_devices[minor] = 1;
> >
> >Locking? In face of multithreaded PCI probes it might be needed.
> 
> I think, this is the same issue?
> 
> <cite from="akpm" date="12/19/06">
> On Sat, 16 Dec 2006 02:09:48 +0100 (CET)
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
> > isicom, fix probe race
> >
> > Fix two race conditions in the probe function with mutex.
> >
> > ...
> >
> >  static int __devinit isicom_probe(struct pci_dev *pdev,
> >       const struct pci_device_id *ent)
> >  {
> > +     static DEFINE_MUTEX(probe_lock);
> 
> hm.  How can isicom_probe() race with itself?  Even with the dreaded
> multithreaded-pci-probing?  It's only called once, by a single thread.
> 
> Confused.
> </cite>
> 
> What do you think? Greg?

We used to be able to call the pci probe functions from different
threads for different devices.  But people seemed to like to enable
options that told them their box could blow up into tiny pieces and then
got upset when it did.  So I removed the option :(

So you don't have to worry about it now, but note that it could race
with the remove function if two different devices are in the system, one
being added and one removed at the same time.  So you should protect it
with a spinlock or something.

thanks,

greg k-h
