From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: wacom: do not directly use
 input_mt_report_pointer_emulation
Date: Wed, 18 Feb 2015 23:43:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502182343360.28769@pobox.suse.cz>
References: <1424200786-4009-1-git-send-email-benjamin.tissoires@redhat.com> <CAF8JNhKwMpLEnBYSAA4-sT_qNLQN7ymKpiYxb6a5m6VTbE_1cQ@mail.gmail.com> <CAN+gG=GWAVKrbaC_Ww7DXWuJ8VkHEqO4GbrygGP6Xpb9FZ897w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43800 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946AbbBRWnz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 17:43:55 -0500
In-Reply-To: <CAN+gG=GWAVKrbaC_Ww7DXWuJ8VkHEqO4GbrygGP6Xpb9FZ897w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 17 Feb 2015, Benjamin Tissoires wrote:

> On Tue, Feb 17, 2015 at 5:36 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> > On Tue, Feb 17, 2015 at 11:19 AM, Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> >> input_mt_sync_frame() calls input_mt_report_pointer_emulation() and do
> >> some internal steps required to keep in sync the state of the touch within
> >> the various reports.
> >>
> >> Given that we use input_mt_assign_slot() in this driver, it is better to
> >> use input_mt_sync_frame().
> >
> > It is sensible to me, except I think you meant input_mt_slot() instead
> > of input_mt_assign_slot().
> 
> Hehe, I should have actually checked the call. I meant
> input_mt_get_slot_by_key().
> 
> >
> >> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > Reviewed-by: Ping Cheng <pingc@wacom.com>

Applied (with adjusted changelog).

-- 
Jiri Kosina
SUSE Labs
