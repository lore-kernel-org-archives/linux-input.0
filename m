From: "johann deneux" <johann.deneux@gmail.com>
Subject: Re: FF layer restrictions [Was: [PATCH 1/1] Input: add sensable phantom driver]
Date: Wed, 21 Mar 2007 23:03:12 +0100
Message-ID: <38b3b7c0703211503s3a8ee177v5b149cfd5975de8c@mail.gmail.com>
References: <2460126662758025813@fi.muni.cz> <45F82626.8000108@gmail.com>
	 <45F83930.4060401@gmail.com>
	 <8e4ff20a0703141147n4b690ab8g4cc8138d1ecc94e1@mail.gmail.com>
	 <d120d5000703141213k6554f7f6o58e4a9da1aa6a20a@mail.gmail.com>
	 <8e4ff20a0703141218r3add7923n74470b5e16f58c5c@mail.gmail.com>
	 <4601339C.6010706@gmail.com>
	 <38b3b7c0703211202p29f7865cr34960c7ea708640e@mail.gmail.com>
	 <d120d5000703211222j64fd22fbn1e06267790f8a569@mail.gmail.com>
	 <46018FB8.1080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46018FB8.1080601@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "=?ISO-8859-1?Q?\"STenyaK_(Bruno_Gonz=E1lez)\"?=" <stenyak@gmail.com>, Anssi Hannula <anssi.hannula@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 3/21/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> Dmitry Torokhov napsal(a):
> > On 3/21/07, johann deneux <johann.deneux@gmail.com> wrote:
> >> I would suggest adding a new effect type (3d effect) and extending the
> >> union in struct ff_effect.
> >> Let me know if I'm too vague, I already suggested that solution but
> >> got no answer. I wonder if my mail got lost, nobody understood what I
> >> said, or if it's just a plain bad idea.
> >>
> >
> > My concern with a new 3D effect is that it will be a very "simple"
> > effect with only constant force apllied. That might be enough for
> > phantom but may not be sufficient for future devices. If we add
> > ability to specify a "plane" for an effect we will be able to add
> > envelopes on top of more complex effects and get desired combined
> > effcet.
>
> I didn't get this too much, because I don't understand the FF layer well so
> far. How is this going to work? Let's say, we have 3 torque values computed
> in US, and this structure:
>
> struct ff_effect {
>     __u16 direction;
>     struct ff_trigger trigger;
>     struct ff_replay replay;
>
>     struct ff_constant_effect {
>         __s16 level;
>         struct ff_envelope {
>              __u16 attack_length;
>              __u16 attack_level;
>              __u16 fade_length;
>              __u16 fade_level;
>         };
>     };
> };
>
> and need to pass the three 16bits torques into s16 ioaddr[0..2]. How?
>

Stupid question, I have forgotten the details of ioctl: Wouldn't the
following work?

struct ff_effect {
        __u16 type;
        __s16 id;
        __u16 direction;
        struct ff_trigger trigger;
        struct ff_replay replay;

        union {
                struct ff_constant_effect constant;
                struct ff_ramp_effect ramp;
                struct ff_periodic_effect periodic;
                struct ff_condition_effect condition[2]; /* One for each axis */
                struct ff_rumble_effect rumble;
        } u;

        /* New member: Specify a plane in the 3d space. */
        struct ff_plane plane;
};

Would that pose compatibility issues? If the input layer knows the
size of the struct the user-space application is sending, it knows if
it's safe to look into the "plane" member. If it is, and the device
driver is capable of handling 3d effects, then fine. If it is but the
device driver can't handle it, return an error code. If it isn't, just
do whatever it's currently doing.

Alternatively, one could leave ff_effect effect untouched and find
another way to specify the plane, e.g. another ioctl.

-- 
Johann
