Return-Path: <SRS0=nOvE=B3=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E368C433DF
	for <linux-input@archiver.kernel.org>; Mon, 17 Aug 2020 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA792075B
	for <linux-input@archiver.kernel.org>; Mon, 17 Aug 2020 13:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgHQNQ6 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbgHQNQe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Aug 2020 09:16:34 -0400
Received: from zero.eik.bme.hu (zero.eik.bme.hu [IPv6:2001:738:2001:2001::2001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEDAC061343
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2020 06:16:33 -0700 (PDT)
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
        by localhost (Postfix) with SMTP id A7D6874594E;
        Mon, 17 Aug 2020 15:16:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
        id 3380B745712; Mon, 17 Aug 2020 15:16:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zero.eik.bme.hu (Postfix) with ESMTP id 322A7745702;
        Mon, 17 Aug 2020 15:16:18 +0200 (CEST)
Date:   Mon, 17 Aug 2020 15:16:18 +0200 (CEST)
From:   BALATON Zoltan <balaton@eik.bme.hu>
To:     Jiri Kosina <jikos@kernel.org>
cc:     linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dan Bastone <dan@pwienterprises.com>
Subject: Re: [PATCH] HID: apple: Add support for Matias wireless keyboard
In-Reply-To: <nycvar.YFH.7.76.2008171214110.27422@cbobk.fhfr.pm>
Message-ID: <alpine.BSF.2.22.395.2008171508120.88029@zero.eik.bme.hu>
References: <20200720205741.0A114747871@zero.eik.bme.hu> <nycvar.YFH.7.76.2008171214110.27422@cbobk.fhfr.pm>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 17 Aug 2020, Jiri Kosina wrote:
> On Mon, 20 Jul 2020, BALATON Zoltan wrote:
>> The Matias Wireless keyboard has an Apple like layout and identifies
>> as ISO RevB Alu keyboard. Use hid-apple for it so Fn key and media
>> control functions work as expected.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> So If I understand correctly, this keyboard identifies itself with Apple
> VID, but in fact it is not.
>
> I'd like to make sure that we don't break the real
> USB_DEVICE_ID_APPLE_ALU_REVB_ISO device produced by Apple; CCing Dan

AFAIK the Apple keyboard with the same pid is a USB one and is already 
handled by hid-apple. This one is a bluetooth keyboard so probably does 
not really clash and even if there's an Apple wireless keyboard with the 
same pid it's more likely we want hid-apple for that too so it's unlikely 
to break anything. (This Matias keyboard looks and acts like an Apple 
keyboard so probably uses this vid/pid to have macOS work better with it 
out of the box without needing additional setup.)

Regards,
BALATON Zoltan
