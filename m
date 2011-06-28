From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 09/12] HID: wiimote: Add wiimote input button parser
Date: Tue, 28 Jun 2011 09:52:12 +0400
Message-ID: <4f32c31e-7cc0-40b8-b2a4-0f92a0f90423@email.android.com>
References: <1309185013-484-1-git-send-email-dh.herrmann@googlemail.com> <1309185013-484-9-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41052 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab1F1Fw1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jun 2011 01:52:27 -0400
Received: by iwn6 with SMTP id 6so4691817iwn.19
        for <linux-input@vger.kernel.org>; Mon, 27 Jun 2011 22:52:26 -0700 (PDT)
In-Reply-To: <1309185013-484-9-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org

David Herrmann <dh.herrmann@googlemail.com> wrote:

>+	input_event(wdata->input, EV_KEY, wiiproto_keymap[WIIPROTO_KEY_LEFT],
>+							!!(payload[0] & 0x01));

input_report_key()


>+	input_event(wdata->input, EV_SYN, SYN_REPORT, 0);

input_sync()

Thanks.


-- 
Dmitry
