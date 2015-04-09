From: Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: Driver for Logitech M560
Date: Thu, 09 Apr 2015 19:08:59 +0200
Message-ID: <5526B22B.4060507@inwind.it>
References: <5404C6F4.1000800@inwind.it>	<CAN+gG=HMUJBWQj65OKRfoPiyzzRPXLVveA6V2S_a1dSJXKJc3g@mail.gmail.com>	<5409F740.9000706@inwind.it> <20150409144154.36fbce15dcdf4556544ee8a7@ao2.it>
Reply-To: kreijack@inwind.it
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-16.italiaonline.it ([212.48.25.144]:49004 "EHLO libero.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755488AbbDIRRR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Apr 2015 13:17:17 -0400
In-Reply-To: <20150409144154.36fbce15dcdf4556544ee8a7@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Dario Righelli <drighelli@gmail.com>

On 2015-04-09 14:41, Antonio Ospite wrote:
> On Fri, 05 Sep 2014 19:47:44 +0200
> Goffredo Baroncelli <kreijack@inwind.it> wrote:
> 
>> On 09/03/2014 11:36 PM, Benjamin Tissoires wrote:
>>> Hi Goffredo,
>>>
>>> On Mon, Sep 1, 2014 at 3:20 PM, Goffredo Baroncelli <kreijack@inwind.it> wrote:
>>>> Hi Benjamin,
>>>>
>>>> following the Nestor suggestion, I rewrote the driver for the
>>>> mouse Logitech M560 on the basis of your work (branch "for-whot").
>>>
>>> Just for the record. This branch is located here:
>>> https://github.com/bentiss/hid-logitech-dj/tree/for-whot and I
>>> *really* need to finish this work so that everything can go upstream
>>> :(
>>
> 
> Hi Benjamin, any news about upstreaming this work?
> 
>> :-) For me this is not a problem. I solved my issue (I made a dkms
>> package for this mouse), but I want to share my effort..
>>
> 
> Goffredo, is this the latest version of your dkms-enabled external
> module?
> https://github.com/kreijack/hid-logitech-dj/tree/m560-dkms

Hi Antonio,

I was never capable to make dkms working; if you have got it, please geve me a patch...
Anyway the most update branch is m560-devel, but you have to insert by hand the modules..

BR
Goffredo



> 
> Thanks,
>    Antonio
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
