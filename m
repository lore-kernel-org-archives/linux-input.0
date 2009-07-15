From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Wed, 15 Jul 2009 11:43:41 -0700
Message-ID: <d6200be20907151143r3d159e8esd078055c57ee7986@mail.gmail.com>
References: <20090714100634.GA4054@elf.ucw.cz>
	 <20090714175201.GB14661@dtor-d630.eng.vmware.com>
	 <20090715134855.GB2538@elf.ucw.cz>
	 <20090715152702.GB21611@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756099AbZGOSno@vger.kernel.org>
In-Reply-To: <20090715152702.GB21611@dtor-d630.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jul 15, 2009 at 8:27 AM, Dmitry
Torokhov<dmitry.torokhov@gmail.com> wrote:
=2E..
>> > I think threaded IRQ will fit the bill and will take care of
>> > IRQ/workqueue shutdown races. Of course you still need to use work=
queue
>> > if polling.
>>
>> I guess we'll just strip polling version for now?
>>
>
> Well, is it useable in polling mode? Do we forsee any devices using i=
t
> that way? If no then shure, strip it out.

I would not consider polling mode acceptable in a shipping device. It
was somewhat useful during bringup since it allowed testing the
touchscreen without a working interrupt.

--=20
Arve Hj=F8nnev=E5g
