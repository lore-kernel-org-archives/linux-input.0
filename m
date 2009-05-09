From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: atkbd.c: Unknown key pressed/released
Date: Sat, 9 May 2009 06:47:18 -0700
Message-ID: <200905090647.18887.dmitry.torokhov@gmail.com>
References: <4A052446.6080906@freemail.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:5852 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbZEINrZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 May 2009 09:47:25 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1573833rvb.1
        for <linux-input@vger.kernel.org>; Sat, 09 May 2009 06:47:25 -0700 (PDT)
In-Reply-To: <4A052446.6080906@freemail.hu>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-15?q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: linux-input@vger.kernel.org

On Friday 08 May 2009 23:35:50 N=E9meth M=E1rton wrote:
> Hi,
>
> I have a Clevo D410J laptop (see dmidecode output attached). When I p=
ress
> the "Application Launch" special key I get the following message in d=
mesg:
>
> [   60.865561] atkbd.c: Unknown key pressed (translated set 2, code 0=
x81 on
> isa0060/serio0). [   60.865574] atkbd.c: Use 'setkeycodes e001 <keyco=
de>'
> to make it known. [   60.967948] atkbd.c: Unknown key released (trans=
lated
> set 2, code 0x81 on isa0060/serio0). [   60.967962] atkbd.c: Use
> 'setkeycodes e001 <keycode>' to make it known.
>
> Is it possible to add support for the "Application Launch" key direct=
ly
> in the kernel? I am currently running Linux kernel 2.6.30-rc5.
>

This should be done in HAL, not in kernel. Please see here:

	http://people.freedesktop.org/~hughsient/quirk/

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
