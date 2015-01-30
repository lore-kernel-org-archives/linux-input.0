From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 4/5] Input: synaptics - Skip quirks when post-2013
 dimensions
Date: Fri, 30 Jan 2015 10:59:30 +0100
Message-ID: <54CB5602.5050807@redhat.com>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>	<1422347645-5194-1-git-send-email-daniel.martin@secunet.com>	<1422347645-5194-5-git-send-email-daniel.martin@secunet.com>	<CAN+gG=HgJr6T3cTewx0=vVGmhS0SfufjtaU97fe+kCmharvZXA@mail.gmail.com> <CAN+gG=H6N+F=05qaVmrXGe=eXe1GgRZxNaiQckQXEWmKM40VOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42869 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760800AbbA3J7i (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2015 04:59:38 -0500
In-Reply-To: <CAN+gG=H6N+F=05qaVmrXGe=eXe1GgRZxNaiQckQXEWmKM40VOg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Daniel Martin <consume.noise@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Peter Hutterer <peter.hutterer@who-t.net>

Hi,

On 01/29/2015 08:50 PM, Benjamin Tissoires wrote:
> On Thu, Jan 29, 2015 at 2:02 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> Hi Daniel,
>>
>> On Tue, Jan 27, 2015 at 3:34 AM, Daniel Martin
>> <daniel.martin@secunet.com> wrote:
>>> From: Daniel Martin <consume.noise@gmail.com>
>>>
>>> If we queried min/max dimensions of x [1266..5674], y [1170..4684] we
>>> have post-2013 model and don't need to apply any quirk.
>>>
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541
>>> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
>>> ---
>>>  drivers/input/mouse/synaptics.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
>>> index 37d4dff..f6c43ff 100644
>>> --- a/drivers/input/mouse/synaptics.c
>>> +++ b/drivers/input/mouse/synaptics.c
>>> @@ -420,6 +420,11 @@ static int synaptics_quirks(struct psmouse *psmouse)
>>>         struct synaptics_data *priv = psmouse->private;
>>>         int i;
>>>
>>> +       /* Post-2013 models expose correct dimensions. */
>>> +       if (priv->x_min == 1266 && priv->x_max == 5674 &&
>>> +           priv->y_min == 1170 && priv->y_max == 4684)
>>> +               return 0;
>>> +
>>
>> Well, this one, I don't like it either :(
>>
>> At least, the test should be within the psmouse_matches_pnp_id() below
>> to ensure we are deciding with Lenovo devices only.
>>
>> The other concern is hardcoding these values in the code directly.
>> What if Synaptics/Lenovo decides to ship a new released model with
>> proper min_max ranges but with a different offset?
>>
>> Andrew told us that the board ID should be enough to discriminate old
>> and faulty touchpads from the new and valid touchpads.
>>
>> My concern here is that we will have to backport these changes in the
>> various stable kernel and the various distributions. And if we do not
>> end up with the right solution right now, that means that we will have
>> to do the job over and over.
>>
>> I am quite tempted to find a solution in the userspace for that fix.
>> Not sure I'll be able to find the right one right now, but it may
>> worth trying.
>>
> 
> So, the user space solution seems difficult because we do not export
> either the board_id or the firmware_id. So that would required to
> update the kernel anyway, a bunch of user space tools and a hwdb... :(
> 
> How about we just add an extra min/max in struct min_max_quirk,
> compare the current min/max with the 2 possible values and if there is
> a match, we do not override the values.
> This way, we keep the crap of wrong/correct min max in the small list
> of device we know are problematic, and if the new batch of E540 has a
> different correct min/max range, then we will be able to adjust it
> without breaking the other we fixed.
> 
> Dmitry, Hans, any comments on this?

I'm thinking more along the lines of adding a max_broken_board_id field
to the quirks, and if the touchpad board_id is larger then the
max_broken_board_id not use the quirk.

Regards,

Hans
