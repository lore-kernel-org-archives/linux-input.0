From: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Input: add MAX7359 key switch controller driver
Date: Thu, 7 May 2009 15:47:24 +0530
Message-ID: <5d5443650905070317pa962440kf6d416f0272decc5@mail.gmail.com>
References: <4A012C64.1020101@samsung.com>
	 <5d5443650905060638l52b3c17dle0d138b689a23252@mail.gmail.com>
	 <4d34a0a70905070303r55c2c681yf58680de2f3d4a9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4d34a0a70905070303r55c2c681yf58680de2f3d4a9f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kim Kyuwon <q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Kim,

>>
>> Could you please restrict the commit text line to 80/72 columns? It
>> will look good.
>
> Is this restriction for commit text mandatory? It seems like I got an
> email from Andrew Morton that my patch was wordwraped even commit
> text.

This helps reader of the commit text to not give much stretch on his ey=
es :)

>>
>>> +
>>> +static int __devinit max7359_probe(struct i2c_client *client,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 const struct i2c_device_id *id)
>>
>> You may want to remove __devinit as it is i2c client driver . I have
>> added linux-i2c for i2c specific review.
>
> Actually I don't want to remove it :), Is there any reason why you th=
ink so?

Sorry I have mistaken it as __init. This is fine.

>
>>> +static int max7359_suspend(struct i2c_client *client, pm_message_t=
 mesg)
>>> +{
>>> + =A0 =A0 =A0 /* If no keys are pressed, enter sleep mode for 8192 =
ms */
>>> + =A0 =A0 =A0 max7359_write_reg(client, MAX7359_REG_SLEEP, 0x01);
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +static int max7359_resume(struct i2c_client *client)
>>> +{
>>> + =A0 =A0 =A0 /* Restore the default setting (autosleep for 256 ms)=
 */
>>> + =A0 =A0 =A0 max7359_write_reg(client, MAX7359_REG_SLEEP, 0x07);
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>
>> Protect these two function with #ifdef CONFIG_PM please.
>
> This is what I really wanted to ask. I'm trying not to use '#ifdef'.
> By the way, why most of drivers use protect suspend/resume functions
> with #ifdef? Just for saving code size?

suspend and resume is only important if the user of this driver has
CONFIG_PM enabled in it's
defconfig, right? So, if CONFIG_PM is not defined suspend/resume
should equal to NULL.

>>
>>
>>> +};
>>> +
>>> +
>>> +MODULE_AUTHOR("Kim Kyuwon <q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
>>> +MODULE_DESCRIPTION("MAX7359 Key Switch Controller Driver");
>>> +MODULE_LICENSE("GPL v2");
>>
>> MODULE_ALIAS ??
>
> In 'include/linux/module.h'
>
> =A096 /* For userspace: you can also call me... */
> =A097 #define MODULE_ALIAS(_alias) MODULE_INFO(alias, _alias)
>
> From comment above, I think MODULE_ALIAS is optional. Do you still
> think MODULE_ALIAS needs?
>

Yes, it is not __must__.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
