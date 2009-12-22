From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Support for 3M multitouch panel
Date: Tue, 22 Dec 2009 19:00:49 +0100
Message-ID: <694242AB-D4DC-470D-916D-9ADB2B798FBA@enac.fr>
References: <20091211101258.CD35D951F5@smtp.lii-enac-fr> <20091211124226.GD17995@ibawizard.net> <20091211141038.0CBD8951F5@smtp.lii-enac.fr> <20091211223622.GA3067@core.coreip.homeip.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:43235 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbZLVSBE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Dec 2009 13:01:04 -0500
In-Reply-To: <20091211223622.GA3067@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: ynezz@true.cz, linux-input@vger.kernel.org

Hi Dmitry,

I am working on the 3M driver and taking your comments into account  
(and applying them to the Stantum driver as well) but I have an  
question on the comment below:

>
>> +struct mmm_finger {
>> +	__s32 x, y;
>> +	__u8 rank;
>> +	int touch:1, valid:1;
>> +};
>
> Does it make sense to turn access to touch and valid into
> read-modify-write sequence?  Just change them to be 'bool's, it won't
> cause your structures to grow in size.
>
>> +struct mmm_data {
>> +	struct mmm_finger f[10];
>> +	__u8 curid, num;
>> +	int touch:1, valid:1;
>
> Same as above.

Why do you think a read-modify-write sequence would be better? in my  
mind these were just cached values, just like x and y.

Cheers,

St.
  
