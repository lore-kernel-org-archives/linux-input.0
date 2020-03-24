Return-Path: <SRS0=LU4O=5J=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04C4C43331
	for <linux-input@archiver.kernel.org>; Tue, 24 Mar 2020 10:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8636F2080C
	for <linux-input@archiver.kernel.org>; Tue, 24 Mar 2020 10:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgCXKY3 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:24:29 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58213 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgCXKY3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Mar 2020 06:24:29 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 033A2C0018;
        Tue, 24 Mar 2020 10:24:26 +0000 (UTC)
Message-ID: <13a0312706b4b37efc7ae6589059d527fc316f9f.camel@hadess.net>
Subject: Re: [PATCH v3 2/2] Input: goodix - Fix spurious key release events
From:   Bastien Nocera <hadess@hadess.net>
To:     Dmitry Mastykin <dmastykin@astralinux.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org
Date:   Tue, 24 Mar 2020 11:24:26 +0100
In-Reply-To: <20200316075302.3759-2-dmastykin@astralinux.ru>
References: <20200316075302.3759-1-dmastykin@astralinux.ru>
         <20200316075302.3759-2-dmastykin@astralinux.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0 (3.36.0-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 2020-03-16 at 10:53 +0300, Dmitry Mastykin wrote:
> The goodix panel sends spurious interrupts after a 'finger up' event,
> which always cause a timeout.
> We were exiting the interrupt handler by reporting touch_num == 0,
> but
> this was still processed as valid and caused the code to use the
> uninitialised point_data, creating spurious key release events.
> 
> Report an error from the interrupt handler so as to avoid processing
> invalid point_data further.
> 
> Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>

LGTM

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
> Changes in v3:
> - Improve commit message
> 
> Changes in v2:
> - Improve commit message
> ---
>  drivers/input/touchscreen/goodix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c
> b/drivers/input/touchscreen/goodix.c
> index 04b5c7b..cc965fe 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -329,7 +329,7 @@ static int goodix_ts_read_input_report(struct
> goodix_ts_data *ts, u8 *data)
>  	 * The Goodix panel will send spurious interrupts after a
>  	 * 'finger up' event, which will always cause a timeout.
>  	 */
> -	return 0;
> +	return -ENOMSG;
>  }
>  
>  static void goodix_ts_report_touch_8b(struct goodix_ts_data *ts, u8
> *coor_data)

