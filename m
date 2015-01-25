From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Merging hid-huion into hid-uclogic
Date: Sun, 25 Jan 2015 15:22:32 +0200
Message-ID: <54C4EE18.4030005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:49581 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbbAYNWf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Jan 2015 08:22:35 -0500
Received: by mail-we0-f178.google.com with SMTP id k48so4902531wev.9
        for <linux-input@vger.kernel.org>; Sun, 25 Jan 2015 05:22:34 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Jiri, everyone,

I'd like to have your opinion if it will be fine to merge hid-huion.c into
hid-uclogic.c, keeping tablet support intact, of course.

The reason is, Huion tablets actually use UC-Logic hardware and the probing
method used in hid-huion.c huion_tablet_enable actually works with (at least)
newer UC-Logic tablets, including at least 6 Yiynova tablet models, a newer
version of Monoprice MP1060-HA60, and some Ugee models - all of them using
UC-Logic VID.

I have all of these working in various branches of digimend-kernel-drivers [1]
and waiting to be contributed, but putting them in hid-huion.c would make it
support more UC-Logic tablet models than hid-uclogic.c does (even though they
reuse their PIDs). And that might be awkward and confusing.

So, would it be a good idea to merge hid-huion.c into hid-uclogic.c and would
you accept such change into the kernel?

Thank you.

[1] https://github.com/DIGImend/digimend-kernel-drivers
