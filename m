From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH v2] Input: wacom - fix touch on newer Bamboo's
Date: Sun, 11 Sep 2011 21:08:51 -0500
Message-ID: <CAGzDe_aqxwvv0Q0-SP8xsDOja6PdyWbTZKHFkn9vn_ihp47toA@mail.gmail.com>
References: <1315353406-8564-1-git-send-email-chris@cnpbagwell.com>
	<20110909204112.GB9157@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:52020 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab1ILCIw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Sep 2011 22:08:52 -0400
Received: by yie30 with SMTP id 30so2298684yie.19
        for <linux-input@vger.kernel.org>; Sun, 11 Sep 2011 19:08:52 -0700 (PDT)
In-Reply-To: <20110909204112.GB9157@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, rydberg@euromail.se

On Fri, Sep 9, 2011 at 3:41 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Sep 06, 2011 at 06:56:46PM -0500, chris@cnpbagwell.com wrote:
>> From: Chris Bagwell <chris@cnpbagwell.com>
>>
>> Bamboo's with Product ID's > 0xD4 return values unrelated to pressur=
e
>> in touch 1 pressure field. =A0They also report touch 2's X/Y values
>> shifted down 1 byte (where pressure was). =A0This results in jumpy
>> 1 finger touch and totally invalid 2nd finger data.
>>
>> For touch detection, switch to a Touch Present single bit that
>> all versions of Bamboo support.
>>
>> For touch 2 offset, calculate offset based on a bit that is set
>> different between the two packet layouts.
>>
>> Since touch pressure reports were removed from driver, there was
>> no need to be reading pressure any more.
>>
>> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
>> Reviewed-by: Ping Cheng <pinglinux@gmail.com>
>
> Applied, thanks Chris.
>

I'm sorry, Dmitry, but I messed up this version #2 of patch.  Can you
please revert or hand fix?

+               touch =3D touch && wacom->shared->stylus_in_proximity;

Somewhere along the line, I lost a "!" on that stylus_in_proximity
check.  So this v2 patch breaks touch support.

If you revert, I am planning on submitting 2 or 3 new wacom clean up
patches in next week.  I can resend with that batch.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
