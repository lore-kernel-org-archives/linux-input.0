From: Roberto Alejandro Espi Munoz <raespi@icid.cu>
Subject: Re: uinput on headless system ...
Date: Tue, 19 Jan 2016 16:58:58 -0500
Message-ID: <569EB1A2.5000907@icid.cu>
References: <56965CFB.3020401@icid.cu> <20160113222151.GE39593@dtor-ws> <CAN+gG=FirVq_MrXDkFe8K=7TEVzif9MSHvov4SyZE1M_Z5N=8g@mail.gmail.com> <5697AB41.3070001@icid.cu> <CAN+gG=Fcz7riLQPhmwZWF8X9xGCQ346rhcOH-Qu5rH-oEkj-xw@mail.gmail.com> <5697BBBD.4050003@icid.cu> <569E4E44.4030906@icid.cu> <20160119213647.GB31589@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.icid.cu ([200.55.133.90]:49992 "EHLO mail.icid.cu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933183AbcASV7a (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2016 16:59:30 -0500
Received: from icid.cu ([10.10.0.3])
	by mail.icid.cu (8.13.8/8.13.8) with ESMTP id u0JKlDNN017058
	for <linux-input@vger.kernel.org>; Tue, 19 Jan 2016 15:47:20 -0500
Received: from [10.10.8.78] by icid.cu
	(Cipher TLSv1:RC4-MD5:128) (MDaemon PRO v9.6.1)
	with ESMTP id md50008539128.msg
	for <linux-input@vger.kernel.org>; Tue, 19 Jan 2016 16:16:48 -0500
In-Reply-To: <20160119213647.GB31589@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

The error is produced when the write operation doesn't return the same 
number of bytes as the one requested to write.  Is there any other way 
of checking a specific error message on files associated with devices?

if (write( uinputDev, &event, sizeof(struct input_event)) != sizeof( 
struct input_event) )
{
     fprintf(stderr, "Error on send_event");
     return -1;
  }

On 01/19/2016 04:36 PM, Dmitry Torokhov wrote:
> On Tue, Jan 19, 2016 at 09:55:00AM -0500, Roberto Alejandro Espi Munoz wrote:
>> Bump ... any other insights or suggestions I could try?
>>
> You can check what error you are getting when trying to open the device
> and that might give you idea.
>
> Thanks.
>


