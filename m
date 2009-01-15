From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Bugme-new] [Bug 12447] New: usbtouchscreen submits URB too
	quickly if built in to kernel
Date: Wed, 14 Jan 2009 20:43:39 -0800
Message-ID: <20090115044338.GA6423@dtor-d630.eng.vmware.com>
References: <bug-12447-10286@http.bugzilla.kernel.org/> <20090114102838.3232cec8.akpm@linux-foundation.org> <1231974508.9098.9.camel@sage.wic.aeroflex.com> <20090114151336.3b97893a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:57954 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943AbZAOEoY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2009 23:44:24 -0500
Content-Disposition: inline
In-Reply-To: <20090114151336.3b97893a.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hagood <david.hagood@aeroflex.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

On Wed, Jan 14, 2009 at 03:13:36PM -0800, Andrew Morton wrote:
> On Wed, 14 Jan 2009 17:08:28 -0600
> David Hagood <david.hagood@aeroflex.com> wrote:
> 
> > On Wed, 2009-01-14 at 10:28 -0800, Andrew Morton wrote:
> > > (switched to email.  Please respond via emailed reply-to-all, not via the
> > > bugzilla web interface).
> > > 
> > OK, you asked for it - no fair complaining about the email wart that I
> > can do nothing about.
> 
> It happens.
> 
> > > On Wed, 14 Jan 2009 08:29:31 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:
> > > 
> > > Is this a USB thing, or an input thing?
> > > 
> > 
> > I'm not sure I understand the question. The problem is in the
> > usbtouchscreen kernel module, which is an input module.
> > 
> > The problem is NOT at the X layer (read: user space), but in the kernel
> > driver.
> > 
> > Did that answer the question?
> 
> The question was asked of the USB and input developers ;) It's unclear
> (to me) which subsystem would need fixing to make this work properly.
> 

I suppose this is device-specific and will have to be worked around in
the driver buy resubmitting request a few times until it "sticks".

-- 
Dmitry
