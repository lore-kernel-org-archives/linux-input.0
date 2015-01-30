From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 3/5] Input: synaptics - Query min dimensions when safe
 firmware
Date: Fri, 30 Jan 2015 10:03:06 +0100
Message-ID: <54CB48CA.60204@redhat.com>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>	<1422347645-5194-1-git-send-email-daniel.martin@secunet.com>	<1422347645-5194-4-git-send-email-daniel.martin@secunet.com> <CAN+gG=FqhKf1khX4bhtpsRAm2x62LP1PwkFkGFmu32TBMCd7yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33052 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbbA3JDQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2015 04:03:16 -0500
In-Reply-To: <CAN+gG=FqhKf1khX4bhtpsRAm2x62LP1PwkFkGFmu32TBMCd7yA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Daniel Martin <consume.noise@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>

Hi,

On 01/29/2015 07:48 PM, Benjamin Tissoires wrote:
> Hi Daniel,
> 
> in one hand I would like to see that upstream ASAP. But on the other
> hand, I have some concerns here and there regarding this series.
> 
> On Tue, Jan 27, 2015 at 3:34 AM, Daniel Martin
> <daniel.martin@secunet.com> wrote:
>> From: Daniel Martin <consume.noise@gmail.com>
>>
>> Query the min dimensions even if the check
>>     SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7
>> fails, but we know that the firmware version is safe. Atm. this is
>> version 8.1 only.
>>
>> With that we don't need quirks for post-2013 models anymore as they
>> expose correct min and max dimensions.
>>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541
>> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
>> ---
>>  drivers/input/mouse/synaptics.c | 27 ++++++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
>> index 7a78d75..37d4dff 100644
>> --- a/drivers/input/mouse/synaptics.c
>> +++ b/drivers/input/mouse/synaptics.c
>> @@ -333,6 +333,30 @@ static int synaptics_identify(struct psmouse *psmouse)
>>         return -1;
>>  }
>>
>> +struct fw_version {
>> +       unsigned char major;
>> +       unsigned char minor;
>> +};
>> +
>> +static const struct fw_version safe_fw_list[] = {
>> +       {8, 1}, /* safe for SYN_QUE_EXT_MIN_COORDS */
>> +       { }
>> +};
>> +
>> +static bool synaptics_is_safe_fw(struct psmouse *psmouse)
>> +{
>> +       struct synaptics_data *priv = psmouse->private;
>> +       int i;
>> +
>> +       for (i = 0; safe_fw_list[i].major; i++) {
>> +               if (safe_fw_list[i].major == SYN_ID_MAJOR(priv->identity) &&
>> +                   safe_fw_list[i].minor == SYN_ID_MINOR(priv->identity))
>> +                       return true;
>> +       }
>> +
>> +       return false;
>> +}
> 
> This seems a little bit too much for just one firmware ID.
> Plus the name safe_fw_list gives hope that this list can be used for
> something else later, but then it may conflict with it current
> purpose.
> 
> How about we just rely on the current list of PNPIDs we already have
> for this generation?
> This might not be a good idea either, so an other solution would be to
> directly check for firmware 8.1 in the test below.
> 
> I'd like to hear other opinions on this however before we commit to a decision.

I think that checking the firmware version, rather then relying on pnp-ids, is
the right thing to do, this e.g. also gives us more accurate min/max values
on the x230 / t430 series.

As for using the list, rather then just the one id, I'm fine either way, the list
is more future proof, which is why I acked this patch as is. But we could go
with just a check for the single version now and extend this later if needed.

Regards,

Hans


> 
> 
> Cheers,
> Benjamin
> 
> PS: I think Hans already mentioned, but if you want your patches to
> land in Dmitry's tree, it's better to CC him directly when submitting
> a patch.
> 
>> +
>>  /*
>>   * Read touchpad resolution and maximum reported coordinates
>>   * Resolution is left zero if touchpad does not support the query
>> @@ -368,7 +392,8 @@ static int synaptics_resolution(struct psmouse *psmouse)
>>                 }
>>         }
>>
>> -       if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 &&
>> +       if ((SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 ||
>> +            synaptics_is_safe_fw(psmouse)) &&
>>             SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c)) {
>>                 if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MIN_COORDS, resp)) {
>>                         psmouse_warn(psmouse,
>> --
>> 2.2.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
