From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/3] input: alps: For protocol V3, do not process data
 when last packet's bit7 is set
Date: Fri, 03 Oct 2014 12:01:43 +0200
Message-ID: <542E7407.2040500@redhat.com>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com> <1412329392-5580-3-git-send-email-pali.rohar@gmail.com> <542E719A.8030509@redhat.com> <201410031158.02134@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbaJCKB5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Oct 2014 06:01:57 -0400
In-Reply-To: <201410031158.02134@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 10/03/2014 11:58 AM, Pali Roh=C3=A1r wrote:
> On Friday 03 October 2014 11:51:22 Hans de Goede wrote:
>> Hi,
>>
>> On 10/03/2014 11:43 AM, Pali Roh=C3=A1r wrote:
>>> Sometimes laptops with closed lid receive invalid ALPS
>>> protocol V3 packets with last bit7 set.
>>>
>>> This happens on Dell Latitude laptops and it looks like it
>>> is BIOS bug. Probably EC does not correctly split keyboard
>>> and touchpad PS/2 data and when laptop lid is closed it
>>> adds 0xFF packet into touchpad PS/2 data.
>>>
>>> When last packet's bit7 is set it is invalid ALPS packet. So
>>> Do not process it and drop it with PSMOUSE_FULL_PACKET.
>>>
>>> After testing it looks like this patch fixed problem with
>>> reseting mouse (after series of invalid packets) when
>>> laptop lid is closed on Dell Latitude machines.
>>>
>>> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>>> Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>>> ---
>>>
>>>  drivers/input/mouse/alps.c |   10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/input/mouse/alps.c
>>> b/drivers/input/mouse/alps.c index 1bd5aa1..b1f44d4 100644
>>> --- a/drivers/input/mouse/alps.c
>>> +++ b/drivers/input/mouse/alps.c
>>> @@ -1179,6 +1179,16 @@ static psmouse_ret_t
>>> alps_process_byte(struct psmouse *psmouse)
>>>
>>>  		return PSMOUSE_BAD_DATA;
>>>  =09
>>>  	}
>>>
>>> +	if (priv->proto_version =3D=3D ALPS_PROTO_V3 &&
>>> psmouse->pktcnt =3D=3D psmouse->pktsize) { +		// For protocol
>>> V3, do not process data when last packet's bit7 is set
>>> +		if (psmouse->packet[psmouse->pktcnt - 1] & 0x80) {
>>> +			psmouse_dbg(psmouse, "v3 discard packet[%i] =3D=20
> %x\n",
>>> +				    psmouse->pktcnt - 1,
>>> +				    psmouse->packet[psmouse->pktcnt - 1]);
>>> +			return PSMOUSE_FULL_PACKET;
>>> +		}
>>> +	}
>>> +
>>
>> I wonder if this should not be PSMOUSE_BAD_DATA as a return
>> value ? I realize that with the 3th patch in place, that will
>> cause an immediate reset, but if your theory is right that
>> this ff gets inserted from the keyboard ps/2 stream, then we
>> actually want a full reset as otherwise we will be out of
>> sync then.
>>
>=20
> We really do not know what is root cause of this problem.=20
> Probably it is BIOS/EC/firmware/... but it could be something=20
> other too.
>=20
> On my laptop - Dell Latitude E6440 - I'm getting these invalid=20
> packets when I close LID. And they are generated too many (lot of=20
> per second). When PSMOUSE_FULL_PACKET is returned then no driver=20
> does not reset touchpad. With PSMOUSE_BAD_DATA psmouse decide=20
> that it needs reset and with 3rd patch psmouse could try to reset=20
> device too many times... So I think PSMOUSE_FULL_PACKET is better=20
> here. And having dmesg log full of device resets is probably not=20
> good too when laptop lid is closed.

Ok, then lets stick with PSMOUSE_FULL_PACKET.

So this patch also is:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Can you please do a v2, with the following tags added to the
commit messages ? :

- Cc: stable@vger.kernel.org
- Acked-by: Hans de Goede <hdegoede@redhat.com>
- Bug: ... for the relevant bugs

Thanks & Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
