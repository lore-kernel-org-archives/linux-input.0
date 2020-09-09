Return-Path: <SRS0=+NLB=CS=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C660C433E2
	for <linux-input@archiver.kernel.org>; Wed,  9 Sep 2020 22:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4D621D7E
	for <linux-input@archiver.kernel.org>; Wed,  9 Sep 2020 22:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIWLt (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:11:49 -0400
Received: from smtprelay0119.hostedemail.com ([216.40.44.119]:47168 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgIIWLt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 9 Sep 2020 18:11:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 7970318225E0D;
        Wed,  9 Sep 2020 22:11:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cork39_10056d8270e0
X-Filterd-Recvd-Size: 2050
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Sep 2020 22:11:47 +0000 (UTC)
Message-ID: <ad58952a64bdf8e64bf4da5461db43c6a30d3b70.camel@perches.com>
Subject: Re: [PATCH v3] HID: add vivaldi HID driver
From:   Joe Perches <joe@perches.com>
To:     Sean O'Brien <seobrien@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 09 Sep 2020 15:11:46 -0700
In-Reply-To: <20200909150254.1.I170489c0c2ac1538b3890abb5a92b95ad4f04d01@changeid>
References: <20200909150254.1.I170489c0c2ac1538b3890abb5a92b95ad4f04d01@changeid>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 2020-09-09 at 15:03 -0700, Sean O'Brien wrote:
> Add vivaldi HID driver. This driver allows us to read and report the top
> row layout of keyboards which provide a vendor-defined (Google) HID
> usage.
[]
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
[]
> @@ -814,6 +814,13 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
>  
>  	if ((parser->global.usage_page << 16) >= HID_UP_MSVENDOR)
>  		parser->scan_flags |= HID_SCAN_FLAG_VENDOR_SPECIFIC;
> +
> +	if ((parser->global.usage_page << 16) == HID_UP_GOOGLEVENDOR)
> +		for (i = 0; i < parser->local.usage_index; i++)
> +			if (parser->local.usage[i] ==
> +					(HID_UP_GOOGLEVENDOR | 0x0001))
> +				parser->device->group =
> +					HID_GROUP_VIVALDI;

Can you please make this less indented code
so there are fewer line breaks?

Something like:

	if ((parser->global.usage_page << 16) != HID_UP_GOOGLEVENDOR)
		return;

	for (i = 0; i < parser->local.usage_index; i++) {
		if (parser->local.usage[i] != (HID_UP_GOOGLEVENDOR | 0x0001))
			continue;
		parser->device->group = HID_GROUP_VIVALDI;
		break;
	}


