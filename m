From: Amit Nagal <helloin.amit@gmail.com>
Subject: Re: list not released in case of -ENODEV in hidraw_release (hidraw.c)
Date: Wed, 27 Jul 2011 09:33:51 +0530
Message-ID: <CA+F9FsDP3u9fe4HW8RSay_2Zxq_GJwrg2FLE74AJWCVjPMEtVQ@mail.gmail.com>
References: <BANLkTi=Teg9iN8osSDY9fqadZ+sA-Ng2Sw@mail.gmail.com>
	<BANLkTikJfc_ZNG6LudKupUULqK+pN93MLg@mail.gmail.com>
	<alpine.LNX.2.00.1107221635550.7300@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48104 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab1G0EDw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jul 2011 00:03:52 -0400
In-Reply-To: <alpine.LNX.2.00.1107221635550.7300@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Alan Ott <alan@signal11.us>, Antonio Ospite <ospite@studenti.unina.it>

On Fri, Jul 22, 2011 at 8:06 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 22 Jun 2011, Amit Nagal wrote:
>
>> > linux kernel ver 2.6.39.1 =A0, =A0hidraw.c =A0, in =A0hidraw_relea=
se function
>> > , list pointer ( struct hidraw_list *list ) is not freed
>> > in case of -ENODEV .
>> >
>> > i think the following patch is applicable :
>> >
>> > --- a/drivers/hid/hidraw.c =A0 =A0 =A02011-06-22 08:57:55.00000000=
0 -0400
>> > +++ b/drivers/hid/hidraw.c =A0 =A0 =A02011-06-22 08:42:04.00000000=
0 -0400
>> > @@ -298,6 +298,7 @@ static int hidraw_release(struct inode *
>> >
>> > =A0 =A0 =A0 =A0mutex_lock(&minors_lock);
>> > =A0 =A0 =A0 =A0if (!hidraw_table[minor]) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(list);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENODEV;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unlock;
>> > =A0 =A0 =A0 =A0}
>> >
>> > Please correct me if i am mistaken .
>> >
>>
>> In continuation of above , in hidraw_release(), for the sequence
>> disconnect =A0followed by last userspace close(fd) call ,
>> even kfree(list->hidraw) should also be called , as in
>> hidraw_disconnect() function kfree(hidraw) is called only when
>> hidraw->open is 0 .
>> so list->hidraw should also be freed when calling last close() call
>> even after disconnect .
>
> Hi Amit,
>
> your analysis is correct. Could you please re-send the patch with the
> other fixes added, and also your Signed-off-by line?
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>


Thanx for reviewing my analysis . i will resubmit the patch after
adding other fixes as well .

Regards
Amit Nagal
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
