From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 44/53] Input: atmel_mxt_ts - Verify Information Block
 checksum on probe
Date: Mon, 10 Jun 2013 10:35:31 +0100
Message-ID: <51B59DE3.2000907@itdev.co.uk>
References: <1370453866-16534-1-git-send-email-nick.dyer@itdev.co.uk> <1370453866-16534-45-git-send-email-nick.dyer@itdev.co.uk> <CAPDwgkO09rBmtgWCYOkoSsQXPK2_sND_QH==SEiyyT2PuoEOpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:19557 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752485Ab3FJJfe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jun 2013 05:35:34 -0400
In-Reply-To: <CAPDwgkO09rBmtgWCYOkoSsQXPK2_sND_QH==SEiyyT2PuoEOpg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yufeng Shen <miletus@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>

Yufeng Shen wrote:
>> +       dev_info(&client->dev,
>> +                "Family: %u Variant: %u Firmware V%u.%u.%02X Objects: %u\n",
>> +                info->family_id, info->variant_id, info->version >> 4,
>> +                info->version & 0xf, info->build, info->object_num);
>> +
> 
> Use data->info->XXX here,  info was pointing to buf which could have
> changed after krealloc.

Thank you, that's a really good spot. Caused when I merged the dev_info
line into that function. It actually explains a report I had about getting
junk in this output but the info_crc check succeeding, hadn't had time to
investigate yet.

I will fix.
