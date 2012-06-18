From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 00/16] HID: uhid: User-space HID I/O driver
Date: Mon, 18 Jun 2012 13:46:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1206181345330.15308@pobox.suse.cz>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34643 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439Ab2FRLqt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jun 2012 07:46:49 -0400
In-Reply-To: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

On Sun, 10 Jun 2012, David Herrmann wrote:

> This adds a new low-level HID driver that allows user-space to implement the
> transport-layer. This is needed by HOGP (HID over Gatt on Bluetooth Low Energy).
> There is already an implementation of HOGP, see the
> linux-bluetooth@vger.kernel.org mailing list for this.
> 
> I've split this into multiple patches to make review easier. This patchset is
> already working for several months for the HOGP developers but there may still
> be some issues with it. Please review.
> 
> The uhid_*() functions implement the basic module functionality. The
> uhid_char_*() functions handle character-device related functionality. The
> uhid_dev_*() functions handle the uhid-device object and the uhid_hid_*()
> functions are HID-callbacks.
> 
> I am open for any suggestions.

David,

I have just finished my review and haven't found any principal issues. I 
am queueing the patchset in my tree.

Thanks a lot for your work on this,

-- 
Jiri Kosina
SUSE Labs
