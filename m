From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 0/8] multitouch updates (mainly eGalax)
Date: Wed, 23 Nov 2011 14:14:01 +0100
Message-ID: <CAN+gG=F5-abvwAC9qE7KAkCe-49NsQgqiue++OdNx1Bq4WUOEQ@mail.gmail.com>
References: <1322042074-3759-1-git-send-email-benjamin.tissoires@enac.fr>
	<alpine.LNX.2.00.1111231348020.28728@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53339 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab1KWNOD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 08:14:03 -0500
In-Reply-To: <alpine.LNX.2.00.1111231348020.28728@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 23, 2011 at 13:49, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 23 Nov 2011, Benjamin Tissoires wrote:
>
>> Here are some multitouch updates.
>> Jiri, the first one is already in your upstream-fixes branch, but no=
t in
>> your for-next branch...
>
> Hi Benjamin,
>
> yes, that is intentional. 'upstream-fixes' branch is what is schedule=
d to
> be sent to Linus still during this development cycle (and therefore i=
s not
> for linux-next).
>
> Other branches get merged into linux-next, as they are scheduled for =
next
> merge window.
>
>> Patch 0002 will help end-users to test their device without recompil=
ing the
>> hid-multitouch between each test.
>>
>> Patches 0003-0008 are focused on eGalax:
>> * I made some cleanup in the #defines for the PIDS.
>> * I removed the MT_QUIRK_EGALAX_XYZ_FIXUP as I understood why it was=
 needed
>> * I also removed the .maxcontact field in EGALAX as it is not necess=
ary
>> =A0 (it was tested on 3 devices: Acer Iconia W500 by Marek, 0xa001 b=
y Cedric,
>> =A0 =A0and Windpad 110W by me)
>> * I added a few new devices (I included the one reported by Marek an=
d I kept
>> =A0 his "From")
>> * I included the new protocol for a001 devices (reported by Cedric)
>
> I will be queueing all those for 3.3, okay?

I'm ok with that.

Thanks a lot,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
