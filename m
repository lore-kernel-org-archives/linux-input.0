From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Wed, 15 Jul 2009 13:24:49 -0700
Message-ID: <d6200be20907151324t7c133d49ofedf02efda4054cd@mail.gmail.com>
References: <20090714100634.GA4054@elf.ucw.cz>
	 <20090714175201.GB14661@dtor-d630.eng.vmware.com>
	 <20090715134855.GB2538@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:46485 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266AbZGOUYu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2009 16:24:50 -0400
In-Reply-To: <20090715134855.GB2538@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Wed, Jul 15, 2009 at 6:48 AM, Pavel Machek<pavel@ucw.cz> wrote:
> On Tue 2009-07-14 10:52:12, Dmitry Torokhov wrote:
>> On Tue, Jul 14, 2009 at 12:06:34PM +0200, Pavel Machek wrote:
>> > From: Arve Hj?nnev?g <arve@android.com>
>> >
>> > This adds support for synaptic touchscreen, used in HTC dream
>> > cellphone.
>> >
>> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> This is pretty large body of code, could we get a sign-off from Arve=
 as
>> well since he seems to be the author?
>
> Arve?
>

The original patches has my sign-offs. Can you just keep that and add
a line describing your changes before your sign-off?

=2E..
>> > +static struct workqueue_struct *synaptics_wq;
>>
>> Do we need a separate workqueue? Is reading the device that slow tha=
t we
>> can use keventd?
>

keventd has two problems. First, other work runs on it that can take
more than 12.5ms. This will case dropped events. Second, the i2c bus
sometimes locks up, which in turns would cause this driver to block
keventd for seconds.

=2E..
>> > + =A0 if (client->irq) {
>> > + =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(client->irq, synaptics_t=
s_irq_handler,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, clien=
t->name, ts);
>>
>> I think threaded IRQ will fit the bill and will take care of
>> IRQ/workqueue shutdown races. Of course you still need to use workqu=
eue
>> if polling.
>
> I guess we'll just strip polling version for now?

Sounds good to me.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
