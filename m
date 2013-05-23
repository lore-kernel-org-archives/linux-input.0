From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 13/26] HID: wiimote: add extension hotplug support
Date: Thu, 23 May 2013 14:28:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305231427000.22195@pobox.suse.cz>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com> <1367788390-29835-14-git-send-email-dh.herrmann@gmail.com> <CANq1E4R+Ppt_MYsPYVNR2hhs+9K6ewvs2oQr=3b86sTDsY=VKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55546 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758513Ab3EWM2a (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 May 2013 08:28:30 -0400
In-Reply-To: <CANq1E4R+Ppt_MYsPYVNR2hhs+9K6ewvs2oQr=3b86sTDsY=VKQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thu, 23 May 2013, David Herrmann wrote:

[ ... snip ... ]
> >  static void wiimote_init_worker(struct work_struct *work)
> > @@ -655,6 +1129,30 @@ static void wiimote_init_worker(struct work_struct *work)
> >
> >         if (wdata->state.devtype == WIIMOTE_DEV_PENDING)
> >                 wiimote_init_detect(wdata);
> 
> We need an additional "wiimote_init_hotplug(wdata);" in this if-clause
> for devices with built-in MP to detect it right during init.
> Otherwise, MP is not initialized until you plug some other extension.
> That's because the MP-timer is disabled for devices with built-in MP.
> Other than that I didn't get any bug-reports. And I haven't found any
> bugs, either.
> 
> I want to avoid resending the whole series, so I will send a fixup
> patch on top of your branch once you applied it (if that is ok?).

Hi David,

that is certainly OK. I just haven't yet finished reviewing the whole lot, 
as it's quite some code :)

Please send the followup patch to this thread, marking it [27/26] or 
some such :) to make it clear that it's a followup to the series.

Thanks,

-- 
Jiri Kosina
SUSE Labs
