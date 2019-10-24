Return-Path: <SRS0=+nWv=YR=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE1BCA9EAF
	for <linux-input@archiver.kernel.org>; Thu, 24 Oct 2019 16:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B1421872
	for <linux-input@archiver.kernel.org>; Thu, 24 Oct 2019 16:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439757AbfJXQRr (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:17:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:56592 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436642AbfJXQRr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Oct 2019 12:17:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 09:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="223613972"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga004.fm.intel.com with ESMTP; 24 Oct 2019 09:17:46 -0700
Message-ID: <bce400a8a2ab1a2ddfc1d270fdff2172884696eb.camel@linux.intel.com>
Subject: Re: [PATCH trivial] HID: intel-ish-hid: Spelling
 s/diconnect/disconnect/
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 24 Oct 2019 09:17:46 -0700
In-Reply-To: <20191024151837.29421-1-geert+renesas@glider.be>
References: <20191024151837.29421-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 2019-10-24 at 17:18 +0200, Geert Uytterhoeven wrote:
> Fix misspelling of "disconnect".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ishtp/hbm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.c
> b/drivers/hid/intel-ish-hid/ishtp/hbm.c
> index c6c9ac09dac3a377..30a91d068306a000 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/hbm.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/hbm.c
> @@ -402,7 +402,7 @@ static void ishtp_hbm_cl_connect_res(struct
> ishtp_device *dev,
>   * @dev: ISHTP device instance
>   * @disconnect_req: disconnect request structure
>   *
> - * Disconnect request bus message from the fw. Send diconnect
> response.
> + * Disconnect request bus message from the fw. Send disconnect
> response.
>   */
>  static void ishtp_hbm_fw_disconnect_req(struct ishtp_device *dev,
>  	struct hbm_client_connect_request *disconnect_req)

