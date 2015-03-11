From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/7] HID: wacom: Move handling of Intuos status packets
 to seperate function
Date: Wed, 11 Mar 2015 11:49:54 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1503111149050.24876@pobox.suse.cz>
References: <1425671264-4944-1-git-send-email-killertofu@gmail.com> <CAF8JNh+GiqBTWZsPsPi9QgQiVJs5EO0f0ADCL_qEn3O4SwutbQ@mail.gmail.com> <54FF1A56.5000809@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37151 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbbCKPt4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2015 11:49:56 -0400
In-Reply-To: <54FF1A56.5000809@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Tue, 10 Mar 2015, Jason Gerecke wrote:

> > > diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> > > index a3d0828..ee6a545 100644
> > > --- a/drivers/hid/wacom_wac.h
> > > +++ b/drivers/hid/wacom_wac.h
> > > @@ -71,6 +71,7 @@
> > >   #define WACOM_REPORT_USB               192
> > >   #define WACOM_REPORT_BPAD_PEN          3
> > >   #define WACOM_REPORT_BPAD_TOUCH                16
> > > +#define WACOM_PKGLEN_STATUS            10
> > 
> > I don't see anywhere else WACOM_PKGLEN_STATUS is used. Do I miss something?
> > 
> Good catch. That's leftover cruft from an earlier revision which is not
> necessary anymore. I'll resubmit this patch with the hunk removed.

No need to resubmit, I'll take care of it in the tree, thanks.

I have now applied 1-6, I'll send a small comment to no.7 and ask for 
respin of that one.

-- 
Jiri Kosina
SUSE Labs
