From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] Input - mt: Fix input_mt_get_slot_by_key
Date: Tue, 7 Apr 2015 15:17:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504071517260.30181@pobox.suse.cz>
References: <1427741655-4142-1-git-send-email-benjamin.tissoires@redhat.com> <20150406163349.GD36770@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45030 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753762AbbDGNSC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Apr 2015 09:18:02 -0400
In-Reply-To: <20150406163349.GD36770@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 6 Apr 2015, Dmitry Torokhov wrote:

> > With https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=for-4.1/wacom&id=9a1c001298fd567c0f0776ab54ab9965eeb9019f
> > in Jiri's tree, scheduled for 4.1, this patch should not break any existing
> > driver. I'd like us to stage it somewhere so that it doesn't get forgotten.
> > 
> > Henrik's previous concerns were that input_mt_sync_frame() may not be called
> > by a driver using input_mt_get_slot_by_key(), and now, no driver should be in
> > this case.
> 
> I'm OK with it going through Juri's tree.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Perfect, thanks. I have now queued it in for-4.1/upstream.

-- 
Jiri Kosina
SUSE Labs
