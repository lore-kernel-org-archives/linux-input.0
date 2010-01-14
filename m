From: Chaogui Zhang <czhang@marywood.edu>
Subject: Re: [PATCH] TiVo USB IR Dongle support
Date: Wed, 13 Jan 2010 20:28:51 -0500
Message-ID: <2992d57b1001131728l767517bcg851ebd4291b71078@mail.gmail.com>
References: <20091206214543.GA5290@acer.drzhang.net>
	 <20091212190143.GA3591@acer.drzhang.net>
	 <20091212233259.GB16760@core.coreip.homeip.net>
	 <20091214220059.GA16776@drzhang.net>
	 <20091214222843.GE2373@core.coreip.homeip.net>
	 <20091216005357.GA23449@drzhang.net>
	 <20100113075308.GB3242@core.coreip.homeip.net>
	 <2992d57b1001131722p686108acn4f51e94609047c97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:57276 "HELO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751068Ab0ANB2w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2010 20:28:52 -0500
Received: by ewy3 with SMTP id 3so325898ewy.13
        for <linux-input@vger.kernel.org>; Wed, 13 Jan 2010 17:28:51 -0800 (PST)
In-Reply-To: <2992d57b1001131722p686108acn4f51e94609047c97@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Jan 13, 2010 at 8:22 PM, Chaogui Zhang <czhang@marywood.edu> wr=
ote:
> On Wed, Jan 13, 2010 at 2:53 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> Hi Chaogui,
>>
>> I was looking at the driver again and I have some concerns with the
>> foolowing fragment:
>>
>> On Tue, Dec 15, 2009 at 07:53:57PM -0500, Chaogui Zhang wrote:
>>> +
>>> + =A0 =A0 /* The lower 5 bits of the first byte of each packet indi=
cates the size
>>> + =A0 =A0 =A0* of the transferred buffer, not including the first b=
yte itself.
>>> + =A0 =A0 =A0*/
>>> +
>>> + =A0 =A0 length =3D (remote->in_buffer[0]) & 0x1f;
>>> + =A0 =A0 for (i =3D 0; i <=3D length; i++)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 snprintf(codes + i * 3, 4, "%02x ", remot=
e->in_buffer[i]);
>>> +
>>> + =A0 =A0 /* 0x80 at the end of a regular packet or in a separate p=
acket
>>> + =A0 =A0 =A0 =A0indicates key release */
>>> +
>>> + =A0 =A0 if (i < TIVOIR_RECV_SIZE && remote->in_buffer[i] =3D=3D 0=
x80)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 snprintf(codes + i * 3, 4, "%02x ", remot=
e->in_buffer[i]);
>>> +
>>
>> So does this mean that 0x80 indicating release is not included in th=
e
>> size of the received packet.
>>
>
> Hi, Dimitry,
>
> Sorry that you are getting this message twice. I accidentally dropped
> the list from the cc again.
>
> You are correct and the 0x80 signals the end of the packet and
>

To finish my sentence: ... and it is NOT included in the packet size.

I don't know what is going on with me today. Silly things like this
keep happening.

My sincere apologies.

--

Chaogui Zhang
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
