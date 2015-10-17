From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: Re: [PATCH 07/15] Input: xpad: move the input device creation to a
 new function
Date: Sat, 17 Oct 2015 20:08:25 +0200
Message-ID: <56228E99.3010202@gmail.com>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
 <1443733046-29610-8-git-send-email-rojtberg@gmail.com>
 <20151010180015.GI39573@dtor-ws> <561FFC47.3060802@gmail.com>
 <20151017164933.GD13470@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34923 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbbJQSI2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Oct 2015 14:08:28 -0400
Received: by wicll6 with SMTP id ll6so46967821wic.0
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2015 11:08:26 -0700 (PDT)
In-Reply-To: <20151017164933.GD13470@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org



Am 17.10.2015 um 18:49 schrieb Dmitry Torokhov:
> Hi Pavel,
>
> On Thu, Oct 15, 2015 at 09:19:35PM +0200, Pavel Rojtberg wrote:
>> Hey Dimitry,
>>
>> I have seen you have also applied
>> "[PATCH 08/15] Input: xpad: query Wireless controller state at init".
>> However this change is unfortunately incomplete without
>> "[PATCH 09/15] Input: xpad: handle "present" and "gone" correctly".
>>
>> As is both the presence as well as the LED packets are sent
>> immediately at init
>> which triggers the the "URB xxxx submitted while active" Warning and causes
>> any initialization to fail.
>>
>> Attached is a fixup against current input/ next of the chunk that is in
>> [PATCH 09/15], but should have been in [PATCH 08/15].
>> Sorry for the inconvenience.
>>
>> do not call xpad_identify_controller at init: it conflicts with
>> the already sent presence packet and will be called by
>> xpad360w_process_packet as needed anyway.
> I see. But I believe we should only do that for wireless controllers,
> because we send the presence request only for XTYPE_XBOX360W and LEDs
> are also present on non-wireless variant, right?
>
> So I think we want:
>
> 	if (xpad->xtype == XTYPE_XBOX360) {
> 		/*
> 		 * Light up the segment corresponding to controller
> 		 * number on wired devices. On wireless we'll do that
> 		 * when they respond to "presence" packet.
> 		 */
> 		xpad_identify_controller(xpad);
> 	}
>
> Thanks.
yes, you are right.

