From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] Input notifier support
Date: Fri, 27 Feb 2009 18:05:37 +0530
Message-ID: <5d5443650902270435y38a006datc6767524e7290fb0@mail.gmail.com>
References: <20090225044730.GA9106@july>
	 <5d5443650902252301l19d08e67t54c1cea004442be2@mail.gmail.com>
	 <9c9fda240902261811g49483f9fk9ac7945834b8764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:2000 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbZB0Mfj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 07:35:39 -0500
In-Reply-To: <9c9fda240902261811g49483f9fk9ac7945834b8764@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hi Kyungmin,

On Fri, Feb 27, 2009 at 7:41 AM, Kyungmin Park <kmpark@infradead.org> w=
rote:
> Hi,
>
> On Thu, Feb 26, 2009 at 4:01 PM, Trilok Soni <soni.trilok@gmail.com> =
wrote:
>> Hi Kyungmin,
>>
>>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>>> index 1730d73..7e96635 100644
>>> --- a/drivers/input/input.c
>>> +++ b/drivers/input/input.c
>>> @@ -274,6 +274,8 @@ void input_event(struct input_dev *dev,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_input_randomness(type, code, val=
ue);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_handle_event(dev, type, code, =
value);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&dev->event_l=
ock, flags);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (type =3D=3D EV_KEY)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_notifier_call_c=
hain(value, &code);
>>
>> This check will be done for every input_report_xxx calls, even for
>> touchscreen events (in which case of course it will fail), and I don=
't
>> think this is optimal solution. Users should be given an option to
>> disable this if they don't need this notification mechanism.
>>
>> How about moving this to input_report_key?
>
> Good, Thank you for point it. I will move it to input_report_key.

As most of the other platforms may not need input_notify as standard
in-built feature, it is better to add Kconfig symbol for this, so that
it can be compiled out when not needed.


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
