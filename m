Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E5FC433FE
	for <linux-input@archiver.kernel.org>; Mon, 14 Nov 2022 14:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiKNOU1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Mon, 14 Nov 2022 09:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiKNOU0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Nov 2022 09:20:26 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A9527B20;
        Mon, 14 Nov 2022 06:20:22 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 0F29FFF80A;
        Mon, 14 Nov 2022 14:20:18 +0000 (UTC)
Message-ID: <487b7e01e0847411e5893a8341bf027cc9d8c4bf.camel@hadess.net>
Subject: Re: PATCH: Simplify hidpp_send_rap_command_sync calls
From:   Bastien Nocera <hadess@hadess.net>
To:     Andreas Bergmeier <abergmeier@gmx.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        USB mailing list <linux-usb@vger.kernel.org>,
        linux-input@vger.kernel.org
Date:   Mon, 14 Nov 2022 15:20:18 +0100
In-Reply-To: <4b871484-b19-95b8-f973-bfebcb5348ab@9300>
References: <4b871484-b19-95b8-f973-bfebcb5348ab@9300>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.0 (3.46.0-2.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 2022-11-10 at 15:47 +0100, Andreas Bergmeier wrote:
> Inside function, report_id might get overwritten.
> Only REPORT_ID_HIDPP_SHORT is ever passed in.
> So there seems to be no point in passing report_id in the first
> place.
> Just directly evaluate which report_id to use in the function itself.

Looks good.

Reviewed-by: Bastien Nocera <hadess@hadess.net>
