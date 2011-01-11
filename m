From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: NVidia Multitouch driver.
Date: Tue, 11 Jan 2011 09:19:01 +0100
Message-ID: <4E2BEA6D-84DA-446B-A045-AD0748B1A910@enac.fr>
References: <AANLkTi=KQMrFR7rO=4gY=GX-aHo+sckA8nGrE-1A9rpe@mail.gmail.com>  <4D2BE29A.4060400@nvidia.com>  <AANLkTike5xYAMCJKd7Lh0i4op3Z4fRDUMAOx5-s==541@mail.gmail.com> <4D2BEDAD.5050604@nvidia.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:56660 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab1AKI3f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Jan 2011 03:29:35 -0500
In-Reply-To: <4D2BEDAD.5050604@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Varun Wadekar <vwadekar@nvidia.com>
Cc: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, USB list <linux-input@vger.kernel.org>, Harry Hong <hhong@nvidia.com>, Bharat Nihalani <bnihalani@nvidia.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@enac.fr>

Hi Ikbel, hi Varun,

Benjamin and I are actually working on an Android-specific version of =20
the multitouch drivers, until the time when Android (perhaps 3.0 =20
Honeycomb) uses multitouch Protocol B. If you give us more details =20
about this driver we might be able to combine our efforts.

Cheers,

St.



Le 11 janv. 11 =E0 06:42, Varun Wadekar a =E9crit :

> Got it. I will try to get these changes pushed upstream.
>
> Support for multiple fingers is completely touch panel driven. We hav=
e
> successfully verified
> than 10 fingers also work fine on Android with another touch panel.
>
> On Tuesday 11 January 2011 11:00 AM, Mohamed Ikbel Boulabiar wrote:
>> On Tue, Jan 11, 2011 at 5:54 AM, Varun Wadekar =20
>> <vwadekar@nvidia.com> wrote:
>>> Do you mean to say there are certain things missing in the touch =20
>>> driver?
>>> What do you mean by the last linux kernel?
>> I have found that patch by chance because I haven't seen it sent to
>> linux-input ml (which what is the std)
>> I just want it to get pushed to the mainline linux kernel as it is =20
>> the
>> upstream of all linux distributions and for the android linux kernel
>> tree itself.
>>
>> I just don't like to see only android getting drivers patches as it
>> can be seen as an action of forking the main kernel.
>>
>> You can rebase the patch to the last tree and get help and feedback
>> from other developers for its integration. Company support of its ow=
n
>> drivers is very appreciated here.
>>
>>
>> And when analyzing the code I got a question. Does the nvodm hw
>> supports only 2 fingers or it's only caused by android limitation ?
>> Can the hw report more than 2 fingers ? (4 for example)
>>
>> Thanks
>>
>> i
>
>
> ---------------------------------------------------------------------=
-=20
> -------------
> This email message is for the sole use of the intended recipient(s) =20
> and may contain
> confidential information.  Any unauthorized review, use, disclosure =20
> or distribution
> is prohibited.  If you are not the intended recipient, please =20
> contact the sender by
> reply email and destroy all copies of the original message.
> ---------------------------------------------------------------------=
-=20
> -------------

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
