From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Added support for the Cando dual touch panel
Date: Thu, 15 Apr 2010 19:46:45 +0200
Message-ID: <CBC9CC4A-A2F6-4580-8AA4-7ECB290959CD@enac.fr>
References: <20100414190341.25BD8951EF@smtp.lii-enac.fr> <1271348935.4941.68.camel@flunder>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:45270 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab0DORqw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Apr 2010 13:46:52 -0400
In-Reply-To: <1271348935.4941.68.camel@flunder>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Priya Vijayan <priya.vijayan@intel.com>


Le 15 avr. 10 =E0 18:28, Florian Echtler a =E9crit :


> Hello Stephane,
>
> I see you didn't use HID_CONNECT_HIDINPUT_FORCE after all.
> Was that intentional?
>
>

Yes, it was. In 2.6.34, IS_INPUT_APPLICATION is updated (it's a patch =20
I submitted back in January) so there's no need for the flag.

If I had known about this flag before I would not have bothered with =20
IS_INPUT_APPLICATION and it would have been simpler for everybody. =20
But the harm was done and there already are 4 or 5 drivers around =20
working this way, so I sticked to the same pattern.

But I'll definitely use the flag for other drivers with strange =20
Application usages I'm working on :-)

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
