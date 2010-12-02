From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] input: misc: add lps001wp_prs driver
Date: Thu, 02 Dec 2010 19:41:35 +0000
Message-ID: <4CF7F66F.70808@cam.ac.uk>
References: <matteo.dameno@st.com> <1291049009-32597-1-git-send-email-matteo.dameno@st.com> <20101130060926.GA31838@core.coreip.homeip.net> <AANLkTikpVtq2cQVhhcsJhZwGFW74mTqo=-vVK1e50AC2@mail.gmail.com> <9BF90A6D61BF154E973D03082989295CA22B3F7E95@SAFEX1MAIL3.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:48489 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091Ab0LBTfE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Dec 2010 14:35:04 -0500
In-Reply-To: <9BF90A6D61BF154E973D03082989295CA22B3F7E95@SAFEX1MAIL3.st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matteo DAMENO <matteo.dameno@st.com>
Cc: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, mems applications <mems.applications@st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Carmine IASCONE <carmine.iascone@st.com>, Greg KH <gregkh@suse.de>, Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>

Sorry for my lack of response earlier in this thread. Looks
like my linux-input subscription has died for some reason so
I hadn't seen it until someone kindly cc'd me.

>> -----Original Message-----
>> From: Mohamed Ikbel Boulabiar [mailto:boulabiar@gmail.com]
>> Sent: Tuesday, November 30, 2010 11:35 AM
>> To: Dmitry Torokhov
>> Cc: mems applications; linux-input@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Matteo DAMENO; Carmine IASCONE; mems
>> Subject: Re: [PATCH] input: misc: add lps001wp_prs driver
>>
>> On Tue, Nov 30, 2010 at 7:09 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>>> +      If you say yes here you get support for the
>>>> +      STM LPS001D Barometer/Termometer on I2C bus.
>>>
>>> This does not belong to input subsystem, IIO is a better fit.
>>
>> According to this site:
>> http://www.cnbc.com/id/40413317
>> and its datasheet:
>> http://www.findmems.com/wp-content/uploads/2010/11/LPS001WP-
>> DATASHEET.pdf
>>
>> This sensors applications are:
>> =E2=96=A0 Altimeter and barometer for portable devices
>> =E2=96=A0 Smartphones
>> =E2=96=A0 Indoor navigation
>> =E2=96=A0 GPS applications
>> =E2=96=A0 Weather station equipment
>> =E2=96=A0 Sports watches
>>
>> "the same devices would be able to identify the precise location in
>> all three dimensions, allowing, for example, a mobile phone to send =
a
>> call to an emergency fire, medical or police service that identified
>> not only the location of the building but also the particular floor.=
"
>> Identifying 3d location is similar to what many joystick are doing.
>>
>> Specially the indoor navigation information means an information abo=
ut
>> the user. And the information is very tied to the user.
>> I don't know whether this can be used to map with virtual reality in=
 a
>> game, or where you use sensors data to give user informations when
>> visiting a museum.
>>
>>
>> Dmitry, is it possible to start putting similar drivers in a new
>> drivers/input/sensors directory but which belongs to the input
>> subsystem ? What do you think ?
>>
>=20
> We agree with you.
> It would be a good idea.
> We are working on many device drivers that are matching your descript=
ion and
> we are ready to submit them.
>=20
> We are disoriented because every maintainer seems to bounce our submi=
ssions
> because of inappropriate position for the device.
>=20
> IIO, input/misc, I2C (we didn't submit here because of deprecation st=
ated in
> Documentation).
> Some one is also submitting our drivers with modifications=20
> under Hwmon...
If it's out of scope they are wasting their time so it will bounce anyw=
ay.
Hwmon is now actively (very well) maintained so inappropriate drivers w=
ill
get a reply quickly. (and if you are talking about the combined magneto=
meter
and accelerometer driver submitted the other day, it already has!)

Note the big lis3* driver in there is getting kicked out to drivers/mis=
c asap.
No one seems quite sure why it went in there in the first place and it =
has been
causing confusion ever since!  The presence of that driver is the main =
reason
people new to these devices tend to think they should be in hwmon in th=
e first
place. (cc'd Guenter and Jean for their information)=20
>=20
> What to do?
This is well within the scope of IIO, so we will be more than happy to =
take
the driver and assist with any issues etc caused by the move. The other=
 existing
option is to put it in drivers/misc and wait for IIO to move out of sta=
ging
or something else to come along. There are a few sensor drivers already=
 there
for exactly that reason.

Disadvantages of MISC:
* Not a coherent location for drivers.  Whether things match in abi etc
is more fluid and relies on a few people shouting when new drivers arri=
ve.

Disadvantages of IIO:
* User space interfaces aren't guaranteed to be stable. However, if you=
 notify
us that they need to be for a particular device we will support the cur=
rent ones
for a suitable period (and provide any new ones alongside).  Basically,=
 it's
taking a while to get the interfaces right though (except for new stuff=
) I think
we are pretty close.
* Kernel abi's probably change more than in the majority of the kernel.
This isn't a problem if you are in tree though as we will obviously upd=
ate the
driver in sync with the changes.
* One or two core elements are in need of work (the buffering code need=
s an
easier to review implementation and the input bridge, in userspace need=
s
some actual work beyond a proof of concept).

Conversely we have more flexibility to change things as and when we dis=
cover
we got a decision wrong.  We have quite a lot of drivers so working
on unifying interfaces is becoming easier all the time.  It's Direct
Digital Synthesis (DDS) chips this week ;)  No merged altimeter drivers
yet though so there will probably be some new abi elements to pin down.

Personally I don't really mind where drivers are physically located, ju=
st that
we use consistent interfaces to user space where ever possible.  The lo=
cation
is easy to change (as it's controlled more or less by kernel developers=
),
the interfaces less so as userspace applications depend on them.

Nice looking device by the way. I'll take a look at the driver shortly
(can do a lot of review independent of the subsystem it is going in).

Thanks,

Jonathan
>=20
> Matteo Dameno
>=20
>>
>> i

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
