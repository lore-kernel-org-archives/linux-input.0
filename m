Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ADCC433E0
	for <linux-input@archiver.kernel.org>; Mon, 15 Feb 2021 14:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B2D64E29
	for <linux-input@archiver.kernel.org>; Mon, 15 Feb 2021 14:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhBOOlr (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 15 Feb 2021 09:41:47 -0500
Received: from mail.nic.cz ([217.31.204.67]:42152 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhBOOli (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 15 Feb 2021 09:41:38 -0500
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id 08C031409C5;
        Mon, 15 Feb 2021 15:40:46 +0100 (CET)
Date:   Mon, 15 Feb 2021 15:40:45 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Roderick Colenbrander <roderick@gaikai.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, dmitry.torokhov@gmail.com,
        pobm@protonmail.com, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Roderick Colenbrander <roderick.colenbrander@sony.com>
Subject: Re: [PATCH v6 2/4] HID: playstation: add microphone mute support
 for DualSense.
Message-ID: <20210215154045.4ac27ec0@nic.cz>
In-Reply-To: <20210215004549.135251-3-roderick@gaikai.com>
References: <20210215004549.135251-1-roderick@gaikai.com>
        <20210215004549.135251-3-roderick@gaikai.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, 14 Feb 2021 16:45:47 -0800
Roderick Colenbrander <roderick@gaikai.com> wrote:

> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> The DualSense controller has a built-in microphone exposed as an
> audio device over USB (or HID using Bluetooth). A dedicated
> button on the controller handles mute, but software has to configure
> the device to mute the audio stream.
> 
> This patch captures the mute button and schedules an output report
> to mute/unmute the audio stream as well as toggle the mute LED.
> 
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

Is the microphone supported via Linux? I.e. is there an audio driver
for it?

If it is, look at the audio-micmute LED trigger.

If you can't use the audio-micmute trigger because the microphone isn't
supported via Linux, I still think the LED should the LED should be
read-write. You can then register a LED private trigger. The driver should
change the state of the LED according to the microphone mute state only
if these trigger is enabled.

Marek
