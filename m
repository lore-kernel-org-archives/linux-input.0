From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 4/5] platform/x86: intel-vbtn: support
 KEY_ROTATE_LOCK_TOGGLE
Date: Thu, 9 Nov 2017 17:54:22 -0800
Message-ID: <20171110015422.GD9783@fury>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
 <1a034599-ff6c-4a42-8252-4f6007894f4a@rwthex-w2-a.rwth-ad.de>
 <1510270246.2624.43.camel@hadess.net>
 <6070680.Ajd9sKXNqZ@pebbles>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:59404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755383AbdKJByZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Nov 2017 20:54:25 -0500
Content-Disposition: inline
In-Reply-To: <6070680.Ajd9sKXNqZ@pebbles>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan =?iso-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Cc: Bastien Nocera <hadess@hadess.net>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, linux-kernel@vger.kernel.org

On Fri, Nov 10, 2017 at 01:15:09AM +0100, Stefan Brüns wrote:
> On Friday, November 10, 2017 12:30:46 AM CET Bastien Nocera wrote:
> > On Thu, 2017-11-09 at 23:44 +0100, Stefan Brüns wrote:
> > > The Rotate Lock button event is emitted on the XPS 12 (BIOS A8, but
> > > not
> > > on BIOS A2).
> > > 
> > > Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> > > ---
> > > 
> > > Changes in v2:
> > > - Emit KEY_ROTATE_LOCK_TOGGLE instead of KEY_ROTATE_DISPLAY
> > > - Use separate up/down events
> > > 
> > >  drivers/platform/x86/intel-vbtn.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/platform/x86/intel-vbtn.c
> > > b/drivers/platform/x86/intel-vbtn.c index e3f6375af85c..a484bcc6393b
> > > 100644
> > > --- a/drivers/platform/x86/intel-vbtn.c
> > > +++ b/drivers/platform/x86/intel-vbtn.c
> > > @@ -42,6 +42,8 @@ static const struct key_entry intel_vbtn_keymap[] = {
> > > 
> > >  	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/* volume-up key release */
> > >  	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/* volume-down key press */
> > >  	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release 
> */
> > > 
> > > +	{ KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key
> > > press */ +	{ KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },	/*
> > > rotate-lock key release */
> > How are those events sent? When pressing and releasing the key, do you
> > receive 0xC8 followed by 0xC9? Or do you receive 0xC8 when pressing and
> > releasing the first time, and 0xC9 when pressing and releasing a second
> > time?
> > 
> > If the former, then it's not going to work. The release is supposed to
> > be ignored, as you send the event with sparse_keymap_report_event().
> > 
> > If the latter, and there's an actual state, does it disable a device
> > on-board, or activate an LED? If so, then it would need to be a switch,
> > not a key.
> 
> Do you think I don't test the patches before sending? Let me tell you, it 
> *does* work.
> 
> You could also read the cover letter, where you find more details, putting the 
> patches in relation to each other.

A point of process. If there is context that is needed to explain the
patch, it belongs in the patch, not just in the cover letter. The cover
letter is effectively lost once the patches are merged.

> 
> Just in case its not yet clear:
> The codes are emitted when pressing a button. It is a button, not a switch. 
> There is no state handled in hardware. On press (as noted by the code 
> comment), event code 0xc8 is emitted. On release, event code 0xc9 is emitted.

This sounds like the "former" scenario Bastien described, for which I understand
the use case to be:

User presses and releases the rotate lock button to prevent the accelerometer for
triggering screen rotation.

User presses and releases the rotate lock button to allow the accelerometer to
trigger screen rotation.

Is that correct?

If so, why do we need to emit two KEY_ROTATE_LOCK_TOGGLE events each time
instead of just the press event like the volume buttons?

-- 
Darren Hart
VMware Open Source Technology Center
