From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: FF layer restrictions [Was: [PATCH 1/1] Input: add sensable phantom
 driver]
Date: Tue, 27 Mar 2007 22:51:34 +0200
Message-ID: <460983D6.7070409@gmail.com>
References: <2460126662758025813@fi.muni.cz> <46018FB8.1080601@gmail.com>	 <38b3b7c0703211503s3a8ee177v5b149cfd5975de8c@mail.gmail.com>	 <200703221150.12403.dtor@insightbb.com> <46090BF2.2000105@gmail.com>	 <38b3b7c0703271136s799114fcndfaa6de8db52fc70@mail.gmail.com>	 <46097A68.6080802@gmail.com> <38b3b7c0703271343p6a56fed8i950941e8cef196d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <38b3b7c0703271343p6a56fed8i950941e8cef196d8@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: johann deneux <johann.deneux@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, =?UTF-8?B?IlNUZW55YUsgKEJydW5vIA==?= =?UTF-8?B?R29uesOhbGV6KSI=?= <stenyak@gmail.com>, Anssi Hannula <anssi.hannula@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

johann deneux napsal(a):
> On 3/27/07, Jiri Slaby <jirislaby@gmail.com> wrote:
>> johann deneux napsal(a):
>> > Are we
>> > misunderstanding eachother maybe? By "vector" I mean a triplet of
>> > numbers, when you say "torques" and "forces vector", do you mean that
>> > each effect is composed of a bunch of torques?
>>
>> Ok, let's make things a little bit clear. I need to put somehow 3 short
>> values (torques -- to tell 3 motors how much to spin around) into the
>> kernel
>> space via ff layer. I computed them using FP in US from forces (3d
>> vector)
>> and the problem is, that I don't know how to transform torques to
>> plane(s)
>> and dir and then back to torques -- this is what I can't figure out,
>> since I
>> have no longer vector -- 3 values for each axis, which says how big is
>> the
>> force in each axis -- but I have values (no axis) specific to each motor.
> 
> I think I'm starting to understand. Looking back at the url you gave,
> it appears your device is some kind of articulated arm, possibly with
> one or more motor(s) at each joint. You are not really dealing with a
> single torque applied at one point in space, but several torques
> applied at several points in space.

Exactly as you write. Sorry for my previous bad definitions.

> For this particular device you have three values, but for other
> devices it could just as well be any other number, right?

Correct.

> A realistic example would be a robot arm with claws, there would be a
> torque for each joint, and some more for the claws.

For instance.

Ok, so how to deal with these devices? Does anybody have some idea? That's
what I was talking about somewhere in the beginning of this thread, the raw
values, because it seems too specific for letting kernel to cope with each
of these devices separately, but there might be a better idea in somebody's
head? But raw is ugly...

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
