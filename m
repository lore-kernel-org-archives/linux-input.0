From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - Increase the wait times for
 backup and reset
Date: Fri, 01 Apr 2011 16:43:59 +0300
Message-ID: <4D95D69F.6070107@atmel.com>
References: <4D821DCF.6090403@atmel.com> <AANLkTik2vokDJuUpX8KObztfcjCbH3O7s5XGN3weiubM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:13898 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756010Ab1DANoO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Apr 2011 09:44:14 -0400
In-Reply-To: <AANLkTik2vokDJuUpX8KObztfcjCbH3O7s5XGN3weiubM@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <dofmind@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 03/21/2011 02:11 PM, Joonyoung Shim wrote:
>> -#define MXT_BACKUP_TIME                25      /* msec */
>> -#define MXT_RESET_TIME         65      /* msec */
>> +#define MXT_BACKUP_TIME                270     /* msec */
>> +#define MXT_RESET_TIME         350     /* msec */
> 
> I wonder mXT cycle time is alterable and if reset and backup time is desided
> by mXT cycle time, i think they can be used to variable.
> 

I agree, waiting for 270 + 350 ms might be overkill. The correct way to do this would be
to wait for the chip to indicate it has completed the backup and reset. I will send a new
patch that implements this.

BR,

-- 
Iiro
