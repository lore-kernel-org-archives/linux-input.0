Return-Path: <SRS0=3/Wm=7D=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D222C433E0
	for <linux-input@archiver.kernel.org>; Thu, 21 May 2020 15:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572BF206F6
	for <linux-input@archiver.kernel.org>; Thu, 21 May 2020 15:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEUPiP (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 21 May 2020 11:38:15 -0400
Received: from smtprelay0055.b.hostedemail.com ([64.98.42.55]:54480 "EHLO
        smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728317AbgEUPiO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 21 May 2020 11:38:14 -0400
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 May 2020 11:38:14 EDT
Received: from smtprelay.b.hostedemail.com (10.5.19.248.rfc1918.com [10.5.19.248])
        by smtpgrave01.b.hostedemail.com (Postfix) with ESMTP id EB2EC51409
        for <linux-input@vger.kernel.org>; Thu, 21 May 2020 15:31:25 +0000 (UTC)
Received: from filter.hostedemail.com (10.5.19.248.rfc1918.com [10.5.19.248])
        by smtprelay02.b.hostedemail.com (Postfix) with ESMTP id 311BA220DB
        for <linux-input@vger.kernel.org>; Thu, 21 May 2020 15:31:25 +0000 (UTC)
X-Session-Marker: 6A6F686E7A40706C656173616E746E696768746D6172652E636F6D
X-HE-Tag: joke19_4a04ae226d1f
X-Filterd-Recvd-Size: 2737
Received: from localhost (hlfxns018gw-134-41-50-0.dhcp-dynamic.fibreop.ns.bellaliant.net [134.41.50.0])
        (Authenticated sender: johnz@pleasantnightmare.com)
        by omf04.b.hostedemail.com (Postfix) with ESMTPA
        for <linux-input@vger.kernel.org>; Thu, 21 May 2020 15:31:24 +0000 (UTC)
Date:   Thu, 21 May 2020 12:29:43 -0300
From:   "John Z." <johnz@pleasantnightmare.com>
To:     linux-input@vger.kernel.org
Subject: Thrustmaster T.Flight 4 driver, help needed
Message-ID: <20200521152943.GE77215@johnslap.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hello all,
    I've recently acquired Thrustmaster T.Flight 4 HOTAS, and few of the
    axes do not work, so I wanted to try and fix that.

    I've gotten as far as decoding the USB HID report and comparing it
    to the data packets - and realizing that HID report basically lies
    about offsets.
    The axes that do work are reported correctly, but those that are
    missing are changing byte values in Vendor Specific areas. The user
    manual also says that if the HOTAS is to be used on PC, it is very
    important to install proprietary driver, otherwise some axes won't
    work.

    I've got a tip from a friend that some hardware requires vendor
    specific GET FEATURE request to put hardware into compliant mode,
    but I have instead started hacking together a simple userspace
    program to parse bytes at correct offsets, and then asked for advice
    about how to get this done so that joydev (or evdev, I am not sure)
    properly picks this up, rather than (I'm assuming?) relying on HID
    report to get the data.
    This _might_ produce a buggy driver since joystick has a plug for
    pedals as well, which may change things if they're plugged in.

    Another person advised me that they don't believe this can be done
    in userspace, that I should write a kernel module if I feel capable,
    and that if I'm comfortable with coding and willing to merge it
    upstream - I should seek further help here.
    They further suggested that it might be possible to use a generic
    driver as a foundation and make a specialized version that only
    loads when vendor and product ID's match the hardware.

    If these suggestions are correct - I have a basic skeleton
    helloworld module building and working and my userspace prototype
    (based on Alan Ott's example). I could use some guidance, even just
    pointers to correct places in documentation would be very useful. I
    tried finding my way myself, but there's so much information I have
    no idea where to even start.

    Thanks.


-- 
John Z.
"Rip and tear until it is done."
