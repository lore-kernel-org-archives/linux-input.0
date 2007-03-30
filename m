From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: FF layer restrictions [Was: [PATCH 1/1] Input: add sensable phantom
 driver]
Date: Fri, 30 Mar 2007 22:11:20 +0300
Message-ID: <460D60D8.7010408@gmail.com>
References: <2460126662758025813@fi.muni.cz> <46018FB8.1080601@gmail.com>	 <38b3b7c0703211503s3a8ee177v5b149cfd5975de8c@mail.gmail.com>	 <200703221150.12403.dtor@insightbb.com> <46090BF2.2000105@gmail.com>	 <38b3b7c0703271136s799114fcndfaa6de8db52fc70@mail.gmail.com>	 <46097A68.6080802@gmail.com>	 <38b3b7c0703271343p6a56fed8i950941e8cef196d8@mail.gmail.com>	 <460983D6.7070409@gmail.com> <38b3b7c0703271434u2fddc4d1jc2b9af097e9c95b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <38b3b7c0703271434u2fddc4d1jc2b9af097e9c95b2@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: johann deneux <johann.deneux@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Dmitry Torokhov <dtor@insightbb.com>, =?ISO-8859-1?Q?=22STenyaK_=28Bruno_Gonz=E1lez=29=22?= <stenyak@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

johann deneux wrote:
> On 3/27/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> Ok, so how to deal with these devices? Does anybody have some idea?
>> That's
>> what I was talking about somewhere in the beginning of this thread,
>> the raw
>> values, because it seems too specific for letting kernel to cope with
>> each
>> of these devices separately, but there might be a better idea in
>> somebody's
>> head? But raw is ugly...
>>
> 
> What about adding a member to ff_effect which would be the number of the
> motor?
> We can't change the layout of ff_effect too much though, so we have to
> find unused bits and put them to work.

Actually, having thought more about this, I'm beginning to believe
Jiri's original FF_RAW approach could actually be a good option to add
3d effect support to the API. It would be similar to FF_CONSTANT but
instead of angle+magnitude the force is defined as s16 per every axis
(so it could actually be used with current drivers as well).

Alternatively we could define FF_3D_CONSTANT as an usual FF_CONSTANT
with an additional direction value, allowing a 3D force to be described
using 2x direction and magnitude.

Or we could define both ;)

Howewer, if I understood correctly that the 3 values the phantom device
takes are not really magnitudes along X, Y, Z, but some possibly
unaligned motors specific to this device, we cannot really abstract the
device motors into a 3D force effect. We could still add some FF_RAW
type, however, but with the values representing motors instead of axes,
with the exact function (direction) of each motor being left undefined
in the API (unlike the FF_RAW type I was talking a few paragraphs ago,
this type of course wouldn't be used at all by other drivers).


> Another possibility is to get rid of "trigger" and replace it by __u8
> motor and some padding, since that's I-Force specific (are there other
> drivers that implement that?). The goal of "trigger" is to start an
> effect when a button is pressed, which can be done from userland
> instead. It's not like we need micro-second latency when starting
> effects.

The generic PID driver implements that. I also think implementing the
support in software for the devices not supporting triggers in hw could
be quite easily done in ff-core.c or ff-memless.c.

(I also don't know what the triggers are useful for)

johann deneux also wrote in another message:
> The
> problem is to make an extension that does not duplicate the
> capabilities of the existing API. We don't want to have two ways of
> specifying the same effects.

How is this a problem?

-- 
Anssi Hannula
