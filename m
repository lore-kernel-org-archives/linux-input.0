Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20B8C433DB
	for <linux-input@archiver.kernel.org>; Sat, 20 Feb 2021 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E53664EC0
	for <linux-input@archiver.kernel.org>; Sat, 20 Feb 2021 15:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhBTPRb (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 20 Feb 2021 10:17:31 -0500
Received: from mail.nic.cz ([217.31.204.67]:60066 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhBTPRa (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 20 Feb 2021 10:17:30 -0500
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id D15B8140B7E;
        Sat, 20 Feb 2021 16:16:45 +0100 (CET)
Date:   Sat, 20 Feb 2021 16:16:45 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 5/7] HID: lenovo: Set LEDs max_brightness value
Message-ID: <20210220161645.778fd38f@nic.cz>
In-Reply-To: <20210220122438.21857-6-hdegoede@redhat.com>
References: <20210220122438.21857-1-hdegoede@redhat.com>
        <20210220122438.21857-6-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 20 Feb 2021 13:24:36 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> +	data->led_mute.max_brightness = LED_ON;

These constants are obsolete since we now support variable maximum
brightness. Just put 1 there.

Marek
