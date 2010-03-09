From: Rantanplan <rantanplanlechien@free.fr>
Subject: Re: [PATCH 2/3] HID: suppress the second input for the Apple Magic
 Mouse.
Date: Tue, 09 Mar 2010 13:01:22 +0100
Message-ID: <4B963892.9020103@free.fr>
References: <1268083784.9018.20.camel@localhost.localdomain> <87eiju2v1u.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:48306 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab0CIMBd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 07:01:33 -0500
In-Reply-To: <87eiju2v1u.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>

Thank you very much for your review. I will try to explain why this=20
patch is so big (sorry for the inconvenience if I speak too much, and i=
f=20
I make too much mistakes, English is not my native speaking).

I first have to tell that I'm not a kernel hacker, but since December I=
=20
started working on my free time (and some time on my job time when my=20
PhD tutor allows me) on including multitouch in Xorg.

I recently bought a Magic Mouse in order to have a light weight=20
multitouch device to test.

The point is that when I used Michael's first version of hid-magicmouse=
=20
I faced some troubles:
- The first point was the kernel oops when disconnecting and closing th=
e=20
Xserver. It was really embarrassing as I had to restart often my Xserve=
r=20
in order to take the changes into account.
- The second point was that with input hotplugging activated, the=20
xserver saw two input device, one of them was not sending any events.
So I had a look at the source of the driver.

I first found the explanation of the second input device (not very=20
difficult to find though), and I did not understand why it was necessar=
y=20
as the driver already was creating one.

Then I also saw that contrary to the driver I saw before (hid-stantum=20
and hid-ntrig) the hid-magicmouse uses raw event instead of higher leve=
l=20
events. I thought it was not very clear (at least for me as I do not=20
speak very well bit fields) and I started to write a work-around.

The last point that was worrying me was the line (after the call of=20
hid_register_report):
'report->size =3D 6;'
The driver registered a new report, tells it has an arbitrary size (or=20
maybe not?) whereas it has no field initialized.

So I wrote first a big patch to avoid all the 'problems' listed above.
I did not send it immediately and I was a little bit overload at work.
However, when I saw that the driver had been included in the next branc=
h=20
of the kernel, I took time to work on the patch again. But, I only trie=
d=20
to tackle the problem of the second input device.

To sum up, the advantages of my patch are, I think, the following=20
(though I do not want to seem to be competing with Micheal):
- It's documenting the data the magic mouse sends as the mouse does not=
=20
send the descriptor.
- It will allow another patch to avoid the use of the raw events instea=
d=20
of high level events (don't know if it is really a benefit)

As Micheal said there are huge pitfalls:
- It heavy regards to its aim
- I insert fields into the descriptor that I use them later with a=20
slightly change in the meaning (some keywords are not well choose and=20
the whole meaning is split between the registering of the fields and th=
e=20
mapping)
- coding style (not really a problem though)
- raw events have the benefits of giving the number of touches into the=
=20
data size, something we don't have with high level events only.


Maybe a solution would just be to add a comment documenting the bit=20
fields in the data? (as now, most of the problems had been solved by th=
e=20
last patch of Michael)

Cheers,
Benjamin


Le 09/03/2010 01:33, Michael Poole a =E9crit :
> Benjamin Tissoires writes:
>
>[snip]
>> ---
>>   drivers/hid/hid-magicmouse.c |  198 ++++++++++++++++++++++++++++++=
++++++------
>>   1 files changed, 172 insertions(+), 26 deletions(-)
>
> This diffstat, compared to the functionality being added, says an awf=
ul
> lot about the approach (IMO).  What is the ongoing maintenance benefi=
t
> of writing fake report pseudo-descriptors only to translate them
> immediately?
>
> In a moment I'll send a much smaller patch that is similar to one of =
Ed
> Tomlinson's patches (unfortunately never provided with his
> Signed-Off-By), but which also avoids creating two input devices.
>
> There are numerous coding style violations in this version:
>
> [snip]
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
