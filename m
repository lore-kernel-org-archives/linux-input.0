From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RESEND] Lenovo Yoga 900 touchpad issues
Date: Mon, 21 Dec 2015 13:32:47 +0200
Message-ID: <20151221113247.GB1758@lahna.fi.intel.com>
References: <CAOhV88MGoJdUzty=DDTLOkd7me5uoRWwTTrR8aD=zf5ga0_Hew@mail.gmail.com>
 <20151216092858.GP1762@lahna.fi.intel.com>
 <CAOhV88Mv+RUADPHT5AwD=dR-VdPn7Cmf4TkJoaBjNA4Q6zL6WQ@mail.gmail.com>
 <20151218144209.GK1762@lahna.fi.intel.com>
 <20151218153802.GL1762@lahna.fi.intel.com>
 <20151218161031.GB12730@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48334 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbbLULfA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Dec 2015 06:35:00 -0500
Content-Disposition: inline
In-Reply-To: <20151218161031.GB12730@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Dec 18, 2015 at 05:10:31PM +0100, Benjamin Tissoires wrote:
> After turning this around, I think I finally got what was going on (and
> yes, it's basically a race that should have been caught long ago):
> - during resume, the i2c-hid driver calls reset, which is a long (few
>   ms) operation.
> - hid-multitouch is also called during resume, and right after i2c-hid
> - hid-multiotuch immediately emits for touchpads a set input mode (this
>   was unseen with touchscreens because they do not have to be switched
>   into a proper mode)
> - there is a race between hid-multitouch accessing the features while
>   the device is still resetting. And our reset interrupt never gets to
>   us because there was an other operation in progress to request/set
>   reports
> 
> So the actual fix would be to make hid-multitouch wait until we reset
> i2c-hid.

The driver used for touchpad is actually hid-rmi but you are right, it
tries to set rmi mode (or something) during its rmi_post_reset() that
then confuses the i2c-hid driver.

Thanks for the analysis :-)

> This should be done by either a mutex or a spinlock in
> i2c_hid_output_raw_report() and i2c_hid_resume() that would protect a
> flag set during suspend and cleared after resume.

Makes sense. I'll make a patch that does this and submit it soon.
