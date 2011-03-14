From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 0/4] Migrations to hid-multitouch, round 2
Date: Mon, 14 Mar 2011 14:10:19 +0100
Message-ID: <AANLkTiko4z7SJmObKsVCMHeqR2iAYdQ_j-aOhZWjssJ3@mail.gmail.com>
References: <1299686450-5475-1-git-send-email-benjamin.tissoires@enac.fr>
	<alpine.LNX.2.00.1103141307590.19969@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1103141307590.19969@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Mar 14, 2011 at 13:08, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 9 Mar 2011, Benjamin Tissoires wrote:
>
>> Hi guys,
>>
>> This is the second version for this patch series.
>>
>> Since last time, I integrated Henrik's comments.
>>
>> Cheers,
>> Benjamin
>>
>> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 21 +---
>> =A0drivers/hid/Makefile =A0 =A0 =A0 =A0 | =A0 =A03 -
>> =A0drivers/hid/hid-3m-pct.c =A0 =A0 | =A0305 -----------------------=
-------------------
>> =A0drivers/hid/hid-cando.c =A0 =A0 =A0| =A0276 ---------------------=
-----------------
>> =A0drivers/hid/hid-multitouch.c | =A0110 +++++++++++++---
>> =A0drivers/hid/hid-stantum.c =A0 =A0| =A0286 -----------------------=
----------------
>> =A06 files changed, 97 insertions(+), 904 deletions(-)
>>
>> ;-)
>
> Hi Benjamin,
>
> thanks a lot for this work you have done.
>
> Is there going to be second round of the patches with a few minor fix=
es
> coming out from Henrik's review?
>
> Thanks,

Hi Jiri,

yes of course. I don't know if I'll have the time to do it today, but
I'll do my best.

Cheers,
Benjamin

>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
>
