From: Paul Collins <paul@burly.ondioline.org>
Subject: Re: [PATCH] [RESEND] fix HID quirks for aluminium apple wireless keyboards
Date: Wed, 18 Jun 2008 22:19:13 +1200
Message-ID: <87mylj2ggu.fsf@burly.wgtn.ondioline.org>
References: <87tzfwiguc.fsf@burly.wgtn.ondioline.org>
	<1213447893811@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jenny.ondioline.org ([66.220.1.122]:46356 "EHLO
	jenny.ondioline.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbYFRKTP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jun 2008 06:19:15 -0400
In-Reply-To: <1213447893811@dmwebmail.dmwebmail.chezphil.org> (Phil Endecott's
	message of "Sat, 14 Jun 2008 13:51:33 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Phil Endecott <phil_tuhck_endecott@chezphil.org>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>

"Phil Endecott" <phil_tuhck_endecott@chezphil.org> writes:

> Why do you set HID_QUIRK_APPLE_NUMLOCK_EMULATION ?  I don't know what
> that quirk really does, but since these keyboards have neither a
> numeric keypad nor a numlock key I can't see any benefit.

>From a quick skim of the code (drivers/hid/hid-input.c) it looks like
it's supposed to allow a laptop-style numeric keymap mapping to be
enabled with F6, but I can't make it do anything here.  Perhaps it is
best removed after the hid-bus merge, otherwise there'll be different
quirks in different places for the same devices.

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
