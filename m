From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: elecom: rewrite report fixup for EX-G and future
 mice
Date: Thu, 7 Dec 2017 11:04:37 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1712071103120.3572@cbobk.fhfr.pm>
References: <20171204205550.2621-1-tk@the-tk.com> <20171205201307.GA13831@gaia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751137AbdLGKEl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 7 Dec 2017 05:04:41 -0500
In-Reply-To: <20171205201307.GA13831@gaia.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomasz Kramkowski <tk@the-tk.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Yuxuan Shui <yshuiv7@gmail.com>, =?ISO-8859-15?Q?Diego_Elio_Petten=F2?= <flameeyes@flameeyes.eu>, Alex Manoussakis <amanou@gnu.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 5 Dec 2017, Tomasz Kramkowski wrote:

> On Mon, Dec 04, 2017 at 08:55:50PM +0000, Tomasz Kramkowski wrote:
> > +static void mouse_button_fixup(struct hid_device *hdev,
> > +			       __u8 *rdesc, unsigned int *rsize,
> > +			       int nbuttons)
> 
> I've just remembered what has been bugging me yesterday when I was
> reviewing this patch. I had come to the realisation (and then
> subsequently forgotten) that this function should probably return __u8 *
> and also get assigned to rdesc on the other end. It seems to me that it
> makes most sense to allow for the possibility (although slim) of this
> function eventually being expanded to actually replace the report
> descriptor 

Sure, but you can extend the API of mouse_button_fixup() once such need 
arises; no need to pass data pointers around without having actual use for 
them.

-- 
Jiri Kosina
SUSE Labs

