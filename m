From: Tom Gundersen <teg@jklm.no>
Subject: [BUG?] HID: uhid: add devname module alias
Date: Mon, 9 Sep 2013 17:43:02 +0200
Message-ID: <CAG-2HqXVR5rFCa0XGmFpJcPWgPBKKaELgmFxhWKxxOYQRc-m2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:53577 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab3IIPnX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 11:43:23 -0400
Received: by mail-bk0-f52.google.com with SMTP id e11so2435492bkh.11
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 08:43:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>, Kay Sievers <kay@vrfy.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Marcel,

The above commit (60cbd53 in mainline) doesn't appear to work for me.
I.e., depmod does not create an entry in modules.devname and hence no
device node is created on boot.

If I understand correctly, you'd also need to create the correct
"char-major-<MAJOR>-<MINOR>" alias (which I don't think you can do as
long as you are using MISC_DYNAMIC_MINOR).

Or am I missing something?

Cheers,

Tom
