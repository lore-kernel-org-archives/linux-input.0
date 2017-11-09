From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 4/5] platform/x86: intel-vbtn: support
 KEY_ROTATE_LOCK_TOGGLE
Date: Thu, 9 Nov 2017 15:46:30 -0800
Message-ID: <20171109234630.GG21449@fury>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
 <1a034599-ff6c-4a42-8252-4f6007894f4a@rwthex-w2-a.rwth-ad.de>
 <1510270246.2624.43.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:33507 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754627AbdKIXqd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Nov 2017 18:46:33 -0500
Content-Disposition: inline
In-Reply-To: <1510270246.2624.43.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Stefan =?iso-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, linux-kernel@vger.kernel.org

On Fri, Nov 10, 2017 at 12:30:46AM +0100, Bastien Nocera wrote:
> On Thu, 2017-11-09 at 23:44 +0100, Stefan Brüns wrote:
> > The Rotate Lock button event is emitted on the XPS 12 (BIOS A8, but
> > not
> > on BIOS A2).
> > 
> > Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> > ---
> > 
> > Changes in v2:
> > - Emit KEY_ROTATE_LOCK_TOGGLE instead of KEY_ROTATE_DISPLAY
> > - Use separate up/down events
> > 
> >  drivers/platform/x86/intel-vbtn.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
> > index e3f6375af85c..a484bcc6393b 100644
> > --- a/drivers/platform/x86/intel-vbtn.c
> > +++ b/drivers/platform/x86/intel-vbtn.c
> > @@ -42,6 +42,8 @@ static const struct key_entry intel_vbtn_keymap[] = {
> >  	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/* volume-up key release */
> >  	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/* volume-down key press */
> >  	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release */
> > +	{ KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key press */
> > +	{ KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key release */
> 
> How are those events sent? When pressing and releasing the key, do you
> receive 0xC8 followed by 0xC9? Or do you receive 0xC8 when pressing and
> releasing the first time, and 0xC9 when pressing and releasing a second
> time?
> 
> If the former, then it's not going to work. The release is supposed to
> be ignored, as you send the event with sparse_keymap_report_event().

I expect the former, which is consistent with the volume keys preceding it (also
ignoring the release).

-- 
Darren Hart
VMware Open Source Technology Center
