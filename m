From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [BUG v3.6.2, 3.7-rc1] Unable to rmmod any hid special driver
Date: Thu, 1 Nov 2012 10:21:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211011021010.6606@pobox.suse.cz>
References: <CAN+gG=HFGMP8yU0PD6Ci-9ppVy4n3wp=SwymzAtp8KTg9Ewa=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58664 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361Ab2KAJVV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 1 Nov 2012 05:21:21 -0400
In-Reply-To: <CAN+gG=HFGMP8yU0PD6Ci-9ppVy4n3wp=SwymzAtp8KTg9Ewa=g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Ratan Nalumasu <ratan@google.com>, linux-input <linux-input@vger.kernel.org>

On Thu, 18 Oct 2012, Benjamin Tissoires wrote:

> Hi Guys,
> 
> Commit 4fe9f8e203fdad1524c04beb390f3c6099781ed9 upstream
> Commit 57a38d925e665fcd729cd9ad4a75c84e11bd95c9 linux-stable
> 
> This commit "HID: hidraw: don't deallocate memory when it is in use"
> prevents users to rmmod then insmod  any hid special driver without
> either physically unplugging the device or without rmmod-ing the hid
> bus itself.
> 
> When the user does a rmmod, hidinput_disconnect is called before
> hidraw_disconnect, thus, the hidraw device is still there, but the
> input one not. It leads to the fact that the device is not working
> anymore even if you call modprobe.

Hmm, I am not sure I understand this explanation, could you please 
elaborate?

Thanks,

-- 
Jiri Kosina
SUSE Labs
