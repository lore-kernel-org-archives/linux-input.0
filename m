From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Tue, 21 Jul 2009 12:36:42 +0100
Message-ID: <20090721113642.GC13286@sirena.org.uk>
References: <20090714100634.GA4054@elf.ucw.cz> <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com> <20090715133627.GA2538@elf.ucw.cz> <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com> <20090721105924.GK4133@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090721105924.GK4133-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 21, 2009 at 12:59:25PM +0200, Pavel Machek wrote:

This looks like an unrelated (but useful) change:

>   *
> + * http://www.synaptics.com/sites/default/files/511_000099_01F.pdf
>   */

This too:

>  static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
>  {
> +/* 
> + * This sensor sends two 6-byte absolute finger reports, an optional
> + * 2-byte relative report followed by a status byte. This function
> + * reads the two finger reports and transforms the coordinates

Worth splitting them out?

> +static irqreturn_t synaptics_ts_hardirq(int irq, void *dev_id)
> +{
> +	disable_irq_nosync(irq);
> +	return IRQ_WAKE_THREAD;

Are you sure that this is going to work?  The IRQ thread code will not
call the thread function if the IRQ is marked as disabled so the thread
won't actually get called and the interrupt will just stay disabled (see
irq_thread() in kernel/irq/manage.c).  As far as I can see the threaded
IRQ support can't be used for devices on interrupt driven buses that
can't interact with the hardware in hardirq context but I might be
missing something here.
