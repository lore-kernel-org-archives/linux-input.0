Return-Path: <SRS0=L/+t=42=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE997C10F27
	for <linux-input@archiver.kernel.org>; Mon,  9 Mar 2020 17:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75FD24671
	for <linux-input@archiver.kernel.org>; Mon,  9 Mar 2020 17:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgCIRKs (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:10:48 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43227 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgCIRKs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2020 13:10:48 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2A84B20005;
        Mon,  9 Mar 2020 17:10:45 +0000 (UTC)
Message-ID: <0d09d5b2e380be29673444027aa04adc97eed8bf.camel@hadess.net>
Subject: Re: [PATCH v3 01/11] Input: goodix - Refactor IRQ pin GPIO accesses
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Dmitry Mastykin <mastichi@gmail.com>
Date:   Mon, 09 Mar 2020 18:10:45 +0100
In-Reply-To: <20200307121505.3707-1-hdegoede@redhat.com>
References: <20200307121505.3707-1-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.35.92 (3.35.92-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 2020-03-07 at 13:14 +0100, Hans de Goede wrote:
> Suspending Goodix touchscreens requires changing the interrupt pin to
> output before sending them a power-down command. Followed by wiggling
> the interrupt pin to wake the device up, after which it is put back
> in input mode.
> 
> So far we have only effectively supported this on devices which use
> devicetree. On X86 ACPI platforms both looking up the pins; and using
> a
> pin as both IRQ and GPIO is a bit more complicated. E.g. on some
> devices
> we cannot directly access the IRQ pin as GPIO and we need to call
> ACPI
> methods to control it instead.
> 
> This commit adds a new irq_pin_access_method field to the
> goodix_chip_data
> struct and adds goodix_irq_direction_output and
> goodix_irq_direction_input
> helpers which together abstract the GPIO accesses to the IRQ pin.
> 
> This is a preparation patch for adding support for properly
> suspending the
> touchscreen on X86 ACPI platforms.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1786317
> BugLink: https://github.com/nexus511/gpd-ubuntu-packages/issues/10
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199207
> Cc: Dmitry Mastykin <mastichi@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Bastien Nocera <hadess@hadess.net>

