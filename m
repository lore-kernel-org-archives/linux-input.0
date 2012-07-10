From: "weixing" <weixing@hanwang.com.cn>
Subject: Re: Re: [PATCH 1/1] Input: hanwang - add support for Art Master II tablet
Date: Tue, 10 Jul 2012 15:15:09 +0800
Message-ID: <201207101515088990365@hanwang.com.cn>
References: <1340979246-2941-1-git-send-email-weixing@hanwang.com.cn>,
 <20120710064233.GA29927@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hanwang.com.cn ([221.122.51.51]:54518 "EHLO mail.hanwang.com.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099Ab2GJHPR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jul 2012 03:15:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, xing_wei777 <xing_wei777@126.com>

Hi Dmitry Torokhov,

On 2012-07-10 14:43:51,you wrote:
>
>Hi,
>
>On Fri, Jun 29, 2012 at 10:14:06PM +0800, weixing wrote:
>>  
>>  	switch (data[0]) {
>>  	case 0x02:	/* data packet */
>>  		switch (data[1]) {
>>  		case 0x80:	/* tool prox out */
>> -			hanwang->current_id = 0;
>> -			input_report_key(input_dev, hanwang->current_tool, 0);
>> +			if (type != HANWANG_ART_MASTER_II) {
>> +				hanwang->current_id = 0;
>> +				input_report_key(input_dev,
>> +					hanwang->current_tool, 0);
>> +			}
>> +			break;
>> +		case 0x00:	/* artmaster ii pen leave */
>> +			if (type == HANWANG_ART_MASTER_II) {
>> +				hanwang->current_id = 0;
>> +				input_report_key(input_dev,
>> +					hanwang->current_tool, 0);
>> +			}
>>  			break;
>
>OK, so this will ignore 0x02 0x80 reports on HANWANG_ART_MASTER_II and
>0x02 0x00 reports on other tablets. I just want to make sure that was
>the intention of the patch.
>

yes.

>Thanks.
>
>-- 
>Dmitry
>--
>To unsubscribe from this list: send the line "unsubscribe linux-input" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



Thanks.

