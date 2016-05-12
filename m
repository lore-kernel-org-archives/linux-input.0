From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: asus: add support for hotkeys
Date: Thu, 12 May 2016 22:28:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1605122228050.31937@cbobk.fhfr.pm>
References: <1462985167-8566-1-git-send-email-usk.fujimaki@gmail.com> <CAKdAkRQa-7w1_CyQ3DOUaZe+JHAkmMFXo1r85asdUdj1L3n7Sw@mail.gmail.com> <CAK4LCm5T4He4RcAtbECwKDNgVQOPppx=DimNeoN8UD3Cv3wy4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59068 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbcELU2m (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2016 16:28:42 -0400
In-Reply-To: <CAK4LCm5T4He4RcAtbECwKDNgVQOPppx=DimNeoN8UD3Cv3wy4g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yusuke FUJIMAKI <usk.fujimaki@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, 13 May 2016, Yusuke FUJIMAKI wrote:

> Hi Dmitry,
> 
> > Can this be done via udev keymaps/hwdb instead of kernel driver?
> I couldn't remap hotkeys.

How exactly did you invike setkeycodes and how did that change evtest 
output?

-- 
Jiri Kosina
SUSE Labs

