From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 05/12] HID: wiimote: Synchronize wiimote input and hid
 event handling
Date: Mon, 11 Jul 2011 14:29:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1107111428330.11049@pobox.suse.cz>
References: <1309185013-484-1-git-send-email-dh.herrmann@googlemail.com> <1309185013-484-5-git-send-email-dh.herrmann@googlemail.com> <ca4e286b-420b-4d36-bb97-243dcdc9a527@email.android.com> <BANLkTimbhk9y8V6ff0FiTsjNQWw6wBXjNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34205 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467Ab1GKM30 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 08:29:26 -0400
In-Reply-To: <BANLkTimbhk9y8V6ff0FiTsjNQWw6wBXjNA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, padovan@profusion.mobi, oliver@neukum.org

On Wed, 29 Jun 2011, David Herrmann wrote:

> But, thanks to your hint, I looked at hid_hw_start() again and as far
> as I can see the synchronization issue exists there, too.
> The ll_driver->start() function is called first and after that, the
> input instance is registered.
> If the ll_driver reports an event before the input instance is
> registered, the hidinput/other-driver will call input_event() on an
> invalid input instance (probably even a NULL dereference).
> This may not be a problem for usbhid, because usbhid_open() has to be
> called first, however, hidp (bluetooth hid) ignores the *_open()
> callback and therefore may fail.

Indeed, this looks like a proper analysis. Thanks a lot for looking into 
it.

Are you planning on submitting the fix for that? Otherwise I'll add it to 
my TODO list, independently on the wiimote driver.

Thanks,

-- 
Jiri Kosina
SUSE Labs
