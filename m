From: Benjamin Tissoires <tissoire@cena.fr>
Subject: Re: [PATCH 2/3] HID: suppress the second input for the Apple Magic
 Mouse.
Date: Mon, 15 Mar 2010 19:47:40 +0100
Message-ID: <4B9E80CC.9030906@cena.fr>
References: <1268083784.9018.20.camel@localhost.localdomain>	<87eiju2v1u.fsf@troilus.org> <4B963892.9020103@free.fr> <87bpex1w5o.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hilar.cena.fr ([195.83.98.1]:55490 "EHLO hilar.tls.cena.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932739Ab0COSro (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Mar 2010 14:47:44 -0400
In-Reply-To: <87bpex1w5o.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>

Hello Mickael, sorry for taking so long to respond.

Here is what I get from my very poor experience in hid hacking.

Le 09/03/2010 14:06, Michael Poole a =E9crit :
> Rantanplan<rantanplanlechien@free.fr>  writes:
>
> [snip]
>   =20
>> Then I also saw that contrary to the driver I saw before (hid-stantu=
m
>> and hid-ntrig) the hid-magicmouse uses raw event instead of higher
>> level events. I thought it was not very clear (at least for me as I =
do
>> not speak very well bit fields) and I started to write a work-around=
=2E
>>     =20
> That was mostly a code compactness issue: It was not clear to me how =
to
> generate an appropriate set of field descriptors for the multi-touch
> records, but it looked like it would not be easy.  It is still not cl=
ear
> to me -- from hid-ntrig, hid-stantum, hid-core and your patch -- how =
a
> variable-length report from the device gets translated to multiple
> events for the touch fields.  (The key words there are "to me": I am
> probably overlooking something.)
>   =20

The previous test I made for the magic mouse (and that was working, tho=
ugh not the way you want I think) was the following: injecting the most=
 of the data I may receive.
To sum up, in our case:
- I injected in the field descriptor the values of the relatives axes (=
as I made in the patch I nearly submitted yesterday)
- Then I injected the first multitouch data by incrementing the collect=
ion by 1
- Then I repeated the injection of the other multitouch data, still inc=
reasing the collection by one (to have 5 mmultitouch collections at the=
 end)

When it came to sending the events, if the data do not contain all the =
collections (only one touch for instance), hid calls all the events dec=
lared in the report with 0 as values.
It is working, as it sends in the order relatives axes and then multito=
uch, but is not very satisfactory as it implies some head over as funct=
ions are called when they should not.

I don't know if the protocol used by the magic mouse is standard, in a =
sense that the stantum always gives all the data it registers.


> The other notable part of using raw events is that the middle-button
> emulation requires watching button state in both the standard mouse
> report and the multi-touch report.  Matching button-down and -up even=
ts
> may be sent in different report types.
>   =20

If you keep a structure to store the events, it should not be a problem=
=2E
Moreover, when using hid to process event, you have only one function f=
or all the report types, thus, you won't miss any button-up -down.


>> The last point that was worrying me was the line (after the call of
>> hid_register_report):
>> 'report->size =3D 6;'
>> The driver registered a new report, tells it has an arbitrary size (=
or
>> maybe not?) whereas it has no field initialized.
>>     =20
> Six bytes is the minimum length of the touch report -- although now t=
hat
> I look at it, report->size was meant to count bits.  (I am not sure w=
hy
> the mouse sometimes decides to send a report with zero touches rather
> than the standard mouse report, but it does.)
>
>   =20
>> So I wrote first a big patch to avoid all the 'problems' listed abov=
e.
>> I did not send it immediately and I was a little bit overload at wor=
k.
>> However, when I saw that the driver had been included in the next
>> branch of the kernel, I took time to work on the patch again. But, I
>> only tried to tackle the problem of the second input device.
>>
>> To sum up, the advantages of my patch are, I think, the following
>> (though I do not want to seem to be competing with Micheal):
>> - It's documenting the data the magic mouse sends as the mouse does
>> not send the descriptor.
>> - It will allow another patch to avoid the use of the raw events
>> instead of high level events (don't know if it is really a benefit)
>>
>> As Micheal said there are huge pitfalls:
>> - It heavy regards to its aim
>> - I insert fields into the descriptor that I use them later with a
>> slightly change in the meaning (some keywords are not well choose an=
d
>> the whole meaning is split between the registering of the fields and
>> the mapping)
>> - coding style (not really a problem though)
>> - raw events have the benefits of giving the number of touches into
>> the data size, something we don't have with high level events only.
>>
>>
>> Maybe a solution would just be to add a comment documenting the bit
>> fields in the data? (as now, most of the problems had been solved by
>> the last patch of Michael)
>>     =20
> To what end?  User space should see the same data from either approac=
h.
> In the kernel, the decoding of the multi-touch reports is in five lin=
es
> near the top of magicmouse_emit_touch() and five to seven lines in
> magicmouse_raw_event()'s case TOUCH_REPORT_ID.  There are ten known
> fields (X, Y, buttons, and six touch fields) in the data, so it seems
> hard to do better than ten (sane) lines.  Using some other descriptio=
n
> may be easier to find, but I'm not sure it will be much clearer.
>
> Michael
>   =20
I just intended a comment above the functions, written with a sort of a=
scii art, to explicit the definition of the data. But maybe I'm just no=
t enough skilled in bit-fields.

Benjamin

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
