From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] serio: delay resume error handling til PM complete
Date: Wed, 25 Nov 2015 09:51:12 -0800
Message-ID: <20151125175112.GB23632@dtor-ws>
References: <cover.1448068686.git.todd.e.brandt@linux.intel.com>
 <d2cc800492b6d0f800d87d73a6be738e42b2023d.1448068686.git.todd.e.brandt@linux.intel.com>
 <CAKdAkRQk6xQTsY=fH7UNYbxiZeYh4rOZpL6wv6a1QzSy9i=Cpw@mail.gmail.com>
 <20151125172559.GA16799@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33621 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbbKYRvP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2015 12:51:15 -0500
Received: by pabfh17 with SMTP id fh17so65767427pab.0
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2015 09:51:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151125172559.GA16799@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd E Brandt <todd.e.brandt@linux.intel.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, todd.e.brandt@intel.com

On Wed, Nov 25, 2015 at 09:25:59AM -0800, Todd E Brandt wrote:
> On Tue, Nov 24, 2015 at 05:26:15PM -0800, Dmitry Torokhov wrote:
> > On Tue, Nov 24, 2015 at 4:58 PM, Todd Brandt
> > <todd.e.brandt@linux.intel.com> wrote:
> > >  Delay the error rescan for serio devices until the PM
> > >  complete phase. PM complete requires locking each device
> > >  before checking for and executing the complete callbacks.
> > >  Serio rescan also locks the device in order to reinit on
> > >  error, so this can cause a conflict which will result in
> > >  unnecessary delay.
> > >
> > >  History:
> > >
> > >  The issue was discovered on an ivy bridge platform with
> > >  i8042 keyboard/mouse. The mouse resume fails
> > 
> > I'd first try to figure out why reconnect failed. What kind of
> > mouse/touchpad is that?
> 
> It's an Alps PS/2 glidepoint touchpad. The actual error appears to be
> a failure in alps_identify as it attempts to get the EC report using
> alps_rpt_cmd. However, I don't think this is too important since
> the psmouse driver is just doing what it's supposed to. It's the
> fact that the error was mitigated right in the middle of the system
> resume that caused the delay.
> 
> I expect that errors in input drivers will happen quite a lot. Users

I do not expect that. If device is still there then we should be able to
communicate with it. Failure to do so indicates that there is some issue
(resume order?) and I would like to know what it is.

>
> don't typically care as long as the device eventually rights itself
> and they don't notice. 

Theoretically you lose settings that you done manually through sysfs.
Suspend/resume cycle is not supposed to lose your settings.

Thanks.

-- 
Dmitry
