From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCHv4 4/6] input/cma3000_d0x: Add CMA3000 spi support
Date: Wed, 2 Nov 2011 13:38:29 +0100
Message-ID: <CAPybu_2qfZqjE87Sm+b5TcxNf=F=Z+oM7cGpt8dYRiWydsYC7Q@mail.gmail.com>
References: <1319487676-27181-1-git-send-email-ricardo.ribalda@gmail.com>
 <1319487676-27181-5-git-send-email-ricardo.ribalda@gmail.com>
 <20111024213635.GB4394@ponder.secretlab.ca> <CAPybu_3pF6u10JMmcbho1e7=8EPHMq8LQ1+uHpyVMOmbRMUsHA@mail.gmail.com>
 <4EA6741B.6090508@cam.ac.uk> <20111025083633.GB31508@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111025083633.GB31508@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Grant Likely <grant.likely@secretlab.ca>, dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hello Mark

  I will wait until your patches arrive to linux-next. And then I will
port mine in top of yours. It will be great to get your feedback then.
Thanks!

On Tue, Oct 25, 2011 at 10:36, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Oct 25, 2011 at 09:32:27AM +0100, Jonathan Cameron wrote:
>> On 10/25/11 08:24, Ricardo Ribalda Delgado wrote:
>
>> > It is not on linux-next, and also it cannot be used directly, in o=
rder
>> > to read you have to do set reg=3D (reg << 2) | 2; And AFAIK it is =
not
>> > supported by the regmap
>
>> My gut feeling is it would easy enough to add if it can't currently
>> be done. Mark?
>
> That should be trivial to add - the | 2 bit is already supported in
> -next and will be sent to Linus this merge window, adding the shift i=
s
> just a simple matter of programming.
>
>> Gains here are leveraging the bus abstractions from there. =A0There =
aren't
>> enough registers to gain from caching etc.
>
> Depends on the workload more than the number of registers - if you're
> able to eliminate enough reads then it can give a bit of a performanc=
e
> boost. =A0But it's completely optional either way.
>



--=20
Ricardo Ribalda
