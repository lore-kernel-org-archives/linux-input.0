From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: New Alps protocol in the wild?
Date: Tue, 14 Aug 2012 11:15:45 -0500
Message-ID: <20120814161545.GE18992@thinkpad-t410>
References: <20120814103553.GF23370@arianrhod.panaceas.james.local>
 <87mx1xxy1y.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58629 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab2HNQP7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Aug 2012 12:15:59 -0400
Content-Disposition: inline
In-Reply-To: <87mx1xxy1y.fsf@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <bgamari@gmail.com>
Cc: James <linux-input@madingley.org>, linux-input@vger.kernel.org

On Tue, Aug 14, 2012 at 12:01:29PM -0400, Ben Gamari wrote:
> James <linux-input@madingley.org> writes:
> 
> > I just got a Dell E6230 with the same E7 report: 73 03 0a
> > As noted above using the qemu serio logging doesn't work.
> > The driver only enables multitouch if it sees the right
> > name for the device in the DSDT.
> >
> > The following patch (against the seabios in qemu-0.14.1)
> > enables the windows 7 driver (7.1211.101.114 from
> > http://www.dell.com/support/drivers/us/en/04/DriverDetails/DriverFileFormats/Product/latitude-e6230?DriverId=CKNFN&FileId=2988050063&urlProductCode=False 
> > ) to bind successfully and alows one to get data from the serio
> > logging patch
> >
> > Are there any standard tools for reverse engineering the
> > protocol - I saw mention of an alps-reg-dump but was
> > unable to find it?
> >
> alps-reg-dump can be found here[1]. Depending upon how different the
> protocol is it may or may not be useful, however.

Just a warning that I haven't updated that in quite some time, and I'm
not even sure exactly how far I was in reverse engineering the protocol
when I stopped updating it. So it may or may not be useful to you.

Seth

