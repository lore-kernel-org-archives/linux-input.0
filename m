From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Fixed missing inits in hid-cando.c
Date: Mon, 19 Apr 2010 13:38:46 +0200
Message-ID: <5E80D4D5-2CDD-4A85-BD21-0516DE566DC6@enac.fr>
References: <20100416202358.7839695164@smtp.lii-enac.fr> <alpine.LNX.2.00.1004191320210.7579@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:53764 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab0DSLiw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Apr 2010 07:38:52 -0400
In-Reply-To: <alpine.LNX.2.00.1004191320210.7579@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Priya Vijayan <priya.vijayan@intel.com>, Florian Echtler <floe@butterbrot.org>


Le 19 avr. 10 =E0 13:20, Jiri Kosina a =E9crit :

> On Fri, 16 Apr 2010, Stephane Chatty wrote:
>
>> With flags non initialized, the single touch emulation has an errati=
c
>> behavior. Fixed this.
>>
>> Signed-off-by: Stephane Chatty
>
> I have made this to actually be
>
> 	Signed-off-by: Stephane Chatty <chatty@lii-enac.fr>
>
> and applied. Please let me know if this is wrong.

Oops, sorry. I usually prefer chatty@enac.fr, but don't bother.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
