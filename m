From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 001/001] hid-sony.c: add sysfs provisioning
Date: Tue, 18 Nov 2014 23:43:49 +0100
Message-ID: <20141118234349.7b44949197898390d496f1cd@ao2.it>
References: <20141116181846.GA31516@abrij.org>
	<20141117133518.ee306b3b35a0e0566a255b14@ao2.it>
	<20141118020144.GB32256@abrij.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:40779 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932322AbaKRWoA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Nov 2014 17:44:00 -0500
In-Reply-To: <20141118020144.GB32256@abrij.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: bri <bri@abrij.org>
Cc: Frank Praznik <frank.praznik@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>

On Mon, 17 Nov 2014 21:01:44 -0500
bri <bri@abrij.org> wrote:

> On Mon, Nov 17, 2014 at 01:35:18PM +0100, Antonio Ospite wrote:
> > I had tried doing something similar in the past (the parsing was just a
> > sscanf): http://thread.gmane.org/gmane.linux.bluez.kernel/5261 but then
> > we deliberately decided against exposing specific sysfs interfaces for
> > device/master_bdaddr, you can just use generic HID feature reports from
> > userspace to get/set these, write a simple program reusing the code in
> > the BlueZ sixaxis plugin, using the ioclts
> > HIDIOCGFEATURE/HIDIOCSFEATURE, this way you don't depend on libusb. As
> > an historical note, the BlueZ sixaxis plugin was one of the first user
> > of these ioctls.
> 
> ...
> 
> > That said I still don't think the changes you are proposing are strictly
> > necessary in the kernel driver, but let's see what the others have to
> > say about that.
> 
> On Mon, Nov 17, 2014 at 02:39:35PM -0500, Frank Praznik wrote:
> > Agreed, I don't see a need for exposing this as a sysfs entry since it's
> > easy enough to use hidraw and an ioctl call to set/get the master address.
> 
> For this argument I would offer that "easy" is different for you or I
> working on a development system than for a less versed person working
> to personally customize an appliance that didn't come with a gcc package,
> but probably did come with /bin/sh.
> 

If you can upload a shell script to the target system you may as well
upload a static binary; and if you can use a modified kernel you can
compile _for_ the target even if not _on_ the target.

And if you need help to write the program which uses the HID ioctls
just ask :)

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
