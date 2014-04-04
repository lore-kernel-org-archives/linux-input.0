From: gmane-G/ASJRsgvFgvW+L+VdN226ESeJV5RFUqQQ4Iyu8u01E@public.gmane.org
Subject: Re: =?UTF-8?Q?ti=5Fam=33=33x=5Fadc=20sampling=20bugs?=
Date: Fri, 04 Apr 2014 08:41:32 -0500
Message-ID: <4a1e407f0574ce0fc1f26e1d536f75b2@reliableembeddedsystems.com>
References: <53379DF2.7050004@rznt.com> <5337B3F4.30500@countercultured.net>
 <CAExKytzRv4CT9zTor=-fc5Mfv+xG9uTjQP=LWosVnhEHsa9Y0A@mail.gmail.com>
 <5338E95F.50204@countercultured.net> <533924B1.5030406@countercultured.net>
 <d8950cff-fd37-46bb-b438-d42f15851602@email.android.com>
 <53399C3A.9040007@countercultured.net>
 <ab74c908-a1d0-417c-836b-8d4b093a942b@email.android.com>
 <5339D810.2030400@countercultured.net>
 <c21be082-4ad8-46e2-a5f3-ad29b4239d94@email.android.com>
 <20140401054158.GA3261@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140401054158.GA3261-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Mosher <nyt-fuEpAR7jH0UNb0vsIHg089HuzzzSOjJt@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 2014-04-01 00:42, Zubair Lutfullah : wrote:
> Sorry for taking this long to reply.
> 
> The confusion here is due to vendor/mainline trees for the kernel.
> 
> This discussion should have been carried out on
> https://github.com/beagleboard/kernel/issues
> instead of the kernel mailing lists.

Sorry for jumping in here.

I use a more recent kernel 3.13.x and currently try to move to 3.14.x.
The sampling seems to work, but I would like to use the generic_buffer
test [1].

The kernel used here [1] is a 3.13.6 stable plus those patches [2] 
(from
Rob Nelson)

Can someone please tell me what's the status with beagle bone black and
iio (and maybe whom to talk to about it).

Regards,

Robert

[1] http://thread.gmane.org/gmane.linux.kernel.iio/11631
[2]
https://github.com/RobertBerger/meta-mainline/blob/dora-training-v3.13.x/beagle-bone-black-ml/recipes-kernel/linux/linux-yocto-custom/beagle-bone-black-ml-user-patches.scc


...do it-do it right-do it right now- Bobby Riggs

My public pgp key is available,at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1
