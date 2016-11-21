From: Emmanuel Deloget <logout@free.fr>
Subject: Re: Suppression of touchscreen driver ft6326
Date: Mon, 21 Nov 2016 11:18:39 +0100
Message-ID: <CAKh=nwHeYNJOSkCJ__gcTEBPU_phOv0b4wk57OxF65zcSMbhHA@mail.gmail.com>
References: <CAKh=nwFgPE=6WNys9FWefftcNrgAeXCSEDj-facvYc6_pb6WjA@mail.gmail.com>
 <cda0c432-69ba-3709-2c25-2e99a6cc3273@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35165 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbcKUKSl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 21 Nov 2016 05:18:41 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so25685873wme.2
        for <linux-input@vger.kernel.org>; Mon, 21 Nov 2016 02:18:41 -0800 (PST)
In-Reply-To: <cda0c432-69ba-3709-2c25-2e99a6cc3273@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hello,

On Mon, Nov 21, 2016 at 11:08 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 21-11-16 11:05, Emmanuel Deloget wrote:
>>
>> Hello,
>>
>> I've seen that the 4.9-rc0 pull request for the input submodule [1] was
>> removing the ft6326 driver (the edt-ft5x06 driver is supposed to be
>> equivalent).
>>
>> Yet, there are some small things (that I happen to use, unfortunately)
>> that are not handled neither by the touchscreen API nor by the new driver,
>> namely the OF properties touchscreen-inverted-x, touchscreen-inverted-y and
>> touchscreen-swapped-x-y. These are really helpfull when you deal with
>> strange screen orientation.
>>
>> Is there a plan to implement these before the release of 4.9 (in order to
>> make the new driver a full equivalent of the removed one) ?
>
>
> What makes you think that the edt-ft5x06 driver does not take
> touchscreen-inverted-x and friends into account ?
>
> That has been fixed quite a while ago, it uses the new
> touchscreen_parse_properties() and touchscreen_report_pos()
> helper functions which take these into account.

My bad. I was looking at 2 different kernel trees - the 4.9-rc and a
4.4 (which lacks the -inverted-* properties).

Sorry for the question and the wasted time.

> Please give it a try, it should work.
>
> Regards,
>
> Hans

Regards,

-- Emmanuel Deloget
