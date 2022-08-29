Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04910ECAAD2
	for <linux-input@archiver.kernel.org>; Mon, 29 Aug 2022 13:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiH2NqG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Mon, 29 Aug 2022 09:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiH2NqF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Aug 2022 09:46:05 -0400
X-Greylist: delayed 6169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Aug 2022 06:46:02 PDT
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9B73914
        for <linux-input@vger.kernel.org>; Mon, 29 Aug 2022 06:46:02 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id BF076E0014;
        Mon, 29 Aug 2022 13:45:58 +0000 (UTC)
Message-ID: <1c34957f0963138f8269d0839aca174a44e93276.camel@hadess.net>
Subject: Re: [PATCH] HID: logitech-hidpp: Enable HID++ for all the Logitech
 Bluetooth devices
From:   Bastien Nocera <hadess@hadess.net>
To:     "Peter F. Patel-Schneider" <pfpschneider@gmail.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Date:   Mon, 29 Aug 2022 15:45:58 +0200
In-Reply-To: <f285873c4cf0a0747db996bbca7e7d9234ce77fb.camel@gmail.com>
References: <4542beb149883ab5dfdcfd7f6bb4b516e5c1bcdb.camel@hadess.net>
         <CAE7qMrrj+rBzoAFf2FezqexgWNo+iSAd6b5NZwKFQ1C1zD_Qaw@mail.gmail.com>
         <f285873c4cf0a0747db996bbca7e7d9234ce77fb.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 2022-08-25 at 16:47 -0400, Peter F. Patel-Schneider wrote:
> 
> PS: There is another HID++ 2.0 feature that reports battery
> information, 0x1F20 ADC Measurement, but that is not in the driver
> code.

Do you have documentation for this one?
