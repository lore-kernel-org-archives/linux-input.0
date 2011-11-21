From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: matrix_keyboard based driver
Date: Mon, 21 Nov 2011 14:52:17 +0100
Message-ID: <CAH9NwWd+40pC=UQFZnQcXoYp7J_Ui=cfcGh0WLaXV6niOjfF4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40136 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465Ab1KUNwj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 08:52:39 -0500
Received: by ghbz2 with SMTP id z2so2794172ghb.19
        for <linux-input@vger.kernel.org>; Mon, 21 Nov 2011 05:52:38 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

today I started with a basic matrix_keyboard based keypad driver. It
seems to work quite
well but I have some questions.

Is it possible to define following values from user space?

* debounce time in [ms]
* auto repeat time in [ms]
* multi click abort time in [ms]

I am also not sure about the default keymap I should use in the
platform_data. At
the moment it looks like:

static const uint32_t ot200_keymap[] = {
	KEY(0, 1, 0x01),
	KEY(0, 2, 0x02),
	KEY(0, 3, 0x03),
	KEY(0, 4, 0x04),
	KEY(0, 5, 0x05),
	KEY(0, 6, 0x06),
	KEY(0, 7, 0x07),
	KEY(0, 8, 0x08),
	KEY(0, 9, 0x09),
...
...
	KEY(9, 6, 0x96),
	KEY(9, 7, 0x97),
	KEY(9, 8, 0x98),
	KEY(9, 9, 0x99),
};

I need to configure the mapping from userspace and it is be done via loadkeys
if I am not wrong. Does the input core handle cases like SHIFT key and
CAPS lock?

thanks
--
Christian Gmeiner, MSc
