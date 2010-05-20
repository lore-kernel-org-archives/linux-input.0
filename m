From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] input: mcs5000 - Add MCS5000 touchkey support
Date: Thu, 20 May 2010 16:42:29 +0900
Message-ID: <4BF4E7E5.5000006@samsung.com>
References: <4BF4DA4D.1090407@samsung.com>
 <20100520070655.GA8080@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44113 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab0ETHmc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 03:42:32 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0L2P00MTAK2TDK@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 20 May 2010 16:42:29 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L2P00LUJK2TIE@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 20 May 2010 16:42:29 +0900 (KST)
In-reply-to: <20100520070655.GA8080@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: riverful.kim@samsung.com, kyungmin.park@samsung.com, linux-input@vger.kernel.org

On 5/20/2010 4:06 PM, Dmitry Torokhov wrote:
> Hi Joonyoung,
> 
> On Thu, May 20, 2010 at 03:44:29PM +0900, Joonyoung Shim wrote:
>> The MELPAS MCS5000 can use to touchkey controller. This is patch to
>> support touchkey at original MCS5000 touchscreen driver.
>>
> 
> Not much of the touchscreen code ends up being reused it seems. Would
> not creating a separate keypad driver make more sense?
> 

OK, i will make a separate keypad driver and it will support MCS5080
keypad together.

> Also, please amke sure that driver allows remapping the keymap (by
> setting keycode, kmeycodemax, keycodesize in input device).
> 

Do you mean a implementation of setkeycode and getkeycode functions?

>> +
>> +	key_val = val & 0x7f;
>> +	pressed = val >> 7;
>> +
>> +	if (pressed) {
>> +		for (i = 0; i < pdata->keymap_size; i++) {
>> +			if (MCS5000_KEY_VAL(pdata->keymap[i]) == key_val) {
>> +				key_code = MCS5000_KEY_CODE(pdata->keymap[i]);
>> +				data->key_code = key_code;
>> +				break;
>> +			}
>> +		}
>> +	} else
>> +		key_code = data->key_code;
> 
> Does that mean that controller does not report code of released key?
> And we can't have several keys being pressed at once?
> 

Yes, this keypad doesn't report key values when releases and keypad
cannot detect several keys at once, so i saved and used last key_code.

>> +
>> +	input_report_key(input, key_code, pressed ? 1 : 0);
>> +	input_sync(input);
> 
> Please also report EV_MSC/MSC_SCAN.
> 

OK.

Thanks.
