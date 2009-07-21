From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Tue, 21 Jul 2009 18:00:07 +0530
Message-ID: <5d5443650907210530x4aaa03d6gd47ef5f79a3ef8a4@mail.gmail.com>
References: <20090714100634.GA4054@elf.ucw.cz>
	 <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com>
	 <20090715133627.GA2538@elf.ucw.cz>
	 <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com>
	 <20090721105924.GK4133@elf.ucw.cz>
	 <20090721113642.GC13286@sirena.org.uk>
	 <5d5443650907210518i6ee4df1evdc04d9ae9453707c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:51613 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbZGUMaI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2009 08:30:08 -0400
In-Reply-To: <5d5443650907210518i6ee4df1evdc04d9ae9453707c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org

Hi Mark,

On Tue, Jul 21, 2009 at 5:48 PM, Trilok Soni<soni.trilok@gmail.com> wro=
te:
> Hi Mark,
>
> On Tue, Jul 21, 2009 at 5:06 PM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:
>> On Tue, Jul 21, 2009 at 12:59:25PM +0200, Pavel Machek wrote:
>>
>> This looks like an unrelated (but useful) change:
>>
>>> =A0 *
>>> + * http://www.synaptics.com/sites/default/files/511_000099_01F.pdf
>>> =A0 */
>>
>> This too:
>>
>>> =A0static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
>>> =A0{
>>> +/*
>>> + * This sensor sends two 6-byte absolute finger reports, an option=
al
>>> + * 2-byte relative report followed by a status byte. This function
>>> + * reads the two finger reports and transforms the coordinates
>>
>> Worth splitting them out?
>>
>>> +static irqreturn_t synaptics_ts_hardirq(int irq, void *dev_id)
>>> +{
>>> + =A0 =A0 disable_irq_nosync(irq);
>>> + =A0 =A0 return IRQ_WAKE_THREAD;
>>
>> Are you sure that this is going to work? =A0The IRQ thread code will=
 not
>> call the thread function if the IRQ is marked as disabled so the thr=
ead
>> won't actually get called and the interrupt will just stay disabled =
(see
>> irq_thread() in kernel/irq/manage.c). =A0As far as I can see the thr=
eaded
>> IRQ support can't be used for devices on interrupt driven buses that
>> can't interact with the hardware in hardirq context but I might be
>> missing something here.
>>
>
> I think threaded irqs are used in USB drivers too, I can't locate the
> patches link for that.
>

Hopefully, this thread can give all details about threaded irq discussi=
on.

http://lkml.org/lkml/2009/2/27/255


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
