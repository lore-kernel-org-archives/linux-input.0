From: Jarod Wilson <jarod@wilsonet.com>
Subject: Re: [PATCH 3/4] ir-core: move decoding state to ir_raw_event_ctrl
Date: Tue, 8 Jun 2010 23:46:36 -0400
Message-ID: <AANLkTimuYkKzDPvtnrWKoT8sh1H9paPBQQNmYWOT7-R2@mail.gmail.com>
References: <20100424210843.11570.82007.stgit@localhost.localdomain>
	<20100424211411.11570.2189.stgit@localhost.localdomain>
	<4BDF2B45.9060806@redhat.com>
	<20100607190003.GC19390@hardeman.nu>
	<20100607201530.GG16638@redhat.com>
	<20100608175017.GC5181@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100608175017.GC5181@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: Jarod Wilson <jarod@redhat.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-media@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jun 8, 2010 at 1:50 PM, David H=E4rdeman <david@hardeman.nu> wr=
ote:
> On Mon, Jun 07, 2010 at 04:15:30PM -0400, Jarod Wilson wrote:
>> On Mon, Jun 07, 2010 at 09:00:03PM +0200, David H=E4rdeman wrote:
>> > On Mon, May 03, 2010 at 05:00:05PM -0300, Mauro Carvalho Chehab wr=
ote:
>> > > David H=E4rdeman wrote:
>> > > > This patch moves the state from each raw decoder into the
>> > > > ir_raw_event_ctrl struct.
>> > > >
>> > > > This allows the removal of code like this:
>> > > >
>> > > > =A0 =A0 =A0 =A0 spin_lock(&decoder_lock);
>> > > > =A0 =A0 =A0 =A0 list_for_each_entry(data, &decoder_list, list)=
 {
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->ir_dev =3D=3D ir_dev=
)
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > > > =A0 =A0 =A0 =A0 }
>> > > > =A0 =A0 =A0 =A0 spin_unlock(&decoder_lock);
>> > > > =A0 =A0 =A0 =A0 return data;
>> > > >
>> > > > which is currently run for each decoder on each event in order
>> > > > to get the client-specific decoding state data.
>> > > >
>> > > > In addition, ir decoding modules and ir driver module load
>> > > > order is now independent. Centralizing the data also allows
>> > > > for a nice code reduction of about 30% per raw decoder as
>> > > > client lists and client registration callbacks are no longer
>> > > > necessary.
>> > >
>> > > The registration callbacks will likely still be needed by lirc,
>> > > as you need to create/delete lirc_dev interfaces, when the modul=
e
>> > > is registered, but I might be wrong. It would be interesting to
>> > > add lirc_dev first, in order to be sure about the better interfa=
ces
>> > > for it.
>> >
>> > Or the lirc_dev patch can add whatever interfaces it needs. Anyway=
, the
>> > current interfaces are not good enough since it'll break if lirc_d=
ev is
>> > loaded after the hardware modules.
>>
>> This is something I've been meaning to mention myself. On system boo=
t, if
>> an mceusb device is connected, it pretty regularly only has the NEC
>> decoder available to use. I have to reload mceusb, or make sure ir-c=
ore is
>> explicitly loaded, wait a bit, then load mceusb, if I want to have a=
ll of
>> the protocol handlers available -- which includes the needed-by-defa=
ult
>> rc6 one. I've only briefly tinkered with trying to fix it, sounds li=
ke you
>> may already have fixage within this patchset.
>
> The problem is that without the patchset, each decoder is expected to
> carry it's own list of datastructures for each hardware receiver.
> Hardware receiver addition/removal is signalled through a callback to
> the decoder, but the callback will (naturally) not be invoked if the
> hardware driver is already loaded when the decoder is. So loading a
> decoder "late" or reloading a decoder will mean that it doesn't know
> about pre-existing hardware.
>
>> > In addition, random module load order is currently broken (try loa=
ding
>> > decoders first and hardware later and you'll see). =A0With this pa=
tch, it
>> > works again.
>>
>> Want.
>
> Then please help me with two things:
>
> a) Test the patches I just sent (especially 6/8 and 7/8, they should
> =A0 be independent from the rest)

Working on merging them into a tree here locally. There's been a bit
of churn, so the last few didn't apply cleanly, but I'm almost there.

> b) Mauro mentioned in <4BDF28C0.4060102@redhat.com> that:
>
> =A0 =A0 =A0 =A0I liked the idea of your redesign, but I didn't like t=
he removal
> =A0 =A0 =A0 =A0of a per-decoder sysfs entry. As already discussed, th=
ere are
> =A0 =A0 =A0 =A0cases where we'll need a per-decoder sysfs entry (lirc=
_dev is
> =A0 =A0 =A0 =A0probably one of those cases - also Jarod's imon driver=
 is
> =A0 =A0 =A0 =A0currently implementing a modprobe parameter that needs=
 to be
> =A0 =A0 =A0 =A0moved to the driver).
>
> =A0 could you please confirm if your lirc and/or imon drivers would b=
e
> =A0 negatively affected by the proposed patches?

Will do so once I get them wedged in on top.


--=20
Jarod Wilson
jarod@wilsonet.com
