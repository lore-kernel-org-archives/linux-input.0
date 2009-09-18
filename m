From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: make the CtrlR and CtrlL modifier output different keys
Date: Fri, 18 Sep 2009 14:46:19 +0800
Message-ID: <4AB32CBB.9050805@gmail.com>
References: <4AB316ED.80005@gmail.com> <20090918061017.GE18668@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:18817 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbZIRGqW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 02:46:22 -0400
Received: by an-out-0708.google.com with SMTP id d40so1256983and.1
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2009 23:46:26 -0700 (PDT)
In-Reply-To: <20090918061017.GE18668@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Fri, Sep 18, 2009 at 01:13:17PM +0800, Xiangfu Liu wrote:
>> Hi.
>>
>> I want make the CtrlR and CtrlL output different keys.
>> like:
>>
>> CtrlR + U =3D 7
>> CtrlR + U =3D Control + U.
>>
>> so I=E3=80=80modify the keyboard.c code. attach is the code.
>>
>> give me some feedback about this patch.
>> thanks.
>=20
> You should be able to do what you want by loading proper keymap; no n=
eed
> to adjust the keyboard code (especially in a way that does not make
> sense for other devices).
>=20
yes. I saw your last email. it's work on. I revert the code in our kern=
el
repos. thanks again.

Best Regards
--=20
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
