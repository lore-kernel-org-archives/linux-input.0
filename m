From: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ti_am33x_adc sampling bugs
Date: Tue, 1 Apr 2014 06:42:00 +0100
Message-ID: <20140401054158.GA3261@gmail.com>
References: <53379DF2.7050004@rznt.com>
 <5337B3F4.30500@countercultured.net>
 <CAExKytzRv4CT9zTor=-fc5Mfv+xG9uTjQP=LWosVnhEHsa9Y0A@mail.gmail.com>
 <5338E95F.50204@countercultured.net>
 <533924B1.5030406@countercultured.net>
 <d8950cff-fd37-46bb-b438-d42f15851602@email.android.com>
 <53399C3A.9040007@countercultured.net>
 <ab74c908-a1d0-417c-836b-8d4b093a942b@email.android.com>
 <5339D810.2030400@countercultured.net>
 <c21be082-4ad8-46e2-a5f3-ad29b4239d94@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c21be082-4ad8-46e2-a5f3-ad29b4239d94-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Mosher <nyt-fuEpAR7jH0UNb0vsIHg089HuzzzSOjJt@public.gmane.org>, Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org


Sorry for taking this long to reply.

The confusion here is due to vendor/mainline trees for the kernel.

This discussion should have been carried out on 
https://github.com/beagleboard/kernel/issues
instead of the kernel mailing lists.

Sorry Jonathan.

The IIO-map-interface patch is in the vendor tree for the Beaglebone.

And it is not intended to be mainlined. Just like the other TI wiki stuff.

But it used to make life a little easier before the IIO sysfs entries were fixed
for the am335x ADC.

The patch was kept as it is because of the ton of guides/wikis out there for the
Beaglebone asking for AIN0/AIN7 pins.

And iirc capemgr (another out of tree module which is being mainlined) used it.
Which made it necessary to keep this.

As far as patch 19 (Add continuous sampling) is concerned, I didn't observe it 
causing these bugs. But it is good that you have pointed them out.
Thank-you.

Could you please go through the patch and suggest a fix as well?

Seems like a FIFO isn't cleared somewhere..

Hope this clears the confusion.

Again, this discussion should have been carried out 
https://github.com/beagleboard/kernel/issues

Not the kernel mailing list.

Regards
ZubairLK

> 
