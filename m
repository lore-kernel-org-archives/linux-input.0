From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] Input notifier support
Date: Fri, 27 Feb 2009 11:11:27 +0900
Message-ID: <9c9fda240902261811g49483f9fk9ac7945834b8764@mail.gmail.com>
References: <20090225044730.GA9106@july>
	 <5d5443650902252301l19d08e67t54c1cea004442be2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756455AbZB0CLp@vger.kernel.org>
In-Reply-To: <5d5443650902252301l19d08e67t54c1cea004442be2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

Hi,

On Thu, Feb 26, 2009 at 4:01 PM, Trilok Soni <soni.trilok@gmail.com> wr=
ote:
> Hi Kyungmin,
>
>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>> index 1730d73..7e96635 100644
>> --- a/drivers/input/input.c
>> +++ b/drivers/input/input.c
>> @@ -274,6 +274,8 @@ void input_event(struct input_dev *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_input_randomness(type, code, valu=
e);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_handle_event(dev, type, code, v=
alue);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&dev->event_lo=
ck, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (type =3D=3D EV_KEY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_notifier_call_ch=
ain(value, &code);
>
> This check will be done for every input_report_xxx calls, even for
> touchscreen events (in which case of course it will fail), and I don'=
t
> think this is optimal solution. Users should be given an option to
> disable this if they don't need this notification mechanism.
>
> How about moving this to input_report_key?

Good, Thank you for point it. I will move it to input_report_key.

Thank you,
Kyungmin Park
