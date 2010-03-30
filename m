From: Octoploid <cryptooctoploid@gmail.com>
Subject: Re: Logitech M705 thumb button
Date: Tue, 30 Mar 2010 09:33:34 +0200
Message-ID: <319012f1003300033k254715dao7f9a807615df36df@mail.gmail.com>
References: <hoqak4$m6t$1@dough.gmane.org>
	 <20100330065625.GC12764@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:41075 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab0C3Hdg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Mar 2010 03:33:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1157245fgg.1
        for <linux-input@vger.kernel.org>; Tue, 30 Mar 2010 00:33:34 -0700 (PDT)
In-Reply-To: <20100330065625.GC12764@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Mar 30, 2010 at 8:56 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Mar 29, 2010 at 03:40:20PM +0200, Octoploid wrote:
>> Just bought a Logitech M705 mouse today and everything is working
>> fine except the thumb button. I just don't get any events in =BBxev=AB=
 or
>> =BBxinput test=AB when I press that button.
>> This mouse comes with the new =BBUnifying USB receiver=AB.
>>
>> Any hints on how I could get that button working?
>>
>
> Start with locating "evtest" utility and confirming that the kerenl d=
oes
> not emit any events for the thumb button.

Yes, there are no events emitted for the thumb button when running =BBe=
vtest=AB.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
