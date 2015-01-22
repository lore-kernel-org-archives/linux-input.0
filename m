From: Dudley Du <dudl@cypress.com>
Subject: RE: Input: cyapa - add gen5 trackpad device basic functions support
Date: Thu, 22 Jan 2015 01:50:59 +0000
Message-ID: <BN1PR06MB070851B957DB3FB5E40BDEFD1490@BN1PR06MB070.namprd06.prod.outlook.com>
References: <20150121131949.GA4622@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1bon0140.outbound.protection.outlook.com ([157.56.111.140]:32359
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754090AbbAVBvE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Jan 2015 20:51:04 -0500
In-Reply-To: <20150121131949.GA4622@mwanda>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Carpenter,

Thanks for the information.
Could you indicate the tool and the command to generate this warning message?

In the code,
1) length = *gen5_pip->resp_len to get the expected response length,
2) then cyapa_empty_pip_output_data() try to polling the response data with the expect length,
3) at last, the length stored the real response length that it got in the polling function.
4) if the real response length is not 0, then assign the real response to replace the excpeted response length.

Thanks,
Dudley

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: 2015?1?21? 21:20
> To: Dudley Du
> Cc: linux-input@vger.kernel.org
> Subject: re: Input: cyapa - add gen5 trackpad device basic functions support
>
> Hello Dudley Du,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch 6972a859601a: "Input: cyapa - add gen5 trackpad device
> basic functions support" from Jan 17, 2015, leads to the following
> Smatch complaint:
>
> drivers/input/mouse/cyapa_gen5.c:2564 cyapa_gen5_irq_cmd_handler()
>  warn: variable dereferenced before check 'gen5_pip->resp_len' (see line
> 2559)
>
> drivers/input/mouse/cyapa_gen5.c
>   2558 */
>   2559length = *gen5_pip->resp_len;
>                                          ^^^^^^^^^^^^^^^^^^^
> Patch introduces a dereference.
>
>   2560cyapa_empty_pip_output_data(cyapa,
>   2561gen5_pip->resp_data,
>   2562&length,
>   2563gen5_pip->resp_sort_func);
>   2564if (gen5_pip->resp_len && length != 0) {
>                                     ^^^^^^^^^^^^^^^^^^
> Patch introduces a check.
>
>   2565*gen5_pip->resp_len = length;
>   2566atomic_dec(&gen5_pip->cmd_issued);
>
> regards,
> dan carpenter

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
