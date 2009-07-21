From: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Tue, 21 Jul 2009 17:48:40 +0530
Message-ID: <5d5443650907210518i6ee4df1evdc04d9ae9453707c@mail.gmail.com>
References: <20090714100634.GA4054@elf.ucw.cz>
	 <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com>
	 <20090715133627.GA2538@elf.ucw.cz>
	 <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com>
	 <20090721105924.GK4133@elf.ucw.cz>
	 <20090721113642.GC13286@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090721113642.GC13286-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Mark,

On Tue, Jul 21, 2009 at 5:06 PM, Mark
Brown<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Tue, Jul 21, 2009 at 12:59:25PM +0200, Pavel Machek wrote:
>
> This looks like an unrelated (but useful) change:
>
>> =A0 *
>> + * http://www.synaptics.com/sites/default/files/511_000099_01F.pdf
>> =A0 */
>
> This too:
>
>> =A0static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
>> =A0{
>> +/*
>> + * This sensor sends two 6-byte absolute finger reports, an optiona=
l
>> + * 2-byte relative report followed by a status byte. This function
>> + * reads the two finger reports and transforms the coordinates
>
> Worth splitting them out?
>
>> +static irqreturn_t synaptics_ts_hardirq(int irq, void *dev_id)
>> +{
>> + =A0 =A0 disable_irq_nosync(irq);
>> + =A0 =A0 return IRQ_WAKE_THREAD;
>
> Are you sure that this is going to work? =A0The IRQ thread code will =
not
> call the thread function if the IRQ is marked as disabled so the thre=
ad
> won't actually get called and the interrupt will just stay disabled (=
see
> irq_thread() in kernel/irq/manage.c). =A0As far as I can see the thre=
aded
> IRQ support can't be used for devices on interrupt driven buses that
> can't interact with the hardware in hardirq context but I might be
> missing something here.
>

I think threaded irqs are used in USB drivers too, I can't locate the
patches link for that.



--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
