From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 04/05] input synaptics-rmi4: rmi_driver - Export some
 symbols and functions for use by reflash.
Date: Mon, 10 Mar 2014 16:34:45 -0700
Message-ID: <20140310233445.GH18578@sonymobile.com>
References: <1394245795-17347-1-git-send-email-cheiny@synaptics.com>
 <1394245795-17347-4-git-send-email-cheiny@synaptics.com>
 <20140310150448.GD18578@sonymobile.com>
 <531E42C3.5000800@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:11641 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752535AbaCJXcw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 19:32:52 -0400
Content-Disposition: inline
In-Reply-To: <531E42C3.5000800@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Mar 10, 2014 at 11:54:59PM +0100, Christopher Heiny wrote:
> On 03/10/2014 08:04 AM, Courtney Cavin wrote:
> > On Sat, Mar 08, 2014 at 03:29:54AM +0100, Christopher Heiny wrote:
> >> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> > [...]
> >> -int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
> >> -			u16 pdt_address);
> >> +#define RMI_SCAN_CONTINUE	0
> >> +#define RMI_SCAN_DONE		1
> >> +
> >> +int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
> >> +		 int (*callback)(struct rmi_device *rmi_dev,
> >> +				 void *ctx, const struct pdt_entry *entry));
> >
> > I don't really like this callback.  The main reason for it is early
> > abort of PDT scanning, right?  It is really that beneficial?
> 
> Well, the main reason for adding this that there are several places 
> where we perform a PDT scan, and they were proving vulnerable to 
> cut-and-paste errors and code drift.  The boilerplate code of the 
> process of doing a PDT scan was also obscuring the actual purpose of 
> each PDT scan.
> 
> Early abort of the PDT scan is also important - in some of the scans you 
> want to quit as soon as you've found the function(s) of interest, or if 
> you detect that the device is still in bootloader mode.  Since there are 
> 256 possible RMI4 pages to scan, stopping early provides serious time 
> savings at boot time and during the reflash process.  It also simplifies 
> the code when the device comes up in bootloader mode.

Ok.  I'm not entirely familiar with the whole paging thing, as it wasn't
part of the spec when I was working with this stuff.  Is it not true
that you can cancel looking through pages when you encounter one with no
functions?  I guess it could be possible that there is a device with all
256 pages populated, where we could encounter a large enough time
difference though.  Bummer.

Maybe we can do something like the following:

struct rmi_pdt {
	u8 page;
	u8 offset;
};

int rmi_pdt_init(struct rmi_dev *dev, struct rmi_pdt *pdt);
int rmi_pdt_next(struct rmi_dev *dev, struct rmi_pdt *pdt,
		struct rmi_pdt_entry *e);

Where you can do:

	struct rmi_pdt_entry e;
	struct rmi_pdt pdt;

	rmi_pdt_init(dev, &pdt);

	while (!rmi_pdt_next(dev, &pdt, &e)) {
		do something; break when done
	}

With this, you can drive the scanning directly from where you want the
data, instead of playing with void pointers.  It's also hard to use
incorrectly, and easy to follow.

What do you think?

> >> +int check_bootloader_mode(struct rmi_device *rmi_dev,
> >> +			  const struct pdt_entry *pdt);
> >
> > This is a silly function name to put in a header. rmi_* perhaps?
> 
> Yes, I noticed that too while preparing the patch, along with a lot of 
> other instances.  I decided to do an overall namespace cleanup later, 
> and not piggyback it onto this particular patchset.  I'll fix this one 
> if it's a blocking issue.

I'd like it if we could fix this in this series, so we don't forget
later.

-Courtney
