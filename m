From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [PATCH] Input: ADP5589 - new driver for
 I2C Keypad Decoder and I/O Expander
Date: Wed, 23 Mar 2011 14:32:39 -0400
Message-ID: <AANLkTi=qx+rcsLQDmY0crma+dAdaOrNxd2QcmSSusjKE@mail.gmail.com>
References: <1300896316-15391-1-git-send-email-vapier@gentoo.org> <4D8A3B52.4000409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44899 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab1CWSdA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Mar 2011 14:33:00 -0400
Received: by fxm17 with SMTP id 17so7604884fxm.19
        for <linux-input@vger.kernel.org>; Wed, 23 Mar 2011 11:32:59 -0700 (PDT)
In-Reply-To: <4D8A3B52.4000409@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, device-drivers-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Wed, Mar 23, 2011 at 14:26, Shubhrajyoti wrote:
> On Wednesday 23 March 2011 09:35 PM, Mike Frysinger wrote:
>> +#define ADP_BANK(offs) =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((offs)>> =C2=A0=
3)
>> +#define ADP_BIT(offs) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1u<< =C2=A0=
((offs)& =C2=A00x7))

Shubhrajyoti: your e-mail client is weird.  it moves spaces around in
the output for no good reason.  your replies made me think Michael's
original style was all screwed up until i looked at the original .c/.h
files on disk.  not sure if there's something you could do to rectify
this ...
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
